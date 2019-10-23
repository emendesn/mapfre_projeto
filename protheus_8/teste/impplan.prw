#include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �IMPPLAN   �Autor  �Jose Novaes         � Data �  05/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Importacao de plano de conta atraves de arquivo texto       ���
���          �separado por ;                                              ���
�������������������������������������������������������������������������͹��
���Obs       �Nao enviar o campo _FILIAL no arquivo texto                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Impplan()

Local aStru		:= {}
Local cArquivo	:= ""
Local cArqTxt	:= "placon.csv"
Local cLinha	:= ""
Local nLinha	:= 1
Local aCabec	:= {}
Local aCampos	:= {}
Local cFilCT1	:= xFilial("CT1")
Local nLoop		:= 1
Local cLinAux	:= ""

aadd(aStru, {"LINHA","C",200,0})

If !File(cArqTxt)
	MsgAlert("Arquivo n�o encontrado!")
	Return
EndIf

cArquivo := CriaTrab(aStru,.T.)
dbUseArea(.T.,,cArquivo,"ARQIMP",.F.,.F.)

DbSelectArea("ARQIMP")
APPEND FROM &cArqTxt ALL SDF 

dbGotop()
While !Eof()
	cLinha	:= ARQIMP->LINHA
	
	cLinAux	:= cLinha

	If nLinha == 1
		
		While AT(";", cLinAux) > 0
			aAdd( aCabec, { Alltrim( SUBSTR(cLinAux, 1, AT(";", cLinAux) - 1) ) } )
			cLinAux	:= SUBSTR(cLinAux, AT(";", cLinAux) + 1)
		EndDo
		
		aAdd(aCabec,{Alltrim(cLinAux)})
	
		nLinha ++
	Else	
		
		While AT(";", cLinAux) > 0
			aAdd(aCampos,{Alltrim(SUBSTR(cLinAux, 1, AT(";", cLinAux) - 1))})
			cLinAux	:= SUBSTR(cLinAux, AT(";", cLinAux) + 1)
		EndDo
		
		aAdd(aCampos,{Alltrim(cLinAux)})
		
		Reclock("CT1",.T.)
		CT1->CT1_FILIAL	:= cFilCT1
		For nLoop	:= 1 to Len(aCabec)
			&("CT1->"+aCabec[nLoop][1])	:= aCampos[nLoop][1]
		Next
		CT1->(MsUnlock())
		
		aCampos	:= {}
	EndIf
	
	dbSelectArea("ARQIMP")
	dbSkip()

EndDo

dbCloseArea("ARQIMP")
Ferase(cArquivo+".DBF")

MsgAlert("Acabou!")

Return



User Function ImpDepar()

Local aStru		:= {}
Local cArquivo	:= ""
Local cArqTxt	:= "depara.csv"
Local cLinha	:= ""
Local nLinha	:= 1
Local aCabec	:= {}
Local aCampos	:= {}
Local cFilCVD	:= xFilial("CVD")
Local nLoop		:= 1
Local cLinAux	:= ""

aadd(aStru, {"LINHA","C",200,0})

If !File(cArqTxt)
	MsgAlert("Arquivo n�o encontrado!")
	Return
EndIf

cArquivo := CriaTrab(aStru,.T.)
dbUseArea(.T.,,cArquivo,"ARQIMP",.F.,.F.)

DbSelectArea("ARQIMP")
APPEND FROM &cArqTxt ALL SDF 

dbGotop()
While !Eof()
	cLinha	:= ARQIMP->LINHA
	
	cLinAux	:= cLinha

	If nLinha == 1
		
		While AT(";", cLinAux) > 0
			aAdd( aCabec, { Alltrim( SUBSTR(cLinAux, 1, AT(";", cLinAux) - 1) ) } )
			cLinAux	:= SUBSTR(cLinAux, AT(";", cLinAux) + 1)
		EndDo
		
		aAdd(aCabec,{Alltrim(cLinAux)})
	
		nLinha ++
	Else	
		
		While AT(";", cLinAux) > 0
			aAdd(aCampos,{Alltrim(SUBSTR(cLinAux, 1, AT(";", cLinAux) - 1))})
			cLinAux	:= SUBSTR(cLinAux, AT(";", cLinAux) + 1)
		EndDo
		
		aAdd(aCampos,{Alltrim(cLinAux)})
		
		Reclock("CVD",.T.)
		CVD->CVD_FILIAL	:= cFilCVD
		For nLoop	:= 1 to Len(aCabec)
			&("CVD->"+aCabec[nLoop][1])	:= aCampos[nLoop][1]
		Next
		CVD->(MsUnlock())
		
		aCampos	:= {}
	EndIf
	
	dbSelectArea("ARQIMP")
	dbSkip()

EndDo

dbCloseArea("ARQIMP")
Ferase(cArquivo+".DBF")

MsgAlert("Acabou!")

Return