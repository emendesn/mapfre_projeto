#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ZFATR27   ºAutor  ³Microsiga           º Data ³  12/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ZFATR27

Local oReport
Private cPerg		:= PADR("ZFATR27",LEN(SX1->X1_GRUPO))
Private _nDifVlr	:= 0

oReport:= ReportDef()
oReport:PrintDialog()

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marcos Milare  (MR)   ³ Data ³ 13/11/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Define as configuracoes e a estrutura do relatorio.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR           ³  DATA      ³ MOTIVO DA ALTERACAO                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³                       ³            ³                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local cTitle   := "Relatório para Carga do SalesForce"
Local oReport
Local oSection1
Local _nLanded	:= 0

CriaSX1(cPerg)
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=TReport():New("ZFATR27",cTitle,cPerg, {|oReport| ReportPrint(oReport)},;
"Este relatório prepara a carga do SalesForce.")
oReport:SetTotalInLine(.F.)
oReport:SetLandScape()
oReport:nFontBody := 8
oReport:nLineHeight := 40
oReport:SetEdit(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1:= TRSection():New(oReport,"Rel Carga SalesForce")

oSection1:SetTotalInLine(.F.)
oSection1:SetHeaderPage()
oSection1:nLinesBefore := 0

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Marcos Milare (MR)    ³ Data ³ 13/11/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Processa as informacoes e imprime o relatorio.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR           ³  DATA      ³ MOTIVO DA ALTERACAO                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³                       ³            ³                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
	MsgInfo("Não existem registros para os parâmetros informados.")
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaSX1   º Autor ³ Marcos Milare      º Data ³  20/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1

DbSelectArea("SX1")

//     cGrupo   ,cOrdem, cPergunt           	   ,cPerSpa,cPerEng , cVar  , cTipo,nTamanho,nDecimal,nPresel ,cGSC, cValid                           , cF3  , cGrpSxg,cPyme, cVar01    ,cDef01   			 ,cDefSpa1,cDefEng1,cCnt01,cDef02        	,cDefSpa2,cDefEng2,cDef03		,cDefSpa3,cDefEng3,cDef04	,cDefSpa4,cDefEng4,cDef05,cDefSpa5,cDefEng5
PutSX1(cPerg , "01" , "Período (MM/AAAA)"			, "" , "" , "mv_ch1" , "C"  , 07     , 0      , 1     , "G", "" 								  , ""	 , ""     ,     , "mv_par01",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "02" , "Produto de"		 			, "" , "" , "mv_ch2" , "C"  , 15     , 0      , 1     , "G", ""		 						  , "SB1", ""     ,     , "mv_par02",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "03" , "Produto ate"		 			, "" , "" , "mv_ch3" , "C"  , 15     , 0      , 1     , "G", ""		 						  , "SB1", ""     ,     , "mv_par03",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "04" , "Grupo de"		 			, "" , "" , "mv_ch4" , "C"  , 04     , 0      , 1     , "G", ""		 						  , "SBM", ""     ,     , "mv_par04",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "05" , "Grupo ate"		 			, "" , "" , "mv_ch5" , "C"  , 04     , 0      , 1     , "G", ""		 						  , "SBM", ""     ,     , "mv_par05",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "06" , "Cliente de"		 			, "" , "" , "mv_ch6" , "C"  , 06     , 0      , 1     , "G", ""		 						  , "SA1", ""     ,     , "mv_par06",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")
PutSX1(cPerg , "07" , "Cliente ate"		 			, "" , "" , "mv_ch7" , "C"  , 06     , 0      , 1     , "G", ""		 						  , "SA1", ""     ,     , "mv_par07",""			 		 ,""      ,""      ,""    ,""				,""      ,""      ,""			,""      ,""      ,""    	,""      ,""      ,""    ,""      ,"")

Return