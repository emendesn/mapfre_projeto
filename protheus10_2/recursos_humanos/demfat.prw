#INCLUDE "rwmake.ch"

// Lucia Valeria (20/07/2001)
// Este relatorio tem por finalidade demonstrar o valor dos serviços prestados ao
// Banco do Brasil reslizando uma totalizacao no final de cada pedido.

User Function DemFat()

Private cString
Private cPerg := "DemFat"
Private oGeraTxt

cString := "SC5"

ValidPerg()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

@ 200,1 TO 370,350 DIALOG oGeraTxt TITLE OemToAnsi("Demonstrativo do Faturamento...")
@ 02,10 TO 080, 165
@ 10,018 Say " Este programa ira gerar relatorio de Demonstrativo do "
@ 18,018 Say " Faturamento, conforme os parametros solicitado  pelos "
@ 26,018 Say " usuarios.                                             "
@ 60,060 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 60,090 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 60,120 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered

Return

Static Function OkGeraTxt()

nHdl    := mv_par01

If nHdl == ""
	MsgAlert("Verifique os parametros, antes de imprimir o relatorio.","Atencao!")
	Return
Endif

Processa({|| RunCont() },"Demonstrativo do Faturamento")

Return

/*/
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ RUNCONT  º Autor ³ AP5 IDE            º Data ³  24/07/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function RunCont

cBitMap    := "lgrl01.bmp"
cBitMap1   := "lgrl02.bmp"
nHeight    := 15
lBold      := .F.
lUnderLine := .F.
lPixel     := .T.
lPrint     := .F.
_nPage     := 0
_cTime     := Time()

oFont   := TFont():New( "Arial"             ,,nHeight,,lBold,,,,,lUnderLine )
oFont1  := TFont():New( "Times New Roman"   ,,10     ,,lBold,,,,,lUnderLine )
oFont2  := TFont():New( "Times New Roman"   ,,12     ,,.t.  ,,,,,lUnderLine )
oFont3  := TFont():New( "Times New Roman"   ,,11     ,,lBold,,,,,lUnderLine )
oFont4  := TFont():New( "Times New Roman"   ,,10     ,,.t.  ,,,,,lUnderLine )
oFont5  := TFont():New( "Times New Roman"   ,,14     ,,lBold,,,,,lUnderLine )
oFont6  := TFont():New( "Times New Roman"   ,,11     ,,.t.  ,,,,,lUnderLine )
oFont7  := TFont():New( "Times New Roman"   ,,16     ,,.t.  ,,,,,lUnderLine )

oPrn := TMSPrinter():New()

// Inicia Processamento

If MV_PAR09 == 01
	_cOrigem := 'V'
Else
	_cOrigem := 'E'
EndIf

_cCliente := Space(01)
_cEstado  := Space(01)
_cLote    := Space(10)
_cPedido  := Space(06)
_cCodCli  := Space(06)
_nTotPed  := 0
_nTotPar  := 0
_nPage    := 0

dbSelectArea("SC6")
cIndexSC6 := CriaTrab("",.F.)
cKey := 'C6_FILIAL+ C6_NUM ' //+ C6_CLISEB + C6_LOJASEB'
IndRegua("SC6",cIndexSC6,cKey,,,"Criando Indice ...." )

dbSelectArea("SC5")
/*cIndex := CriaTrab("",.F.)
cKey := 'SC5->C5_FILIAL + SC5->C5_LOTE + SC5->C5_NUM '
IndRegua("SC5",cIndex,cKey,,,"Criando Indice ...." )*/
dbGoTop()

While !EOF()
/*	
	If C5_LIBEROK <> 'S' .or. ( C5_FILIAL < MV_PAR01 .or. C5_FILIAL > MV_PAR02);
		.or. ( C5_CLIENTE < MV_PAR03 .or. C5_CLIENTE > MV_PAR05);
		.or. ( C5_LOJACLI < MV_PAR04 .or. C5_LOJACLI > MV_PAR06);
		.or. ( C5_NUM     < MV_PAR10 .or. C5_NUM     > MV_PAR11);
		.or. ( C5_LOTE    < MV_PAR07 .or. C5_LOTE    > MV_PAR08);
		.or. !(Entre(MV_PAR12,MV_PAR13,SC5->C5_EMISSAO)) ;
		.or. ( C5_ORIGEM  <> _cOrigem )
		
		dbSkip()
		loop
	EndIf
	*/
	/*
	If _cLote <> SC5->C5_LOTE .or. ( _cCodCli <> SC5->C5_CLIENTE ) // + SC5->C5_LOJACLI)*/
		_cCodCli := SC5->C5_CLIENTE //  + SC5->C5_LOJACLI
		If SA1->(DBSeek( SC5->C5_FILIAL + SC5->C5_CLIENTE + SC5->C5_LOJACLI ))
			_cCliente := SA1->A1_NOME
		//	If SX5->(DBSeek(xFilial("SX5") + "12" + SA1->A1_EST))
				_cEstado  :=  "SP"
		//	EndIf
		EndIf
		//_cLote := C5_LOTE
		_nPage     := 0
		nLin := 3111
	//EndIf
	
	If nLin > 3110
		oPrn:EndPage()
		oPrn:StartPage()
		ImpCab()
		nLin := 700
	Endif
	
	_cFilPed := SC5->C5_FILIAL
	_cPedido := SC5->C5_NUM
	
	_cAlias  := Alias()
	_nSavReg := RecNo()
	
	dbSelectArea("SC6")
	
	_cSC6Cli := Space(06)
	_cSC6Loj := Space(02)
	
	DBSeek(_cFilPed + _cPedido)
	
	While ( !EOF().And. (_cFilPed +_cPedido) == (SC6->C6_FILIAL + SC6->C6_NUM) )
		/*
		//If _cSC6Cli + _cSC6Loj <> SC6->C6_CLISEB + SC6->C6_LOJASEB
			
			//If _cSC6Cli + _cSC6Loj <> Space(08)
				
				If nLin > 3110
					oPrn:EndPage()
					oPrn:StartPage()
					ImpCab()
					nLin := 700
				Endif
				
				oPrn:Say( nLin , 0620 , "VALOR TOTAL DA DEPENDÊNCIA " , oFont1 )
				oPrn:Say( nLin , 1100 , Replicate(" .",40), oFont1 )
				oPrn:Say( nLin , 2100 , TransForm( _nTotPar , "@E 9,999,999,999.99" ) , oFont4 )  // sub-total
				
				nLin += 210
			EndIf
			
			_cSC6Fil := SC6->C6_FILIAL
			//_cSC6Cli := SC6->C6_CLISEB
			//_cSC6Loj := SC6->C6_LOJASEB
			_nTotPar := 0
			
			If SA1->(DBSeek(_cSC6Fil + _cSC6Cli + _cSC6Loj))
		*/		
				If nLin > 3110
					oPrn:EndPage()
					oPrn:StartPage()
					ImpCab()
					nLin := 700
				Endif
				
				//oPrn:Say( nLin , 0120 , SubStr(SA1->A1_PREFIXO,1,10), oFont1 )
				//oPrn:Say( nLin , 0380 , SubStr(SA1->A1_SAG,1,5)     , oFont1 )
				//oPrn:Say( nLin , 1100 , SubStr(SC6->C6_CIDADE,1,20), oFont1 )
		  /*		
				If SA7->(DBSeek(_cSC6Fil + _cSC6Cli + _cSC6Loj + SC6->C6_PRODUTO))
					oPrn:Say( nLin , 0600 , SubStr(SA7->A7_CODCLI,1,30) + " - ", oFont1 )  // sub-total
				EndIf
				
				nLin += 50
			EndIf
			
		EndIf
		    */
		If nLin > 3110
			oPrn:EndPage()
			oPrn:StartPage()
			ImpCab()
			nLin := 700
		Endif
		
		oPrn:Say( nLin , 0620 , SubStr(SC6->C6_DESCRI,1,40), oFont1 )
		oPrn:Say( nLin , 1300 , TransForm(SC6->C6_QTDVEN, "@E 9,999,999.99")  , oFont1 )  // sub-total
		oPrn:Say( nLin , 1700 , TransForm(SC6->C6_PRCVEN, "@E 999,999,999.99"), oFont1 )  // sub-total
		oPrn:Say( nLin , 2100 , TransForm(SC6->C6_VALOR,"@E 9,999,999,999.99"), oFont1 )  // sub-total
		nLin += 50
		
		_nTotPar += SC6->C6_VALOR
		_nTotPed += SC6->C6_VALOR
		
		dbSkip()
	EndDo
	
	If _nTotPar > 0
		If nLin > 3110
			oPrn:EndPage()
			oPrn:StartPage()
			ImpCab()
			nLin := 700
		Endif
		
		oPrn:Say( nLin , 0620 , " VALOR TOTAL DA DEPENDÊNCIA " , oFont1 )
		oPrn:Say( nLin , 1100 , Replicate(" .",40), oFont1 )
		oPrn:Say( nLin , 2100 , TransForm( _nTotPar , "@E 9,999,999,999.99" ) , oFont4 )  // sub-total
		_nTotPar := 0
		nLin += 210
	EndIf
	
	dbSelectArea(_cAlias)
	dbGoto(_nSavReg)
	
	If _nTotPed > 0
		
		If nLin > 3110
			oPrn:EndPage()
			oPrn:StartPage()
			ImpCab()
			nLin := 700
		Endif
		
		oPrn:Say( nLin , 0200 ," TOTAL GERAL DOS SERVIÇO  " , oFont6 )
		oPrn:Say( nLin , 0630 , Replicate(" .",29), oFont6 )
		oPrn:Say( nLin , 1350 ,"( Pedido: " + StrZero(Val(_cPedido),6) + " )", oFont4 )
		oPrn:Say( nLin , 1600 , Replicate(" .",17), oFont6 )
		oPrn:Say( nLin , 2100 , TransForm( _nTotPed,"@E 9,999,999,999.99" ) , oFont4 )  // sub-total
		
		_nTotPed := 0
		nLin += 210
	EndIf
	dbSkip()
EndDo

oPrn:EndPage()

// FIM DA IMPRESSAO

oPrn:Setup()
oPrn:Preview()

MS_FLUSH()

//Ferase(cIndex)
//Ferase(cIndexSC6)
Close(oGeraTxt)

Return

Static Function ImpCab ()

_nPage += 1

oPrn:Say( 20, 20, " ",oFont,1000 ) // startando a impressora

oPrn:SayBitmap( 0090,0150 ,cBitMap  ,200,150 )

oPrn:Say( 0110 , 0500 , " SEBIVAL - SEGURANÇA BANCÁRIA INDUSTRIAL E DE VALORES LTDA " , oFont2 )
oPrn:Say( 0180 , 0770 , "DEMONSTRATIVO DO FATURAMENTO" , oFont2 )

oPrn:Say( 0285 , 0100 , "Hora: "           , oFont4 )
oPrn:Say( 0285 , 0200 , SubStr(_cTime,1,8) , oFont3 )

oPrn:Say( 0110 , 2000 , "Folha: "   , oFont4 )
oPrn:Say( 0180 , 2000 , "Dt. Ref.:" , oFont4 )
oPrn:Say( 0250 , 2000 , "Emissao:"  , oFont4 )

oPrn:Say( 0110 , 2150 , STRZERO(_nPage,3) , oFont3 )
oPrn:Say( 0180 , 2150 , DtoC(dDataBase)   , oFont3 )
oPrn:Say( 0250 , 2150 , DtoC(dDataBase)   , oFont3 )
//Right(cAlias,2)
oPrn:Say( 0320 , 1600 , "Mês: "     + Right(Space(10)+MesExtenso(Month(dDataBase)),10) + " / " + Str(Year(dDataBase),4), oFont2 )
oPrn:Say( 0360 , 0100 , "Cliente: " + _cCliente, oFont5 )
oPrn:Say( 0420 , 0100 , "Estado:  " + SubStr(_cEstado,1,30), oFont5 )
oPrn:Say( 0420 , 1950 , "Lote: "   ) //+  Substr(_cLote,1,10), oFont5 )
oPrn:Say( 0480 , 0100 , "Serviço: Vigilância", oFont5 )
oPrn:Say( 0510 , 0100 , Replicate("_",115), oFont7 )
oPrn:Say( 0570 , 0100 , " Prefixo ", oFont5 )
oPrn:Say( 0570 , 0360 , " SAG ", oFont5 )
oPrn:Say( 0570 , 0610 , " Descricao do Serviço ", oFont5 )
oPrn:Say( 0570 , 1350 , " Qtde ", oFont1 )
oPrn:Say( 0570 , 1650 , " Valor Unitario ", oFont5 )
oPrn:Say( 0570 , 2050 , " Valor Total", oFont5 )
oPrn:Say( 0585 , 0100 , Replicate("_",115), oFont7 )

return

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

If alltrim(cVersao) == "5.08"
  // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
  aAdd(aRegs,{cPerg,"01","Filial de ..........",,,"mv_ch1","C",02,00,0,"G","","mv_par01","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"SM0",})
  aAdd(aRegs,{cPerg,"02","Filial ate .........",,,"mv_ch2","C",02,00,0,"G","","mv_par02","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"SM0",})
  aAdd(aRegs,{cPerg,"03","Cliente de..........",,,"mv_ch3","C",06,00,0,"G","","mv_par03","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"SA1",})
  aAdd(aRegs,{cPerg,"04","Loja de.............",,,"mv_ch4","C",02,00,0,"G","","mv_par04","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"05","Cliente ate.........",,,"mv_ch5","C",06,00,0,"G","","mv_par05","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"SA1",})
  aAdd(aRegs,{cPerg,"06","Loja ate............",,,"mv_ch6","C",02,00,0,"G","","mv_par06","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"07","Lote de.............",,,"mv_ch7","C",10,00,0,"G","","mv_par07","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"08","Lote ate............",,,"mv_ch8","C",10,00,0,"G","","mv_par08","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"09","Origem..............",,,"mv_ch9","C",01,00,0,"C","","mv_par09","VIGILANCIA","","",,,"VIGIL. EXTRA","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"10","Pedido de...........",,,"mv_chA","C",06,00,0,"G","","mv_par10","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"11","Pedido ate..........",,,"mv_chB","C",06,00,0,"G","","mv_par11","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"12","Periodo de..........",,,"mv_chC","D",08,00,0,"G","","mv_par12","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"13","Periodo ate.........",,,"mv_chD","D",08,00,0,"G","","mv_par13","","","",,,"","","",,,"","","",,,"","","",,,"","","",,"",})
Else
     // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
  aAdd(aRegs,{cPerg,"01","Produto de     "   ,"mv_ch1","C",15,0,0,"G","","mv_par01","","","","","","","","","","","","","","","SB1"}) 

  aAdd(aRegs,{cPerg,"01","Filial de ..........","mv_ch1","C",02,00,0,"G","","mv_par01","","","","","","","","","",,,"","","","","","",,"SM0",})
  aAdd(aRegs,{cPerg,"02","Filial ate .........","mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","",,,"","","","","","",,"SM0",})
  aAdd(aRegs,{cPerg,"03","Cliente de..........","mv_ch3","C",06,00,0,"G","","mv_par03","","","","","","","","","",,,"","","","","","",,"SA1",})
  aAdd(aRegs,{cPerg,"04","Loja de.............","mv_ch4","C",02,00,0,"G","","mv_par04","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"05","Cliente ate.........","mv_ch5","C",06,00,0,"G","","mv_par05","","","","","","","","","",,,"","","","","","",,"SA1",})
  aAdd(aRegs,{cPerg,"06","Loja ate............","mv_ch6","C",02,00,0,"G","","mv_par06","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"07","Lote de.............","mv_ch7","C",10,00,0,"G","","mv_par07","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"08","Lote ate............","mv_ch8","C",10,00,0,"G","","mv_par08","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"09","Origem..............","mv_ch9","C",01,00,0,"C","","mv_par09","VIGILANCIA","","","VIGIL. EXTRA","","","","","","","","",,,"","","",,"",})
  aAdd(aRegs,{cPerg,"10","Pedido de...........","mv_chA","C",06,00,0,"G","","mv_par10","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"11","Pedido ate..........","mv_chB","C",06,00,0,"G","","mv_par11","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"12","Periodo de..........","mv_chC","D",08,00,0,"G","","mv_par12","","","","","","","","","",,,"","","","","","",,"",})
  aAdd(aRegs,{cPerg,"13","Periodo ate.........","mv_chD","D",08,00,0,"G","","mv_par13","","","","","","","","","",,,"","","","","","",,"",})

Endif



For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return
