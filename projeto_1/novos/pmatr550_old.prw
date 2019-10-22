#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ PMATR550 ณ Autor ณ Jose Novaes           ณ Data ณ 11.11.14 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณEspecifico para Mapfre Tesouraria                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PMATR550()

Private oReport  := Nil
Private oItens  := Nil
//Private oTotDia	 := Nil
Private cPerg    := PadR ("PMATR550", Len (SX1->X1_GRUPO))
                                                                           
PutSx1(cPerg,"01","Vencimento Inicio " ,'','',"mv_ch1","D",08,0, ,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Vencimento Final  " ,'','',"mv_ch2","D",08,0, ,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"03","Produto           " ,'','',"mv_ch3","C",15,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")

ReportDef()
oReport:PrintDialog()   
 
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออัอออออออัออออออออออออออออออออออัออออออัอออออออออออปฑฑ
ฑฑบFun…o    ณREPORTDEF ณ Autor ณ Jose Novaes          ณ Data ณ 11.11.14  บฑฑ
ฑฑฬออออออออออุออออออออออฯอออออออฯออออออออออออออออออออออฯออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo da estrutura do relat๓rio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
 
oReport := TReport():New("PMATR550","Rela็ใo de NF - Salesforce",cPerg,{|oReport| PrintReport(oReport/*,oTotDia*/)},"Impressใo da Rela็ใo de NF - Salesforce.")
oReport:SetLandscape(.T.)
                                     
oItens := TRSection():New( oReport , "PMATR550", {"QRY"} )
oItens:SetTotalInLine(.F.)
TRCell():New( oItens, "D2_PEDIDO" , "QRY", RetTitle("D2_PEDIDO") )
TRCell():New( oItens, "F2_VEND1"  , "QRY", RetTitle("F2_VEND1")  )
TRCell():New( oItens, "A1_CGC"    , "QRY", RetTitle("A1_CGC")    )
TRCell():New( oItens, "D2_COD"    , "QRY", RetTitle("D2_COD")    )
TRCell():New( oItens, "D2_QUANT"  , "QRY", RetTitle("D2_QUANT")  )
TRCell():New( oItens, "D2_PRCVEN" , "QRY", RetTitle("D2_PRCVEN") )
TRCell():New( oItens, "D2_TOTAL"  , "QRY", RetTitle("D2_TOTAL")  )
TRCell():New( oItens, "D2_CLIENTE", "QRY", RetTitle("D2_CLIENTE"))
TRCell():New( oItens, "A1_NOME"   , "QRY", RetTitle("A1_NOME")   )
TRCell():New( oItens, "D2_EMISSAO", "QRY", RetTitle("D2_EMISSAO"))
 
//TRFunction():New(oItens:Cell("D2_QUANT"),/*cId*/,"SUM"     ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.           ,.T.           ,.F.        ,oItens)
//TRFunction():New(oItens:Cell("D2_TOTAL") ,/*cId*/,"SUM"     ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.           ,.T.           ,.F.        ,oItens)
 
//oTotdia := TRSection():New( oReport , "Total do Dia", {"QRY"} )
//oTotdia:SetTotalInLine(.F.)
//TRCell():New(oTotDia,"NACD1"		,/*Tabela*/,RetTitle("D2_QUANT"),PesqPict("SD2","D2_QUANT")		,TamSX3("D2_QUANT"	)[1]		,/*lPixel*/,{|| nAcD1 },,,"RIGHT"							)
//TRCell():New(oTotDia,"NACD2"		,/*Tabela*/,RetTitle("D2_TOTAL"),PesqPict("SD2","D2_TOTAL")		,TamSX3("D2_TOTAL"	)[1]		,/*lPixel*/,{|| nAcD2 },,,"RIGHT"							)

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัอออออออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑณFun…o    ณPRINTREPORT ณ Autor ณ Jose Novaes         ณ Data ณ 11.11.14 ณฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯอออออออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDesc.     ณ QUERY                                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)
 
Local cQuery     := ""
 
Pergunte(cPerg,.F.)

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
 
oItens:BeginQuery()
oItens:EndQuery({{"QRY"},cQuery})    
oItens:Print()
 
Return Nil