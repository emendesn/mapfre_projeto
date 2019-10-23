#Include "protheus.ch"

User Function Gluglu()

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

Salsifufu(aSM0)

dbCloseArea('SM0')

Set Dele Off

MsgAlert("IéIé!!!")

Return


Static Function Salsifufu(aSM0)

Local nLoop		:= 0
Local aStrut	:= {}
Private lExcl	:= .F.

For nLoop	:= 1 to Len(aSM0)
	
	RPCSetType(3)
	RpcSetEnv(aSM0[nLoop][1], aSM0[nLoop][2])
	
	dbSelectArea("SX2")
	Copy to "SX2TRB"

	If MsOpenDbf(.T.,"DBFCDX","SX2TRB", "SX2TRB",.T.,.F.)
		dbGotop()
		While !Eof()
			If MsFile(SX2TRB->X2_ARQUIVO,,"TOPCONN")
				dbSelectArea(SX2TRB->X2_CHAVE)
				aStrut	:= dbStruct()
				dbCreate("\DADOSADV\"+SX2TRB->X2_ARQUIVO, aStrut, "DBFCDX")
			EndIf
			dbSelectArea("SX2TRB")
			dbSkip()
		EndDo
	    dbCloseArea("SX2TRB")
		Ferase("SX2TRB.DBF")
	EndIf
	RpcClearEnv()
	
Next

Return