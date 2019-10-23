# Include 'rwmake.ch'
# Include 'avprint.ch'                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Fatura    ºAutor  ³Denilson Correa     º Data ³ 17/10/2001  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³IMPRESSAO da Fatura da TDSJIT                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fatura2()
Private oPrn, oFont1, oFont2, oFont3, oFont4, aFontes
aItens    := {}
nTotal    := 0
_nTotDesc := 0
_nLinLimi := 2800
_cPerg   := "TJFI13"       
ValidPerg()
Pergunte(_cPerg,.T.)

//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Fatura                            ³
//³ mv_par02             // Ate a Fatura                         ³
//³ mv_par03             // Prefixo                              ³
//³ mv_par04             // Cliente                              ³
//³ mv_par05             // Loja                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cFatDe  := mv_par01
_cFatAte := mv_par02
_cPrefixo:= mv_par03
_cCliente:= mv_par04
_cLoja   := mv_par05

ProcRel()
   
Return .t. 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ProcRel   ºAutor  ³--------------------º Data ³------------ º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³------------------------------------------------------------º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ EMPLAREL                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ProcRel()
      
   RptStatus( {|| ImpFat() } )

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ImpSol    ºAutor  ³--------------------º Data ³-------------º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³------------------------------------------------------------º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpFat()

Private nPagina := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicoes de Impressao                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

AVPRINT oPrn NAME "avprint"
//oPrn:SetLandscape()
oPrn:SetPortrait()

//                           Font                W  H  Bold          Underline Device
oFont1 := oSend(TFont(),"New","Verdana"          ,0,12,,.T.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,10,,.T.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,10,,.F.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,14,,.F.,,,,,,,,,,,oPrn)  

aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8 } 

//Regua()
//Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona o SE1 para buscar os dados das Duplicatas           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SE1")
DbSetOrder(2)
Set SoftSeek On
DbSeek(xFilial()+_cCliente+_cLoja+_cPrefixo+_cFatDe)
Set SoftSeek off

nValor := 0
cNum   := " "

While !Eof() .And. SE1->E1_FILIAL  = xFilial() .And. SE1->E1_NUM     <= _cFatAte  ;
             .And. SE1->E1_PREFIXO = _cPrefixo .And. SE1->E1_CLIENTE  = _cCliente ;
             .And. SE1->E1_LOJA    = _cLoja

	If SE1->E1_TIPO <> "DP " .OR. SE1->E1_FATURA <> "NOTFAT" .OR. SE1->E1_SALDO = 0
		DbSelectArea("SE1")
		DbSkip()
		Loop	
	EndIf 

  	If lEnd
		nLin := nLin + 100
		oPrn:Say(200,200,"CANCELADO PELO OPERADOR",oFont1)  
		Exit
	EndIf

	nValor := SE1->E1_Valor
    cNum   := SE1->E1_Num
    cPre   := SE1->E1_Prefixo
    cPar   := AllTrim(SE1->E1_Num+SE1->E1_Parcela)
    dDia   := SE1->E1_Emissao
    dVct   := SE1->E1_Vencto

    nTotal := 0
    cNome  := " "
    cEnd   := " "
    cCep   := " "
    cMun   := " "
    cEst   := " "
    cCgc   := " "
    cIns   := " "
    cArea  := Alias()
    nRec   := Recno()
    cInd   := IndexOrd()
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Posiciona o SA1(Cliente) para buscar os Dados                     ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    DbSelectArea("SA1")
    DbSetOrder(1)
    DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA)

    cNome := ALLTRIM(SA1->A1_NOME)
    cEnd  := ALLTRIM(SA1->A1_END)     //+","+ALLTRIM(SA1->A1_NUMEND)
    cCep  := SA1->A1_CEP
    cMun  := SA1->A1_MUN
    cEst  := SA1->A1_EST
    cCgc  := SA1->A1_CGC
    cIns  := SA1->A1_INSCR

//    DbSelectArea("SZ2")
//    DbSeek(xFilial("SA1")+"C"+SE1->E1_CLIENTE+SE1->E1_LOJA)

    If Empty(SA1->A1_ENDCOB)
        cEndCOB := ALLTRIM(SA1->A1_END)+"-"+ALLTRIM(SA1->A1_BAIRRO)+"-"+ALLTRIM(SA1->A1_MUN)+"/"+SA1->A1_EST+"-"
        cCepCOB := SA1->A1_CEP
    Else
        cEndCOB := ALLTRIM(SA1->A1_ENDCOB)+"-"+ALLTRIM(SA1->A1_BAIRROC)+"-"+ALLTRIM(SA1->A1_MUNC)+"/"+SA1->A1_ESTC+"-"
        cCepCOB := SA1->A1_ESTC
    EndIf            
   
	Gera()       
	SetRegua(Len(aItens))

	ImpCabec1()

    ImpDadosCli()

	ImpDadosFat()

	nLin := 1150
	ImpCabecTit(nLin)

	nLin  := nLin + 70
	_nCol := 160
//	nLin := 1100
	For i := 1 To Len(aItens)  // Step 2
	    IncRegua()
		_nCol := 160
		oPrn:Say(nLin,_nCol,Dtoc(aItens[i,1]),aFontes[5],,,,3)
		_nCol := _nCol + 300
		oPrn:Say(nLin,_nCol,aItens[i,2],aFontes[5],,,,3)
		_nCol := _nCol + 600
		oPrn:Say(nLin,_nCol,TransForm(aItens[i,3],"@E 99,999,999.99"),aFontes[5],,,,2)

		If Len(aItens) >= i+1     
		    i := i+1
			_nCol := _nCol + 100
			oPrn:Say(nLin,_nCol,Dtoc(aItens[i,1]), aFontes[5],,,,3)
			_nCol := _nCol + 300
			oPrn:Say(nLin,_nCol,aItens[i,2],aFontes[5],,,,3)
			_nCol := _nCol + 600
			oPrn:Say(nLin,_nCol,TransForm(aItens[i,3],"@E 99,999,999.99"),aFontes[5],,,,2)
		EndIf
		nLin := nLin + 40
	
		If nLin > 2750
			ImpRoda()
			AvEndPage
			ImpCabec1()
			nLin := 440
			oPrn:Say(nLin,2000,"CONTINUACAO", aFontes[2],,,,3)
			nLin := nLin+40
			ImpCabecTit(nLin)
			nLin  := nLin + 70
		EndIf
	
	Next
	//
	// Imprime o Total e o Valor do desconto
	//                      
	_nlinTot := 2800

    If mv_par06 = 1
		oPrn:Say(_nlinTot,1500,"SUB-TOTAL:", aFontes[2],,,,3)
		oPrn:Say(_nlinTot,1900,TransForm(nTotal,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Duplicata
		_nlinTot := _nlinTot + 50              
		oPrn:Say(_nlinTot,1500,"DESCONTO:", aFontes[2],,,,3)
		oPrn:Say(_nlinTot,1900,TransForm(_nTotDesc,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Duplicata
		_nlinTot := _nlinTot + 50              
		oPrn:Say(_nlinTot,1500,"TOTAL DA FATURA:"      , aFontes[2],,,,3)
		oPrn:Say(_nlinTot,1900,TransForm(nTotal-_nTotDesc,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Duplicata
	Else
		oPrn:Say(_nlinTot,1500,"TOTAL DA FATURA:"      , aFontes[2],,,,3)
		oPrn:Say(_nlinTot,1900,TransForm(nTotal,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Duplicata
    EndIf
	
	ImpRoda()
    DbSelectArea(cArea)
    DbSetOrder(cInd)
    DbGoTo(nRec)
    DbSkip()
End

AvEndPage
AvEndPrint

Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ImpCabec1 ³ Autor ³ Denilson Correa       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Monta Cabecalho Relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpCabec1()

//Dimensoes da Pagina - Largura 3250 / Altura 2300 - Pixels
//oPrn:Say(nLin,0100, Texto , aFontes[1],,,,3) - 1. Centralizado , 2. Alinhar a Direita , 3. Alinhar a Esquerda

// Lay-Out do Cabecalho1
//0060						850	900										                                                         3240
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 0060
//³                     ³ JIT SISTEMAS DE LOGISTICA   ³ 0110                 Emissao
//³                     ³                             ³ 0160                 99/99/99
//³                     ³ ENDERECO                    ³ 0190
//³                     ³ CEP                         ³ 0200                  FATURA
//³    lOGOTIPO         ³ CNPJ              INSCRICAO ³ 0230                  000001
//³						³ FONE              FAX       ³ 0260
//³						³ TEXTO NORMAL 10             ³ 0290
//³						³ TEXTO NORMAL 10             ³ 0320
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 0410

AVNEWPAGE
nPagina++
       //linha,col,linha,col
oPrn:Box(0010,0010,3000,2350) // Moldura da Pagina
COPY FILE TDSJIT.BMP TO TDSJIT1.BMP
oPrn:Box(0020,0020,0300,2340) // Moldura do Cabecalho
oSend(oPrn,"SayBitmap", 0025,0030,"TDSJIT1.BMP",0350,0250 ) // Logotipo TDSJIT

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime os Dados da Empresas                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Linha de Informacoes JIT

oPrn:Say(0030,0410,SM0->M0_NOMECOM          , aFontes[7],,,,3)
oPrn:Say(0080,0410,AllTrim(SM0->M0_ENDCOB)  , aFontes[8],,,,3)
oPrn:Say(0130,0410,"CEP:  "+TransForm(SM0->M0_CEPCOB,"@R 99999-999")+" - "+AllTrim(SM0->M0_BAIRCOB)+" - "+AllTrim(SM0->M0_CIDCOB)+" - "+SM0->M0_ESTCOB, aFontes[8],,,,3)
oPrn:Say(0180,0410,"CNPJ: "+TransForm(SM0->M0_CGC,"@R 99.999.999/9999-99")+" - INSCR. EST. "+TransForm(SM0->M0_INSC,"@R 999.999.999.999"), aFontes[8],,,,3)
oPrn:Say(0230,0410,"FONE: "+SM0->M0_TEL+" - FAX: "+SM0->M0_FAX, aFontes[8],,,,3)

oPrn:Box(0030,1930,0290,2330) // Moldura da Emissao e Numero 
oPrn:Say(0050,1950,"Data Emissão", aFontes[8],,,,3)
oPrn:Say(0100,1950,Dtoc(dDia)    , aFontes[8],,,,3)
oPrn:Say(0180,1950,"FATURA Nº"   , aFontes[8],,,,3)
oPrn:Say(0230,1950,cNum          , aFontes[8],,,,3)

oPrn:Say(0330,1000,"FATURA", aFontes[6],,,,3)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ImpDadosCli ³ Autor ³ Denilson Correa       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Monta Cabecalho Relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ImpDadosCli()

//Dimensoes da Pagina - Largura 3000 / Altura 2365 - Pixels
//oPrn:Say(nLin,0100, Texto , aFontes[1],,,,3) - 1. Centralizado , 2. Alinhar a Direita , 3. Alinhar a Esquerda

//0060															                                                  3240
//0435 0435
//0455³³ 0475
//0515³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³ 0515
//0535³ NOME DO SACADO : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  CODIGO   : XXXXXX/XX        ³ 0555
//0575³ ENDERECO       :³ 0595
//0625³ CEP/MUNICIPIO  :³ 0645
//0665³ PRACA DE PAGTO.:³ 0685
//0705³ CNPJ/CPF       :                  IE        :                                         ³ 0725
//0765ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 0765
//linha,col,linha,col
oPrn:Box(0440,0020,0700,2340) // Moldura do Cabecalho2

// Linha de Informacoes Coluna 01
oPrn:Say(0480,0050,"NOME DO SACADO"  	, aFontes[3],,,,3)
oPrn:Say(0520,0050,"ENDERECO"  	     	, aFontes[3],,,,3)
oPrn:Say(0560,0050,"CEP/MUNICIPIO"   	, aFontes[3],,,,3)
oPrn:Say(0600,0050,"PRACA DE PAGTO." 	, aFontes[3],,,,3)
oPrn:Say(0640,0050,"CNPJ/CPF" 			, aFontes[3],,,,3)

oPrn:Say(0480,0400,cNome   															, aFontes[2],,,,3)
oPrn:Say(0520,0400,cEnd   															, aFontes[3],,,,3)
oPrn:Say(0560,0400,TransForm(cCep,"@R 99999-999")+" - "+cMun+" ESTADO: "+cEst     	, aFontes[3],,,,3)
oPrn:Say(0600,0400,cENDCOB+" - "+TransForm(cCepCob,"@R 99999-999")   				, aFontes[3],,,,3)
oPrn:Say(0640,0400,TransForm(cCGC,"@R 99.999.999/9999-99")+" I.EST. No.: "+cIns   	, aFontes[3],,,,3)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ImpDadosFat ³ Autor ³ Denilson Correa       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Monta Cabecalho Relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ImpDadosFat()

//Dimensoes da Pagina - Largura 3000 / Altura 2365 - Pixels
//oPrn:Say(nLin,0100, Texto , aFontes[1],,,,3) - 1. Centralizado , 2. Alinhar a Direita , 3. Alinhar a Esquerda

//0640	150 			800      1000            1300       1500       1700                     3240
//0720 "+-------------------------+--------------------------+----------+"
//0730 "|         FATURA          |        DUPLICATA         |          |"
//0780 "+---------------+---------+---------------+----------+VENCIMENTO|"
//0790 "|   VALOR R$    | NUMERO  |    VALOR R$   |  NUMERO  |          |"
//0840 "+---------------+---------+---------------+----------+----------+"
//0850 "|999.999.999.99 |999999-9 |999.999.999.99 | 999999-9 |99/99/9999|"
//0900 "+---------------+---------+---------------+----------+----------+"
//linha,col,linha,col
oPrn:Box(0720,0500,0780,1000) // Moldura da Fatura
oPrn:Box(0780,0500,0840,0800) // Molduta do Valor R$ - Fatura
oPrn:Box(0780,0800,0840,1000) // Moldura do Numero   - Fatura 

oPrn:Box(0720,1000,0780,1500) // Moldura da Duplicata 
oPrn:Box(0780,1000,0840,1300) // Moldura do Valor    - Duplicata
oPrn:Box(0780,1300,0840,1500) // Moldura do Numero   - Duplicata

oPrn:Box(0720,1500,0900,1700) // Moldura Vencimento

oPrn:Say(0730,0510,"FATURA"      , aFontes[2],,,,3)
oPrn:Say(0790,0510,"VALOR R$"    , aFontes[2],,,,3)
oPrn:Say(0790,0810,"NUMERO"      , aFontes[2],,,,3)
oPrn:Say(0730,1010,"DUPLICATA"   , aFontes[2],,,,3)
oPrn:Say(0790,1010,"VALOR R$"    , aFontes[2],,,,3)
oPrn:Say(0790,1310,"NUMERO"      , aFontes[2],,,,3)
oPrn:Say(0770,1510,"VENCIMENTO"  , aFontes[2],,,,3)
//0640	500				800      1000            1300       1500       1700                     3240
//0720 "+-------------------------+--------------------------+----------+"
//0730 "|         FATURA          |        DUPLICATA         |          |"
//0780 "+---------------+---------+---------------+----------+VENCIMENTO|"
//0790 "|   VALOR R$    | NUMERO  |    VALOR R$   |  NUMERO  |          |"
//0840 "+---------------+---------+---------------+----------+----------+"
//0850 "|999.999.999.99 |999999-9 |999.999.999.99 | 999999-9 |99/99/9999|"
//0900 "+---------------+---------+---------------+----------+----------+"
oPrn:Box(0840,0500,0900,0800) // Moldura - Valor da Fatura
oPrn:Box(0840,0800,0900,1000) // Moldura - Numero da Fatura 
oPrn:Box(0840,1000,0900,1300) // Moldura - Valor da Duplicata
oPrn:Box(0840,1300,0900,1500) // Moldura - Numero da Duplicata
oPrn:Box(0840,1500,0900,1700) // Moldura - Data de Vencimento


oPrn:Say(0850,0810,cNum , aFontes[2],,,,3)// Numero da Fatura
If mv_par06 = 1         
    //
    // Imprimi Desconto
    //
	oPrn:Say(0850,0510,TransForm(nTotal- _nTotDesc,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Fatura 
Else                             
	oPrn:Say(0850,0510,TransForm(nTotal,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Fatura 
	// nValor ja é valor Liquido (Valor - AB-) 
	// para imprivir o valor sem o desconto soma-se o valor do desconto
	nValor := nValor + _nTotDesc 
EndIf 
oPrn:Say(0850,1010,TransForm(nValor,"@E 99,999,999.99") 	, aFontes[2],,,,3)// Valor da Duplicata
oPrn:Say(0850,1310,cPar      								, aFontes[2],,,,3)// Numero da Duplicata
oPrn:Say(0850,1510,Dtoc(dVct)                      			, aFontes[2],,,,3)// Data de Vencimento

//0900	500
//0950 "+---------------------------------------------------------------+"
//0960 "|                        VALOR POR EXTENSO                      |"
//1000 "+---------------------------------------------------------------+"
//1010 "|                                                               |"
//1050 "|                                                               |"
//1090 "+---------------------------------------------------------------+"

oPrn:Box(0950,0500,1000,1700) // Moldura - Valor por Extenso
oPrn:Box(1000,0500,1090,1700) // Molduta - Extenso
oPrn:Say(0960,0970,"VALOR POR EXTENSO" 	, aFontes[2],,,,3)// Valor da Fatura 

cExtenso := Extenso(nValor,.F.,)	
oPrn:Say(1010,0510,AllTrim(SubStr(cEXTENSO,01,65))+Replicate('*',65-Len(Trim(SubStr(cEXTENSO,01,65)))), aFontes[2],,,,3)
oPrn:Say(1050,0510,AllTrim(SubStr(cEXTENSO,66,65))+Replicate('*',65-Len(Trim(SubStr(cEXTENSO,66,65)))), aFontes[2],,,,3)
Return .T.
                 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ImpDadosFat ³ Autor ³ Denilson Correa       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Monta Cabecalho Relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ImpCabecTit(nLin)
//
// Imprime Detalhe
//
//1100															                                                  3240
//1100 "+----------+----------+-----------------+----------+--------+---------------+"
//1110 "| EMISSAO  |  DOC No. |    VALOR R$     | EMISSAO  | Doc.No.|  VALOR R$     |"
//1150 "+----------+----------+-----------------+----------+--------+---------------+"
//1160 "|01/01/2001| 999999-0 |                 |01/01/2001|        |               |"
//1210 "+----------+----------+-----------------+----------+--------+---------------+"
	
//linha,col,linha,col
_nCol := 150
oPrn:Box(nlin,_nCol,nLin+50,_nCol+300) // Moldura Data      
_nCol := _nCol + 300
oPrn:Box(nlin,_nCol,nLin+50,_nCol+300) // Molduta Doc                  
_nCol := _nCol + 300
oPrn:Box(nlin,_nCol,nLin+50,_nCol+400) // Moldura Valor                
_nCol := _nCol + 400
oPrn:Box(nlin,_nCol,nLin+50,_nCol+300) // Moldura Data      
_nCol := _nCol + 300
oPrn:Box(nlin,_nCol,nLin+50,_nCol+300) // Molduta Doc                  
_nCol := _nCol + 300
oPrn:Box(nlin,_nCol,nLin+50,_nCol+400) // Moldura Valor                
nLin := nLin + 10

_nCol := 160
oPrn:Say(nlin,_nCol,"EMISSAO"  	, aFontes[2],,,,3)
_nCol := _nCol + 300
oPrn:Say(nlin,_nCol,"DOC No."   , aFontes[2],,,,3)
_nCol := _nCol + 300
oPrn:Say(nlin,_nCol,"VALOR R$"  , aFontes[2],,,,3)
_nCol := _nCol + 400
oPrn:Say(nlin,_nCol,"EMISSAO"   , aFontes[2],,,,3)
_nCol := _nCol + 300
oPrn:Say(nlin,_nCol,"DOC No."  	, aFontes[2],,,,3)
_nCol := _nCol + 300
oPrn:Say(nlin,_nCol,"VALOR R$" 	, aFontes[2],,,,3)

nLin  := nLin + 40
_nCol := 150

oPrn:Box(nLin,_nCol,_nLinLimi-10,_nCol+300)
_nCol := _nCol + 300
oPrn:Box(nLin,_nCol,_nLinLimi-10,_nCol+300)
_nCol := _nCol + 300
oPrn:Box(nLin,_nCol,_nLinLimi-10,_nCol+400)
_nCol := _nCol + 400
oPrn:Box(nLin,_nCol,_nLinLimi-10,_nCol+300)
_nCol := _nCol + 300
oPrn:Box(nLin,_nCol,_nLinLimi-10,_nCol+300)
_nCol := _nCol + 300
oPrn:Box(nlin,_nCol,_nLinLimi-10,_nCol+400)
nLin  := nLin + 50

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ImpDadosFat ³ Autor ³ Denilson Correa       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Monta Cabecalho Relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ImpRoda()

//Dimensoes da Pagina - Largura 3000 / Altura 2365 - Pixels
//oPrn:Say(nLin,0100, Texto , aFontes[1],,,,3) - 1. Centralizado , 2. Alinhar a Direita , 3. Alinhar a Esquerda

//linha,col,linha,col
oPrn:Box(3000,0010,3050,2350) // Moldura da Fatura
oPrn:Say(3010,0020,"Esta Faruta deverá ser quitada através de Depósito Bancário: Bco.Bradesco S.A. C/C 275800-8 - Agencia 2583-6 - Ford Urb. Henry Ford", aFontes[4],,,,3)
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GERA                                     ³ Data ³ 05/10/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Array para Fatura                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// 
Static Function Gera()
DbSelectArea("SE1")
DbSetOrder(10)
DbSeek(xFilial()+SA1->A1_COD+SA1->A1_LOJA+cPre+cNum)
aItens    := {}
nTotal    := 0   
_nTotDesc := 0
Num       :=Space(9)
While xFilial()==SE1->E1_Filial .and. SE1->E1_Fatpref==cPre .and. SE1->E1_Fatura==cNum
    //
    // Verifica se ha abatimento
    //                          
    If SE1->E1_TIPO = "AB-"
        DbSkip()
        Loop		
    EndIf
    //
    // Verifica se o Titulo tem Abatimento
    //
    _nRecAtu  := Recno()
    _cPrefAtu := SE1->E1_PREFIXO
    _cNumAtu  := SE1->E1_NUM
    _cParcAtu := SE1->E1_PARCELA
    _nValDesc := 0
    DbSetOrder(1)
	If DbSeek(xFilial()+_cPrefAtu+_cNumAtu+_cParcAtu+"AB-")
    	_nValDesc := SE1->E1_VALOR
    EndIf    
	DbSetOrder(10)
	DbGoto(_nRecAtu)
	//
	// Monta o Array de Titulos da Fatura
	//		       
    NUM := SE1->E1_NUM+"-"+SE1->E1_PARCELA
    Aadd(aItens,{SE1->E1_Emissao,Num,SE1->E1_VALOR})
    nTotal := nTotal + SE1->E1_VALOR
    _nTotDesc := _nTotDesc + _nValDesc
    DbSkip()
    NUM := Space(9)
End
Return










Static Function Regua()

//AVNEWPAGE
//oPrn:SetLandscape()
oPrn:SetPortrait()

oFontTeste := oSend(TFont(),"New","ARIAL"          ,0,5,,.F.,,,,,,,,,,,oPrn)  

oPrn:Line(0000,0000,0000,2350) // Moldura da Pagina
oPrn:Line(0100,0000,0100,2350) // Linhas              
oPrn:Line(0200,0000,0200,2350) // Linhas
oPrn:Line(0300,0000,0300,2350) // Linhas              
oPrn:Line(0400,0000,0400,2350) // Linhas              
oPrn:Line(0500,0000,0500,2350) // Linhas              
oPrn:Line(0600,0000,0600,2350) // Linhas              
oPrn:Line(0700,0000,0700,2350) // Linhas              
oPrn:Line(0800,0000,0800,2350) // Linhas              
oPrn:Line(0900,0000,0900,2350) // Linhas              
oPrn:Line(1000,0000,1000,2350) // Linhas              
oPrn:Line(1100,0000,1100,2350) // Linhas              
oPrn:Line(1200,0000,1200,2350) // Linhas              
oPrn:Line(1300,0000,1300,2350) // Linhas              
oPrn:Line(1400,0000,1400,2350) // Linhas              
oPrn:Line(1500,0000,1500,2350) // Linhas              
oPrn:Line(1600,0000,1600,2350) // Linhas              
oPrn:Line(1700,0000,1700,2350) // Linhas              
oPrn:Line(1800,0000,1800,2350) // Linhas              
oPrn:Line(1900,0000,1900,2350) // Linhas              
oPrn:Line(2000,0000,2000,2350) // Linhas              
oPrn:Line(2100,0000,2100,2350) // Linhas              
oPrn:Line(2200,0000,2200,2350) // Linhas              
oPrn:Line(2300,0000,2300,2350) // Linhas              
oPrn:Line(2400,0000,2400,2350) // Linhas              
oPrn:Line(2500,0000,2500,2350) // Linhas              
oPrn:Line(2600,0000,2600,2350) // Linhas              
oPrn:Line(2700,0000,2700,2350) // Linhas              
oPrn:Line(2800,0000,2800,2350) // Linhas              
oPrn:Line(2900,0000,2900,2350) // Linhas              
oPrn:Line(3000,0000,3000,2350) // Linhas              
oPrn:Line(3100,0000,3100,2350) // Linhas              
oPrn:Line(3200,0000,3200,2350) // Linhas              

oPrn:Line(0000,0000,3110,0000) // Colunas
oPrn:Line(0000,0100,3110,0100) // Colunas
oPrn:Line(0000,0200,3110,0200) // Colunas
oPrn:Line(0000,0300,3110,0300) // Colunas
oPrn:Line(0000,0400,3110,0400) // Colunas
oPrn:Line(0000,0500,3110,0500) // Colunas
oPrn:Line(0000,0600,3110,0600) // Colunas
oPrn:Line(0000,0700,3110,0700) // Colunas
oPrn:Line(0000,0800,3110,0800) // Colunas
oPrn:Line(0000,0900,3110,0900) // Colunas
oPrn:Line(0000,1000,3110,1000) // Colunas
oPrn:Line(0000,1100,3110,1100) // Colunas
oPrn:Line(0000,1200,3110,1200) // Colunas
oPrn:Line(0000,1300,3110,1300) // Colunas
oPrn:Line(0000,1400,3110,1400) // Colunas
oPrn:Line(0000,1500,3110,1500) // Colunas
oPrn:Line(0000,1600,3110,1600) // Colunas
oPrn:Line(0000,1700,3110,1700) // Colunas
oPrn:Line(0000,1800,3110,1800) // Colunas
oPrn:Line(0000,1900,3110,1900) // Colunas
oPrn:Line(0000,2000,3110,2000) // Colunas
oPrn:Line(0000,2100,3110,2100) // Colunas
oPrn:Line(0000,2200,3110,2200) // Colunas
oPrn:Line(0000,2300,3110,2300) // Colunas
oPrn:Line(0000,2350,3110,2350) // Colunas
oPrn:Line(0000,2400,3110,2400) // Colunas

l := 0
c := 0
For l := 0 to 3100 Step 100
	For c := 0 to 2400 Step 100
		oPrn:Say(l+10,c+10,"("+StrZero(l,4)+","+StrZero(C,4)+")",oFontTeste,,,,3)
    Next
Next
AvEndPage
AvEndPrint
Return     

*/
Static Function ValidPerg()
_cAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
aRegs :={}
//+--------------------------------------------------------------+
//¦ Variaveis utilizadas para parametros                         ¦
//¦ mv_par01             // Da Nota Fiscal                       ¦
//¦ mv_par02             // Ate a Nota Fiscal                    ¦ 
//¦ mv_par03             // Da Serie                             ¦ 
//¦ mv_par04             // Nota Fiscal de Entrada/Saida         ¦ 
//+--------------------------------------------------------------+

Aadd(aRegs,{_cPerg,"01","Da Fatura               ?","mv_ch1","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
Aadd(aRegs,{_cPerg,"02","Ate a Fatura            ?","mv_ch2","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
Aadd(aRegs,{_cPerg,"03","Prefixo                 ?","mv_ch3","C",03,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
Aadd(aRegs,{_cPerg,"04","Cliente                 ?","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","SA1"})
Aadd(aRegs,{_cPerg,"05","Loja                    ?","mv_ch5","C",02,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
Aadd(aRegs,{_cPerg,"06","Imp.Desconto            ?","mv_ch6","N",01,0,0,"C","","mv_par06","Sim","","","Nao","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
    If !dbSeek(_cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            EndIf
        Next
        MsUnlock()
    EndIf
Next
DbSelectArea(_cAlias)
Return
