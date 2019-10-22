#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PMATR550  �Autor  � Jose Novaes        � Data �  05/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Programa para emissao de reletorio para carga do Sales Force���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico para MSF                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PMATR550

Local oReport

Private cPerg	:= PADR("PMATR550",LEN(SX1->X1_GRUPO))

oReport:= ReportDef()
oReport:PrintDialog()

Return()


/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Jose Novaes           � Data � 05/12/14   ���
���������������������������������������������������������������������������Ĵ��
���Descricao � Define as configuracoes e a estrutura do relatorio.          ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local cTitle   := "Relat�rio para Carga do SalesForce"
Local oReport
Local oSection1

PutSx1(cPerg,"01","Vencimento Inicio " ,'','',"mv_ch1","D",08,0, ,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Vencimento Final  " ,'','',"mv_ch2","D",08,0, ,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"03","Produto           " ,'','',"mv_ch3","C",15,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")

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
oReport:=TReport():New("PMATR550",cTitle,cPerg, {|oReport| ReportPrint(oReport)},;
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
���Programa  �ReportPrint� Autor � Jose Novaes           � Data � 05/12/14   ���
����������������������������������������������������������������������������Ĵ��
���Descricao � Processa as informacoes e imprime o relatorio.                ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport)

Local oSection1	:= oReport:Section(1)
Local cTitulo	:= oReport:Title()

Local nCount	:= 0
Local cQuery	:= ""

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
TRFunction():New(oSection1:Cell("D2_QUANT")	,nil, "SUM"	,/*oBreak*/,"","@E 999,999,999,999"	,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("D2_TOTAL")	,nil, "SUM"	,/*oBreak*/,"","@E 999,999,999,999"	,/*uFormula*/,.F.,.T.)

oReport:SetTitle(cTitulo)

cQuery += " SELECT D2_PEDIDO,F2_VEND1,A1_CGC,D2_COD,D2_QUANT,D2_PRCVEN,D2_TOTAL,D2_CLIENTE,A1_NOME,D2_EMISSAO "
cQuery += " FROM " + RetSqlName("SD2") + " SD2 "
cQuery += " INNER JOIN " + RetSqlName("SA1") + " SA1 "
cQuery += " ON SD2.D2_CLIENTE = SA1.A1_COD AND SD2.D2_LOJA = SA1.A1_LOJA AND SA1.D_E_L_E_T_ <> '*' AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "
cQuery += " INNER JOIN " + RetSqlName("SF2") + " SF2 "
cQuery += " ON SD2.D2_CLIENTE = SF2.F2_CLIENTE AND SD2.D2_LOJA = SF2.F2_LOJA AND SD2.D2_DOC = SF2.F2_DOC AND SD2.D2_SERIE = SF2.F2_SERIE "
cQuery += " AND SF2.D_E_L_E_T_ <> '*' AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "
cQuery += " INNER JOIN " + RetSqlName("SF4") + " SF4 "
cQuery += " ON SD2.D2_TES = SF4.F4_CODIGO AND SF4.D_E_L_E_T_ <> '*' AND SF4.F4_FILIAL = '"+xFilial("SF4")+"' "
cQuery += " WHERE  "
cQuery += " SD2.D_E_L_E_T_ <> '*' "
cQuery += " AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery += " AND SD2.D2_EMISSAO BETWEEN '" + Dtos(mv_par01) + "' AND '" + Dtos(mv_par02) + "'"       
cQuery += " AND SD2.D2_TIPO NOT IN ('B','D','I')"
If !Empty(mv_par03)
	cQuery += " AND SD2.D2_COD = '" + mv_par03 + "'"
EndIf
cQuery += " AND SF4.F4_DUPLIC = 'S'"
cQuery += " ORDER BY SD2.D2_FILIAL,SD2.D2_EMISSAO,SD2.D2_PEDIDO "
 
cQuery := ChangeQuery(cQuery)    

If Select("QRY") > 0
    Dbselectarea("QRY")
    QRY->(DbClosearea())
EndIf
 
dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),"QRY",.T.,.F.)
TcSetField("QRY","D2_EMISSAO","D",8,0)
TcSetField("QRY","D2_QUANT"  ,"N",TamSX3("D2_QUANT")[1],TamSX3("D2_QUANT")[2])
TcSetField("QRY","D2_PRCVEN" ,"N",TamSX3("D2_PRCVEN")[1],TamSX3("D2_QUANT")[2])
TcSetField("QRY","D2_TOTAL"  ,"N",TamSX3("D2_TOTAL")[1],TamSX3("D2_QUANT")[2])   

If QRY->(Eof())
	MsgInfo("N�o existem registros para os par�metros informados.")
	QRY->(DbCloseArea())
	Return()
EndIf

Count To _nCount
QRY->(DbGoTop())

// Regua
oReport:SetMeter(_nCount)

While !oReport:Cancel() .And. !QRY->(Eof())

	oReport:IncMeter()
	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()
	
	// Tratamento para imprimir apenas uma vez a linha de cabecalho no Excel
	If oReport:nDevice == 4 .And. oSection1:lHeaderSection
		oReport:lHeaderVisible := .F.
		oSection1:lHeaderSection := .F.
	EndIf
	
	QRY->(DbSkip())
	
EndDo

QRY->(DbCloseArea())

Return