#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ZFATR27   �Autor  �Microsiga           � Data �  12/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ZFATR27

Local oReport
Private cPerg		:= PADR("ZFATR27",LEN(SX1->X1_GRUPO))
Private _nDifVlr	:= 0

oReport:= ReportDef()
oReport:PrintDialog()

Return()


/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Marcos Milare  (MR)   � Data � 13/11/2012 ���
���������������������������������������������������������������������������Ĵ��
���Descricao � Define as configuracoes e a estrutura do relatorio.          ���
���������������������������������������������������������������������������Ĵ��
��� PROGRAMADOR           �  DATA      � MOTIVO DA ALTERACAO                ���
���������������������������������������������������������������������������Ĵ��
���                       �            �                                    ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local cTitle   := "Relat�rio para Carga do SalesForce"
Local oReport
Local oSection1
Local _nLanded	:= 0

CriaSX1(cPerg)
Pergunte(cPerg,.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport:=TReport():New("ZFATR27",cTitle,cPerg, {|oReport| ReportPrint(oReport)},;
"Este relat�rio prepara a carga do SalesForce.")
oReport:SetTotalInLine(.F.)
oReport:SetLandScape()
oReport:nFontBody := 8
oReport:nLineHeight := 40
oReport:SetEdit(.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//��������������������������������������������������������������������������

oSection1:= TRSection():New(oReport,"Rel Carga SalesForce")

oSection1:SetTotalInLine(.F.)
oSection1:SetHeaderPage()
oSection1:nLinesBefore := 0

Return(oReport)


/*/
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrint� Autor � Marcos Milare (MR)    � Data � 13/11/2012 ���
����������������������������������������������������������������������������Ĵ��
���Descricao � Processa as informacoes e imprime o relatorio.                ���
����������������������������������������������������������������������������Ĵ��
��� PROGRAMADOR           �  DATA      � MOTIVO DA ALTERACAO                 ���
����������������������������������������������������������������������������Ĵ��
���                       �            �                                     ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport)

Local oSection1 	:= oReport:Section(1)
Local cTitulo		:= oReport:Title()
Local cSQL			:= ""
Local _cEnter		:= Chr(13)+Chr(10)
Local _cNReduz		:= ""
Local _nVarAno		:= 0
Local _nVarAtu		:= 0

Private _cAnoIni	:= ""
Private _cAnoFim	:= ""
Private _cAtuIni	:= ""
Private _cAtuFim	:= ""
Private _cAntIni	:= ""
Private _cAntFim	:= ""
Private _cQtdFim	:= ""
Private _cQtdIni	:= ""

//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
//�                                                                        �
//�TRCell():New                                                            �
//�ExpO1 : Objeto TSection que a secao pertence                            �
//�ExpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//�ExpC3 : Nome da tabela de referencia da celula                          �
//�ExpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//�ExpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//�ExpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//�ExpL7 : Informe se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//�ExpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//��������������������������������������������������������������������������

TRCell():New( oSection1, "D2_PEDIDO" , "QRY", RetTitle("D2_PEDIDO") )
TRCell():New( oSection1, "F2_VEND1"  , "QRY", RetTitle("F2_VEND1")  )
TRCell():New( oSection1, "A1_CGC"    , "QRY", RetTitle("A1_CGC")    )
TRCell():New( oSection1, "D2_COD"    , "QRY", RetTitle("D2_COD")    )
TRCell():New( oSection1, "D2_QUANT"  , "QRY", RetTitle("D2_QUANT")  )
TRCell():New( oSection1, "D2_PRCVEN" , "QRY", RetTitle("D2_PRCVEN") )
TRCell():New( oSection1, "D2_TOTAL"  , "QRY", RetTitle("D2_TOTAL")  )
TRCell():New( oSection1, "D2_CLIENTE", "QRY", RetTitle("D2_CLIENTE"))
TRCell():New( oSection1, "A1_NOME"   , "QRY", RetTitle("A1_NOME")   )
TRCell():New( oSection1, "D2_EMISSAO", "QRY", RetTitle("D2_EMISSAO"))

//Totais
TRFunction():New(oSection1:Cell("QTDE")		,nil, "SUM"	,/*oBreak*/,"","@E 999,999,999,999"	,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("TOT_ANO")	,nil, "SUM"	,/*oBreak*/,"","@E 999,999,999,999"	,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("TOT_ANT")	,nil, "SUM"	,/*oBreak*/,"","@E 999,999,999,999"	,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("TOT_ATU")	,nil, "SUM"	,/*oBreak*/,"","@E 999,999,999,999"	,/*uFormula*/,.F.,.T.)

oReport:SetTitle(cTitulo)

cSQL := "SELECT	B1_COD, B1_GRUPO, B1_TIPO, D2_CLIENTE, QTDE," +_cEnter
cSQL += "		SUM(PRC_ANO) PRC_ANO, SUM(PRC_ANT) PRC_ANT, SUM(PRC_ATU) PRC_ATU" +_cEnter
cSQL += " FROM (" +_cEnter
cSQL += "		SELECT B1_COD, B1_GRUPO, B1_TIPO, B.QTDE, A.D2_CLIENTE, A.PRC_ANO, A.PRC_ANT, A.PRC_ATU" +_cEnter
cSQL += "		FROM "+RetSqlName("SB1")+" SB1" +_cEnter
cSQL += "		INNER JOIN (" +_cEnter
cSQL += "			SELECT	D2_COD, D2_CLIENTE," +_cEnter
cSQL += "					ROUND( SUM(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6+D2_VALFRE+D2_DESPESA) / SUM(D2_QUANT),2) PRC_ANO," +_cEnter
cSQL += "					0 PRC_ANT," +_cEnter
cSQL += "					0 PRC_ATU" +_cEnter
cSQL += "			FROM "+RetSqlName("SD2")+" SD2" +_cEnter
cSQL += "			WHERE SD2.D_E_L_E_T_ = '' AND D2_FILIAL = '"+xFilial("SD2")+"'" +_cEnter
cSQL += "			AND D2_EMISSAO BETWEEN '"+_cAnoIni+"' AND '"+_cAnoFim+"'" +_cEnter
cSQL += "			AND D2_CF IN ('5101','5102','5122','5401','5501','5551','6101','6102','7101','7102')" +_cEnter
cSQL += "			AND D2_CLIENTE BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'" +_cEnter
cSQL += "			AND D2_TIPO = 'N'" +_cEnter
cSQL += "			GROUP BY D2_COD, D2_CLIENTE" +_cEnter
cSQL += "			UNION ALL" +_cEnter
cSQL += "			SELECT	D2_COD, D2_CLIENTE," +_cEnter
cSQL += "					0 PRC_ANO," +_cEnter
cSQL += "					ROUND( SUM(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6+D2_VALFRE+D2_DESPESA) / SUM(D2_QUANT),2) PRC_ANT," +_cEnter
cSQL += "					0 PRC_ATU" +_cEnter
cSQL += "			FROM "+RetSqlName("SD2")+" SD2" +_cEnter
cSQL += "			WHERE SD2.D_E_L_E_T_ = '' AND D2_FILIAL = '"+xFilial("SD2")+"'" +_cEnter
cSQL += "			AND D2_EMISSAO BETWEEN '"+_cAntIni+"' AND '"+_cAntFim+"'" +_cEnter
cSQL += "			AND D2_CF IN ('5101','5102','5122','5401','5501','5551','6101','6102','7101','7102')" +_cEnter
cSQL += "			AND D2_CLIENTE BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'" +_cEnter
cSQL += "			AND D2_TIPO = 'N'" +_cEnter
cSQL += "			GROUP BY D2_COD, D2_CLIENTE" +_cEnter
cSQL += "			UNION ALL" +_cEnter
cSQL += "			SELECT	D2_COD, D2_CLIENTE," +_cEnter
cSQL += "					0 PRC_ANO," +_cEnter
cSQL += "					0 PRC_ANT," +_cEnter
cSQL += "					ROUND( SUM(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6+D2_VALFRE+D2_DESPESA) / SUM(D2_QUANT),2) PRC_ATU" +_cEnter
cSQL += "			FROM "+RetSqlName("SD2")+" SD2" +_cEnter
cSQL += "			WHERE SD2.D_E_L_E_T_ = '' AND D2_FILIAL = '"+xFilial("SD2")+"'" +_cEnter
cSQL += "			AND D2_EMISSAO BETWEEN '"+_cAtuIni+"' AND '"+_cAtuFim+"'" +_cEnter
cSQL += "			AND D2_CF IN ('5101','5102','5122','5401','5501','5551','6101','6102','7101','7102')" +_cEnter
cSQL += "			AND D2_CLIENTE BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'" +_cEnter
cSQL += "			AND D2_TIPO = 'N'" +_cEnter
cSQL += "			GROUP BY D2_COD, D2_CLIENTE" +_cEnter
cSQL += "		) A" +_cEnter
cSQL += "		ON (B1_COD = A.D2_COD)" +_cEnter
cSQL += "		INNER JOIN (" +_cEnter
cSQL += "			SELECT	D2_COD, D2_CLIENTE, ROUND(SUM(D2_QUANT) / 12,0) QTDE" +_cEnter
cSQL += "			FROM "+RetSqlName("SD2")+" SD2" +_cEnter
cSQL += "			WHERE SD2.D_E_L_E_T_ = '' AND D2_FILIAL = '"+xFilial("SD2")+"'" +_cEnter
cSQL += "			AND D2_EMISSAO BETWEEN '"+_cQtdIni+"' AND '"+_cQtdFim+"'" +_cEnter
cSQL += "			AND D2_CF IN ('5101','5102','5122','5401','5501','5551','6101','6102','7101','7102')" +_cEnter
cSQL += "			AND D2_CLIENTE BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'" +_cEnter
cSQL += "			AND D2_TIPO = 'N'" +_cEnter
cSQL += "			GROUP BY D2_COD, D2_CLIENTE" +_cEnter
cSQL += "		) B" +_cEnter
cSQL += "		ON (B1_COD = B.D2_COD AND B.D2_CLIENTE = A.D2_CLIENTE)" +_cEnter
cSQL += "		WHERE SB1.D_E_L_E_T_ = '' AND B1_FILIAL = '"+xFilial("SB1")+"'" +_cEnter
cSQL += "		AND B1_COD BETWEEN '"+mv_par02+"' AND '"+mv_par03+"'" +_cEnter
cSQL += "		AND B1_TIPO IN ('PA','CT','DS')" +_cEnter
cSQL += "		AND B1_GRUPO BETWEEN '"+mv_par04+"' AND '"+mv_par05+"'" +_cEnter
cSQL += " ) SINT" +_cEnter
cSQL += " GROUP BY B1_COD, B1_GRUPO, B1_TIPO, QTDE, D2_CLIENTE" +_cEnter
cSQL += " ORDER BY B1_COD, B1_GRUPO, B1_TIPO, QTDE, D2_CLIENTE" +_cEnter

If Select ("TMP") > 0
	TMP->(DbCloseArea())
EndIf

dbUseArea(.T.,'TOPCONN',TcGenQry(,,cSQL),'TMP',.T.,.F.)

If TMP->(Eof())
	MsgInfo("N�o existem registros para os par�metros informados.")
	TMP->(DbCloseArea())
	Return()
EndIf

Count To _nCount
TMP->(DbGoTop())

// Regua
oReport:SetMeter(_nCount)

While !oReport:Cancel() .And. !TMP->(Eof())

	_cNReduz	:= Alltrim(Posicione("SA1",1,xFilial("SA1")+TMP->D2_CLIENTE,"A1_NREDUZ"))
	_nVarAno	:= ( (TMP->PRC_ATU / TMP->PRC_ANO) -1 ) * 100
	_nVarAtu	:= ( (TMP->PRC_ANT / TMP->PRC_ANO) -1 ) * 100

	oReport:IncMeter()
	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()
	// Tratamento para imprimir apenas uma vez a linha de cabecalho no Excel
	If oReport:nDevice == 4 .And. oSection1:lHeaderSection
		oReport:lHeaderVisible := .F.
		oSection1:lHeaderSection := .F.
	EndIf
	
	TMP->(DbSkip())
	
EndDo

If Select ("TMP") > 0
	TMP->(DbCloseArea())
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaSX1   � Autor � Marcos Milare      � Data �  20/01/14   ���
�������������������������������������������������������������������������͹��
���Descricao �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaSX1

DbSelectArea("SX1")

//     cGrupo   ,cOrdem, cPergunt           	   ,cPerSpa,cPerEng , cVar  , cTipo,nTamanho,nDecimal,nPresel ,cGSC, cValid                           , cF3  , cGrpSxg,cPyme, cVar01    ,cDef01   			 ,cDefSpa1,cDefEng1,cCnt01,cDef02        	,cDefSpa2,cDefEng2,cDef03		,cDefSpa3,cDefEng3,cDef04	,cDefSpa4,cDefEng4,cDef05,cDefSpa5,cDefEng5
PutSX1(cPerg , "01" , "Per�odo (MM/AAAA)"			, "" , "" , "mv_ch1" , "C"  , 07     , 0      , 1     , "G", "" 								  , ""	 , ""     ,     , "mv_par01",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "02" , "Produto de"		 			, "" , "" , "mv_ch2" , "C"  , 15     , 0      , 1     , "G", ""		 						  , "SB1", ""     ,     , "mv_par02",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "03" , "Produto ate"		 			, "" , "" , "mv_ch3" , "C"  , 15     , 0      , 1     , "G", ""		 						  , "SB1", ""     ,     , "mv_par03",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "04" , "Grupo de"		 			, "" , "" , "mv_ch4" , "C"  , 04     , 0      , 1     , "G", ""		 						  , "SBM", ""     ,     , "mv_par04",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "05" , "Grupo ate"		 			, "" , "" , "mv_ch5" , "C"  , 04     , 0      , 1     , "G", ""		 						  , "SBM", ""     ,     , "mv_par05",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "06" , "Cliente de"		 			, "" , "" , "mv_ch6" , "C"  , 06     , 0      , 1     , "G", ""		 						  , "SA1", ""     ,     , "mv_par06",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "07" , "Cliente ate"		 			, "" , "" , "mv_ch7" , "C"  , 06     , 0      , 1     , "G", ""		 						  , "SA1", ""     ,     , "mv_par07",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")

Return