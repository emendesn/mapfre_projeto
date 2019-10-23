#Include "protheus.ch"

User Function AjustCT1()

Local lOpenEmp	:= .F.

Set Dele On

lOpenEmp := MsOpenDbf(.T.,"DBFCDX","SIGAMAT.EMP", "SM0",.T.,.F.)
If ( lOpenEmp )
	MsOpenIdx("SIGAMAT.IND",'M0_CODIGO+M0_CODFIL',.T.,,,"SIGAMAT.IND")
	DbSetIndex("SIGAMAT.IND")
Else
	MsgAlert("Não foi possível abrir o SIGAMAT!")
EndIf

dbSelectArea("SM0")

MainProc()

dbCloseArea("SM0")

Set Dele Off

MsgAlert("Terminou!")


Static Function MainProc()

Local aStrCT1	:= {}
Local nLoop		:= 0
Local cConta	:= ""
Local cCtaSup	:= ""
Local aContaAux	:= {}

RPCSetType(3)
RpcSetEnv("01","01")

dbUseArea(.T., "DBFCDX", "\BENNER\CT1340.DBF", "TMP", .T., .F.)
If Alias() == "TMP"
	dbCreateIndex("CT1340","CT1_CONTA")
	aStrCT1	:= TMP->(dbStruct())
Else
	MsgAlert("Arquivo não encontrado!")
	Return
EndIf

dbSelectArea("TMP")
dbGotop()
While !Eof()

	//Conta Redutora
	If "(-)" $ TMP->CT1_DESC01
		Reclock("TMP")
		TMP->CT1_NORMAL	:= IIF(TMP->CT1_NORMAL=="1","2","1")
		TMP->(MsUnlock())
	EndIf

	//Conta Sintetica
	If TMP->CT1_CLASSE == "1"
		aContaAux	:= {}
		For nLoop	:= 1 to Len(aStrCT1)
			aAdd(aContaAux,TMP->(FieldGet(nLoop)))
		Next
	Else	//Conta Analitica
		cConta	:= TMP->CT1_CONTA
		cCtaSup	:= TMP->CT1_CTASUP

		//Cria a conta superior
		If !dbSeek(cCtaSup)
			Reclock("TMP",.T.)
			For nLoop	:= 1 to Len(aContaAux)
				TMP->(FieldPut(nLoop,aContaAux[nLoop]))
			Next
			TMP->CT1_CONTA	:= cCtaSup
			TMP->CT1_CTASUP	:= Left(cCtaSup,9)
			TMP->(MsUnlock())
		EndIf
		
		dbSeek(cConta)
		
		//Cria Analiticas
		If "POS EXCLUSIVO" $ TMP->CT1_DESC01
			aContaAux	:= {}
			For nLoop	:= 1 to Len(aStrCT1)
				aAdd(aContaAux,TMP->(FieldGet(nLoop)))
			Next

			If !dbSeek(Left(cConta,12)+"2")
				Reclock("TMP",.T.)
				For nLoop	:= 1 to Len(aContaAux)
					TMP->(FieldPut(nLoop,aContaAux[nLoop]))
				Next
				TMP->CT1_CONTA	:= Left(cConta,12)+"2"
				TMP->CT1_DESC01	:= "POS PLENO"
				TMP->(MsUnlock())
			EndIf

			If !dbSeek(Left(cConta,12)+"3")
				Reclock("TMP",.T.)
				For nLoop	:= 1 to Len(aContaAux)
					TMP->(FieldPut(nLoop,aContaAux[nLoop]))
				Next
				TMP->CT1_CONTA	:= Left(cConta,12)+"3"
				TMP->CT1_DESC01	:= "POS PERSONAL"
				TMP->(MsUnlock())
			EndIf
			
			dbSeek(Left(cConta,12)+"3")
		EndIf
	EndIf
	
	TMP->(dbSkip())
EndDo

TMP->(dbCloseArea())

RpcClearEnv()

MsgAlert("Terminou!")

Return