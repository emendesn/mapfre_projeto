#Include "protheus.ch"

User Function AjustaSX()

Local lOpenedEmp	:= .T.
Local aSM0			:= {}

Set Dele On

lOpenedEmp := MsOpenDbf(.T.,"DBFCDX","SIGAMAT.EMP", "SM0",.T.,.F.)
IF ( lOpenedEmp )
	MsOpenIdx("SIGAMAT.IND",'M0_CODIGO+M0_CODFIL',.T.,,,"SIGAMAT.IND")
	DbSetIndex("SIGAMAT.IND")
ELSE
	MsgAlert("Não foi possível abrir o SIGAMAT!")
ENDIF

dbSelectArea('SM0')
dbGotop()
While !Eof()
	If ASCAN(aSM0, {|aVal| aVal[1] == M0_CODIGO}) == 0
		aAdd(aSM0,{M0_CODIGO,M0_CODFIL})
	EndIf
	dbSkip()
EndDo

MainProc(aSM0)

dbCloseArea('SM0')

Set Dele Off

MsgAlert("Terminou!")

Return


Static Function MainProc(aSM0)

Local nLoop		:= 0
Local cPer		:= ""
lOCAL lAltera	:= .F.

For nLoop	:= 1 to Len(aSM0)
	
	RPCSetType(3)
	RpcSetEnv(aSM0[nLoop][1], aSM0[nLoop][2])
	
	dbSelectArea("SIX")
	dbGotop()
	While !Eof()
		lAlter	:= (Empty(SIX->DESCRICAO) .or. Empty(SIX->DESCSPA) .or. Empty(SIX->DESCENG))
		If lAlter
			Reclock("SIX")
			If Empty(SIX->DESCRICAO)
				SIX->DESCRICAO	:= "."
				cPer	:= "."
			Else
				cPer	:= SIX->DESCRICAO
			EndIf
			SIX->DESCSPA	:= IIF(Empty(SIX->DESCSPA),cPer,SIX->DESCSPA)
			SIX->DESCENG	:= IIF(Empty(SIX->DESCENG),cPer,SIX->DESCENG)			
			SIX->(MsUnlock())
		EndIf
		
		dbSkip()
	EndDo


	dbSelectArea("SX1")
	dbGotop()
	While !Eof()
		lAlter	:= (Empty(SX1->X1_PERGUNT) .or. Empty(SX1->X1_PERSPA) .or. Empty(SX1->X1_PERENG))
		If lAlter
			Reclock("SX1")
			If Empty(SX1->X1_PERGUNT)
				SX1->X1_PERGUNT	:= "."
				cPer	:= "."
			Else
				cPer	:= SX1->X1_PERGUNT
			EndIf
			SX1->X1_PERSPA	:= IIF(Empty(SX1->X1_PERSPA),cPer,SX1->X1_PERSPA)
			SX1->X1_PERENG	:= IIF(Empty(SX1->X1_PERENG),cPer,SX1->X1_PERENG)			
			SX1->(MsUnlock())
		EndIf
		
		dbSkip()
	EndDo
	
	dbCloseArea("SX1")
	
	RpcClearEnv()
	
Next

Return