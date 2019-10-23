#Include "Ctbr070.Ch"
#Include "RWMAKE.Ch"

#DEFINE CENTRO_CUSTO	1
#DEFINE ITEM_CONTABIL	2
#DEFINE CLASSE_VALOR 	3
#DEFINE VALOR_DEBITO 	4
#DEFINE VALOR_CREDITO	5
#DEFINE CODIGO_HP    	6
#DEFINE HISTORICO    	7

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr070	³ Autor ³ Pilar S Albaladejo	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Conferencia de Digitacao               	 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Ctbr070()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ Generico      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbR070C()

Local aCtbMoeda		:= {}
LOCAL cDesc1 		:= STR0001	//"Este programa ira imprimir o Relatorio para Conferencia"
LOCAL cDesc2 		:= STR0002   //"de Digitacao - Modelo 1. Ideal para Plano de Contas "
LOCAL cDesc3		:= STR0003   //"que possuam codigos nao muito extensos.            "
LOCAL wnrel
LOCAL cString		:= "CT2"
Local titulo 		:= STR0004 	//"Conferencia de Digitacao - Modelo 1"
Local lRet			:= .T.
Local lCusto 		:= .F.
Local lItem 		:= .F.
Local lCV	 		:= .F.
Local Limite		:= 132
Local cDescMoeda	:= ""

PRIVATE Tamanho		:="M"
PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR070"
PRIVATE aReturn 	:= { STR0005, 1,STR0006, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  := "CTBR070C"

Private lTot123
li 		:= 80
m_pag	:= 1
CTR070SX1()

Pergunte("CTR070",.F.)
            
If mv_par17 == 1		// Resumido
	Titulo += STR0022
EndIf	

If mv_par09 == 1 
	lCusto := .T.
Else 
	lCusto := .F.	
Endif	

If mv_par10 == 1 
	lItem := .T.
Else 
	lItem := .F.	
Endif	

If mv_par14 == 1 
	lCV := .T.
Else 
	lCV := .F.	
Endif	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros						 	³
//³ mv_par01				// Data Inicial                  	 	³
//³ mv_par02				// Data Final                         	³
//³ mv_par03				// Lote  Inicial                        ³
//³ mv_par04				// Lote  Final  						³
//³ mv_par05				// Documento Inicial                    ³
//³ mv_par06				// Documento Final			    		³
//³ mv_par07				// Moeda?						     	³
//³ mv_par08				// Cod Conta? Normal / Reduzido 		³
//³ mv_par09				// Imprime C. Custo? Sim / Nao	    	³
//³ mv_par10				// Imprime Item? Sim / Nao			    ³
//³ mv_par11				// Imprime Lcto? Realiz. / Orcado / Pre ³
//³ mv_par12				// Quebra Pagina por?Lote/Doc/Nao Quebra³
//³ mv_par13				// Totaliza    ? Sim / Nao			    ³
//³ mv_par14				// Imprime Classe de Valores? Sim / Nao ³
//³ mv_par15				// Sub-Lote Inicial                  	³
//³ mv_par16				// Sub-Lote Final  						³
//³ mv_par17				// Imprime? Resumido / Completo			³
//³ mv_par18				// Cod C.C. ? Normal / Reduzido			³
//³ mv_par19				// Cod Item ? Normal / Reduzido 		³
//³ mv_par20				// Cod Cl.Vlr? Normal / Reduzido 		³
//³ mv_par21				// Impr. Compl. Part. Dobrada? Sim/Não  ³
//³ SE FOR PARA O CHILE							               	 	³
//³ mv_par22				// Do Corrrelativo               	 	³
//³ mv_par23				// Ate Correlativo                    	³
//³ mv_par24				// Imp.Tot.Inf/Dig/Dif?           	 	³
//³ SE NAO FOR PARA O CHILE        				              	 	³
//³ mv_par22				// Imp.Tot.Inf/Dig/Dif?           	 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel	:= "CTBR070"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If mv_par09 == 1                   
	lCusto := .T.
Else 
	lCusto := .F.	 
Endif	

If mv_par10 == 1 
	lItem := .T.
Else 
	lItem := .F.	
Endif	

If mv_par14 == 1 
	lCV := .T.
Else 
	lCV := .F.	
Endif	
                                                                      
lTot123 := If( cPaisLoc = "CHI", mv_par24, mv_par22)

If nLastKey == 27
	Set Filter To
	Return
Endif

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par07)
	If Empty(aCtbMoeda[1])                       
      Help(" ",1,"NOMOEDA")
      Set Filter To
      Return
   Endif
Endif

cDescMoeda 	:= Alltrim(aCtbMoeda[2])

Titulo	+= STR0030 + cDescMoeda

// Somente caso imprima dois tipos juntos envio como 220 colunas
If (mv_par17 == 2) .And. ((lCusto .And. lItem) .Or. (lItem .And. lCv) .Or. (lCusto .And. lCv) .Or.;
   (lCusto .And. lItem .And. lCv)) .Or. ( mv_par17 = 1 .And. lTot123 == 1)
	tamanho := "G"
	Limite  := 220
Endif

SetDefault(aReturn,cString,,,Tamanho,If(Tamanho="G",2,1))	

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| CTR070Imp(@lEnd,wnRel,cString,Titulo,lCusto,lItem,lCV,Limite)})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR070IMP ³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 24.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio -> Conferencia Digitacao Modelo 1        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR070Imp(lEnd,WnRel,cString,Titulo,lCusto,lItem,lCV)       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1   - A‡ao do Codeblock                                ³±±
±±³          ³ ExpC1   - T¡tulo do relat¢rio                              ³±±
±±³          ³ ExpC2   - Mensagem                                         ³±±
±±³          ³ ExpC3   - Titulo                                           ³±±
±±³          ³ ExpL1   - Define se imprime o centro de custo              ³±±
±±³          ³ ExpL2   - Define se imprime o item                         ³±±
±±³          ³ ExpL3   - Define se imprime a classe de valor              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CTR070Imp(lEnd,WnRel,cString,Titulo,lCusto,lItem,lCV,Limite)

LOCAL CbTxt		:= Space(10)
Local CbCont	:= 0
Local cabec1  	:= ""                                       
Local cabec2  	:= " "

Local aColunas		:= {}
Local cLote
Local cSubLote
Local cDoc                
Local cMoeda		:= mv_par07
Local cSayItem		:= CtbSayApro("CTD")
Local cSayCC		:= CtbSayApro("CTT")
Local cSayCV		:= CtbSayApro("CTH")
Local cLoteRes
Local cSubRes
Local cDocRes
Local dDataRes
Local dData
Local lTotal		:= Iif(mv_par13 == 1,.T.,.F.)
Local lResumo	    := Iif(mv_par17 == 1,.T.,.F.)
Local lPrimPag		:= .T.
Local lQuebraDoc	:= .F.
Local cSEGOFI		:= "" //Correlativo para o Chile
Local nTotalDeb		:= 0
Local nTotalCrd		:= 0
Local nTotLotDeb	:= 0
Local nTotLotCrd	:= 0
Local nTotGerDeb	:= 0
Local nTotGerCrd	:= 0
Local nTotGerInf	:= nTotGerDig := 0
Local nDif			:= 0
Local nCol
Local n

If !lResumo
	If !lCusto .And. !lItem .And. !lCV //So imprime a conta
		Cabec1 := STR0007+space(19)+STR0015
	Else
	
	/*
	
	LI TP CONTA                C CUSTO              ITEM CONTA           COD CL VAL                   VALOR DEB        VALOR CRED  HP HIST
	
	      12345678901234567890 12345678901234567890 12345678901234567890 12345678901234567890 12345678901234567 12345678901234567 123 1234567890123456789012345678901234567890
	
	LI TP CONTA                ITEM CONTA           COD CL VAL                   VALOR DEB        VALOR CRED  HP HIST
	
	      12345678901234567890 12345678901234567890 12345678901234567890 12345678901234567 12345678901234567 123 1234567890123456789012345678901234567890
	      
	LI TP CONTA                COD CL VAL                   VALOR DEB        VALOR CRED  HP HIST
	                           12345678901234567890         VALOR DEB        VALOR CRED  HP HIST 
	
	      12345678901234567890 12345678901234567890 12345678901234567 12345678901234567 123 1234567890123456789012345678901234567890
	*/
	
		Cabec1 := STR0008
		If lCusto .And. lItem .And. lCv
			aColunas := { 027, 048, 069, 090, 108, 126, 130 }
		ElseIf (lCusto .And. lItem)
			aColunas := { 027, 048, 000, 069, 087, 105, 109 }
		ElseIf (lCusto .And. lCv)
			aColunas := { 027, 000, 048, 069, 087, 105, 109 }
		ElseIf (lItem .And. lCv)
			aColunas := { 000, 027, 048, 069, 087, 105, 109 }
		ElseIf lCusto
			aColunas := { 027, 000, 000, 048, 066, 084, 088 }
		ElseIf lItem
			aColunas := { 000, 027, 000, 048, 066, 084, 088 }
		Else
			aColunas := { 000, 000, 027, 048, 066, 084, 088 }
		Endif 
		If lCusto
			Cabec1 += Upper(Left(cSayCC + Space(21), 21))
		Endif
		If lItem
			Cabec1 += Upper(Left(cSayItem + Space(21), 21))
		Endif
		If lCv
			Cabec1 += Upper(Left(cSayCv + Space(21), 21))
		Endif
		Cabec1 += STR0016
	EndIf
Else     
	If lTot123 == 1
		Cabec1 := STR0021 
	Else
		Cabec1 := STR0031 
	EndIF
	
	CTC->(DbSetOrder(1))
/*
DATA          LOTE      SUBLOTE    DOCUMENTO      TOTAL INFORMADO       VALOR A DEBITO      VALOR A CREDITO           DIFERENCA                        TOTAL DIGITADO    DIFERENCA INF/DIG
***********************************************************************************************************************************************************************************************************
10/06/2002    008850        001       000001             2.500,00             2.500,00             2.500,00                0,00    1234567890123             2.500,00                 0,00    1234567890123
*/                                                                                                                                                                                         
EndIf	

dbSelectArea("CT2")
dbSetOrder(1)
dbSeek(xFilial()+DTOS(mv_par01)+mv_par03+mv_par15+mv_par05,.T.)

SetRegua(RecCount())

While !Eof() .And. CT2->CT2_FILIAL == xFilial() 	.And.;
					CT2->CT2_DATA <= mv_par02                       
					
	If lEnd
		@Prow()+1,0 PSAY STR0009   //"***** CANCELADO PELO OPERADOR *****"
		Exit
	EndIF                        
	
	If Ctr070Skip()
		dbSkip()
		Loop
	EndIf	

	IncRegua()

	cLote 		:= CT2->CT2_LOTE
	cSubLote 	:= CT2->CT2_SBLOTE
	cDoc		:= CT2->CT2_DOC
	dData 		:= CT2->CT2_DATA
	If cPaisLoc == "CHI"	
		cSegOfi := CT2->CT2_SEGOFI
	EndIf		
	lFirst:= .T.
	nTotalDeb := 0
	nTotalCrd := 0

	lQuebraDoc := Iif(mv_par12==2,.T.,.F.)
	While !Eof() .And. CT2->CT2_FILIAL == xFilial() 			.And.;
						Dtos(CT2->CT2_DATA) == Dtos(dData) 	.And.;
						CT2->CT2_LOTE == cLote 				.And.;
						CT2->CT2_SBLOTE == cSubLote 			.And.;
						CT2->CT2_DOC == cDoc

		If Ctr070Skip()
			dbSkip()
			Loop
		EndIf	

		IncRegua()

		IF (!lResumo .And. li > 62) .Or. lQuebraDoc
			CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
			If lQuebraDoc .Or. lPrimPag
				lPrimPag	:= .F.				
			EndIf	
			lQuebraDoc := .F.
		EndIf

		If lFirst .And. !lResumo
			@ li,00 PSAY Replicate("-",Limite)			
			li++
			@ li,000 PSAY STR0012
			@ li,007 PSAY DTOC(dData)
			@ li,019 PSAY STR0013
			@ li,027 PSAY cLote
			@ li,038 PSAY STR0017 //"Sub-Lote"
			@ li,049 PSAY cSubLote
			@ li,058 PSAY STR0014
			@ li,064 PSAY cDoc
			If cPaisLoc == "CHI"
				@ Li,80 PSAY STR0029 + cSegOfi
			EndIf		
			lFirst := .F.
			li ++
			@ li,00 PSAY Replicate("-",Limite)						
			li++
		EndIf
	
		If !lResumo			// Imprime o relatorio detalhado
			If ! lCusto .And. ! lItem .And. ! lCv //Se nao imprime C.C, Item E Cl.Valores
				@ li, 000 PSAY CT2->CT2_LINHA
				@ li, 004 PSAY CT2->CT2_DC
				If mv_par08 == 2
					dbSelectArea("CT1")
					dbSeek(xFilial()+CT2->CT2_DEBITO)
					@ li, 006 PSAY CT1->CT1_RES
					dbSeek(xFilial()+CT2->CT2_CREDIT)				
					@ li, 027 PSAY CT1->CT1_RES
					dbSelectArea("CT2")				
				Else
					@ li, 006 PSAY CT2->CT2_DEBITO
					@ li, 027 PSAY CT2->CT2_CREDIT
				Endif			
	  	
				nValor	:= CT2->CT2_VALOR
  	
				If CT2->CT2_DC == "1" .Or. CT2->CT2_DC == "3" 
					@ li, 049 PSAY nValor Picture Tm(nValor,17)
					nTotalDeb += nValor
					nTotGerDeb+= nValor
					nTotLotDeb+= nValor
				Endif
				If CT2->CT2_DC == "2" .Or. CT2->CT2_DC == "3"
					@ li, 070 PSAY nValor Picture Tm(nValor,17)
					nTotalCrd += nValor
					nTotGerCrd+= nValor
					nTotLotCrd+= nValor					
				Endif
				@ li, 092 PSAY CT2->CT2_HP
				@ li, 097 PSAY CT2->CT2_HIST
			Else //Se imprime C.C ou Item ou Cl. Valores os lanc. tipo '3' serao desdobrados
				If CT2->CT2_DC == '1' .Or. CT2->CT2_DC =='2'//Se o lancamento e tipo '1' ou '2'
					@ li, 000 PSAY CT2->CT2_LINHA
					@ li, 004 PSAY CT2->CT2_DC
					If mv_par08 == 2
						dbSelectArea("CT1")
						If CT2->CT2_DC == '1'
							dbSeek(xFilial()+CT2->CT2_DEBITO)
							@ li, 006 PSAY CT1->CT1_RES      
						ElseIf CT2->CT2_DC == '2'												
							dbSeek(xFilial()+CT2->CT2_CREDIT)				
							@ li, 006 PSAY CT1->CT1_RES
						Endif
						dbSelectArea("CT2")				
					Else
						If CT2->CT2_DC == '1'
							@ li, 006 PSAY CT2->CT2_DEBITO
						ElseIf CT2->CT2_DC == '2'					
							@ li, 006 PSAY CT2->CT2_CREDIT
						Endif
					Endif			
	  	
					nValor := CT2->CT2_VALOR
					If CT2->CT2_DC == '1'
						If lCusto
							@ li,aColunas[CENTRO_CUSTO] PSAY Ctr070CTT(CT2->CT2_CCD)
						Endif
						If lItem
							@ li,aColunas[ITEM_CONTABIL] PSAY Ctr070CTD(CT2->CT2_ITEMD)
						Endif   
						If lCv
							@ li,aColunas[CLASSE_VALOR] PSAY Ctr070CTH(CT2->CT2_CLVLDB)
						Endif						
						@ li,aColunas[VALOR_DEBITO] PSAY nValor Picture Tm(nValor,17)
						nTotalDeb += nValor
						nTotGerDeb+= nValor
						nTotLotDeb+= nValor						
					ElseIf CT2->CT2_DC =='2'
						If lCusto
							@ li,aColunas[CENTRO_CUSTO] PSAY Ctr070CTT(CT2->CT2_CCC)
						Endif
						If lItem
							@ li,aColunas[ITEM_CONTABIL] PSAY Ctr070CTD(CT2->CT2_ITEMC)
						Endif   
						If lCv
							@ li,aColunas[CLASSE_VALOR] PSAY Ctr070CTH(CT2->CT2_CLVLCR)
						Endif						
						@ li,aColunas[VALOR_CREDITO] PSAY nValor Picture Tm(nValor,17)
						nTotalCrd += nValor
						nTotGerCrd+= nValor
						nTotLotCrd+= nValor
					Endif	
					@ li, aColunas[CODIGO_HP] PSAY CT2->CT2_HP
					@ li, aColunas[HISTORICO] PSAY CT2->CT2_HIST                       
									
				Elseif CT2->CT2_DC == '3' //Se o lancamento e tipo '3', e desdobrado
					For n:=1 to 2
					   @ li, 000 PSAY CT2->CT2_LINHA
					   If n == 1
							@ li, 004 PSAY '1'
						Else                
							@ li, 004 PSAY '2'
						Endif						
						If mv_par08 == 2
							dbSelectArea("CT1")
							If n==1
								dbSeek(xFilial()+CT2->CT2_DEBITO)
								@ li, 006 PSAY CT1->CT1_RES
							Else
								dbSeek(xFilial()+CT2->CT2_CREDIT)				
								@ li, 006 PSAY CT1->CT1_RES
							Endif
							dbSelectArea("CT2")				
						Else                             
							If n==1
								@ li, 006 PSAY CT2->CT2_DEBITO
							Else
								@ li, 006 PSAY CT2->CT2_CREDIT
							Endif
						Endif			
	  		
						nValor	:= CT2->CT2_VALOR
						If n == 1
							If lCusto
								@ li,aColunas[CENTRO_CUSTO] PSAY Ctr070CTT(CT2->CT2_CCD)
							Endif
							If lItem
								@ li,aColunas[ITEM_CONTABIL] PSAY Ctr070CTD(CT2->CT2_ITEMD)
							Endif   
							If lCv
								@ li,aColunas[CLASSE_VALOR] PSAY Ctr070CTH(CT2->CT2_CLVLDB)
							Endif						
							@ li,aColunas[VALOR_DEBITO] PSAY nValor Picture Tm(nValor,17)
							nTotalDeb += nValor
							nTotGerDeb+= nValor
							nTotLotDeb+= nValor
						Else
							If lCusto
								@ li,aColunas[CENTRO_CUSTO] PSAY Ctr070CTT(CT2->CT2_CCC)
							Endif
							If lItem
								@ li,aColunas[ITEM_CONTABIL] PSAY Ctr070CTD(CT2->CT2_ITEMC)
							Endif   
							If lCv
								@ li,aColunas[CLASSE_VALOR] PSAY Ctr070CTH(CT2->CT2_CLVLCR)
							Endif						
							@ li,aColunas[VALOR_CREDITO] PSAY nValor Picture Tm(nValor,17)						
							nTotalCrd += nValor
							nTotGerCrd+= nValor
							nTotLotCrd+= nValor
						Endif
						@ li, aColunas[CODIGO_HP]	PSAY CT2->CT2_HP
						@ li,aColunas[HISTORICO] 	PSAY CT2->CT2_HIST
						
						If n == 1 .and. mv_par21 == 1
							// Procura pelo complemento de historico
							cSeq 	:= CT2->CT2_SEQLAN
							cEmpOri	:= CT2->CT2_EMPORI
							cFilOri	:= CT2->CT2_FILORI
							nReg := Recno()
							dbSelectArea("CT2")
							dbSetOrder(10)
							If dbSeek(xFilial()+DTOS(dData)+cLote+cSubLote+cDoc+cSeq+cEmpOri+cFilOri)
								dbSkip()
								If CT2->CT2_DC == "4"
									While !Eof() .And. CT2->CT2_FILIAL == xFilial() .And.;
										CT2->CT2_LOTE == cLote .And. CT2->CT2_DOC == cDoc .And.;
										CT2->CT2_SEQLAN == cSeq .And. CT2->CT2_EMPORI == cEmpOri .And. ;
										CT2->CT2_FILORI == cFilOri 	.And. ;
										DTOS(CT2->CT2_DATA) == DTOS(dData)
										
										If CT2->CT2_DC == "4"
											li++
											IF li > 62
												/*Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho,;
												Iif(aReturn[4] == 1, GetMv("MV_COMP"), GetMv("MV_NORM")))*/
										   		CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
											EndIf
											If !lCusto .And. !lItem .And. !lCV
												@ li, 000 PSAY CT2->CT2_LINHA
												@ li, 004 PSAY CT2->CT2_DC
												@ li, 097 PSAY CT2->CT2_HIST
											Else
												@ li, 000 PSAY CT2->CT2_LINHA
												@ li, 004 PSAY CT2->CT2_DC
												@ li, aColunas[HISTORICO] PSAY CT2->CT2_HIST
											EndIf
										EndIf
										dbSkip()
									EndDo
								EndIf
							EndIf
							dbSelectArea("CT2")
							dbSetOrder(1)
							dbGoto(nReg)
							li++
						ElseIf n == 1
							li++
						EndIf
					Next
				Endif
			EndIf
			
			// Procura pelo complemento de historico
			cSeq 	:= CT2->CT2_SEQLAN
			cEmpOri	:= CT2->CT2_EMPORI
			cFilOri	:= CT2->CT2_FILORI
			nReg := Recno()
			dbSelectArea("CT2")
			dbSetOrder(10)
			If dbSeek(xFilial()+DTOS(dData)+cLote+cSubLote+cDoc+cSeq+cEmpOri+cFilOri)
				dbSkip()
				If CT2->CT2_DC == "4"
					While !Eof() .And. CT2->CT2_FILIAL == xFilial() .And.;
						CT2->CT2_LOTE == cLote .And. CT2->CT2_DOC == cDoc .And.;
						CT2->CT2_SEQLAN == cSeq .And. CT2->CT2_EMPORI == cEmpOri .And. ;
						CT2->CT2_FILORI == cFilOri 	.And. ;
						DTOS(CT2->CT2_DATA) == DTOS(dData)
						
						If CT2->CT2_DC == "4"
							li++
							IF li > 62
								/*Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho,;
								Iif(aReturn[4] == 1, GetMv("MV_COMP"), GetMv("MV_NORM")))*/
						   		CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)							
							EndIf
							If !lCusto .And. !lItem .And. !lCV
								@ li, 000 PSAY CT2->CT2_LINHA
								@ li, 004 PSAY CT2->CT2_DC
								@ li, 097 PSAY CT2->CT2_HIST
							Else
								@ li, 000 PSAY CT2->CT2_LINHA
								@ li, 004 PSAY CT2->CT2_DC
								@ li, aColunas[HISTORICO] PSAY CT2->CT2_HIST
							EndIf
						EndIf
						dbSkip()
					EndDo
				EndIf
			EndIf
			dbSetOrder(1)
			dbGoto(nReg)
			dbSkip()
			li++
			IF li > 62
		   		CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
				/*Cabec( Titulo, Cabec1, Cabec2, NomeProg, Tamanho,;
					Iif(aReturn[4] == 1, GetMv("MV_COMP"), GetMv("MV_NORM")))*/
			EndIf
		Else						// Armazena valores para impressa resumida
			cLoteRes 	:= CT2->CT2_LOTE
			cSubRes		:= CT2->CT2_SBLOTE
			cDocRes		:= CT2->CT2_DOC
			dDataRes	:= CT2->CT2_DATA
			If CT2->CT2_DC == "1" .Or. CT2->CT2_DC == "3"
			nValor := CT2->CT2_VALOR
				nTotalDeb += nValor
				nTotGerDeb+= nValor
				nTotLotDeb+= nValor
			EndIf
			If CT2->CT2_DC == "2" .Or. CT2->CT2_DC == "3"
			nValor := CT2->CT2_VALOR
				nTotalCrd += nValor
				nTotGerCrd+= nValor			
				nTotLotCrd+= nValor
			EndIf	
			dbSkip()
		EndIf
	EndDO

	If lTotal .And. !lResumo			// Relatorio Completo
		li++
		@ li,02 PSAY STR0018
//		CTC->(MsSeek(xFilial()+dtos(dData)+cLote+cSubLote+cDoc+"01"))
		CTC->(MsSeek(xFilial()+dtos(dData)+cLote+cSubLote+cDoc+cMoeda))
		nTotGerInf += CTC->CTC_INF
		nTotGerDig += CTC->CTC_DIG
		If !lCusto .And. !lItem  .And. !lCV                     
			@ li, 049 		PSAY nTotalDeb Picture Tm(nTotalDeb,17)
			@ li, 070 		PSAY nTotalCrd Picture Tm(nTotalCrd,17)
		Else
			@ li, aColunas[VALOR_DEBITO] 	PSAY nTotalDeb Picture Tm(nTotalDeb,17)
			@ li, aColunas[VALOR_CREDITO] 	PSAY nTotalCrd Picture Tm(nTotalCrd,17)
		Endif
		
		If lTot123 == 1	//Se imprime total informado, digitado e diferenca		
			If limite = 132
				nCol := If(Len(aColunas) > 0, aColunas[HISTORICO], 097)
				@ li ++, nCol	PSAY STR0025 + 	Trans(CTC->CTC_INF, Tm(CTC->CTC_INF,17)) //"INFORMADO"
				@ li   , nCol	PSAY STR0026 + 	Trans(CTC->CTC_DIG, Tm(CTC->CTC_DIG,17)) //"DIGITADO "
				If Round(NoRound(CTC->CTC_DIG - CTC->CTC_INF, 2), 2) # 0
					li ++
					@ li,nCol PSAY STR0027 + Trans(Abs(CTC->CTC_DIG - CTC->CTC_INF),; //"DIFERENCA"
							   					 Tm(CTC->CTC_DIG,17))
				Endif
			Else
				@ li, aColunas[HISTORICO] 		PSAY STR0028 + Trans(CTC->CTC_INF,; //"INFORMADO "
																	Tm(CTC->CTC_INF,17)) +;
				 								     Space(4) + STR0026 +; //"DIGITADO "
				 								     Trans(CTC->CTC_DIG, Tm(CTC->CTC_DIG,17)) +;
				 								     Space(4) + STR0027 +; //"DIFERENCA"
													 Trans(	Abs(CTC->CTC_DIG-CTC->CTC_INF),;
													 Tm(CTC->CTC_DIG,17))
			Endif
		EndIf
		li++
		nTotalDeb := 0	
		nTotalCrd := 0	
		
		// TOTALIZA O LOTE
		If cLote != CT2->CT2_LOTE 				.Or.;
		   cSubLote != CT2->CT2_SBLOTE 			.Or.;
		   Dtos(dData) != Dtos(CT2->CT2_DATA)
			li++
			@ li,02 PSAY STR0020
		 //	CT6->(MsSeek(xFilial()+dtos(dData)+cLote+cSubLote+"01"))
		 	CT6->(MsSeek(xFilial()+dtos(dData)+cLote+cSubLote+cMoeda))
			If !lCusto .And. !lItem  .And. !lCV                     
				@ li, 049 PSAY nTotLotDeb Picture Tm(nTotLotDeb,17)
				@ li, 070 PSAY nTotLotCrd Picture Tm(nTotLotCrd,17)
			Else
				@ li, aColunas[VALOR_DEBITO] 	PSAY nTotLotDeb Picture Tm(nTotLotDeb,17)
				@ li, aColunas[VALOR_CREDITO] 	PSAY nTotLotCrd Picture Tm(nTotLotCrd,17)
			Endif
			If lTot123 == 1	//Se imprime total informado, digitado e diferenca											
				If limite = 132
					nCol := If(Len(aColunas) > 0, aColunas[HISTORICO], 097)
					@ li ++, nCol PSAY STR0025 + 	Trans(CT6->CT6_INF,; //"INFORMADO"
														Tm(CT6->CT6_INF,17))
					@ li   , nCol PSAY STR0026 + 	Trans(CT6->CT6_DIG,; //"DIGITADO "
														Tm(CT6->CT6_DIG,17))
					If Round(NoRound(CT6->CT6_DIG - CT6->CT6_INF, 2), 2) # 0
						li ++
						@ li,nCol PSAY STR0027 + 	Trans(Abs(CT6->CT6_DIG -; //"DIFERENCA"
														CT6->CT6_INF), Tm(CT6->CT6_DIG,17))
					Endif				
				Else     
					@ li, aColunas[HISTORICO] 		PSAY STR0028 + Trans(CT6->CT6_INF,; //"INFORMADO "
																		Tm(CT6->CT6_INF,17)) +;
			 									     Space(4) + STR0026 +; //"DIGITADO "
			 									     Trans(CT6->CT6_DIG, Tm(CT6->CT6_DIG,17)) +;
			 									     Space(4) + STR0027 +;  //"DIFERENCA"
													 Trans(	Abs(CT6->CT6_DIG-CT6->CT6_INF),;
													 Tm(CT6->CT6_DIG,17))
				Endif
			EndIf
			li++
			nTotLotDeb := 0	
			nTotLotCrd := 0	
        EndIf
	ElseiF lResumo       			// Relatorio Resumido
		IF li > 62
			CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
		EndIf
		nDif := Round(NoRound(nTotalDeb - nTotalCrd, 2), 2)
//		CTC->(MsSeek(xFilial()+dtos(dDataRes)+cLoteRes+cSubRes+cDocRes+"01"))
		CTC->(MsSeek(xFilial()+dtos(dDataRes)+cLoteRes+cSubRes+cDocRes+cMoeda))

		@ li,000 PSAY DTOC(dDataRes)
		@ li,014 PSAY cLoteRes
		@ li,028 PSAY cSubRes
		@ li,038 PSAY cDocRes
		If lTot123 == 1
			@ li,048 PSAY CTC->CTC_INF 	Picture Tm(CTC->CTC_INF,17)		
			@ li,069 PSAY nTotalDeb 	Picture Tm(nTotalDeb,17)		
			@ li,090 PSAY nTotalCrd 	Picture Tm(nTotalCrd,17)    
			@ li,110 PSAY Abs(nDif)		Picture Tm(Abs(nDif),17)
			If nDif > 0
				@ li,131 PSAY STR0023 		// "DIF A DEBITO"
			ElseIf nDif < 0
				@ li,131 PSAY STR0024		// "DIF A CREDITO"
			EndIf			
			@ li,148 PSAY CTC->CTC_DIG 	Picture Tm(CTC->CTC_DIG,17)		

			nTotGerDig += CTC->CTC_DIG
			nTotGerInf += CTC->CTC_INF

			nDif := Round(NoRound(CTC->CTC_DIG - CTC->CTC_INF, 2), 2)
			@ li,169 PSAY Abs(nDif)		Picture Tm(nDif,17)		
		Else
			@ li,069 PSAY nTotalDeb 	Picture Tm(nTotalDeb,17)		
			@ li,090 PSAY nTotalCrd 	Picture Tm(nTotalCrd,17)    		
		EndIf
		li++
		nTotalDeb 	:= 0	
		nTotalCrd 	:= 0			
	Endif
	
	// Impressao do Cabecalho
	If mv_par12 == 1			// Quebra pagina quando for lote diferente
		If cLote != CT2->CT2_LOTE 				.Or.;
		   cSubLote != CT2->CT2_SBLOTE 			.Or.;
		   Dtos(dData) != Dtos(CT2->CT2_DATA)   .And. Ctr070Skip()
	   		CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
		EndIf
	ElseIF li > 62
		CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)
	EndIf
EndDo

If li != 80
	If lTotal
		IF li > 62 
			CtCGCCabec(,,,Cabec1,Cabec2,dDataBase,Titulo,,"2",Tamanho)		
		EndIf		
		li+=2
		@ li,00 PSAY Replicate("-",Limite)
		li++
		@ li,02 PSAY STR0019
		If !lResumo
			If !lCusto .And. !lItem  .And. !lCV                     
				@ li, 049 PSAY nTotGerDeb Picture Tm(nTotGerDeb,17)
				@ li, 070 PSAY nTotGerCrd Picture Tm(nTotGerCrd,17)
			Else
				@ li, aColunas[VALOR_DEBITO] 	PSAY nTotGerDeb Picture Tm(nTotGerDeb,17)
				@ li, aColunas[VALOR_CREDITO] 	PSAY nTotGerCrd Picture Tm(nTotGerCrd,17)
			Endif
			If lTot123 == 1			
				If limite = 132			
					nCol := If(Len(aColunas) > 0, aColunas[HISTORICO], 097)
					@ li ++, nCol  	PSAY STR0025 + 	Trans(nTotGerInf, Tm(nTotGerInf,17)) //"INFORMADO"
					@ li   , nCol	PSAY STR0026 + 	Trans(nTotGerDig, Tm(nTotGerDig,17)) //"DIGITADO "
					If Round(NoRound(nTotGerDig - nTotGerInf, 2), 2) # 0
						li ++
						@ li,nCol	PSAY STR0027 + 	Trans(Abs(nTotGerDig - nTotGerInf),; //"DIFERENCA"
														Tm(nTotGerDig,17))
					Endif
				Else
					@ li, aColunas[HISTORICO] 		PSAY STR0028 + Trans(nTotGerInf,; //"INFORMADO "
																		Tm(nTotGerInf,17)) +;
				 								     Space(4) + STR0026 +; //"DIGITADO "
				 								     Trans(nTotGerDig, Tm(nTotGerDig,17)) +;
				 								     Space(4) + STR0027 +;  //"DIFERENCA"
													 Trans(	Abs(nTotGerDig-nTotGerInf),;
													 Tm(nTotGerDig,17))
				Endif                     
			EndIf
		Else 
			If lTot123 == 1
				nDif := nTotGerDeb - nTotGerCrd
	
				@ li,048 PSAY nTotGerInf 	Picture Tm(nTotGerInf,17)		
				@ li,069 PSAY nTotGerDeb 	Picture Tm(nTotGerDeb,17)		
				@ li,090 PSAY nTotGerCrd 	Picture Tm(nTotGerCrd,17)    
				@ li,110 PSAY Abs(nDif)		Picture Tm(Abs(nDif),17)
				@ li,148 PSAY nTotGerDig 	Picture Tm(nTotGerDig,17)		
	
				nDif := Round(NoRound(nTotGerDig - nTotGerInf, 2), 2)				
				@ li,169 PSAY Abs(nDif)		Picture Tm(nDif,17)		  
			Else
				@ li,069 PSAY nTotGerDeb 	Picture Tm(nTotGerDeb,17)		
				@ li,090 PSAY nTotGerCrd 	Picture Tm(nTotGerCrd,17)    			
			EndIf
		Endif                                               
		li++
		@ li,00 PSAY Replicate("-",Limite)
	EndIf	
	roda(cbcont,cbtxt,"M")
	Set Filter To
EndIf	

If aReturn[5] = 1
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf

MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Ctr070Skip³ Autor ³ Pilar S Albaladejo	³ Data ³ 02.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica condicoes para pular os registros			      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Ctr070Skip()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ Generico      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function Ctr070Skip()

Local lRet := .F.

If mv_par11 <> CT2->CT2_TPSALD
	lRet := .T.
Endif
	   
If (CT2->CT2_LOTE < mv_par03) .Or. (CT2->CT2_LOTE > mv_par04)
	lRet := .T.
Endif
	
If (CT2->CT2_SBLOTE < mv_par15) .Or. (CT2->CT2_SBLOTE > mv_par16)
	lRet := .T.
Endif
	
If (CT2->CT2_DOC < mv_par05) .Or. (CT2->CT2_DOC > mv_par06)
	lRet := .T.
Endif

If CT2->CT2_MOEDLC <> mv_par07
	lRet := .T.
Endif            

If CT2->CT2_DC = "4"
	lRet	:= .T.
EndIf

If cPaisLoc == "CHI" .And. (CT2->CT2_SEGOFI < mv_par22 .Or. CT2->CT2_SEGOFI > mv_par23)
	lRet := .T.
EndIf	        

Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ctr070Ctt ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 17.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par15 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ctr070Ctt(cCC)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cCC = Conteudo a Ser impresso                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCc = Centro de custo a ser substituido (se for o caso)    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function Ctr070Ctt(cCc)

Local aSaveArea := GetArea()

If mv_par18 = 2
	dbSelectArea("CTT")
	dbSetOrder(1)		
	MsSeek(xFilial() + cCC)
	cCC := CTT->CTT_RES
Endif

RestArea(aSaveArea)
Return cCC

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ctr070Ctd ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 17.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par16 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ctr070Ctd(cItem)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cItem = Conteudo a Ser impresso                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cItem = Item a ser substituido (se for o caso)    	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function Ctr070Ctd(cItem)

Local aSaveArea := GetArea()

If mv_par19 = 2
	dbSelectArea("CTD")
	dbSetOrder(1)
	MsSeek(xFilial() + cItem)
	cItem := CTD->CTD_RES
Endif

RestArea(aSaveArea)
Return cItem

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ctr070Cth ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 17.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par17 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ctr070Cth(cClVl)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cItem = Conteudo a Ser impresso                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cClVl = Classe de valor a ser substituida (se for o caso)  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function Ctr070Cth(cClVl)

Local aSaveArea := GetArea()

If mv_par20 = 2
	dbSelectArea("CTH")
	dbSetOrder(1)
	MsSeek(xFilial() + cCLVL)
	cCLVL := CTH->CTH_RES
Endif

RestArea(aSaveArea)
Return cCLVL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTR070SX1    ³Autor ³  Lucimara Soares     ³Data³ 25/11/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria as perguntas do relatório Ctr070                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Function CTR070SX1()

Local aSaveArea 	:= GetArea()
Local cMvPar		:= ""
Local cMvCh			:= ""

aPergs := {}  

aHelpPor	:= {} 
aHelpEng	:= {}	
aHelpSpa	:= {}

If cPaisLoc == "CHI"
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ATENCAO                                                                ³
	  ³Caso haja a necessidade de adicao de novos parametros entrar em contato³
	  ³com o departamento de Localizacoes.          						  ³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	
	PutSx1(cPerg, "22","Do Correlativo ?","¿De Correlativo ?","From Correlative?","mv_chm","C",10,0,0,;
			"G",""," ","","","MV_PAR22"," "," "," ","",	" "," "," "," "," "," ", " "," "," "," ",;
			" "," ",{"Informe o numero do correlativo.s"},{"Inform the correlative  number."},{"Informe el numero del correlativo."})
	
	PutSx1(cPerg, "23","Ate Correlativo ?","¿Hasta Correlativo ?","To Correlative?","mv_chn","C",10,0,0,;
			"G","","","","","MV_PAR23"," "," "," ","",	" "," "," "," "," "," ", " "," "," "," ",;
			" "," ",{"Informe o numero do correlativo.s"},{"Inform the correlative  number."},{"Informe el numero del correlativo."})
	
	cMvPar	:= "24"
	cMvCh	:= "o"
Else
	cMvPar	:= "22"
	cMvCh	:= "m"
EndIf
	
aHelpPor	:= {} 
aHelpEng	:= {}	
aHelpSpa	:= {}
Aadd(aHelpPor,"Informe se deseja imprimir o total ")			
Aadd(aHelpPor,"informado,digitado e a diferenca.")

Aadd(aHelpSpa,"Informe si desea imprimir el total ")
Aadd(aHelpSpa,"informado, registrado y la diferencia.") 

Aadd(aHelpEng,"Inform if you wish to print the ")			
Aadd(aHelpEng,"entered total,typed total and ")
Aadd(aHelpEng,"the difference.")	

Aadd(aPergs,{  "Imp.Tot.Inf/Dig/Dif?","¨Imp.Tot.Inf/Reg/Dif?","Print.Ent./typ/Diff Tot.?","mv_ch"+cMvCh,"N",1,0,0,"C","","mv_par"+cMvPar,"Sim","Si","Yes","","","Nao","No","No","","","","","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa})                    

AjustaSx1("CTR070", aPergs)   

RestArea(aSaveArea)

Return
