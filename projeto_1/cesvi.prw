#include "rwmake.ch"
/* 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BRCNAFUN  �Autor  �Ricardo Ferla       � Data �  10/02/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcoes especificas para os CNABS de Reenvio de Informacoes ���
���          �bancarias (Ocorrencias 02/04/05/06)                         ���
�������������������������������������������������������������������������͹��
���Uso       �Equifax do Brasil                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CNABVENC  �Autor  �Ricardo Ferla       � Data �  10/02/04   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o Vencimento do Titulo                             ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CNABVENC(cOcorren,cBanco)

Local cRet	:= "000000"
cOcorren	:= Iif(cOcorren==Nil,"01",cOcorren)

If cBanco $ "341"
	//����������������������������������������������������Ŀ
	//�Retorna a Data de Vencto somente para as Ocorrencias�
	//�06= Altera��o de Vencto                             �
	//������������������������������������������������������
	If cOcorren $ "06"
		cRet:= GravaData(SE1->E1_VENCREA,.F.)
	EndIf
Else
	cRet:= GravaData(SE1->E1_VENCREA,.F.)
EndIf

Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CNABABT   �Autor  �Ricardo Ferla       � Data �  10/02/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Valor do Abatimento                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CNABABT(cOcorren,cBanco)

Local cRet	:= "0000000000000"
cOcorren	:= Iif(cOcorren==Nil,"01",cOcorren)

//������������������������������������������������������������Ŀ
//�Retorna o Valor do Abatimento somente para as Ocorrencias   �
//�04= Concessao de AB- / 05= Cancelamento de AB-              �
//��������������������������������������������������������������
If cOcorren $ "04" // Concessao de AB-
	//����������������Ŀ
	//�Ret o Abatimento�
	//������������������
	If DtoS(SE1->E1_EMISSAO) >= "20040210"
		nRet := SE1->(U_EfxAbatR(E1_PREFIXO,E1_NUM,E1_PARCELA,1,"V",E1_VENCREA))
	Else
       	nRet := SE1->(SomaAbat(E1_PREFIXO,E1_NUM,E1_PARCELA,"R",E1_MOEDA,E1_EMISSAO))
	EndIf
	nRet := Strzero( Int(nRet*100),13)
ElseIf cOcorren $ "05" // Cancelamento de AB-
	//����������������������������������Ŀ
	//�Obtem o antigo valor do Abatimento�
	//������������������������������������
	cRet:= "0000000000000"
EndIf

Return cRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CNABVAL   �Autor  �Ricardo Ferla       � Data �  10/02/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Valor do Titulo                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CNABVAL(cOcorren,cBanco)

Local cRet	:= "0000000000000"
cOcorren	:= Iif(cOcorren==Nil,"01",cOcorren)

If cOcorren $ "02/04/05/06"
	//�����������������������������Ŀ
	//�Ret o Valor Liquido do Titulo�
	//�������������������������������
	If DtoS(SE1->E1_EMISSAO) >= "20040210"
		nRet := SE1->(E1_VALOR - U_EfxSumRet("*"))
	Else
		nRet := SE1->E1_VALOR
	EndIf
	nRet := Strzero(Round(nRet,2)*100,13)
EndIf

Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CNABJUR   �Autor  �Ricardo Ferla       � Data �  10/02/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Valor dos Juros ao Dia                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CNABJUR(cOcorren,cBanco)

Local cRet	:= "0000000000000"
cOcorren	:= Iif(cOcorren==Nil,"01",cOcorren)

If cOcorren $ "02/04/05/06"
	//�����������������������������Ŀ
	//�Ret o Valor de Juros ao Dia  �
	//�������������������������������
	If DtoS(SE1->E1_EMISSAO) >= "20040210"
		nRet := SE1->(E1_VALOR - U_EfxSumRet("*"))
	Else
		nRet := SE1->E1_VALOR
	EndIf
	nRet:= Strzero(Int(nRet*(GetMv("MV_JURCNAB"))),13)
EndIf

Return cRet 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CODBAR    �Autor  �Microsiga           � Data �  19/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para Valida��o de C�digo de Barras (CB) e Representa���
���          � Num�rica do C�digo de Barras - Linha Digit�vel (LD).		  ���
���          �                                                            ���
���          � A LD de Bloquetos possui tr�s Digitos Verificadores (DV) qu���
���          � s�o consistidos pelo M�dulo 10, al�m do D�gito Verificador ���
���          � Geral (DVG) que � consistido pelo M�dulo 11. Essa LD t�m 47���
���          � D�gitos.                                                   ���
���          � 														      ���
���          � A LD de T�tulos de Concessin�rias do Servi�o P�blico e IPTU���
���          � possui quatro Digitos Verificadores (DV) que s�o consistido���
���          � pelo M�dulo 10, al�m do Digito Verificador Geral (DVG) que ���
���          � tamb�m � consistido pelo M�dulo 10. Essa LD t�m 48 D�gitos.���
���          � 															  ���
���          � O CB de Bloquetos e de T�tulos de Concession�rias do Servi纱�
���          � P�blico e IPTU possui apenas o D�gito Verificador Geral(DVG���
���          � sendo que a �nica diferen�a � que o CB de Bloquetos �      ���
���          � consistido pelo M�dulo 11 enquanto que o CB de T�tulos de  ���
���          � Concession�rias � consistido pelo M�dulo 10. Todos os CB�s ���
���          � t�m 44 D�gitos.                                            ���
���          � 															  ���
���          � Para utilizar dessa Fun��o, deve-se criar o campo E2_CODBAR���
���          � Tipo Caracter, Tamanho 48 e colocar na Valida��o do Usu�rio���
���          � EXECBLOCK("CODBAR",.T.).                                   ���
���          �                                                            ���
���          � Utilize tamb�m o gatilho com a Fun��o CONVLD() para convert���
���          � a LD em CB.			                                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �Equifax do Brasil                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION CODBAR()
SETPRVT("cStr,lRet,cTipo,nConta,nMult,nVal,nDV,cCampo,i,nMod,nDVCalc")

// Retorna .T. se o Campo estiver em Branco.
IF VALTYPE(M->E2_CODBAR) == NIL .OR. EMPTY(M->E2_CODBAR)
	RETURN(.T.)
ENDIF

cStr := LTRIM(RTRIM(M->E2_CODBAR))

// Se o Tamanho do String for 45 ou 46 est� errado! Retornar� .F.
lRet := IF(LEN(cStr)==45 .OR. LEN(cStr)==46,.F.,.T.)

// Se o Tamanho do String for menor que 44, completa com zeros at� 47 d�gitos. Isso �
// necess�rio para Bloquetos que N�O t�m o vencimento e/ou o valor informados na LD.
cStr := IF(LEN(cStr)<44,cStr+REPL("0",47-LEN(cStr)),cStr)

// Verifica se a LD � de (B)loquetos ou (C)oncession�rias/IPTU. Se for CB retorna (I)ndefinido.
cTipo := IF(LEN(cStr)==47,"B",IF(LEN(cStr)==48,"C","I"))

// Verifica se todos os d�gitos s�o num�rios.
FOR i := LEN(cStr) TO 1 STEP -1
	lRet := IF(SUBSTR(cStr,i,1) $ "0123456789",lRet,.F.)
NEXT

IF LEN(cStr) == 47 .AND. lRet
	// Consiste os tr�s DV�s de Bloquetos pelo M�dulo 10.
	nConta  := 1
	WHILE nConta <= 3
		nMult  := 2
		nVal   := 0
		nDV    := VAL(SUBSTR(cStr,IF(nConta==1,10,IF(nConta==2,21,32)),1))
		cCampo := SUBSTR(cStr,IF(nConta==1,1,IF(nConta==2,11,22)),IF(nConta==1,9,10))
		FOR i := LEN(cCampo) TO 1 STEP -1
			nMod  := VAL(SUBSTR(cCampo,i,1)) * nMult
			nVal  := nVal + IF(nMod>9,1,0) + (nMod-IF(nMod>9,10,0))
			nMult := IF(nMult==2,1,2)
		NEXT
		nDVCalc := 10-MOD(nVal,10)
		// Se o DV Calculado for 10 � assumido 0 (Zero).
		nDVCalc := IF(nDVCalc==10,0,nDVCalc)
		lRet    := IF(lRet,(nDVCalc==nDV),.F.)
		nConta  := nConta + 1			
	ENDDO
	// Se os DV�s foram consistidos com sucesso (lRet=.T.), converte o n�mero para CB para consistir o DVG. 
  	cStr := IF(lRet,SUBSTR(cStr,1,4)+SUBSTR(cStr,33,15)+SUBSTR(cStr,5,5)+SUBSTR(cStr,11,10)+SUBSTR(cStr,22,10),cStr)
ENDIF

IF LEN(cStr) == 48 .AND. lRet
	// Consiste os quatro DV�s de T�tulos de Concession�rias de Servi�o P�blico e IPTU pelo M�dulo 10.
	nConta  := 1
	WHILE nConta <= 4
		nMult  := 2
		nVal   := 0
		nDV    := VAL(SUBSTR(cStr,IF(nConta==1,12,IF(nConta==2,24,IF(nConta==3,36,48))),1))
		cCampo := SUBSTR(cStr,IF(nConta==1,1,IF(nConta==2,13,IF(nConta==3,25,37))),11)
		FOR i := 11 TO 1 STEP -1
			nMod  := VAL(SUBSTR(cCampo,i,1)) * nMult
			nVal  := nVal + IF(nMod>9,1,0) + (nMod-IF(nMod>9,10,0))
			nMult := IF(nMult==2,1,2)
		NEXT
		nDVCalc := 10-MOD(nVal,10)
		// Se o DV Calculado for 10 � assumido 0 (Zero).
		nDVCalc := IF(nDVCalc==10,0,nDVCalc)
		lRet    := IF(lRet,(nDVCalc==nDV),.F.)
		nConta  := nConta + 1			
	ENDDO
	// Se os DV�s foram consistidos com sucesso (lRet=.T.), converte o n�mero para CB para consistir o DVG. 
  	cStr := IF(lRet,SUBSTR(cStr,1,11)+SUBSTR(cStr,13,11)+SUBSTR(cStr,25,11)+SUBSTR(cStr,37,11),cStr)
ENDIF

IF LEN(cStr) == 44 .AND. lRet
	IF cTipo $ "BI"
		// Consiste o DVG do CB de Bloquetos pelo M�dulo 11.
		nMult  := 2
		nVal   := 0
		nDV    := VAL(SUBSTR(cStr,5,1))
		cCampo := SUBSTR(cStr,1,4)+SUBSTR(cStr,6,39)
		FOR i := 43 TO 1 STEP -1
			nMod  := VAL(SUBSTR(cCampo,i,1)) * nMult
			nVal  := nVal + nMod
			nMult := IF(nMult==9,2,nMult+1)
		NEXT
		nDVCalc := 11-MOD(nVal,11)
		// Se o DV Calculado for 0,10 ou 11 � assumido 1 (Um).
		nDVCalc := IF(nDVCalc==0 .OR. nDVCalc==10 .OR. nDVCalc==11,1,nDVCalc)		
		lRet    := IF(lRet,(nDVCalc==nDV),.F.)
		// Se o Tipo � (I)ndefinido E o DVG N�O foi consistido com sucesso (lRet=.F.), tentar�
		// consistir como CB de T�tulo de Concession�rias/IPTU no IF abaixo.  
	ENDIF
	IF cTipo == "C" .OR. (cTipo == "I" .AND. !lRet)
		// Consiste o DVG do CB de T�tulos de Concession�rias pelo M�dulo 10.
		lRet   := .T.
		nMult  := 2
		nVal   := 0
		nDV    := VAL(SUBSTR(cStr,4,1))
		cCampo := SUBSTR(cStr,1,3)+SUBSTR(cStr,5,40)
		FOR i := 43 TO 1 STEP -1
			nMod  := VAL(SUBSTR(cCampo,i,1)) * nMult
			nVal  := nVal + IF(nMod>9,1,0) + (nMod-IF(nMod>9,10,0))
			nMult := IF(nMult==2,1,2)
		NEXT
		nDVCalc := 10-MOD(nVal,10)
		// Se o DV Calculado for 10 � assumido 0 (Zero).
		nDVCalc := IF(nDVCalc==10,0,nDVCalc)
		lRet    := IF(lRet,(nDVCalc==nDV),.F.)
	ENDIF
ENDIF

IF !lRet
	HELP(" ",1,"ONLYNUM")
ENDIF

RETURN(lRet)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CONVLD    �Autor  �Microsiga           � Data �  19/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para conversao da representacao numerica do Codigo   ���
���          �de barras - LInha Digitavel(LD) em Codigo de Barras (CB)    ���
���          �Para utilizacao dessa funcao, deve-se criar um gatilho para ���
���          �o campo E2_CODBAR, Conta Dominio:E2_CODBAR, Tipo: Primario  ���
���          �Regra:U_CONVLD, Posiciona:Nao                               ���
���          �Utilize tambem a Validacao do Usuario para o Campo E2_CODBAR���
���          �U_CODBAR para validar a LD ou o CB                          ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION CONVLD()

SETPRVT("cStr")

cStr := LTRIM(RTRIM(M->E2_CODBAR))

IF VALTYPE(M->E2_CODBAR) == NIL .OR. EMPTY(M->E2_CODBAR)
	// Se o Campo est� em Branco n�o Converte nada.
	cStr := ""
ELSE
	// Se o Tamanho do String for menor que 44, completa com zeros at� 47 d�gitos. Isso �
	// necess�rio para Bloquetos que N�O t�m o vencimento e/ou o valor informados na LD.
	cStr := IF(LEN(cStr)<44,cStr+REPL("0",47-LEN(cStr)),cStr)
ENDIF

DO CASE
CASE LEN(cStr) == 47
	cStr := SUBSTR(cStr,1,4)+SUBSTR(cStr,33,15)+SUBSTR(cStr,5,5)+SUBSTR(cStr,11,10)+SUBSTR(cStr,22,10)
CASE LEN(cStr) == 48
   cStr := SUBSTR(cStr,1,11)+SUBSTR(cStr,13,11)+SUBSTR(cStr,25,11)+SUBSTR(cStr,37,11)
OTHERWISE
	cStr := cStr+SPACE(48-LEN(cStr))
ENDCASE

RETURN(cStr) 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TIPOINS   �Autor  �Isabel Cristina     � Data �  19/10/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Tipo de Inscricao da empresa.                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
//User Function TIPOINS()
//Local cTipo := "0"

//IF !Empty(AllTrim(SA2->A2_CGC))
// 	cTipo:= Iif(LEN(ALLTRIM(SA2->A2_CGC))==11,"01","02")
//ELSE
//    cTipo:= Iif(LEN(ALLTRIM(SA2->A2_CGC))==11,"1","2")
//EndIf


//Return cTipo 


User Function TIPOINS()
Local cTipo := "0"

IF !Empty(AllTrim(SA2->A2_CGC))
 	cTipo:= Iif(LEN(ALLTRIM(SA2->A2_CGC))==11,"01","02") 	
EndIf


Return cTipo 


  
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TIPONUM   �Autor  �Isabel Cristina     � Data �  19/10/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Numero da inscricao da empresa                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function TIPONUM()
Local cInsc := "0"

IF !Empty(AllTrim(SA2->A2_CGC))
 	cInsc:= "000"+SUBSTR(SA2->A2_CGC,1,11)
ELSE
    cInsc:=STRZERO(VAL(SA2->A2_CGC),14)
EndIf


Return cInsc


 /*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TIPONOME  �Autor  �Isabel Cristina     � Data �  19/10/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Nome do Favorecido.                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function TIPONOME()
Local cFavore := "0"

IF !Empty(AllTrim(SA2->A2_FAVOREC))
 	cFavore:= SUBSTR(SA2->A2_FAVOREC,1,30)
ELSE
    cFavore:= SUBSTR(SA2->A2_NOME,1,30)
EndIf


Return cFavore   


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TIPOBRAD  �Autor  �Isabel Cristina     � Data �  19/10/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o Numero da inscricao da empresa conf.config.       ���
���          �  Bradesco                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � Equifax do Brasil                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function TIPOBRAD()

Local cTipo := "0"

//�����������������������������������Ŀ
//�Caso utiliza os dados do Favorecido�
//�������������������������������������
If !Empty(AllTrim(SA2->A2_FAVOCPF))
	//�������������Ŀ
	//�Caso seja CPF�
	//���������������
 	If Len(AllTrim(SA2->A2_FAVOCPF))==11
 		cTipo:= SUBSTR(SA2->A2_FAVOCPF,1,9)+"0000"+SUBSTR(SA2->A2_FAVOCPF,10,2)
	Else
		cTipo:= "0"+SA2->A2_FAVOCPF
	EndIf
Else
	//�������������Ŀ
	//�Caso seja CPF�
	//���������������
 	If Len(AllTrim(SA2->A2_CGC))==11
 		cTipo:= SUBSTR(SA2->A2_CGC,1,9)+"0000"+SUBSTR(SA2->A2_CGC,10,2)
	Else
		cTipo:= "0"+SA2->A2_CGC
	EndIf
EndIf


Return cTipo