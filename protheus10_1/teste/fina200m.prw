#INCLUDE "FINA200.CH"
#include "fileio.ch"
#Include "PROTHEUS.CH"  
#Include "RWMAKE.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � FinA200  � Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorno da comunica��o banc�ria                            ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � FinA200()                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
�������������������������������������������������������������������������Ĵ��
���			ATUALIZACOES SOFRIDAS                              			  ���
�������������������������������������������������������������������������Ĵ��
��� Claudio   	�13/07/00�xxxxxx� Retirar todas as chamadas a WriteSx2     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FinA200m(nPosArotina)

//������������������������������������Ŀ
//� Verifica as perguntas selecionadas �
//��������������������������������������
If !pergunte("AFI200",.T.)
	Return
Endif	
MV_PAR04 := UPPER(MV_PAR04)

PRIVATE cPerg	:= "AFI200",cLotefin := "    ",nTotAbat := 0,cConta := " "
PRIVATE nHdlBco:= 0,nHdlConf := 0,nSeq := 0 ,cMotBx := "NOR",nTotAGer:=0
PRIVATE nValEstrang := 0
PRIVATE cMarca := GetMark()
PRIVATE aRotina:= { {OemToAnsi(STR0001) ,"fA200Parm" , 0 , 1},;  // "Parametros"    
                    {OemToAnsi(STR0002) ,"AxVisualm" , 0 , 2},;  // "Visualizar"     
                    {OemToAnsi(STR0003) ,"TESTEM", 0 , 4} }  // "Receber Arquivo"

PRIVATE VALOR  := 0
PRIVATE nHdlPrv := 0
PRIVATE nOtrGa	:= 0

//��������������������������������������Ŀ
//� Define o cabecalho da tela de baixas �
//����������������������������������������
PRIVATE cCadastro := OemToAnsi(STR0006)  //"Comunica��o Banc�ria-Retorno" 

DEFAULT nPosArotina := 0

If nPosArotina > 0
	dbSelectArea('SE1')
	bBlock := &( "{ |a,b,c,d,e| " + aRotina[ nPosArotina,2 ] + "(a,b,c,d,e) }" )
	Eval( bBlock, Alias(), (Alias())->(Recno()),nPosArotina)
Else
	mBrowse( 6, 1,22,75,"SE1")
Endif	

//�������������������������Ŀ
//� Fecha os Arquivos ASCII �
//���������������������������
FCLOSE(nHdlBco)
FCLOSE(nHdlConf)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � fA200Ger � Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Comunicacao Bancaria - Retorno                             ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � fA200Ger()                                                 ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � FinA200                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function TESTEM(cAlias)
Processa({|lEnd| TESTE1(cAlias)})  // Chamada com regua
Return .T.

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � fA200Gera� Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Comunicacao Bancaria - Retorno                             ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � fA200Ger()                                                 ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � FinA200                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function TESTE1(cAlias)
Local cPosNum,cPosData,cPosDesp,cPosDesc,cPosAbat,cPosPrin,cPosJuro,cPosMult
Local cPosOcor,cPosTipo,cPosCC,cPosDtCC,cPosMot
Local lPosNum  :=.f.,lPosData:=.f.,lPosMot  :=.f.
Local lPosDesp :=.f.,lPosDesc:=.f.,lPosAbat :=.f.
Local lPosPrin :=.f.,lPosJuro:=.f.,lPosMult :=.f.
Local lPosOcor :=.f.,lPosTipo:=.f.,lPosOutrD:= .F.
Local lPosCC   :=.f.,lPosDtCC:=.f.,lPosNsNum:=.f.
Local nLidos,nLenNum,nLenData,nLenDesp,nLenDesc,nLenAbat,nLenMot, nTamDet
Local nLenPrin,nLenJuro,nLenMult,nLenOcor,nLenTipo,nLenCC,nLenDtCC
Local cArqConf,cArqEnt,xBuffer
Local lDesconto,lContabiliza
Local cData
Local cPosNsNum , nLenNsNum , cPosOutrD, nLenOutrD
Local lUmHelp 	:= .F.
Local cTabela 	:= "17"
Local lPadrao 	:= .f.
Local lBaixou 	:= .f.
Local nSavRecno:= Recno()
Local nPos
Local aTabela 	:= {}
Local lRecicl	:= GetMv("MV_RECICL")
Local lNaoExiste:= .f.
Local cIndex	:= " "
LOCAL lFina200 := ExistBlock("FINA200" ) 
LOCAL l200Pos  := ExistBlock("FA200POS" ) 
LOCAL lFa200Fil:= ExistBlock("FA200FIL") 
LOCAL lFa200F1 := ExistBlock("FA200F1" ) 
LOCAL lF200Tit := ExistBlock("F200TIT" ) 
LOCAL lF200Fim := ExistBlock("F200FIM" ) 
LOCAL lF200Var := ExistBlock("F200VAR" ) 
LOCAL lF200Avl := ExistBlock("F200AVL" ) 
LOCAL l200Fil  := .F.
LOCAL lFirst	:= .F.
Local cMotBan	:= Space(10)				// motivo da ocorrencia no banco
Local nCont, cMotivo, lSai := .f.
Local aLeitura := {}
Local lFa200_02 := ExistBlock("FA200_02")
Local aValores := {}
LOCAL lBxCnab  := GetMv("MV_BXCNAB") == "S"
LOCAL cNomeArq
LOCAL aCampos  := {}
Local lAchou	:= .F.
Local nTamParc := TAMSX3("E1_PARCELA")[1]
Local nX := 0
Local nRegSE5 := 0
Local lPosDtVc := .F.
Local nLenDtVc
Local cPosDtVc
Local lF200ABAT := ExistBlock("F200ABAT")
nHdlBco   	:= 0
nHdlConf   	:= 0
nSeq       	:= 0 
cMotBx     	:= "NOR"
nTotAGer   	:= 0
nTotDesp   	:= 0 // Total de Despesas para uso com MV_BXCNAB
nTotOutD   	:= 0 // Total de outras despesas para uso com MV_BXCNAB
nTotValCC   := 0 // Total de outros creditos para uso com MV_BXCNAB
nValEstrang := 0
VALOR    	:= 0
nHdlPrv  	:= 0

Private cBanco
Private cAgencia
Private cConta
Private cHist070
Private lAut:=.f.,nTotAbat := 0
Private cArquivo
Private dDataCred
Private lCabec := .f.
Private cPadrao
Private nTotal := 0
Private cModSpb := "1"  // Informado apenas para nao dar problemas nas rotinas de baixa
Private nAcresc
Private nDecresc

//��������������������������������������������������������������Ŀ
//� Posiciona no Banco indicado                                  �
//����������������������������������������������������������������
cBanco  := mv_par06
cAgencia:= mv_par07
cConta  := mv_par08
cSubCta := mv_par09
lDigita := IIF(mv_par01==1,.T.,.F.)
lAglut  := IIF(mv_par02==1,.T.,.F.)

dbSelectArea("SA6")
DbSetOrder(1)
SA6->( dbSeek(cFilial+cBanco+cAgencia+cConta) )

dbSelectArea("SEE")
DbSetOrder(1)
SEE->( dbSeek(cFilial+cBanco+cAgencia+cConta+cSubCta) )
If !SEE->( found() )
	Help(" ",1,"PAR150")
	Return .F.
Endif

If lBxCnab // Baixar arquivo recebidos pelo CNAB aglutinando os valores
	If Empty(SEE->EE_LOTE)
		cLoteFin := "0001"
	Else
		cLoteFin := Soma1(SEE->EE_LOTE)
	EndIf
EndIf
nTamDet := Iif( Empty (SEE->EE_NRBYTES), 400 , SEE->EE_NRBYTES )
nTamDet+=2  // ajusta tamanho do detalhe para ler o CR+LF
cTabela := Iif( Empty(SEE->EE_TABELA), "17" , SEE->EE_TABELA )
//���������������������������������������Ŀ
//� Verifica se a tabela existe           �
//�����������������������������������������
dbSelectArea( "SX5" )
If !SX5->( dbSeek( cFilial + cTabela ) )
	Help(" ",1,"PAR150")
   Return .F.
Endif

While !SX5->(Eof()) .and. SX5->X5_TABELA == cTabela
	AADD(aTabela,{Alltrim(X5Descri()),AllTrim(SX5->X5_CHAVE)})
	SX5->(dbSkip( ))
Enddo

//��������������������������������������������������������������Ŀ
//� Verifica o numero do Lote                                    �
//����������������������������������������������������������������
PRIVATE cLote
dbSelectArea("SX5")
dbSeek(cFilial+"09FIN")
cLote := Substr(X5Descri(),1,4)

//������������������������������������������������������������������������Ŀ
//� Verifica se � um EXECBLOCK e caso sendo, executa-o							�
//��������������������������������������������������������������������������
If At(UPPER("EXEC"),X5Descri()) > 0
	cLote := &(X5Descri())
Endif

If ( MV_PAR12 == 1 )
	//������������������������������Ŀ
	//� Abre arquivo de configuracao �
	//��������������������������������
	cArqConf:=mv_par05
	IF !FILE(cArqConf)
		Help(" ",1,"NOARQPAR")
		Return .F.
	Else
		nHdlConf:=FOPEN(cArqConf,0+64)
	EndIF

	//����������������������������Ŀ
	//� L� arquivo de configuracao �
	//������������������������������
	nLidos:=0
	FSEEK(nHdlConf,0,0)
	nTamArq:=FSEEK(nHdlConf,0,2)
	FSEEK(nHdlConf,0,0)

	While nLidos <= nTamArq
    
		//�������������������������������������������Ŀ
		//� Verifica o tipo de qual registro foi lido �
		//���������������������������������������������
		xBuffer:=Space(85)
		FREAD(nHdlConf,@xBuffer,85)
		IF SubStr(xBuffer,1,1) == CHR(1)
			nLidos+=85
			Loop
		EndIF
		IF SubStr(xBuffer,1,1) == CHR(3)
			nLidos+=85
			Exit
		EndIF

		IF !lPosNum
			cPosNum:=Substr(xBuffer,17,10)
			nLenNum:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosNum:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosData
			cPosData:=Substr(xBuffer,17,10)
			nLenData:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosData:=.t.
			nLidos+=85
			Loop
		End
		IF !lPosDesp
			cPosDesp:=Substr(xBuffer,17,10)
			nLenDesp:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDesp:=.t.
			nLidos+=85
			Loop
		End
		IF !lPosDesc
			cPosDesc:=Substr(xBuffer,17,10)
			nLenDesc:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDesc:=.t.
			nLidos+=85
			Loop
		End
		IF !lPosAbat
			cPosAbat:=Substr(xBuffer,17,10)
			nLenAbat:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosAbat:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosPrin
			cPosPrin:=Substr(xBuffer,17,10)
			nLenPrin:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosPrin:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosJuro
			cPosJuro:=Substr(xBuffer,17,10)
			nLenJuro:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosJuro:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosMult
			cPosMult:=Substr(xBuffer,17,10)
			nLenMult:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosMult:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosOcor
			cPosOcor:=Substr(xBuffer,17,10)
			nLenOcor:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosOcor:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosTipo
			cPosTipo:=Substr(xBuffer,17,10)
			nLenTipo:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosTipo:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosOutrD
			cPosOutrD:=Substr(xBuffer,17,10)
			nLenOutrD:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosOutrD:=.t.
			nLidos+=85
			Loop
		EndIF	
		IF !lPosCC
			cPosCC:=Substr(xBuffer,17,10)
			nLenCC:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosCC:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosDtCc
			cPosDtCc:=Substr(xBuffer,17,10)
			nLenDtCc:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDtCc:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosNsNum
			cPosNsNum := Substr(xBuffer,17,10)
			nLenNsNum := 1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosNsNum := .t.
			nLidos += 85
			Loop
		EndIF
		IF !lPosMot									// codigo do motivo da ocorrencia
			cPosMot:=Substr(xBuffer,17,10)
			nLenMot:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosMot:=.t.
			nLidos+=85
			Loop
		EndIF
		If !lPosDtVc
			cPosDtVc:=Substr(xBuffer,17,10)
			nLenDtVc:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDtVc:=.t.
			nLidos+=85
			Loop
		Endif
	EndDo

	//�������������������������������Ŀ
	//� fecha arquivo de configuracao �
	//���������������������������������
	Fclose(nHdlConf)
EndIf
//���������������������������������Ŀ
//� Abre arquivo enviado pelo banco �
//�����������������������������������
cArqEnt:=mv_par04
IF !FILE(cArqEnt)
	Help(" ",1,"NOARQENT")
	Return .F.
Else
	nHdlBco:=FOPEN(cArqEnt,0+64)
EndIF

If lRecicl
	//��������������������������������������������������������������Ŀ
	//� Filtra o arquivo por E1_NUMBCO - caso exista reciclagem      �
	//����������������������������������������������������������������
	dbSelectArea("SE1")
	cIndex	:= CriaTrab(nil,.f.)
	cChave	:= IndexKey()
	IndRegua("SE1",cIndex,"E1_FILIAL+E1_NUMBCO",,Fa200ChecF(),OemToAnsi(STR0009))  //"Selecionando Registros..."
	nIndex := RetIndex("SE1")
	dbSelectArea("SE1")
	#IFNDEF TOP
		dbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
    
	dbGoTop()
	IF BOF() .and. EOF()
		Help(" ",1,"RECNO")
		Return
	EndIf
EndIf

If !(Chk200File())
	Return .F.
Endif

//����������������������������������������������������������������������Ŀ
//� Chama a SumAbatRec antes do Controle de transa��o para abrir o alias �
//� auxiliar __SE1																		 �
//������������������������������������������������������������������������
SumAbatRec( "", "", "", 1, "")

//��������������������������������������������������������������Ŀ
//� Gera arquivo de Trabalho                                     �
//����������������������������������������������������������������
AADD(aCampos,{"DATAC","D",08,0})
AADD(aCampos,{"TOTAL","N",17,2})

cNomeArq:=CriaTrab(aCampos)
dbUseArea( .T., __cRDDNTTS, cNomeArq, "TRB", if(.F. .Or. .F., !.F., NIL), .F. )
IndRegua("TRB",cNomeArq,"Dtos(DATAC)",,,"")

//�������������������������������Ŀ
//� L� arquivo enviado pelo banco �
//���������������������������������
nLidos:=0
FSEEK(nHdlBco,0,0)
nTamArq:=FSEEK(nHdlBco,0,2)
FSEEK(nHdlBco,0,0)
//����������������������������������������������������Ŀ
//� Desenha o cursor e o salva para poder moviment�-lo �
//������������������������������������������������������
ProcRegua( nTamArq/nTamDet , 24 )

lFirst := .F.
nTotAger := 0
nCtDesp := 0
nCtOutCrd := 0 

While nLidos <= nTamArq
	IncProc()
	nDespes :=0
	nDescont:=0
	nAbatim :=0
	nValRec :=0
	nJuros  :=0
	nMulta  :=0
	nValCc  :=0
	nCM     :=0
	nOutrDesp :=0   
	If ( MV_PAR12 == 1 )
		//�����������������������������Ŀ
		//� Tipo qual registro foi lido �
		//�������������������������������
		xBuffer:=Space(nTamDet)
		FREAD(nHdlBco,@xBuffer,nTamDet)    
    
		IF SubStr(xBuffer,1,1) $ "0#A"
			nLidos+=nTamDet
			Loop
		EndIF
		IF SubStr(xBuffer,1,1) $ "1#F#J#7#2"
			//����������������������������������Ŀ
			//� L� os valores do arquivo Retorno �
			//������������������������������������
			cNumTit :=Substr(xBuffer,Int(Val(Substr(cPosNum, 1,3))),nLenNum )
			cData   :=Substr(xBuffer,Int(Val(Substr(cPosData,1,3))),nLenData)
			cData   :=ChangDate(cData,SEE->EE_TIPODAT)
			dBaixa  :=Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
			cTipo   :=Substr(xBuffer,Int(Val(Substr(cPosTipo, 1,3))),nLenTipo )
			cTipo   := Iif(Empty(cTipo),"NF ",cTipo)		// Bradesco
			cNsNum  := " "
			cEspecie:= "   "
			dDataCred := Ctod("//")
			dDtVc := Ctod("//")
			IF !Empty(cPosDesp)
				nDespes:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosDesp,1,3))),nLenDesp))/100,2)
			EndIF
			IF !Empty(cPosDesc)
				nDescont:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosDesc,1,3))),nLenDesc))/100,2)
			EndIF
			IF !Empty(cPosAbat)
				nAbatim:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosAbat,1,3))),nLenAbat))/100,2)
			EndIF
			IF !Empty(cPosPrin)
				nValRec :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosPrin,1,3))),nLenPrin))/100,2)
			EndIF
			IF !Empty(cPosJuro)
				nJuros  :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosJuro,1,3))),nLenJuro))/100,2)
			EndIF
			IF !Empty(cPosMult)
				nMulta  :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosMult,1,3))),nLenMult))/100,2)
			EndIF
			IF !Empty(cPosOutrd)
				nOutrDesp  :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosOutrd,1,3))),nLenOutrd))/100,2)
			EndIF
			IF !Empty(cPosCc)
				nValCc :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosCc,1,3))),nLenCc))/100,2)
			EndIF
			IF !Empty(cPosDtCc)
				cData  :=Substr(xBuffer,Int(Val(Substr(cPosDtCc,1,3))),nLenDtCc)
				cData    := ChangDate(cData,SEE->EE_TIPODAT)
				dDataCred:=Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
				dDataUser:=dDataCred
			End
			IF !Empty(cPosNsNum)
				cNsNum  :=Substr(xBuffer,Int(Val(Substr(cPosNsNum,1,3))),nLenNsNum)
			End
			If nLenOcor == 2
				cOcorr  :=Substr(xBuffer,Int(Val(Substr(cPosOcor,1,3))),nLenOcor) + " "
			Else
				cOcorr  :=Substr(xBuffer,Int(Val(Substr(cPosOcor,1,3))),nLenOcor)
			EndIf	
			If !Empty(cPosMot)
				cMotBan:=Substr(xBuffer,Int(Val(Substr(cPosMot,1,3))),nLenMot)
			EndIf
			IF !Empty(cPosDtVc)
				cDtVc :=Substr(xBuffer,Int(Val(Substr(cPosDtVc,1,3))),nLenDtVc)
				cDtVc := ChangDate(cDtVc,SEE->EE_TIPODAT)
				dDtVc :=Ctod(Substr(cDtVc,1,2)+"/"+Substr(cDtVc,3,2)+"/"+Substr(cDtVc,5,2),"ddmmyy")
			EndIf


			//�������������������������������Ŀ
			//� o array aValores ir� permitir �
			//� que qualquer exce��o ou neces-�
			//� sidade seja tratado no ponto  �
			//� de entrada em PARAMIXB        �
			//���������������������������������
			// Estrutura de aValores
			//	Numero do T�tulo	- 01
			//	data da Baixa		- 02
			// Tipo do T�tulo		- 03
			// Nosso Numero		- 04
			// Valor da Despesa	- 05
			// Valor do Desconto	- 06
			// Valor do Abatiment- 07
			// Valor Recebido    - 08
			// Juros					- 09
			// Multa					- 10
			// Outras Despesas	- 11
			// Valor do Credito	- 12
			// Data Credito		- 13
			// Ocorrencia			- 14
			// Motivo da Baixa 	- 15
			// Linha Inteira		- 16
			// Data de Vencto	   - 17
			
			aValores := ( { cNumTit, dBaixa, cTipo, cNsNum, nDespes, nDescont, nAbatim, nValRec, nJuros, nMulta, nOutrDesp, nValCc, dDataCred, cOcorr, cMotBan, xBuffer,dDtVc })

			If lF200Var
				ExecBlock("F200VAR",.F.,.F.,{aValores})
			Endif

			//�������������������������������Ŀ
			//� Verifica especie do titulo    �
			//���������������������������������
			nPos := Ascan(aTabela, {|aVal|aVal[1] == Substr(cTipo,1,2)})
			If nPos != 0
				cEspecie := aTabela[nPos][2]
			Else
				cEspecie	:= "  "
			EndIf								
			If cEspecie $ MVABATIM			// Nao l� titulo de abatimento
				nLidos += nTamDet
				Loop
			Endif
		Else
			nLidos += nTamDet
			Loop
		Endif
	Else
		aLeitura := ReadCnab2(nHdlBco,MV_PAR05,nTamDet)
		If ( Empty(aLeitura[1]) )
			nLidos += nTamDet
			Loop
		Endif
		cNumTit  := SubStr(aLeitura[1],1,10)
		cData    := aLeitura[04]
		cData    := ChangDate(cData,SEE->EE_TIPODAT)
		dBaixa   := Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
		cTipo    := aLeitura[02]
		cTipo    := Iif(Empty(cTipo),"NF ",cTipo)		// Bradesco
		cNsNum   := aLeitura[11]
		nDespes  := aLeitura[06]
		nDescont := aLeitura[07]
		nAbatim  := aLeitura[08]
		nValRec  := aLeitura[05]
		nJuros   := aLeitura[09]
		nMulta   := aLeitura[10]
		cOcorr   := PadR(aLeitura[03],3)
		nValOutrD:= aLeitura[12]
		nValCC   := aLeitura[13]
		cData    := aLeitura[14]
		cData    := ChangDate(cData,SEE->EE_TIPODAT)
		dDataCred:= Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
		dDataUser:= dDataCred
		cMotBan  := aLeitura[15]
		xBuffer  := aLeitura[17]
		dDtVc		:= CTOD("//")

		aValores := ( { cNumTit, dBaixa, cTipo, cNsNum, nDespes, nDescont, nAbatim, nValRec, nJuros, nMulta, nVaLOutrD, nValCc, dDataCred, cOcorr, cMotBan, xBuffer })

		If lF200Var
			ExecBlock("F200VAR",.F.,.F.,{aValores})
		Endif

		//�������������������������������Ŀ
		//� Verifica especie do titulo    �
		//���������������������������������
		nPos := Ascan(aTabela, {|aVal|aVal[1] == Alltrim(Substr(cTipo,1,3))})
		If nPos != 0
			cEspecie := aTabela[nPos][2]
		Else
			cEspecie	:= "  "
		EndIf
		If cEspecie $ MVABATIM			// Nao l� titulo de abatimento
			Loop
		EndIf
	EndIf   
	If lF200Avl .And. !ExecBlock("F200AVL",.F.,.F.,{aValores} ) 
		Loop
	Endif
	//�������������������������������Ŀ
	//� Verifica codigo da ocorrencia �
	//� �ndice: Filial+banco+cod banco�
	//� +tipo                         �
	//���������������������������������
	dbSelectArea("SEB")
	If !(dbSeek(cFilial+mv_par06+cOcorr+"R"))
		Help(" ",1,"FA200OCORR",,mv_par06+"-"+cOcorr+"R",4,1)
	Endif
	lHelp 		:= .F.
	lNaoExiste  := .F.				// Verifica se registro de reciclagem existe no SE1
	If l200pos
		Execblock("FA200POS",.F.,.F.,{aValores})
	Endif
	//���������������������������������������������������������������Ŀ
	//� Verifica se existe o titulo no SE1. Caso este titulo nao seja �
	//� localizado, passa-se para a proxima linha do arquivo retorno. �
	//� O texto do help sera' mostrado apenas uma vez, tendo em vista �
	//� a possibilidade de existirem muitos titulos de outras filiais.�
	//� OBS: Sera verificado inicialmente se nao existe outra chave   �
	//� igual para tipos de titulo diferentes.                        �
	//�����������������������������������������������������������������
	dbSelectArea("SE1")
	If SEB->EB_OCORR != "39"		// cod 39 -> indica reciclagem
		dbSetOrder(1)
      lAchou := .F.
		If !lFa200Fil
			// Busco pelo IdCnab
			dbSetOrder(16)  // Filial+IdCnab
			If dbSeek(xFilial("SE1")+Substr(cNumTit,1,10))
				cEspecie := SE1->E1_TIPO
            lAchou := .T.
				nPos   := 1
    		Endif
			While !lAchou
				// Busca por chave antiga
				dbSetOrder(1)
				If !dbSeek(cFilial+cNumTit+Space(nTamParc-1)+cEspecie)
					nPos := Ascan(aTabela, {|aVal|aVal[1] == Substr(cTipo,1,2)},nPos+1)
					If nPos != 0
						cEspecie := aTabela[nPos][2]
					Else
						Exit
					Endif
				Else
					Exit
				Endif
			Enddo
			If nPos == 0
				lHelp := .T.
			EndIF
			If !lUmHelp .And. lHelp
				Help(" ",1,"NOESPECIE",,cNumTit+" "+cEspecie,5,1)
				lUmHelp := .T.
			Endif
		Else
			l200Fil := .T.
			Execblock("FA200FIL",.F.,.F.)
		EndIf
	Else
		If lRecicl
			//���������������������������������������������������������������Ŀ
			//� Mesmo que nao exista o registro no SE1, ele ser� criado no 	�
			//� arquivo de reclicagem                                         �
			//�����������������������������������������������������������������
			dbSetOrder(nIndex+1)
			If !dbSeek(cFilial+cNsNum)
				If !lFirst
					Fa200Recic()				// Abre arquivo de reciclagem
					lFirst := .T.
				EndIf
				Fa200GrRec(cNsNum)
				lNaoExiste := .T.				// Registro nao existente no SE1 -> portanto nao deve gravar nada no SE1!!
			Endif
		Else			// � uma rejeicao porem o registro nao foi cadastrado no SE1
			Help(" ",1,"NOESPECIE",,cNumTit+" "+cEspecie,5,1)
			lNaoExiste := .T.
		EndIf	
	EndIF	

	If !lHelp .And. !lNaoExiste
		lSai := .f.
		IF SEB->EB_OCORR $ "03�15�16�17�40�41�42"		//Registro rejeitado
			For nCont := 1 To Len(cMotBan) Step 2
				cMotivo := Substr(cMotBan,nCont,2)
				If fa200Rejeita(cMotivo)
					lSai := .T.
					//������������������������������������������������Ŀ
					//� Trata tarifas da retirada do titulo do banco	�
					//��������������������������������������������������
			      If lBxCnab
			      	nTotDesp += nDespes
						nTotOutD += nOutrDesp
			      Else
						IF nDespes > 0 .or. nOutrDesp > 0		//Tarifas diversas
							Fa200Tarifa()
						Endif
					Endif
					Exit
				EndIf
			Next nCont
			If lSai
				If ( MV_PAR12 == 1 )
					nLidos += nTamDet
				Endif
				Loop
			EndIf
		Endif
		
		BEGIN TRANSACTION
            
		IF SEB->EB_OCORR $ "06�07�08�36�37�38�39"		//Baixa do Titulo
			cPadrao:=fA070Pad()
			lPadrao:=VerPadrao(cPadrao)
			lContabiliza:= Iif(mv_par11==1,.T.,.F.)
                
			//�������������������������������Ŀ
			//� Monta Contabilizacao.         �
			//���������������������������������
			If !lCabec .and. lPadrao .and. lContabiliza
				nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
				lCabec := .T.
			End
			nValEstrang := SE1->E1_SALDO
			lDesconto   := Iif(mv_par10==1,.T.,.F.)
			nTotAbat	:= SumAbatRec(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,;
							SE1->E1_MOEDA,"S",dBaixa)
			cBanco      := Iif(Empty(SE1->E1_PORTADO),cBanco,SE1->E1_PORTADO)
			cAgencia    := Iif(Empty(SE1->E1_AGEDEP),cAgencia,SE1->E1_AGEDEP)
			cConta      := Iif(Empty(SE1->E1_CONTA),cConta,SE1->E1_CONTA)
			cHist070    := OemToAnsi(STR0010)  //"Valor recebido s/ Titulo"
			

			//Ponto de entrada para tratamento de abatimento e desconto que voltam na mesma posicao
			//Bradesco
			If lF200ABAT
				ExecBlock("F200ABAT",.F.,.F.)
			Endif
				
			SA6->(DbSetOrder(1))
			SA6->(MSSeek(xFilial("SA6")+cBanco+cAgencia+cConta))

			//�������������������������������Ŀ
			//� Verifica se a despesa est�    �
			//� descontada do valor principal �
			//���������������������������������
			If SEE->EE_DESPCRD == "S"
				nValRec := nValRec+nDespes + nOutrDesp - nValCC
			EndIf
			// Calcula a data de credito, se esta estiver vazia
			If dDataCred == Nil .Or. Empty(dDataCred)
				dDataCred := dBaixa // Assume a data da baixa
				For nX := 1 To Sa6->A6_Retenca // Para todos os dias de retencao
														 // valida a data

					// O calculo eh feito desta forma, pois os dias de retencao
					// sao dias uteis, e se fosse apenas somado dDataCred+A6_Retenca
					// nao sera verdadeiro quando a data for em uma quinta-feira, por
					// exemplo e, tiver 2 dias de retencao.
					dDataCred := DataValida(dDataCred+1,.T.)
				Next
			EndIf
			dDataUser := dDataCred
			If dDataCred > dBaixa
				cModSpb := "3"   // COMPE
			Endif
			//����������������������������������Ŀ
			//� Possibilita alterar algumas das  �
			//� vari�veis utilizadas pelo CNAB.  �
			//������������������������������������
			If lFina200
				ExecBlock("FINA200",.F.,.F.)
			Endif
			
			// Serao usadas na Fa070Grv para gravar a baixa do titulo, considerando os acrescimos e decrescimos
			nAcresc     := Round(NoRound(xMoeda(SE1->E1_SDACRES,SE1->E1_MOEDA,1,dBaixa,3),3),2)
			nDecresc    := Round(NoRound(xMoeda(SE1->E1_SDDECRE,SE1->E1_MOEDA,1,dBaixa,3),3),2)

			lBaixou:=fA070Grv(lPadrao,lDesconto,lContabiliza,cNsNum,.T.,dDataCred,.f.,cArqEnt,SEB->EB_OCORR)

			If lBaixou
				nTotAGer+=nValRec
				//Para baixa totalizadora somente gravo o movimento de titulos que
				//nao estejam em carteira descontada (2 ou 7) pois este movimento bancario
				//j� foi gerado no momento da transferencia ou montagem do bordero
				IF !(SE1->E1_SITUACA $ "2/7")
					dbSelectArea("TRB")
					If !(dbSeek(Dtos(dDataCred)))
						Reclock("TRB",.T.)
						Replace DATAC With dDataCred
					Else
						Reclock("TRB",.F.)
					Endif
					Replace TOTAL WITH TOTAL + nValRec
					MsUnlock()
				Endif
			Endif	

			If lBxCnab
				nTotValCc += nValCC
			Else
				//��������������������������������������������������������Ŀ
				//� Grava Outros Cr�ditos, se houver valor                 �
				//����������������������������������������������������������
				If nValcc > 0
					fa200Outros()
				Endif
			Endif
			
			If lCabec .and. lPadrao .and. lContabiliza .and. lBaixou
				nTotal+=DetProva(nHdlPrv,cPadrao,"FINA200",cLote)
			Endif

			//�������������������������������Ŀ
			//� Credito em C.Corrente -> gera �
			//� arquivo de reciclagem         �
			//���������������������������������
			If SEB->EB_OCORR $ "39"
				If lRecicl
					If !lFirst
						Fa200Recic()
						lFirst := .T.
					EndIf
					Fa200GrRec(cNsNum)
					dbSelectArea("SE1")
					RecLock("SE1")
					Replace E1_OCORREN With "02"
					MsUnlock()
				EndIf	
			EndIf
		Endif

      If lBxCnab
      	nTotDesp += nDespes
			nTotOutD += nOutrDesp
      Else
			IF nDespes > 0 .or. nOutrDesp > 0		//Tarifas diversas
				Fa200Tarifa()
			Endif
		Endif			

		If SEB->EB_OCORR == "02"			// Confirma��o
			RecLock("SE1")
			SE1->E1_OCORREN := "01"
			If Empty(SE1->E1_NUMBCO)
				SE1->E1_NUMBCO  := cNsNUM
			EndIf
			MsUnLock()
			If lFa200_02
				ExecBlock("FA200_02",.f.,.f.)
			Endif
		Endif

		//Grava alteracao da data de vencto quando for o caso
		If SEB->EB_OCORR $ "14" .and. !Empty(dDtVc)  //Alteracao de Vencto
			RecLock("SE1")
			Replace SE1->E1_VENCTO With dDtVc
			Replace SE1->E1_VENCREA With DataValida(dDtVc,.T.)
			MsUnlock()
		Endif

		END TRANSACTION

	Endif
	// Avanca uma linha do arquivo retorno
	nLidos+=nTamDet

	//����������������������������������Ŀ
	//� Possibilita alterar algumas das  �
	//� vari�veis utilizadas pelo CNAB.  �
	//������������������������������������
	If lF200Tit
		ExecBlock("F200TIT",.F.,.F.)
	Endif

Enddo

If lCabec .and. lPadrao .and. lContabiliza 
	dbSelectArea("SE1")
	dbGoBottom()
	dbSkip()
	VALOR := nTotAger
	nTotal+=DetProva(nHdlPrv,cPadrao,"FINA200",cLote)
Endif

If l200Fil .and. lfa200F1
	Execblock("FA200F1",.f.,.f.)
Endif

If lF200Fim
	Execblock("F200FIM",.f.,.f.)
Endif

//������������������������������������������������������Ŀ
//� Grava no SEE o n�mero do �ltimo lote recebido e gera �
//� movimentacao bancaria											�
//��������������������������������������������������������
If !Empty(cLoteFin) .and. lBxCnab
	RecLock("SEE",.F.)
	SEE->EE_LOTE := cLoteFin
	MsUnLock()
	If TRB->(Reccount()) > 0
		dbSelectArea("TRB")
		dbGoTop()
		While !Eof()
			Reclock( "SE5" , .T. )
			SE5->E5_FILIAL := xFilial()
			SE5->E5_DATA   := TRB->DATAC
			SE5->E5_VALOR  := TRB->TOTAL
			SE5->E5_RECPAG := "R"
			SE5->E5_DTDIGIT:= TRB->DATAC
			SE5->E5_BANCO  := cBanco
			SE5->E5_AGENCIA:= cAgencia
			SE5->E5_CONTA  := cConta
			SE5->E5_DTDISPO:= TRB->DATAC
			SE5->E5_LOTE   := cLoteFin
			SE5->E5_HISTOR := STR0011 + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
			If SpbInUse()
				SE5->E5_MODSPB := "1"
			Endif
			MsUnlock()

			//������������������������������������������������������Ŀ
			//� Gravacao complementar dos dados da baixa aglutinada  �
			//��������������������������������������������������������
			If ExistBlock("F200BXAG")                               
				Execblock("F200BXAG",.f.,.f.)
			Endif

			//�������������������������������Ŀ
			//� Atualiza saldo bancario.      �
			//���������������������������������
			AtuSalBco(cBanco,cAgencia,cConta,SE5->E5_DATA,SE5->E5_VALOR,"+")
			dbSelectArea("TRB")
			dbSkip()
		Enddo
	Endif
	If nTotDesp > 0 .Or. nTotOutD > 0
		Fa200Tarifa(nTotDesp, nTotOutD)
	Endif		
	If nTotValCC > 0
		fa200Outros(nTotValCC)
	Endif		
EndIf

//Contabilizo totalizador das despesas banc�rias e outros creditos
If !lBxCnab

	VALOR2 := nCtDesp
	VALOR3 := nCtOutCrd

	dbSelectArea("SE5")
	nRegSE5 := SE5->(Recno())
	dbGoBottom()
	dbSkip()

	lPadrao:=VerPadrao("562")		// Movimentacao Banc�ria a Pagar
	lContabiliza:= Iif(mv_par11==1,.T.,.F.)

	If !lCabec .and. lPadrao .and. lContabiliza
		nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
		lCabec := .T.
	Endif

	If lCabec .and. lPadrao .and. lContabiliza
		nTotal+=DetProva(nHdlPrv,"562","FINA200",cLote)  //Total de Despesas e Outras despesas
		nTotal+=DetProva(nHdlPrv,"563","FINA200",cLote)	  //Total de Outros Cr�ditos 
	Endif
	VALOR2 := VALOR3 := 0
	dbSelectArea("SE5")
	dbGoto(nRegSE5)
Endif

IF lCabec .and. nTotal > 0
	RodaProva(nHdlPrv,nTotal)
	//�����������������������������������������������������Ŀ
	//� Envia para Lancamento Contabil                      �
	//�������������������������������������������������������
	cA100Incl(cArquivo,nHdlPrv,3,cLote,lDigita,lAglut)
Endif

If lRecicl .and. lFirst
	dbSelectArea("cTemp")
	dbCloseArea()
	If cIndex != " "
		RetIndex("SE1")
		Set Filter To
		FErase (cIndex+OrdBagExt())
	EndIf	
Endif

dbSelectArea("TRB")
dbCloseArea()
Ferase(cNomeArq+GetDBExtension())         // Elimina arquivos de Trabalho
Ferase(cNomeArq+OrdBagExt())	 			   // Elimina arquivos de Trabalho

VALOR := 0
dbSelectArea( "SE1" )
dbGoTo( nSavRecno )
If ExistBlock("F200IMP")
	ExecBlock("F200IMP",.F.,.F.)
Endif
Return .F.

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �fA200Par  � Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Aciona parametros do Programa                               ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function fA200Parm()
Pergunte( cPerg )
MV_PAR04 := UPPER(MV_PAR04)
Return .T.

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �fA200Rejei� Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Trata titulo rejeitado.                                     ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �fa200Rejei                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function fa200Rejeim(cMotivo)
Local cAlias := Alias()
Local lRet := .F.
Local lPadrao := .f.
Local cNumBor := " "
Private cSituant := "0"									// Private para permitir condicionamento para contabiliza��o

dbSelectArea("SEB")
// Procura pela chave completa->filial+banco+ocorrencia+tipo+motivo banco
If dbSeek(cFilial+mv_par06+cOcorr+"R"+cMotivo)
	IF SEB->EB_MOTSIS == "01" .OR. EMPTY(SEB->EB_MOTSIS)	// Titulo protestado ou nao pago
		dbSelectArea("SEA")											// Retorna p/ carteira
		dbSetOrder(1)
		If dbSeek(cFilial+SE1->E1_NUMBOR+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO)
			Reclock( "SEA" , .F. , .T.)
			SEA->(dbDelete( ))
			MsUnlock()
		EndIf
		//���������������������������������������������������������������Ŀ
		//� PONTO DE ENTRADA FA280RE2                                     �
		//� Tratamento de dados de titulo rejeitado antes de "zerar" os 	�
		//� dados do mesmo.                                               �
		//�����������������������������������������������������������������
		If ExistBlock("FA200RE2")
			Execblock("FA200RE2",.F.,.F.)
		Endif	
		cSituant := SE1->E1_SITUACA
		cNumBor := SE1->E1_NUMBOR
		Reclock( "SE1" )
		SE1->E1_SITUACA := "0"
		SE1->E1_PORTADO := Space(Len(SE1->E1_PORTADO) )
		SE1->E1_AGEDEP  := Space(Len(SE1->E1_AGEDEP ) )
		SE1->E1_CONTA   := Space(Len(SE1->E1_CONTA  ) )
		SE1->E1_DATABOR := CtoD ( "" )
		SE1->E1_NUMBOR  := Space(Len(SE1->E1_NUMBOR ) )
		SE1->E1_NUMBCO  := Space(Len(SE1->E1_NUMBCO ) )
		lRet := .T.
		MsUnlock()

		//���������������������������������������������������������������Ŀ
		//�Efetua a contabilizacao da transferencia para carteira, caso   �
		//�exista este lancamento padrao, pois se nao for feito neste mo- �
		//�mento nao havera registro da rejeicao.                         �
		//�����������������������������������������������������������������
		lPadrao:=VerPadrao("540")
		If !lCabec .and. lPadrao
			nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
			lCabec := .T.
		Endif

		If lCabec .and. lPadrao
			nTotal+=DetProva(nHdlPrv,"540","FINA200",cLote)
			// Forca a contabilizacao da rejeicao on-line pois nao e registrada
			// a transferencia para a carteira
			lDigita := .T.  
		Endif
		
		If cSituAnt == "2"			//  'Se cobranca descontada e rejeita gera um movimento a pagar"
			Reclock("SE5", .T. )
			Replace E5_FILIAL         With xFilial()
			Replace E5_BANCO       With cBanco
			Replace E5_AGENCIA    With cAgencia
			Replace E5_CONTA        With cConta
			Replace E5_VALOR        With nValrec
			Replace E5_HISTOR        With "EST. " + cNumBor+" "+SE1->E1_PREFIXO+" "+SE1->E1_NUM+" "+SE1->E1_PARCELA+" "+SE1->E1_TIPO
			Replace E5_VLMOED2    With nValrec
			Replace E5_RECPAG      With "P"
			Replace E5_DATA           With dBaixa
			Replace E5_DTDIGIT        With dDataBase
			Replace E5_DTDISPO      With dBaixa
			If SpbInUse()
				SE5->E5_MODSPB := "1"
			Endif
			MsUnlock()
			AtuSalBco(cBanco,cAgencia,cConta,SE5->E5_DATA,SE5->E5_VALOR,"-") 

			lPadrao:=VerPadrao("562")
			If !lCabec .and. lPadrao
				nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
				lCabec := .T.
			Endif

			If lCabec .and. lPadrao
				nTotal+=DetProva(nHdlPrv,"562","FINA200",cLote)
				// Forca a contabilizacao da rejeicao on-line pois nao e registrada
				// a transferencia para a carteira
				lDigita := .T.  
			Endif
		EndIf
   Endif
EndIf

//���������������������������������������������������������������Ŀ
//� PONTO DE ENTRADA FA280REJ                                     �
//� Tratamento de dados de titulo rejeitado                     	�
//�����������������������������������������������������������������
If ExistBlock("FA200REJ")
	Execblock("FA200REJ",.F.,.F.)
Endif	
MsUnlock()
dbSelectArea( cAlias )
Return lRet

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �fA200Tarif� Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Trata uma determinada tarifa.                               ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �fa200Tarifa( )                                              ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �Generico                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function fa200Tarifam(nTotDesp, nTotOutD)

Local cAlias := Alias()
Local lPadrao
Local lContabiliza
Local cNat
Local lSpbInUse := SpbInUse()
Local nX := 0

nDespes   := If(nTotDesp == Nil, nDespes  , nTotDesp)
nOutrDesp := If(nTotOutD == Nil, nOutrDesp, nTotOutD)

If nDespes == 0 .and. nOutrDesp == 0
	Return
EndIf	

//���������������������������������������������������������Ŀ
//� Calcula a data de credito, se esta estiver vazia			�
//� Se aplica apenas nos casos de confirma��o de entrada do	�
//� titulo e tenha lancamento de Despesas Banc�rias, pois 	�
//� nas ocorrencias de baixa, essa data ja estara calculada �
//�����������������������������������������������������������
If dDataCred == Nil .Or. Empty(dDataCred)
	dDataCred := dBaixa // Assume a data da baixa
	For nX := 1 To Sa6->A6_Retenca // Para todos os dias de retencao
											 // valida a data
			// O calculo eh feito desta forma, pois os dias de retencao
			// sao dias uteis, e se fosse apenas somado dDataCred+A6_Retenca
			// nao sera verdadeiro quando a data for em uma quinta-feira, por
			// exemplo e, tiver 2 dias de retencao.
		dDataCred := DataValida(dDataCred+1,.T.)
	Next
EndIf

If nDespes > 0
	//�������������������������������Ŀ
	//� Gera registro na movimenta��o �
	//� bancaria.                     �
	//���������������������������������
	cNat := &(GetMv("MV_NATDPBC"))
	Reclock( "SE5" , .T. )
	SE5 -> E5_FILIAL := xFilial()
	SE5 -> E5_DATA   := dBaixa
	SE5 -> E5_VALOR  := nDespes
	SE5 -> E5_NATUREZ:= Iif(!Empty(cNat) .Or. nTotDesp # Nil,cNat,SE1 -> E1_NATUREZ)
	SE5 -> E5_RECPAG := "P"
	SE5 -> E5_DTDIGIT:= dDataBase
	SE5 -> E5_BANCO  := SA6 -> A6_COD
	SE5 -> E5_AGENCIA:= SA6 -> A6_AGENCIA
	SE5 -> E5_CONTA  := SA6 -> A6_NUMCON
	SE5 -> E5_DTDISPO:= dDataCred
	SE5 -> E5_TIPODOC:= "DB"		// Despesas Banc�rias
	SE5 -> E5_MOTBX  := "NOR"		// Normal
	If nTotDesp # Nil
		SE5->E5_LOTE   := cLoteFin
		SE5->E5_HISTOR := STR0011 + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
	Else
		SE5 -> E5_PREFIXO:= SE1 -> E1_PREFIXO
		SE5 -> E5_NUMERO := SE1 -> E1_NUM
		SE5 -> E5_PARCELA:= SE1 -> E1_PARCELA
		SE5 -> E5_TIPO   := SE1 -> E1_TIPO
		SE5 -> E5_CLIFOR := SE1 -> E1_CLIENTE
		SE5 -> E5_LOJA   := SE1 -> E1_LOJA
		SE5 -> E5_HISTOR := SEB -> EB_DESCRI
	Endif
	If lSpbInUse
		SE5->E5_MODSPB := "1"
	Endif
	
	MsUnlock()

	//�������������������������������������������������������������Ŀ
	//� PONTO DE ENTRADA F200DB1                                    �
	//� Serve para tratamento complementar das despesas bancarias.  �
	//���������������������������������������������������������������
	IF ExistBlock("F200DB1")
		ExecBlock("F200DB1",.F.,.F.)
	Endif

	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DATA,SE5->E5_VALOR,"-")

	lPadrao:=VerPadrao("562")		// Movimentacao Banc�ria a Pagar
	lContabiliza:= Iif(mv_par11==1,.T.,.F.)

	If !lCabec .and. lPadrao .and. lContabiliza
		nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
		lCabec := .T.
	Endif

	dbSelectArea("SE5")

	If lCabec .and. lPadrao .and. lContabiliza
		nTotal+=DetProva(nHdlPrv,"562","FINA200",cLote)
		Reclock("SE5",.F.)
		SE5 -> E5_LA := "S"		// Marca a contabiliza��o
		MsUnlock()
	Endif
	nCtDesp += nDespes
Endif

If nOutrDesp > 0
	//�������������������������������Ŀ
	//� Gera registro na movimenta��o �
	//� bancaria.                     �
	//���������������������������������
	cNat := &(GetMv("MV_NATDPBC"))
	Reclock( "SE5" , .T. )
	SE5 -> E5_FILIAL := xFilial()
	SE5 -> E5_DATA   := dBaixa
	SE5 -> E5_VALOR  := nOutrDesp
	SE5 -> E5_NATUREZ:= Iif(!Empty(cNat) .Or. nTotOutD # Nil,cNat,SE1 -> E1_NATUREZ)
	SE5 -> E5_RECPAG := "P"
	SE5 -> E5_DTDIGIT:= dDataBase
	SE5 -> E5_DTDISPO:= dDataCred
	SE5 -> E5_TIPODOC:= "OD"		//Outras Despesas
	SE5 -> E5_MOTBX  := "NOR"		//Normal
	If nTotOutD # Nil
		SE5->E5_LOTE    := cLoteFin
		SE5->E5_HISTOR  := STR0011 + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
		SE5->E5_BANCO   := SA6 -> A6_COD
		SE5->E5_AGENCIA := SA6 -> A6_AGENCIA
		SE5->E5_CONTA   := SA6 -> A6_NUMCON
	Else
		SE5 -> E5_PREFIXO:= SE1 -> E1_PREFIXO
		SE5 -> E5_NUMERO := SE1 -> E1_NUM
		SE5 -> E5_PARCELA:= SE1 -> E1_PARCELA
		SE5 -> E5_TIPO   := SE1 -> E1_TIPO
		SE5 -> E5_CLIFOR := SE1 -> E1_CLIENTE
		SE5 -> E5_LOJA   := SE1 -> E1_LOJA
		SE5 -> E5_HISTOR := SEB -> EB_DESCRI
		SE5 -> E5_BANCO  := SE1 -> E1_PORTADO
		SE5 -> E5_AGENCIA:= SE1 -> E1_AGEDEP
		SE5 -> E5_CONTA  := SE1 -> E1_CONTA
	Endif
	If lSpbInUse
		SE5->E5_MODSPB := "1"
	Endif
	
	MsUnlock()

	//�������������������������������������������������������������Ŀ
	//� PONTO DE ENTRADA F200DB2                                    �
	//� Serve para tratamento complementar de outras despesas.      �
	//���������������������������������������������������������������
	IF ExistBlock("F200DB2")
		ExecBlock("F200DB2",.F.,.F.)
	Endif

	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DATA,SE5->E5_VALOR,"-")

	lPadrao:=VerPadrao("562")		// Movimentacao Banc�ria a Pagar
	lContabiliza:= Iif(mv_par11==1,.T.,.F.)

	If !lCabec .and. lPadrao .and. lContabiliza
		nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
		lCabec := .T.
	Endif

	dbSelectArea("SE5")
	If lCabec .and. lPadrao .and. lContabiliza
		nTotal+=DetProva(nHdlPrv,"562","FINA200",cLote)
		Reclock("SE5",.F.)
		SE5 -> E5_LA := "S"		// Marca a contabiliza��o
		MsUnlock()
	Endif
	nCtDesp += nOutrDesp
Endif
dbSelectArea(cAlias)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �fA200Outro� Autor � Wagner Xavier         � Data � 26/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Trata uma determinada tarifa.                               ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �fa200Tarifa( )                                              ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �Generico                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function fa200Outrosm( nTotValcc )
Local cAlias := Alias()
Local cNat
Local nX := 0

//�������������������������������Ŀ
//� Gera registro na movimenta��o �
//� bancaria.                     �
//���������������������������������

nValCC := If(nTotValCC = Nil, nValCC, nTotValCC)

If nValCC = 0
	Return .T.
Endif

//���������������������������������������������������������Ŀ
//� Calcula a data de credito, se esta estiver vazia			�
//� Se aplica apenas nos casos de confirma��o de entrada do	�
//� titulo e tenha lancamento de Despesas Banc�rias, pois 	�
//� nas ocorrencias de baixa, essa data ja estara calculada �
//�����������������������������������������������������������
If dDataCred == Nil .Or. Empty(dDataCred)
	dDataCred := dBaixa // Assume a data da baixa
	For nX := 1 To Sa6->A6_Retenca // Para todos os dias de retencao
											 // valida a data
			// O calculo eh feito desta forma, pois os dias de retencao
			// sao dias uteis, e se fosse apenas somado dDataCred+A6_Retenca
			// nao sera verdadeiro quando a data for em uma quinta-feira, por
			// exemplo e, tiver 2 dias de retencao.
		dDataCred := DataValida(dDataCred+1,.T.)
	Next
EndIf

//�������������������������������Ŀ
//� Gera registro na movimenta��o �
//� bancaria.                     �
//���������������������������������
cNat := &(GetMv("MV_NATDPBC"))
Reclock( "SE5" , .T. )
SE5->E5_FILIAL := xFilial()
SE5->E5_DATA   := dBaixa
SE5->E5_VALOR  := nValcc
SE5->E5_TIPODOC:= "DB"		//Outros Cr�ditos
SE5->E5_NATUREZ:= Iif(!Empty(cNat) .Or. nTotValCC # Nil,cNat,SE1 -> E1_NATUREZ)
SE5->E5_RECPAG := "R"
SE5->E5_DTDIGIT:= dDataBase
SE5->E5_BANCO  := SA6->A6_COD
SE5->E5_AGENCIA:= SA6->A6_AGENCIA
SE5->E5_CONTA  := SA6->A6_NUMCON
SE5->E5_DTDISPO:= dDataCred
SE5->E5_MOTBX  := "NOR"	// Normal
If nTotValCC # Nil
	SE5->E5_LOTE    := cLoteFin
	SE5->E5_HISTOR  := STR0011 + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
Else 	
	SE5->E5_PREFIXO:= SE1->E1_PREFIXO
	SE5->E5_NUMERO := SE1->E1_NUM
	SE5->E5_PARCELA:= SE1->E1_PARCELA
	SE5->E5_TIPO   := SE1->E1_TIPO
	SE5->E5_CLIFOR := SE1->E1_CLIENTE
	SE5->E5_LOJA   := SE1->E1_LOJA
	SE5->E5_HISTOR := SEB->EB_DESCRI
Endif
If SpbInUse()
	SE5->E5_MODSPB := "1"
Endif

MsUnlock()

//�������������������������������������������������������������Ŀ
//� PONTO DE ENTRADA F200OCR                                    �
//� Serve para tratamento complementar de outros creditos.      �
//���������������������������������������������������������������
IF ExistBlock("F200OCR")
	ExecBlock("F200OCR",.F.,.F.)
Endif

//�������������������������������Ŀ
//� Atualiza saldo bancario.      �
//���������������������������������
AtuSalBco(cBanco,cAgencia,cConta,dBaixa,nValcc,"+")

lPadrao:=VerPadrao("563")		// Movimentacao Banc�ria a Receber
lContabiliza:= Iif(mv_par11==1,.T.,.F.)

If !lCabec .and. lPadrao .and. lContabiliza
	nHdlPrv:=HeadProva(cLote,"FINA200",Substr(cUsuario,7,6),@cArquivo)
	lCabec := .T.
Endif

dbSelectArea("SE5")

If lCabec .and. lPadrao .and. lContabiliza
	nTotal+=DetProva(nHdlPrv,"563","FINA200",cLote)
	Reclock("SE5",.F.)
	SE5->E5_LA := "S"
	MsUnlock()
Endif
nCtOutCrd := nValcc
dbSelectArea( cAlias )
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �Fa200Recic� Autor � Pilar S. Albaladejo   � Data � 22/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Cria o arquivo de reciclagem                                ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �fa200Recic( )	                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �Generico                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Fa200Recicm()

Local cDbf , aCampos
cDbf := "RECICL" + SubStr(cNumEmp,1,2)

If !File(cDbf+GetDBExtension())
	aCampos:={ {"FILIAL  ","C",02,0},;
              {"NOSSONUM","C",08,0}}
	If (Select("cTemp") <> 0 )
		dbSelectArea ( "cTemp" )
		dbCloseArea ()
	Endif
	dbCreate(cDbf,aCampos)
   dbUseArea(.T.,,cDbf,"cTemp",NIL,.F.)
Endif

dbUseArea(.T.,,cDbf,"cTemp",NIL,.F.)
IndRegua("cTemp",cDbf,"FILIAL+NOSSONUM",,,OemToAnsi(STR0009))  //"Selecionando Registros..."
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �Fa200GrRec� Autor � Pilar S. Albaladejo   � Data � 22/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Grava registros no arquivo de reciclagem                    ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �fa200GrRec( )	                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �Generico                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Fa200GrRecm(cNsNum)
Local cAlias := Alias()
dbSelectArea("cTemp")
If !dbSeek(xFilial("SE1")+cNsNum)
	RecLock("cTemp",.T.)
	Replace FILIAL		With xFilial("SE1")
	Replace NOSSONUM 	With cNsNum
	MsUnlock()
EndIf
dbSelectArea(cAlias)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 �Fa200ChecF� Autor � Pilar S Albaladejo    � Data � 22/05/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Retorna Expresao para Indice Condicional						  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe	 �Fa200ChecF() 															  ���
�������������������������������������������������������������������������Ĵ��
��� Uso		 �Generico																	  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA200ChecFm()
Local cFiltro := ""
cFiltro := 'E1_FILIAL == "'+cFilial+'" .And. E1_SALDO > 0'
Return cFiltro

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 �Chk200File� Autor � Mauricio Pequim Jr    � Data � 24/11/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Checa se arquivo de TB j� foi processado anteriormente		  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe	 �Chk200File()  															  ���
�������������������������������������������������������������������������Ĵ��
��� Uso		 �Fina200																	  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Chk200Filem()
LOCAL cFile := "TB"+cNumEmp+".VRF"
LOCAL lRet	:= .F.
LOCAL aFiles:= {}
LOCAL cString
LOCAL nTam
LOCAL nHdlFile

If !FILE(cFile)
	nHdlFile := fCreate(cFile)
ELSE
	//������������������������������������������������������������Ŀ
	//� Tenta abrir o arquivo em modo exclusivo e Leitura/Gravacao �	
	//��������������������������������������������������������������
	While (nHdlFile := fOpen(cFile,FO_READWRITE+FO_EXCLUSIVE))==-1 .AND. ;
			MsgYesNo( STR0013+cNumEmp+STR0014, STR0012 )
	End
Endif

If nHdlFile > 0

	nTam := TamSx1("AFI200","04")[1] // Tamanho do parametro
	xBuffer := SPACE(nTam)
	// Le o arquivo e adiciona na matriz
	While fReadLn(nHdlFile,@xBuffer,nTam) 
		Aadd(aFiles, Trim(xBuffer))
	Enddo	

	If ASCAN(aFiles,Trim(MV_PAR04)) > 0
		Help(" ",1,"CHK200FILE")       // Arquivo de Trans.Banc. j� processado
	Else
		fSeek(nHdlFile,0,2) // Posiciona no final do arquivo
		cString := Alltrim(mv_par04)+Chr(13)+Chr(10)
		fWrite(nHdlFile,cString)	// Grava nome do arquivo a ser processado
		lRet := .T.
	endif	
	fClose (nHdlFile)
Else
   Help(" ", 1, "CHK200ERRO") // Erro na leitura do arquivo de entrada
EndIf	
Return lRet
