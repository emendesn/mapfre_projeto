//#include "fivewin.ch"
#INCLUDE "RWMAKE.CH"
//#Include "Protheus.ch"
//#Include "topconn.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ObrigCampo� Autor � Richard Anderson      � Data � 05/06/01 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Transforma um campo nao obrigatorio para obrigatorio e     ���
���          � vice e versa.                                              ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico - Cliente Golden -                                ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function ObrigCampo(cCampo,cBloqueio)

LOCAL nPos := 0

cCampo := Padr( cCampo, 10 )

If cBloqueio == NIL
	cBloqueio := "T"
EndIf

nPos := Ascan( aGets, { | e | Substr( e, 9, 10 ) == cCampo } )

If nPos > 0
	aGets[ nPos ] := Stuff( aGets[ nPos ], 22, 1, cBloqueio )
EndIf

Return .T.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VECAMPO   �Autor  �Andressa Favero     � Data �  18/12/02   ���
�������������������������������������������������������������������������͹��
���Desc.     � Torna obrigatorio os campos do cadastro de fornecedores    ���
���          � para aplicacao do PAGFOR                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Uso Exclusivo para o cliente Golden Cargo                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VECAMPO()

U_OBRIGCAMPO("A2_BANCO","F")
U_OBRIGCAMPO("A2_AGENCIA","F")
U_OBRIGCAMPO("A2_NUMCON","F")
U_OBRIGCAMPO("A2_DIGCTA","F")
U_OBRIGCAMPO("A2_TPCON","F")

If M->A2_TIPOPAG $ "2/3"
	
	U_OBRIGCAMPO("A2_BANCO","T")
	U_OBRIGCAMPO("A2_AGENCIA","T")
	U_OBRIGCAMPO("A2_NUMCON","T")
	U_OBRIGCAMPO("A2_DIGCTA","T")
	U_OBRIGCAMPO("A2_TPCON","T")
	
EndIf

Return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VECAMPO2  �Autor  �Andressa Favero     � Data �  18/12/02   ���
�������������������������������������������������������������������������͹��
���Desc.     � Torna obrigatorio os campos do cadastro de contas a pagar  ���
���          � para aplicacao do PAGFOR                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Uso Exclusivo para o cliente Golden Cargo                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VeCampo2()



// inicializa as variaveis

U_OBRIGCAMPO("E2_CODBAR","F")
U_OBRIGCAMPO("E2_BANCO","F")
U_OBRIGCAMPO("E2_AGENCIA","F")
U_OBRIGCAMPO("E2_NUMCON","F")
U_OBRIGCAMPO("E2_DIGCTA","F")


If M->E2_TIPOPAG $ "2/3"
	
	U_OBRIGCAMPO("E2_BANCO","T")
	U_OBRIGCAMPO("E2_AGENCIA","T")
	U_OBRIGCAMPO("E2_NUMCON","T")
	U_OBRIGCAMPO("E2_DIGCTA","T")
	
ElseIf M->E2_TIPOPAG $ "4/5"
	
	U_OBRIGCAMPO("E2_CODBAR","T")
	
EndIf

Return()

/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � Valcod1  � Autor �Microsiga              � Data � 31/07/02 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Calculo do modulo 11                                       ���
���          � funcao usada como validacao do campo E2_CODBAR.            ���
���          �                                                            ���
���          � Nome        Tipo   Tamanho   Validacao                     ���
���          � -----------  --     ----     ----------------------------  ���
���          � E2_CODBAR    C       47      EXECBLOCK("VALCOD1")          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
/*/

User Function VALCOD1()

LRET := .F.

if ValType(M->E2_CODBAR) == NIL
	Return(.t.)
Endif

cStr := M->E2_CODBAR

i := 0
nMult := 2
nModulo := 0
cChar := SPACE(1)
cDigito := SPACE(1)

If len(AllTrim(cStr)) > 44  // linha digitada
	
	cDV1    := SUBSTR(cStr,10, 1)
	cDV2    := SUBSTR(cStr,21, 1)
	cDV3    := SUBSTR(cStr,32, 1)
	
	cCampo1 := SUBSTR(cStr, 1, 9)
	cCampo2 := SUBSTR(cStr,11,10)
	cCampo3 := SUBSTR(cStr,22,10)
	
	/*
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������Ŀ��
	���Descri��o � Calculo do modulo 10 sugerido pelo ITAU. Esta funcao       ���
	���          � somente e utilizada como validacao do campo E2_CODBAR      ���
	���          � Verifica a digitacao do codigo de barras                   ���
	��������������������������������������������������������������������������ٱ�
	�����������������������������������������������������������������������������
	*/
	
	//
	// Calcula DV1
	//
	
	nMult := 2
	nModulo := 0
	nVal := 0
	
	For i := Len(cCampo1) to 1 Step -1
		cChar := Substr(cCampo1,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := Val(cChar)*nMult
		If nModulo >= 10
			nVal := NVAL + 1
			nVal := nVal + (nModulo-10)
		Else
			nVal := nVal + nModulo
		EndIf
		nMult:= if(nMult==2,1,2)
	Next
	nCalc_DV1 := 10 - (nVal % 10)
	if nCalc_DV1 == 10
		nCalc_DV1:=0
	endif
	
	//
	// Calcula DV2
	//
	nMult := 2
	nModulo := 0
	nVal := 0
	
	For i := Len(cCampo2) to 1 Step -1
		cChar := Substr(cCampo2,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := Val(cChar)*nMult
		If nModulo >= 10
			nVal := nVal + 1
			nVal := nVal + (nModulo-10)
		Else
			nVal := nVal + nModulo
		EndIf
		nMult:= if(nMult==2,1,2)
	Next
	nCalc_DV2 := 10 - (nVal % 10)
	if nCalc_DV2==10
		nCalc_DV2:=0
	endif
	//
	// Calcula DV3
	//
	nMult := 2
	nModulo := 0
	nVal := 0
	
	For i := Len(cCampo3) to 1 Step -1
		cChar := Substr(cCampo3,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := Val(cChar)*nMult
		If nModulo >= 10
			nVal := nVal + 1
			nVal := nVal + (nModulo-10)
		Else
			nVal := nVal + nModulo
		EndIf
		nMult:= if(nMult==2,1,2)
	Next
	nCalc_DV3 := 10 - (nVal % 10)
	
	if nCalc_DV3==10
		nCalc_DV3:=0
	endif
	
	if !(nCalc_DV1 == Val(cDV1) .and. nCalc_DV2 == Val(cDV2) .and. nCalc_DV3 == Val(cDV3) )
		Help(" ",1,"INVALCODBAR")
		lRet := .f.
	else
		lRet := .t.
	endif
	
Else
	cDigito := SUBSTR(cStr,5, 1)
	cStr    := SUBSTR(cStr,1, 4)+ ;
	SUBSTR(cStr,6,39)
	
	/*
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������Ŀ��
	���Descri��o � Calculo do modulo 11 sugerido pelo ITAU. Esta funcao       ���
	���          � somente e utilizada como validacao do campo E2_CODBAR.     ���
	���          � Verifica o codigo de barras grafico (Atraves de leitor)    ���
	��������������������������������������������������������������������������ٱ�
	�����������������������������������������������������������������������������
	*/
	
	cStr := AllTrim(cStr)
	
	if Len(cStr) < 43
		Help(" ", 1, "FALTADG")
		Return(.f.)
	Endif
	
	For i := Len(cStr) to 1 Step -1
		cChar := Substr(cStr,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := nModulo + Val(cChar)*nMult
		nMult:= if(nMult==9,2,nMult+1)
	Next
	nRest := 11 - (nModulo % 11)
	nRest := if(nRest==10 .or. nRest==11,1,nRest)
	if nRest <> Val(cDigito)
		Help(" ",1,"DgCnab")
		lRet := .f.
	else
		lRet := .t.
	endif
	
Endif

Return(lRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GAT001    �Autor  �Microsiga           � Data �  11/09/02   ���
�������������������������������������������������������������������������͹��
���Desc.     �Transforma a linha digitavel em codigo de barras.           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

// Vari�veis utilizadas no programa

User Function GAT001()


_cMonta1 := ""
_cMonta2 := ""
_cMonta3 := ""
_cMonta4 := ""
_cMonta5 := ""
_cMonta6 := ""
_cMonta7 := ""
_cReturn := ""
_cCodbar := Trim(M->E2_CODBAR)
_nTamCod := Len(_cCodbar)
_nTamVal := Len(_cCodbar)-33

// Verifica tamanho da linha digit�vel

If _nTamCod == 44
	_cReturn := _cCodbar
Else
	If _nTamVal < 14        // Codigo de Barras sem fator de vencimento.
		_cMonta3 := "0000"
		_cMonta4 := Strzero(Val(Substr(_cCodbar,34,_nTamVal)),10)
	Else                    // Codigo de Barras com fator de vencimento.
		_cMonta3:= Substr(_cCodbar,34,4)
		_cMonta4:= Substr(_cCodbar,38,10)
	Endif
	
	// Monta o Codigo de Barras
	
	_cMonta1:= Substr(_cCodbar,1,4)
	_cMonta2:= Substr(_cCodbar,33,1)
	_cMonta5:= Substr(_cCodbar,5,5)
	_cMonta6:= Substr(_cCodbar,11,10)
	_cMonta7:= Substr(_cCodbar,22,10)
	
	_cCodBar := _cMonta1 + _cMonta2 + _cMonta3 + _cMonta4 + _cMonta5 + _cMonta6 + _cMonta7
	_cReturn := _cCodbar
Endif

Return(_cReturn)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTAATIV   �Autor  �Cristian Gutierrez  � Data �  18/12/02   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para validacao da conta contabil, verifica se esta  ���
���          �ou nao ativa.                                               ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico para o cliente Golden Cargo                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CTAATIV()

//�������������������������
//�Declaracao de Variaveis�
//�������������������������
Local lRet     := .T.
Local aArea    := GetArea()
Local aAreaSI1 := SI1->(GetArea())
//���������������������������������������������������Ŀ
//�Valida o status da conta contabil, se ativa ou nao.�
//�Somente aceita contas com status Ativo.            �
//�����������������������������������������������������

DbSelectArea("SI1")
DbSetOrder(1)
If MsSeek(xFilial("SI1")+&(ReadVar())) .And. SI1->I1_CTAATIV == "N"
	Aviso("Conta Inativa","A conta cont�bil selecionada est� inativa. Selecione uma conta ativa",{"OK"},,"Conta: "+&(ReadVar()))
	lRet := .F.

EndIF   

RestArea(aAreaSI1)
RestArea(aArea)

Return(lRet)              


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GAT002	   �Autor  �Cristian Gutierrez  � Data �  07/06/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Utilizado no gatilho para o campo d1_cod, sequencia 3       ���
���          �como condicao                                               ���
�������������������������������������������������������������������������͹��
���Uso       � Exclusivo para o cliente Golden                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GAT002()

lRet := .T.

If Empty(SA2->A2_CONTA) .And. !Empty(SD1->D1_CONTA)
	lRet := .F.
EndIf        

Return(lRet)             

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GAT003	   �Autor  �Cristian Gutierrez  � Data �  07/06/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao utilizada no gatilho do campo E5_BANCO, para alimenta���
���          �cao automatica dos campos de cc e conta contabil.           ���
�������������������������������������������������������������������������͹��
���Uso       � Exclusivo para o cliente Golden                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GAT003()                                     
//�������������������������
//�Declaracao de Variaveis�
//�������������������������
Local aArea    := GetArea()
Local aAreaSA6	:= SA6->(GetArea())
Local aAreaSED	:= SED->(GetArea())     

If cRECPAG == "R"

	DbSelectArea("SA6")
	DbSetOrder(1)
	If DbSeek(xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA)
		M->E5_DEBITO	:= SA6->A6_CONTA
		M->E5_CCD		:= SA6->A6_CC
	EndIf
   //M->E5_DEBITO := Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA,SA6->A6_CONTA)
	//M->E5_CCD		:= Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA,SA6->A6_CC)
	
	DbSelectArea("SED")
	DbSetOrder(1)
	If DbSeek(xFilial("SED")+M->E5_NATUREZ)
		M->E5_CREDITO	:= SED->ED_CTACRED
		M->E5_CCC		:= SED->ED_CC
	EndIf
 	//M->E5_CREDITO 	:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CTACRED)
	//M->E5_CCC 		:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CC)

ElseIF cRECPAG == "P"
	
	DbSelectArea("SA6")
	DbSetOrder(1)
	If DbSeek(xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA)
		M->E5_CREDITO	:= SA6->A6_CONTA
		M->E5_CCC		:= SA6->A6_CC
	EndIf
   //M->E5_CREDITO	:= Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+E5_AGENCIA+M->E5_CONTA,SA6->A6_CONTA)
	//M->E5_CCC			:= Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+E5_AGENCIA+M->E5_CONTA,SA6->A6_CC)	
	
		DbSelectArea("SED")
	DbSetOrder(1)
	If DbSeek(xFilial("SED")+M->E5_NATUREZ)
		M->E5_DEBITO 	:= SED->ED_CTADEB 
		M->E5_CCD		:= SED->ED_CC
	EndIf
	//M->E5_CCD 		:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CC)
	//M->E5_DEBITO  	:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CTADEB)
	
Else
	Return(M->E5_BANCO)

EndIf

RestArea(aAreaSA6)                 
RestArea(aAreaSED)
RestArea(aArea)   

Return(M->E5_BANCO)      


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CCATIV   �Autor  �Cristian Gutierrez  � Data �  18/12/02   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para validacao da conta contabil, verifica se esta  ���
���          �ou nao ativa.                                               ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico para o cliente Golden Cargo                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CCATIV()

//�������������������������
//�Declaracao de Variaveis�
//�������������������������
Local lRet     := .T.
Local aArea    := GetArea()
Local aAreaSI3 := SI3->(GetArea())
//���������������������������������������������������Ŀ
//�Verifica o campo aceita lancamento no cadastro de  �
//�Centros de Custos, aceita lancam. para S ou Branco �
//�����������������������������������������������������

DbSelectArea("SI3")
DbSetOrder(1)
If MsSeek(xFilial("SI3")+&(ReadVar())) .And. SI3->I3_LANC == "N"
	Aviso("Centro de Custo Invalido","Este centro de custo � sint�tico e nao aceita lancamentos. Selecione um centro de custos anal�tico",{"OK"},,"Conta: "+&(ReadVar()))
	lRet := .F.

EndIF   

RestArea(aAreaSI3)
RestArea(aArea)

Return(lRet)              



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LOTECON   �Autor  �Andreza Favero      � Data �  10/01/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Definir o numero do lote contabil diferente para contas a   ���
���          �pagar e contas a receber.                                   ���
�������������������������������������������������������������������������͹��
���Uso       � AP6                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function LoteGolden

Local aArea:= GetArea()

If FUNNAME() == "FINA370"
	If MV_PAR06 == 1         // Contas a Receber
		cLote:= "8850"
	ElseIf MV_PAR06 == 2     // Contas a Pagar
		cLote:= "8851"
	ElseIf MV_PAR06 == 3     // Cheques
		cLote:= "8851"
	ElseIf MV_PAR06 == 4     // Todas - recebera o numero padrao do sistema
		cLote:= "8850"
	EndIf      
Else  
   If cModulo == "SIGAFIN"
      cLote:= "8850"
   Else
      cLote:= Substr(X5_DESCRI,1,Iif(CtbinUse(),6,4))	
   EndIf   
EndIf

RestArea(aArea)

Return(cLote)