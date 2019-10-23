//#INCLUDE "CONR330.CH"
#Include "RWMAKE.Ch"
//#Include "PROTHEUS.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CONR330  ³ Autor ³ Alessandro B. Freire  ³ Data ³ 19.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de Lancamentos                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CONR330(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ConR330M()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel
LOCAL cString:="CT2"
LOCAL cDesc1 := "Este programa ir  imprimir a Ficha de Lancamentos"
LOCAL cDesc2 := "de acordo com os parƒmetros solicitados pelo"
LOCAL cDesc3 := "usu rio."
LOCAL tamanho		:="G"
PRIVATE aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }  // "Zebrado" ### "Administracao"
PRIVATE nomeprog:="CONR330M"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="COR330"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("COR330",.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01      // Do Lote   											  ³
//³ mv_par02      // Ate o Lote											  ³
//³ mv_par03      // Do Documento										  ³
//³ mv_par04      // Ate o Documento									  ³
//³ mv_par05      // Imprime        Lancto         Pre-Lancto    ³
//³ mv_par06      // Imprime        Conta          Cod.Reduz.    ³
//³ mv_par07      // Da data                                     ³
//³ mv_par08      // Ate a data                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas no arquivo SIGACONR.INI ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par05 == 2
	PRIVATE titulo := "Ficha de Pre-Lancamentos"
	cString := "CTC"
Else
	PRIVATE titulo := "Ficha de Lancamentos"
	cString := "CT2"
EndIf

titulo := titulo + "  (" + DTOC(mv_par07) + "-" + DTOC(mv_par08) + ")"

PRIVATE cabec1 := " "
//                           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6        7         8         9         0         1
//                 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234678901234567890123456789012345678901234567890
PRIVATE cabec2 := "Conta                          "+;
						RetTitle("CT4_ITEM",19)+RetTitle("CT3_CUSTO",20)+;
						"Descricao                           Historico                                                       Debito                           Credito"
PRIVATE cCancel:= "***** CANCELADO PELO OPERADOR *****"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="CONR330"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,"",.f.)

If nLastKey == 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

If mv_par05 == 2
	RptStatus({|lEnd| Cr330ImpB(@lEnd,wnRel,cString)},Titulo)
Else
	RptStatus({|lEnd| Cr330ImpA(@lEnd,wnRel,cString)},Titulo)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³ Cr330ImpA³ Autor ³ Alessandro B. Freire  ³ Data ³ 19/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Fichas de Lancamento                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Cr330ImpA(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACON                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³           ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³           ³ cString - Mensagem                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Cr330ImpA(lEnd,WnRel,cString)

Local tamanho    :="G"
Local nTotDeb    := 0
Local nTotCred   := 0
Local cLoteDoc   := ""
Local cLoteI2    := ""
Local lFirst     := .T.
Local cDigVer    := GetMv("MV_DIGVER")
Local dDataSI2
Local cNumSI2
Local cSI2EmpFil := ""
Local nRecnoSI2  := 0
Local lComplHist

m_pag  := 1
li     := 80
cbCont := 0
cbTxt  := ""

If mv_par05 == 2
	PRIVATE titulo := "Ficha de Pre-Lancamentos"
	cString := "CTC"
Else
	PRIVATE titulo := "Ficha de Lancamentos"
	cString := "CT2"
EndIf

titulo := titulo + "  (" + DTOC(mv_par07) + "-" + DTOC(mv_par08) + ")"

dbSelectArea( "CT2" )
cCapLote := GetMv("MV_CAPLOTE") 
cCtrlSI6 := GetMv("MV_CTRLSI6")

If cCapLote == "D"
	dbSetorder(6)
	dbSeek( cFilial + mv_par03, .t. )
Else
   If cCtrlSI6 == "M"
      dbSetorder(1)
//      dbSeek( cFilial + mv_par01+ mv_par03, .t. )    
  
      dbSeek( cFilial + mv_par07 + mv_par01 + mv_par03, .t. )
  
   Else
      dbSetOrder(3)
      dbSeek( cFilial + Dtos(mv_par07), .t. )
   Endi
EndIf

SetRegua( RecCount() )

While !Eof() .And. cFilial == CT2->CT2_FILIAL

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	EndIF

	IncRegua()

	If cCapLote == "D"
		If CT2->CT2_DOC > mv_par04
			Exit
		EndIf	
		cLoteI2 := CT2->CT2_DOC 
	Else
		If cCtrlSI6 == "M"
      	If CT2->CT2_DOC > mv_par02 + mv_par04
         	Exit
			EndIf
			cLoteI2 := CT2->CT2_DOC
		Else
			If CT2->CT2_DATA > MV_PAR08
         	Exit
			Endif
			cLoteI2 := DTOS(CT2_DATA)+CT2->CT2_DOC
		Endif
	EndIf
	
	If CT2->CT2_DATA < mv_par07 .Or. CT2->CT2_DATA > mv_par08
		dbSkip()
		Loop
	EndIf

	If cCtrlSI6 == "D"
   	If CT2_DOC < MV_PAR01 .Or. CT2_DOC > MV_PAR02
      	dbSkip()
			Loop
		Endi
	Endif
	
  	If CT2_DOC < MV_PAR03 .Or. CT2_DOC > MV_PAR04
     	dbSkip()
		Loop
	Endif

	If ( Li > 49 .or. cLoteDoc != cLoteI2 .or. Eof() ) .and. !lFirst
		If Li < 50
			Li := 50
		EndIf
		
		@ li, 000 PSAY Repl( "-", 220 )
		
		li++
		@ li, 106 PSAY "Totais.................................:"
		@ li, 156 PSAY nTotDeb  Picture "@E 99999,999,999,999.99"
		@ li, 191 PSAY nTotCred Picture "@E 99999,999,999,999.99"
		
		li++
		@ li, 000 PSAY Repl( "-", 220 )
		
		li++
		@ li, 000 PSAY "VISTOS:"
		li++
		@ li, 000 PSAY "CONTABILIDADE:                             APROVADOR:                                 SUPERIOR:" 
		li+=2
		@ li, 000 PSAY "________________________________________   ________________________________________   ________________________________________"
		
		If cLoteDoc != cLoteI2
			nTotDeb  := 0
			nTotCred := 0
			cLoteDoc := cLoteI2
		EndIf
		
		Li := 80
		lFirst := .T.
	EndIf 

	If li > 58 
		If cLoteDoc != cLoteI2
			nTotDeb  := 0
			nTotCred := 0
			cLoteDoc := cLoteI2
		EndIf
		
		Cabec1 :=	"Lote..: " +;
						SubStr( CT2->CT2_DOC, 1, 4 ) + ;
						"   Docto.: " +;
						SubStr( CT2->CT2_DOC, 5, 6 )   +;
						"   Data:"+;
						DTOC(CT2->CT2_DATA)
		
		Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho, 15 )
		lFirst := .F.
	EndIf	

	If CT2->CT2_DC $ "DX"
		CT1->( dbSetOrder( 1 ) )
		CT1->( dbSeek( xFilial("CT1") + CT2->CT2_DEBITO ) )
		If mv_par06 == 1
			If cDigVer == "S"
				@ li,000 PSAY Alltrim(CT2->CT2_DEBITO)+CT2->CT2_DCD
			Else
				@ li,000 PSAY CT2->CT2_DEBITO
			EndIf	
		Else		
			@ li,000 PSAY Alltrim(CT1->CT1_RES)
		EndIf			
		@ li,031 PSAY CT2->CT2_ITEMD
		@ li,050 PSAY CT2->CT2_CCD
		@ li,070 PSAY Substr(CT1->CT1_DESC,1,25)
		@ li,106 PSAY CT2->CT2_HIST

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Tratamento p/ o Complemento de Historico.                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nRecnoSI2 := RecNo()

		dbSelectArea("CT2")
		dbSetOrder(3)

		nComplHist := 0
		cItem      := CT2->CT2_ITEMD
		lComplHist := .T.
		cSI2EmpFil := CT2->CT2_EMPORIG + CT2->CT2_FILORIG
		dDataSI2   := CT2->CT2_DATA
		cNumSI2    := CT2->CT2_DOC

		dbSkip()

		While CT2->CT2_DATA == dDataSI2 .And. CT2->CT2_DOC == cNumSI2 .And.;
				lComplHist .And. !Eof()
			If CT2->CT2_EMPORIG + CT2->CT2_FILORIG  == cSI2EmpFil
				If CT2->CT2_DC == "-"
					If Empty(nComplHist) .And. !Empty(cItem)
						li := li + 1
						@ li,070 PSAY Cr330DescA(cItem, "D", "CT2")
					Else
						li := li + 1
					EndIf

					@ li,106 PSAY AllTrim(CT2->CT2_HIST)

					nComplHist := nComplHist + 1
				Else
					lComplHist := .F.
				EndIf
			EndIf

			dbSelectArea("CT2")
			dbSkip()
		End

		dbSetOrder( Iif(cCapLote == "D", 6, If(cCtrlSI6=="M",1,3)) )
		dbGoto(nRecnoSI2)

		If Empty(nComplHist) .And. !Empty(CT2->CT2_ITEMD)
			li++
			@ li,070 PSAY Cr330DescA(CT2->CT2_ITEMD, "D", "CT2")
		EndIf

		@ li,156 PSAY CT2->CT2_VALOR Picture "@E 99999,999,999,999.99"
		nTotDeb += CT2->CT2_VALOR		
		li++
	EndIf

	If CT2->CT2_DC $ "CX"
		CT1->( dbSetOrder( 1 ) )
		CT1->( dbSeek( xFilial("CT1") + CT2->CT2_CREDITO ) )
		If mv_par06 == 1
			If cDigVer == "S"
				@ li,000 PSAY Alltrim(CT2->CT2_CREDITO)+CT2->CT2_DCC
			Else
				@ li,000 PSAY CT2->CT2_CREDITO			
			EndIf	
		Else
			@ li,000 PSAY Alltrim(CT1->CT1_RES)
		EndIf			
		@ li,031 PSAY CT2->CT2_ITEMC
		@ li,050 PSAY CT2->CT2_CCC
		@ li,070 PSAY Substr(CT1->CT1_DESC,1,25)
		@ li,106 PSAY CT2->CT2_HIST

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Tratamento p/ o Complemento de Historico.                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nRecnoSI2 := RecNo()

		dbSelectArea("CT2")
		dbSetOrder(3)

		nComplHist := 0
		cItem      := CT2->CT2_ITEMC
		lComplHist := .T.
		cSI2EmpFil := CT2->CT2_EMPORIG + CT2->CT2_FILORIG
		dDataSI2   := CT2->CT2_DATA
		cNumSI2    := CT2->CT2_DOC

		dbSkip()

		While CT2->CT2_DATA == dDataSI2 .And. CT2->CT2_DOC == cNumSI2 .And.;
				lComplHist .And. !Eof()
			If CT2->CT2_EMPORIG + CT2->CT2_FILORIG  == cSI2EmpFil
				If CT2->CT2_DC == "-"
					If Empty(nComplHist) .And. !Empty(cItem)
						li := li + 1
						@ li,070 PSAY Cr330DescA(cItem, "C", "CT2")
					Else
						li := li + 1
					EndIf

					@ li,106 PSAY AllTrim(CT2->CT2_HIST)

					nComplHist := nComplHist + 1
				Else
					lComplHist := .F.
				EndIf
			EndIf

			dbSelectArea("CT2")
			dbSkip()
		End

		dbSetOrder( Iif(cCapLote == "D", 6, If(cCtrlSI6=="M",1,3)) )
		dbGoto(nRecnoSI2)

		If Empty(nComplHist) .And. !Empty(CT2->CT2_ITEMC)
			li++
			@ li,070 PSAY Cr330DescA(CT2->CT2_ITEMC, "C", "CT2")
		EndIf	

		@ li,191 PSAY CT2->CT2_VALOR Picture "@E 99999,999,999,999.99"
		nTotCred += CT2->CT2_VALOR		
		li++
	EndIf
	
	dbSkip()
EndDo

If li != 80
	If Li < 50
		Li := 50
	EndIf
		
	@ li, 000 PSAY Repl( "-", 220 )
		
	li++
	@ li, 106 PSAY "Totais.................................:"
	@ li, 156 PSAY nTotDeb  Picture "@E 99999,999,999,999.99"
	@ li, 191 PSAY nTotCred Picture "@E 99999,999,999,999.99"
		
	li++
	@ li, 000 PSAY Repl( "-", 220 )
		
	li++
	@ li, 000 PSAY "VISTOS:"
	li++
	@ li, 000 PSAY "CONTABILIDADE:                             APROVADOR:                                 SUPERIOR:"  
	li+=2
	@ li, 000 PSAY "________________________________________   ________________________________________   ________________________________________"

EndIf

If aReturn[5] == 1
	Set Printer To
	Commit
	Ourspool(wnrel)
End

MS_FLUSH()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Cr330DescA³ Autor ³ Alessandro B. Freire  ³ Data ³ 19/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Fichas de Lancamento                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Cr330DescA( cItem, cDebCrd, cAlias1, cCredito, cDebito )   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACON                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ cItem    - Item do Lancamento                              ³±±
±±³           ³ cDebCrd  - Debito ou Credito                               ³±±
±±³           ³ cAlias1  - Alias corrente                                  ³±±
±±³           ³ cCredito - Conta Credito                                   ³±±
±±³           ³ cDebito  - Conta Debito                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Cr330DescA(cItem, cDebCrd, cAlias1, cCredito, cDebito)

LOCAL cRetorno := ""

If ! Empty( cItem )
	dbSelectArea( "CTD" )
	dbSetOrder( 1 )
	dbSeek( cFilial + cItem )
	cRetorno := CTD->ID_DESC
Else	
	dbSelectArea( "CT1" )
	dbSetOrder(1)

	If cDebCrd == "C"
		dbSeek( cFilial + cCredito )
	Else
		dbSeek( cFilial + cDebito )
	EndIf

	cRetorno := Substr(CT1->CT1_DESC,1,25)
EndIf

dbSelectArea(cAlias1)

Return(cRetorno)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³ Cr330ImpB³ Autor ³ Alessandro B. Freire  ³ Data ³ 19/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Fichas de Lancamento                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Cr330ImpB(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACON                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³           ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³           ³ cString - Mensagem                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Cr330ImpB(lEnd,WnRel,cString)

LOCAL tamanho		:="G"
LOCAL nTotDeb		:= 0
LOCAL nTotCred		:= 0
LOCAL cLoteDoc      := ""
LOCAL cLoteIC		:= ""
LOCAL lFirst		:= .T.
LOCAL cDigVer		:= GetMv("MV_DIGVER")
Local dDataSIC
Local cNumSIC
Local cSICEmpFil := ""
Local nRecnoSIC  := 0
Local lComplHist

m_pag  := 1
li     := 80
cbCont := 0
cbTxt  := ""
 
dbSelectArea( "CTC" )
dbSetorder(1)
cCapLote := GetMv("MV_CAPLOTE") 
cCtrlSI6 := GetMv("MV_CTRLSI6")
If cCapLote == "D"
	dbSetorder(6)
	dbSeek( cFilial + mv_par03, .t. )
Else
   If cCtrlSI6 == "M"
      dbSetorder(1)
      dbSeek( cFilial + mv_par01+ mv_par03, .t. )
   Else
      dbSetOrder(3)
      dbSeek( cFilial + Dtos(mv_par07), .t. )
   Endi
EndIf

SetRegua( RecCount() )

While !Eof() .And. cFilial == CTC->CTC_FILIAL

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	EndIF

	IncRegua()

	If cCapLote == "D"
		If CTC->CTC_DOC > mv_par04
			Exit
		EndIf	
		cLoteIC := CTC->CTC_DOC 
	Else
		If cCtrlSI6 == "M"
      	If CTC->CTC_NUM > mv_par02 + mv_par04
         	Exit
			EndIf
			cLoteIC := CTC->CTC_NUM
		Else
			If CTC->CTC_DATA > MV_PAR08
				Exit
			Endi
			cLoteIC := DTOS(CTC_DATA)+CTC->CTC_NUM
		Endif
	EndIf
	
	If CTC->CTC_DATA < mv_par07 .Or. CTC->CTC_DATA > mv_par08
		dbSkip()
		Loop
	EndIf

	If cCtrlSI6 == "D"
		If CTC_NUM < MV_PAR01 .Or. CTC_NUM > MV_PAR02
			dbSkip()
			Loop
		Endif
	Endif
	
	If CTC_DOC < MV_PAR03 .Or. CTC_DOC > MV_PAR04
		dbSkip()
		Loop
	Endif

	If ( Li > 49 .or. cLoteDoc != cLoteIC .or. Eof() ) .and. !lFirst
		If Li < 50
			Li := 50
		EndIf
		
		@ li, 000 PSAY Repl( "-", 220 )
		
		li++
		@ li, 106 PSAY "Totais.................................:"
		@ li, 156 PSAY nTotDeb  Picture "@E 99999,999,999,999.99"
		@ li, 191 PSAY nTotCred Picture "@E 99999,999,999,999.99"
		
		li++
		@ li, 000 PSAY Repl( "-", 220 )
		
		li++
		@ li, 000 PSAY "VISTOS:"
		li++
		@ li, 000 PSAY "CONTABILIDADE:                             APROVADOR:                                 SUPERIOR:"  
		li+=2
		@ li, 000 PSAY "________________________________________   ________________________________________   ________________________________________"
		
		If cLoteDoc != cLoteIC
			nTotDeb  := 0
			nTotCred := 0
			cLoteDoc := cLoteIC
		EndIf
		
		Li := 80
		lFirst := .T.
	EndIf 

	If li > 58 
		If cLoteDoc != cLoteIC
			nTotDeb  := 0
			nTotCred := 0
			cLoteDoc := cLoteIC
		EndIf
		
		Cabec1 :=	"Lote..: " +;
						SubStr( CTC->CTC_NUM, 1, 4 ) + ;
						"   Docto.: " +;
						SubStr( CTC->CTC_NUM, 5, 6 )  +;
						"   Data:"+;
						DTOC(CTC->CTC_DATA)
		
		Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho, 15 )
		lFirst := .F.
	EndIf	

	If CTC->CTC_DC $ "DX"
		CT1->( dbSetOrder( 1 ) )
		CT1->( dbSeek( xFilial("CT1") + CTC->CTC_DEBITO ) )
		If mv_par06 == 1
			If cDigVer == "S"
				@ li,000 PSAY Alltrim(CTC->CTC_DEBITO)+CTC->CTC_DCD
			Else
				@ li,000 PSAY CTC->CTC_DEBITO
			EndIf	
		Else		
			@ li,000 PSAY Alltrim(CT1->CT1_RES)
		EndIf			
		@ li,031 PSAY CTC->CTC_ITEMD
		@ li,050 PSAY CTC->CTC_CCD
		@ li,070 PSAY Substr(CT1->CT1_DESC,1,25)
		@ li,106 PSAY CTC->CTC_HIST

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Tratamento p/ o Complemento de Historico.                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nRecnoSIC := RecNo()

		dbSelectArea("CTC")
		dbSetOrder(3)

		nComplHist := 0
		cItem      := CTC->CTC_ITEMD
		lComplHist := .T.
		cSICEmpFil := CTC->CTC_EMPORIG + CTC->CTC_FILORIG
		dDataSIC   := CTC->CTC_DATA
		cNumSIC    := CTC->CTC_NUM

		dbSkip()

		While CTC->CTC_DATA == dDataSIC .And. CTC->CTC_NUM == cNumSIC .And.;
				lComplHist .And. !Eof()
			If CTC->CTC_EMPORIG + CTC->CTC_FILORIG  == cSICEmpFil
				If CTC->CTC_DC == "-"
					If Empty(nComplHist) .And. !Empty(cItem)
						li := li + 1
						@ li,070 PSAY Cr330DescA(cItem, "D", "CTC")
					Else
						li := li + 1
					EndIf

					@ li,106 PSAY AllTrim(CTC->CTC_HIST)

					nComplHist := nComplHist + 1
				Else
					lComplHist := .F.
				EndIf
			EndIf	
			dbSelectArea("CTC")
			dbSkip()
		End

		dbSetOrder( Iif(cCapLote == "D", 6, If(cCtrlSI6=="M",1,3)) )
		dbGoto(nRecnoSIC)

		If Empty(nComplHist) .And. !Empty(CTC->CTC_ITEMD)
			li++
			@ li,070 PSAY Cr330DescA(CTC->CTC_ITEMD, "D", "CTC")
		EndIf

		@ li,156 PSAY CTC->CTC_VALOR Picture "@E 99999,999,999,999.99"
		nTotDeb += CTC->CTC_VALOR		
		li++
	EndIf

	If CTC->CTC_DC $ "CX"
		CT1->( dbSetOrder( 1 ) )
		CT1->( dbSeek( xFilial("CT1") + CTC->CTC_CREDITO ) )
		If mv_par06 == 1
			If cDigVer == "S"
				@ li,000 PSAY Alltrim(CTC->CTC_CREDITO)+CTC->CTC_DCC
			Else
				@ li,000 PSAY CTC->CTC_CREDITO			
			EndIf	
		Else
			@ li,000 PSAY Alltrim(CT1->CT1_RES)
		EndIf			
		@ li,031 PSAY CTC->CTC_ITEMC
		@ li,050 PSAY CTC->CTC_CCC
		@ li,070 PSAY Substr(CT1->CT1_DESC,1,25)
		@ li,106 PSAY CTC->CTC_HIST

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Tratamento p/ o Complemento de Historico.                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nRecnoSIC := RecNo()

		dbSelectArea("CTC")
		dbSetOrder(3)

		nComplHist := 0
		cItem      := CTC->CTC_ITEMC
		lComplHist := .T.
		cSICEmpFil := CTC->CTC_EMPORIG + CTC->CTC_FILORIG
		dDataSIC   := CTC->CTC_DATA
		cNumSIC    := CTC->CTC_NUM

		dbSkip()

		While CTC->CTC_DATA == dDataSIC .And. CTC->CTC_NUM == cNumSIC .And.;
				lComplHist .And. !Eof()
			If CTC->CTC_EMPORIG + CTC->CTC_FILORIG  == cSICEmpFil
				If CTC->CTC_DC == "-"
					If Empty(nComplHist) .And. !Empty(cItem)
						li := li + 1
						@ li,070 PSAY Cr330DescA(cItem, "C", "CTC")
					Else
						li := li + 1
					EndIf

					@ li,106 PSAY AllTrim(CTC->CTC_HIST)

					nComplHist := nComplHist + 1
				Else
					lComplHist := .F.
				EndIf
			EndIf

			dbSelectArea("CTC")
			dbSkip()
		End

		dbSetOrder( Iif(cCapLote == "D", 6, If(cCtrlSI6=="M",1,3)) )
		dbGoto(nRecnoSIC)

		If Empty(nComplHist) .And. !Empty(CTC->CTC_ITEMC)
			li++
			@ li,070 PSAY Cr330DescA(CTC->CTC_ITEMC, "C", "CTC")
		EndIf	

		@ li,191 PSAY CTC->CTC_VALOR Picture "@E 99999,999,999,999.99"
		nTotCred += CTC->CTC_VALOR		
		li++
	EndIf
	
	dbSkip()
EndDo

If li != 80
	If Li < 50
		Li := 50
	EndIf
		
	@ li, 000 PSAY Repl( "-", 220 )
		
	li++
	@ li, 106 PSAY "Totais.................................:"
	@ li, 156 PSAY nTotDeb  Picture "@E 99999,999,999,999.99"
	@ li, 191 PSAY nTotCred Picture "@E 99999,999,999,999.99"
		
	li++
	@ li, 000 PSAY Repl( "-", 220 )
		
	li++
	@ li, 000 PSAY "VISTOS:"
	li++
	@ li, 000 PSAY "CONTABILIDADE:                             APROVADOR:                                 SUPERIOR:"  
	li+=2
	@ li, 000 PSAY "________________________________________   ________________________________________   ________________________________________"

EndIf

If aReturn[5] == 1
	Set Printer To
	Commit
	Ourspool(wnrel)
End

MS_FLUSH()
