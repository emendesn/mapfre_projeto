#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFINR130  บAutor  ณTrade               บ Data ณ  09/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relacao do titulos vencidos do CR (mais titulos a vencer   บฑฑ
ฑฑบ          ณ se houver), para analise de auditoria.                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico: Cesvi                                          บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณConsultor   ณ Data       ณ Altera็ใo                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณJose Novaes ณ 03/06/2014 ณ #JN20140603 - Inclusao do tipo NDC no filtroณฑฑ
ฑฑณ            ณ            ณ do relatorio.                               ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณJose Novaes ณ 26/11/2014 ณ #JN20141126 - Correcao da geracao da        ณฑฑ
ฑฑณ            ณ            ณ planilha e melhorias nas queries            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณJose Novaes ณ 02/12/2014 ณ #JN20141202 - Ajuste das colunas da planilhaณฑฑ
ฑฑณ            ณ            ณ para que sejam iguais ao relatorio.         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณJose Novaes ณ 05/12/2014 ณ #JN20141205 - Tratamendo de baixas          ณฑฑ
ฑฑณ            ณ            ณ nos tํtulos vencidos.                       ณฑฑ
ฑฑศออออออออออออฯออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PFINR130()
Local aSay      := {}
Local aButton	:= {}
Local cDesc1    := "Esta rotina ira gerar um arquivo DBF com as informacoes dos"
Local cDesc2    := "titulos do Contas a Receber e abrir as mesmas no Excel."
Local cTitulo   := ""
Local nOpc		:= 0
//Private cPerg	:= "PFR130"	//#JN20141126.o
Private cPerg	:= PADR("PFR130",len(sx1->x1_grupo))	//#JN20141126.n
Private dBaixa	:= dDataBase

ValidPerg()
dbSelectArea("SX1")
//dbSeek("PFR130    03")	//#JN20141126.o
dbSeek(cPerg+"03")	//#JN20141126.n
RecLock("SX1",.F.)
SX1->X1_CNT01 := "01/01/05"
Commit
dbSkip()
RecLock("SX1",.F.)
SX1->X1_CNT01 := dToc(dDataBase - 90)
Commit

Pergunte(cPerg,.F.)

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aButton, { 5, .T., {|| Pergunte(cPerg, .T.)    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )

FormBatch( cTitulo, aSay, aButton )

If nOpc <> 1
Return Nil
EndIf

Processa( { || RunProc() }, "Aguarde...", "Gerando Arquivo", .F. )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunProc   บAutor  ณ Trade              บ Data ณ  09/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina auxiliar de Processamento                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Cesvi                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunProc()
Local aStru	:= {}
//Local cDirDocs	  := "\PROTHEUS_DATA\RELATO\"	//#JN20141126.o
Local oExcelApp
Local cPath	:= ""	//#JN20141126.n

/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ Cria arquivo para exportacao de dados para excel.                     บฑฑ
ฑฑศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
*/
aadd(aStru, {"CODIGO"     ,"C", 6,0})	// Codigo do Cliente
aadd(aStru, {"LOJA"       ,"C", 2,0})	// Loja
aadd(aStru, {"NOME"       ,"C",20,0})	// Nome Reduzido
aadd(aStru, {"PREFIXO"    ,"C", 3,0})	// Rubrica
aadd(aStru, {"NUMERO"     ,"C", 6,0})	// Qtd de Cheques
aadd(aStru, {"PARCELA"    ,"C", 1,0})	// Vlr de Cheques
aadd(aStru, {"TIPO"       ,"C", 3,0})	// Qtd de Creditos
aadd(aStru, {"NATUREZA"   ,"C",10,0})	// Vlr de Creditos
//aadd(aStru, {"EMISSAO"    ,"D", 8,0})	// Qtd de Tributos	//#JN20141202.o
aadd(aStru, {"EMISSAO"    ,"C", 8,0})	// Qtd de Tributos	//#JN20141202.n
//aadd(aStru, {"VENC_ORI"   ,"D", 8,0})	// Vlr de Tributos	//#JN20141202.o
aadd(aStru, {"VENC_ORI"   ,"C", 8,0})	// Vlr de Tributos	//#JN20141202.n
//aadd(aStru, {"VENC_REA"   ,"D", 8,0})	// Qtd de Boletos	//#JN20141202.o
aadd(aStru, {"VENC_REA"   ,"C", 8,0})	// Qtd de Boletos	//#JN20141202.n
//aadd(aStru, {"PORTADO"    ,"C",03,0})	// Banco	//#JN20141202.o
aadd(aStru, {"BANCO"    ,"C",03,0})	// Banco	//#JN20141202.n
aadd(aStru, {"SITUACA"    ,"C", 1,0})
aadd(aStru, {"VALOR"      ,"N",17,2})	// Vlr de Totais
//aadd(aStru, {"SALDO"      ,"N",17,2})	// Saldo	//#JN20141202.o
aadd(aStru, {"VENCIDO"      ,"N",17,2})	// Vlr Vencido	//#JN20141202.n
aadd(aStru, {"VENCER"      ,"N",17,2})	// Vlr a Vencer	//#JN20141202.n
aadd(aStru, {"ATRASO"      ,"N",4,0})	// Atraso	//#JN20141202.n
aadd(aStru, {"NUMBCO"     ,"C",15,0})	// Numero Banco 

cArquivo := CriaTrab(aStru,.T.)
cIndex1  := CriaTrab(Nil,.F.)
dbUseArea(.T.,,cArquivo,"TRB",.F.,.F.)

dbSelectArea("TRB")
cChave1:="CODIGO+LOJA+NUMERO+PARCELA"
IndRegua("TRB",cIndex1,cChave1,,,"Criando Indice...")
dbSelectArea("TRB")
dbSetOrder(1)

cQuery := "SELECT * FROM " + RetSqlName("SE1")
//cQuery += " WHERE E1_CLIENTE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"	//#JN20140603.o
cQuery += " WHERE D_E_L_E_T_ <> '*' AND E1_FILIAL = '"+xFilial("SE1")+"'"	//#JN20140603.n
cQuery += " AND   E1_VENCREA BETWEEN '" + Dtos(mv_par03) + "' AND '" + Dtos(mv_par04) + "'"	//#JN20141126.n
cQuery += " AND   E1_CLIENTE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"	//#JN20140603.n
//cQuery += " AND   E1_VENCREA BETWEEN '" + Dtos(mv_par03) + "' AND '" + Dtos(mv_par04) + "'"	//#JN20141126.o
cQuery += " AND   E1_NATUREZ BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "'"
//cQuery += " AND   D_E_L_E_T_ <> '*' AND E1_OCORREN <> '4' AND E1_TIPO = 'NF' "	//#JN20140603.o
cQuery += " AND   E1_OCORREN <> '4' AND E1_TIPO IN ('NF','NDC') "	//#JN20140603.o
//cQuery += " ORDER BY E1_CLIENTE"	//#JN20141126.o
cQuery += " ORDER BY E1_FILIAL,E1_CLIENTE"	//#JN20141126.n

cQuery := ChangeQuery(cQuery)

dbSelectArea("SE1")
aStru := SE1->(dbStruct())
dbCloseArea()

dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), "SE1", .F., .T.)

For ni := 1 to Len(aStru)
	If aStru[ni,2] != 'C'
		TCSetField('SE1', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
	Endif
Next

dbSelectArea("SE1")
ProcRegua( SE1->(RecCount()) )
SE1->(DbGoTop())

nSaldo := 0

While !SE1->(EOF())
	IncProc("Aguarde Processando Tํtulos: Vencidos")

    If SE1->E1_SALDO == 0 .and. SE1->E1_BAIXA <= mv_par04
		SE1->(dbSkip())
		Loop
	Endif

    mv_par15  := 1
    mv_par17  := 1
    mv_par20  := 1
    mv_par33  := 1
    nDescont  := 0

	dDataReaj := IIF(SE1->E1_VENCTO < dDataBase, IIF(mv_par17=1,dDataBase,SE1->E1_VENCREA), dDataBase)
    
	nSaldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,mv_par15,dDataReaj,,SE1->E1_LOJA,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0),1)

    If SE1->E1_SALDO == 0 .and. SE1->E1_BAIXA > mv_par04
       nSaldo := SE1->E1_VALOR
    EndIf

	If Str(SE1->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. SE1->E1_DECRESC > 0 .And. SE1->E1_SDDECRE == 0
		nSAldo -= SE1->E1_DECRESC
	Endif

	If Str(SE1->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. SE1->E1_ACRESC > 0 .And. SE1->E1_SDACRES == 0
		nSAldo += SE1->E1_ACRESC
	Endif

	If SE1->E1_TIPO $ MVABATIM .and. SE1->E1_BAIXA <= dDataBase .and. !Empty(SE1->E1_BAIXA)
		nSaldo := 0
	Endif

	nDescont := FaDescFin("SE1",dBaixa,nSaldo,1)   

	If nDescont > 0
		nSaldo := nSaldo - nDescont
	Endif
			
	If ! SE1->E1_TIPO $ MVABATIM
		If ! (SE1->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. ;
			!( MV_PAR20 == 2 .And. nSaldo == 0 )  	// deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo

			nAbatim := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",mv_par15,dDataReaj,SE1->E1_CLIENTE,SE1->E1_LOJA)

			If STR(nSaldo,17,2) == STR(nAbatim,17,2)
				nSaldo := 0
			ElseIf mv_par33 != 3
				nSaldo-= nAbatim
			Endif
		EndIf
	Endif	
	nSaldo:=Round(NoRound(nSaldo,3),2)
			
    If SE1->E1_SALDO > 0
       nSaldo := SE1->E1_SALDO
    EndIf

    _imposto := SE1->E1_IRRF + SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS

	If nSaldo <= 0
		SE1->(dbSkip())
		Loop
	Endif

    If SE1->E1_BAIXA > MV_PAR04 .AND. SE1->E1_BAIXA < dDataBase .AND. SE1->E1_SALDO == 0
       SE1->(dbSkip())
	   Loop
    EndIf

	dbSelectArea("TRB")
	dbSetOrder(1)
	RecLock("TRB",.T.)
	TRB->CODIGO		:= SE1->E1_CLIENTE
	TRB->LOJA		:= SE1->E1_LOJA
	TRB->NOME		:= SE1->E1_NOMCLI
	TRB->PREFIXO	:= SE1->E1_PREFIXO
	TRB->NUMERO		:= SE1->E1_NUM
	TRB->PARCELA	:= SE1->E1_PARCELA
	TRB->TIPO		:= SE1->E1_TIPO
	TRB->NATUREZA	:= SE1->E1_NATUREZ
	//TRB->EMISSAO	:= SE1->E1_EMISSAO	//#JN20141202.o
	TRB->EMISSAO	:= DTOC(SE1->E1_EMISSAO	)	//#JN20141202.n
	//TRB->VENC_ORI	:= SE1->E1_VENCORI	//#JN20141202.o
	TRB->VENC_ORI	:= DTOC(SE1->E1_VENCORI	)	//#JN20141202.n
	//TRB->VENC_REA	:= SE1->E1_VENCREA	//#JN20141202.o
	TRB->VENC_REA	:= DTOC(SE1->E1_VENCREA	)	//#JN20141202.n
	//TRB->PORTADO	:= SE1->E1_PORTADO	//#JN20141202.o
	TRB->BANCO		:= SE1->E1_PORTADO		//#JN20141202.n
	TRB->SITUACA	:= SE1->E1_SITUACA
	TRB->VALOR		:= SE1->E1_VALOR
	//TRB->SALDO		:= nSaldo	//#JN20141202.o
    If SE1->E1_VENCREA < IIF(MV_PAR09 == 1, dDataBase, mv_par04)	//#JN20141202.n
		TRB->VENCIDO	:= nSaldo	//#JN20141202.n
		TRB->ATRASO		:= IIF(MV_PAR09 == 1, dDataBase, mv_par04) - SE1->E1_VENCREA	//#JN20141202.n			
   	Else	//#JN20141202.n
		TRB->VENCER		:= nSaldo	//#JN20141202.n
	EndIf      	      	//#JN20141202.n
    TRB->NUMBCO		:= SE1->E1_NUMBCO
	MsUnlock()
	dbSelectArea("SE1")
	dbSkip()
EndDo

SE1->(DbCloseArea())
ChKFile("SE1")
dbSelectArea("SE1")
dbSetOrder(1)

//
// a vencer
//
aTmp := {}
aadd(aTmp, {"CODIGO"     ,"C", 6,0})	// Codigo do Cliente
aadd(aTmp, {"LOJA"       ,"C", 2,0})	// Loja

cArqTmp := CriaTrab(aTmp,.T.)
dbUseArea(.T.,,cArqTmp,"TMP",.F.,.F.)
dbSelectArea("TMP")

dbSelectArea("TRB")
dbSetOrder(1)
dbGotop()
While !Eof()
   vCliente := TRB->CODIGO
   vLoja    := TRB->LOJA
   While TRB->CODIGO == vCliente .and. TRB->LOJA == vLoja
      TRB->(dbSkip())
   EndDo   
   RecLock("TMP",.T.)
   TMP->CODIGO := vCliente
   TMP->LOJA   := vLoja
   MsUnlock()
   dbSelectArea("TRB")
EndDo

dbSelectArea("TMP")
ProcRegua( TMP->(RecCount()) )
TMP->(DbGoTop())

While !TMP->(EOF())
	cCliente := TMP->CODIGO
	cLoja    := TMP->LOJA
	
	cQuery1 := "SELECT * FROM " + RetSqlName("SE1")
	//cQuery1 += " WHERE E1_CLIENTE = '" + cCliente + "' AND E1_LOJA = '" + cLoja + "'"	//#JN20141126.o
	cQuery1 += " WHERE D_E_L_E_T_ <> '*' AND E1_FILIAL = '"+xFilial("SE1")+"'"	//#JN20141126.n
	cQuery1 += " AND   E1_VENCREA > '" + Dtos(mv_par04) + "'"
	cQuery1 += " AND   E1_EMISSAO <= '" + Dtos(dDataBase) + "'"
	cQuery1 += " AND   E1_CLIENTE = '" + cCliente + "' AND E1_LOJA = '" + cLoja + "'"	//#JN20141126.n
    cQuery1 += " AND   E1_NATUREZ BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "'"
	//cQuery1 += " AND   D_E_L_E_T_ <> '*' AND E1_OCORREN <> '4' AND E1_TIPO = 'NF'"	//#JN20141126.o
	cQuery1 += " AND E1_OCORREN <> '4' AND E1_TIPO = 'NF'"	//#JN20141126.n	
	//cQuery1 += " ORDER BY E1_CLIENTE"	//#JN20141126.o
	cQuery1 += " ORDER BY E1_FILIAL"	//#JN20141126.n		
	
	cQuery1 := ChangeQuery(cQuery1)
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery1), "TR3", .F., .T.)
	
	TCSetField("TR3", "E1_EMISSAO", "D")
	TCSetField("TR3", "E1_VENCTO" , "D")
	TCSetField("TR3", "E1_VENCORI", "D")
	TCSetField("TR3", "E1_VENCREA", "D")
	TCSetField("TR3", "E1_BAIXA"  , "D")

    nSaldo := 0	

	dbSelectArea("TR3")
	TR3->(DbGoTop())
	While !TR3->(EOF())
		IncProc("Aguarde Processando Tํtulos: เ Vencer")
		
	    If TR3->E1_SALDO == 0 .and. TR3->E1_BAIXA <= mv_par04	//#JN20141205.n
			TR3->(dbSkip())	//#JN20141205.n
			Loop	//#JN20141205.n
		Endif	//#JN20141205.n

    	mv_par15  := 1
	    mv_par17  := 1
	    mv_par20  := 1
	    mv_par33  := 1
	    nDescont  := 0

		dDataReaj := IIF(TR3->E1_VENCTO < dDataBase, IIF(mv_par17=1,dDataBase,TR3->E1_VENCREA), dDataBase)
    
		nSaldo := SaldoTit(TR3->E1_PREFIXO,TR3->E1_NUM,TR3->E1_PARCELA,TR3->E1_TIPO,TR3->E1_NATUREZ,"R",TR3->E1_CLIENTE,mv_par15,dDataReaj,,TR3->E1_LOJA,,If(cPaisLoc=="BRA",TR3->E1_TXMOEDA,0),1)

		If Str(TR3->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. TR3->E1_DECRESC > 0 .And. TR3->E1_SDDECRE == 0
			nSAldo -= TR3->E1_DECRESC
		Endif

		If Str(TR3->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. TR3->E1_ACRESC > 0 .And. TR3->E1_SDACRES == 0
			nSAldo += TR3->E1_ACRESC
		Endif

		If TR3->E1_TIPO $ MVABATIM .and. TR3->E1_BAIXA <= dDataBase .and. !Empty(TR3->E1_BAIXA)
			nSaldo := 0
		Endif

		nDescont := FaDescFin("SE1",dBaixa,nSaldo,1)   

		If nDescont > 0
			nSaldo := nSaldo - nDescont
		Endif
			
		If ! TR3->E1_TIPO $ MVABATIM
			If ! (TR3->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. ;
				!( MV_PAR20 == 2 .And. nSaldo == 0 )  	// deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo

				nAbatim := SomaAbat(TR3->E1_PREFIXO,TR3->E1_NUM,TR3->E1_PARCELA,"R",mv_par15,dDataReaj,TR3->E1_CLIENTE,TR3->E1_LOJA)

				If STR(nSaldo,17,2) == STR(nAbatim,17,2)
					nSaldo := 0
				ElseIf mv_par33 != 3
					nSaldo-= nAbatim
				Endif
			EndIf
		Endif	
		nSaldo:=Round(NoRound(nSaldo,3),2)
			
		If nSaldo <= 0
	       nSaldo := TR3->E1_VALOR
		Endif

        If TR3->E1_BAIXA > MV_PAR04 .AND. TR3->E1_BAIXA < dDataBase .AND. TR3->E1_SALDO == 0
		   TR3->(dbSkip())
		   Loop
        EndIf
	    If TR3->E1_SALDO > 0
	       nSaldo := TR3->E1_SALDO
	    EndIf   
	    If nSaldo < TR3->E1_VALOR
	       nSaldo := TR3->E1_VALOR
	    EndIf

        _imposto := TR3->E1_IRRF + TR3->E1_COFINS + TR3->E1_CSLL + TR3->E1_PIS

		dbSelectArea("TRB")
		dbSetOrder(1)
		RecLock("TRB",.T.)
		TRB->CODIGO	 := TR3->E1_CLIENTE
		TRB->LOJA	 := TR3->E1_LOJA
		TRB->NOME	 := TR3->E1_NOMCLI
		TRB->PREFIXO := TR3->E1_PREFIXO
		TRB->NUMERO	 := TR3->E1_NUM
		TRB->PARCELA := TR3->E1_PARCELA
		TRB->TIPO	 := TR3->E1_TIPO
		TRB->NATUREZA:= TR3->E1_NATUREZ
		//TRB->EMISSAO := TR3->E1_EMISSAO	//#JN20141202.o
		TRB->EMISSAO := DTOC(TR3->E1_EMISSAO)	//#JN20141202.n
		//TRB->VENC_ORI:= TR3->E1_VENCORI	//#JN20141202.o
		TRB->VENC_ORI:= DTOC(TR3->E1_VENCORI)	//#JN20141202.n
		//TRB->VENC_REA:= TR3->E1_VENCREA	//#JN20141202.o
		TRB->VENC_REA:= DTOC(TR3->E1_VENCREA)	//#JN20141202.n
		//TRB->PORTADO := TR3->E1_PORTADO	//#JN20141202.o
		TRB->BANCO   := TR3->E1_PORTADO	//#JN20141202.n
		TRB->SITUACA := TR3->E1_SITUACA
		TRB->VALOR	 := TR3->E1_VALOR
		//TRB->SALDO	 := nSaldo	//#JN20141202.o
	    If TR3->E1_VENCREA < IIF(MV_PAR09 == 1, dDataBase, mv_par04)	//#JN20141202.n
			TRB->VENCIDO	:= nSaldo	//#JN20141202.n
			TRB->ATRASO		:= IIF(MV_PAR09 == 1, dDataBase, mv_par04) - TR3->E1_VENCREA	//#JN20141202.n			
	   	Else	//#JN20141202.n
			TRB->VENCER		:= nSaldo	//#JN20141202.n
		EndIf      	      	//#JN20141202.n
    	TRB->NUMBCO	 := TR3->E1_NUMBCO
		MsUnlock()
		dbSelectArea("TR3")
		dbSkip()
	EndDo
	TR3->(DbCloseArea())
	TMP->(dbSkip())
EndDo

TMP->(DbCloseArea())
Ferase( cArqTmp+".DBF" ) 

//
// Impressao do relatorio
//
ImpRel()

//
// Gera Excel
//
If mv_par07 == 1
   If !ApOleClient( "MsExcel" )
   	   ApMsgStop( "Microsoft Excel nใo instalado","Aten็ใo" )
   	   Return
   Else
   
   	  //Pasta para grava็ใo da planilha
   	  MsgAlert("Selecione a pasta para grava็ใo da planilha!")	//#JN20141126.n
   	  cPath	:= cGetFile( '*.xls' , 'Planilhas (XLS)', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_RETDIRECTORY ),.F., .T. )	//#JN20141126.n
   
      cArq := cArquivo // +".DBF"
      //cArqExcel := "\PROTHEUS_DATA\RELATO\"+cArq+".XLS"	//#JN20141126.o
      cArqExcel := cArq+".XLS"	//#JN20141126.n
      Copy To &cArqExcel      
      //Copia a planilha para a pasta local do usuแrio
      If CpyS2T( "\SYSTEM\"+cArqExcel, Left(cPath,Len(cPath)-1), .f. )	//#JN20141126.n
	      oExcelApp:= MsExcel():New()
	      //oExcelApp:WorkBooks:Open(cArqExcel)	//#JN20141126.o
	      oExcelApp:WorkBooks:Open(cPath+cArqExcel)	      	//#JN20141126.n
	      //oExcelApp:WorkBooks:Open("\PROTHEUS_DATA\RELATO\"+cArq+".XLS")	//#JN20141126.o
	      oExcelApp:SetVisible(.T.)
	  Else	//#JN20141126.n
	  	MsgAlert("Nใo foi possํvel gerar a planilha!")	//#JN20141126.n
      EndIf	//#JN20141126.n
      Ferase(cArqExcel)
   EndIf
EndIf

TRB->(DbCloseArea())
Ferase( cArquivo+".DBF" )
Ferase( cIndex1+OrdBagExt() )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpRel    บAutor  ณTrade               บ Data ณ  09/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Cesvi                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpRel()
Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Rela็ใo de Titulos Contas เ Receber"
Local cPict        := ""
Local titulo       := "Rela็ใo de Titulos Contas a Receber - PDD | Por: " + IIF(MV_PAR08==1, "Natureza", "Cliente")
Local nLin         := 80
//                               1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16
//                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1       := "Cliente   Nome                  PRE  Numero  P Tipo Natureza    Emissao     Vencto    Vencto  Banco          Valor        Valor          Valor   Dias          Numero"
Local Cabec2       := "                                                                          Original      Real              Original      Vencido       a Vencer  Atraso          Banco"
Local imprime      := .T.
Local aOrd         := {}

Private lEnd       := .F.
Private lAbortPrint:= .F.
//Private CbTxt      := ""
Private limite     := 80
Private tamanho    := "G"
Private nomeprog   := "PFINR130"
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "PFINR130"
Private cString    := "TRB"

wnrel := SetPrint(cString,wnrel,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,)

If nLastKey == 27
	Return
Endif

//SetDefault(aReturn,cString)
SetDefault(aReturn,cString,,.F.)

If nLastKey == 27
	Return
Endif

nTipo := IIf(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  12/09/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem

dbSelectArea("TRB")
If MV_PAR08 == 2
   dbSetOrder(1)
Else
   cIndex2  := CriaTrab(Nil,.F.)
   cChave2:="NATUREZA+CODIGO"
   IndRegua("TRB",cIndex2,cChave2,,,"Criando Indice...")
EndIf

SetRegua(RecCount())
dbGoTop()

_valTot  := 0
_salTot1 := 0
_salTot2 := 0
_qtdTot1 := 0

While !EOF()
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If nLin > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif

	If MV_PAR08 == 2
	   _cliente := TRB->CODIGO
	   _cLoja   := TRB->LOJA
	Else   
	   _cliente := TRB->NATUREZA
    EndIf

	_valGrp  := 0
	_salGrp1 := 0
	_salGrp2 := 0
	_qtdTot2 := 0	

	While IIF(MV_PAR08==2,TRB->CODIGO == _cliente .AND. TRB->LOJA == _cLoja, TRB->NATUREZA == _cliente)
   	   @ nLin,000 PSAY TRB->CODIGO
   	   @ nLin,007 PSAY TRB->LOJA
   	   @ nLin,010 PSAY AllTrim(TRB->NOME)
   	   @ nLin,032 PSAY TRB->PREFIXO
   	   @ nLin,037 PSAY TRB->NUMERO
   	   @ nLin,045 PSAY TRB->PARCELA
   	   @ nLin,047 PSAY TRB->TIPO
   	   @ nLin,052 PSAY TRB->NATUREZA   
   	   @ nLin,064 PSAY TRB->EMISSAO
   	   @ nLin,074 PSAY TRB->VENC_ORI
   	   @ nLin,084 PSAY TRB->VENC_REA
   	   //@ nLin,094 PSAY TRB->PORTADO	//#JN20141202.o 
   	   @ nLin,094 PSAY TRB->BANCO	//#JN20141202.n    	   
   	   @ nLin,099 PSAY TRB->SITUACA
   	   @ nLin,101 PSAY TRB->VALOR	PICTURE "@E 99,999,999.99"
       //If TRB->VENC_REA < IIF(MV_PAR09 == 1, dDataBase, mv_par04)	//#JN20141202.o
       If CTOD(TRB->VENC_REA) < IIF(MV_PAR09 == 1, dDataBase, mv_par04)       	//#JN20141202.n
   	      //@ nLin,114 PSAY TRB->SALDO	PICTURE "@E 99,999,999.99"	//#JN20141202.o
   	      //@ nLin,145 PSAY IIF(MV_PAR09 == 1, dDataBase, mv_par04) - TRB->VENC_REA	PICTURE "9999"	//#JN20141202.o
   	      //_salGrp1 := _salGrp1 + TRB->SALDO	//#JN20141202.o
   	      _salGrp1 := _salGrp1 + TRB->VENCIDO	//#JN20141202.n
   	   Else
   	      //@ nLin,129 PSAY TRB->SALDO	PICTURE "@E 99,999,999.99"	//#JN20141202.o
   	      //_salGrp2 := _salGrp2 + TRB->SALDO	//#JN20141202.o
   	      _salGrp2 := _salGrp2 + TRB->VENCER	//#JN20141202.n
   	   EndIf      	      
       @ nLin,114 PSAY TRB->VENCIDO	PICTURE "@E 99,999,999.99"	//#JN20141202.n
   	   @ nLin,129 PSAY TRB->VENCER	PICTURE "@E 99,999,999.99"	//#JN20141202.n
       @ nLin,145 PSAY TRB->ATRASO	PICTURE "9999"	//#JN20141202.n
	   @ nLin,153 PSAY TRB->NUMBCO

   	   _valGrp  := _valGrp + TRB->VALOR
   	   _qtdTot2 ++

 	   nLin ++
  	   If nLin > 55
		  Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		  nLin := 9
	   Endif
	   TRB->(dbSkip())
 	EndDo
 	@ nLin,001 PSAY "sub-total >>>>>>>>>>>    Titulos:"
    @ nLin,038 PSAY _qtdTot2	PICTURE "99999"
    @ nLin,101 PSAY _valGrp		PICTURE "@E 99,999,999.99"
   	@ nLin,114 PSAY _salGrp1	PICTURE "@E 99,999,999.99"   	   
   	@ nLin,129 PSAY _salGrp2	PICTURE "@E 99,999,999.99"   	      	
    nLin ++
    @ nLin,000 PSAY Repl("-",220)          
    nLin ++    
    _valTot := _valTot + _valGrp
   	_salTot1 := _salTot1 + _salGrp1   	   
   	_salTot2 := _salTot2 + _salGrp2
   	_qtdTot1 := _qtdTot1 + _qtdTot2
EndDo

If nLin <> 80
    nLin := nLin + 2
    @ nLin,001 PSAY "TOTAL GERAL >>>>>>>>>    Titulos:"
    @ nLin,038 PSAY _qtdTot1	PICTURE "99999"
    @ nLin,101 PSAY _valTot		PICTURE "@E 99,999,999.99"
   	@ nLin,114 PSAY _salTot1	PICTURE "@E 99,999,999.99"   	   
   	@ nLin,129 PSAY _salTot2	PICTURE "@E 99,999,999.99"   	      	
	Roda(cbcont,cbtxt,Tamanho)
EndIf

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ                    บ Data ณ  02/10/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg

//Local _sAlias := Alias()	//#JN20141126
Local aArea := GetArea()	//#JN20141126.n
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
//cPerg  := PADR(cPerg,len(sx1->x1_grupo))	//#JN20141126.o

//          Grupo/Ordem/Pergunta              /Variavel/      Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01     /Def01      /Cnt01/ Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/X1_F3
AAdd(aRegs,{cPerg,"01","Cliente De         ?","S","E","mv_ch1","C",06     ,00     ,0    ,"G" ,"","MV_PAR01",""   ,"","","","","","","","","","","","","","","","","","","","","","","","SA1",""})
AAdd(aRegs,{cPerg,"02","Cliente Ate        ?","S","E","mv_ch2","C",06     ,00     ,0    ,"G" ,"","MV_PAR02",""   ,"","","","","","","","","","","","","","","","","","","","","","","","SA1",""})
AAdd(aRegs,{cPerg,"03","Vencimento De      ?","S","E","mv_ch3","D",08     ,00     ,0    ,"G" ,"","MV_PAR03",""   ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"04","Vencimento Ate     ?","S","E","mv_ch4","D",08     ,00     ,0    ,"G" ,"","MV_PAR04",""   ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"05","Natureza De        ?","S","E","mv_ch5","C",10     ,00     ,0    ,"G" ,"","MV_PAR05",""   ,"","","","","","","","","","","","","","","","","","","","","","","","SED",""})
AAdd(aRegs,{cPerg,"06","Natureza Ate       ?","S","E","mv_ch6","C",10     ,00     ,0    ,"G" ,"","MV_PAR06",""   ,"","","","","","","","","","","","","","","","","","","","","","","","SED",""})
AAdd(aRegs,{cPerg,"07","Gera Excel         ?","S","E","mv_ch7","N",01     ,00     ,0    ,"C" ,"","MV_PAR07","Sim","Sim","Sim","","","Nao","Nao","Nao","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"08","Ordem              ?","S","E","mv_ch8","N",01     ,00     ,0    ,"C" ,"","MV_PAR08","Natureza","Natureza","Natureza","","","Cliente","Cliente","Cliente","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"09","Considera DataBase ?","S","E","mv_ch9","N",01     ,00     ,0    ,"C" ,"","MV_PAR09","Sim","Sim","Sim","","","Nao","Nao","Nao","","","","","","","","","","","","","","","","","",""})
For i:=1 to Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			EndIf
		Next
		MsUnLock()
	EndIf
Next

//DbSelectArea(_sAlias)	//#JN20141126
RestArea(aArea)	//#JN20141126

Return
