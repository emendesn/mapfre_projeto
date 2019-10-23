#include "fina150.ch"
#include "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Fina150  ³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera‡„o do Arquivo de Envio de Titulos ao Banco            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Fina150()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CESV150(nPosAuto)

Local lOk		:= .F.
Local aSays 	:= {}
Local aButtons := {}

PRIVATE cCadastro := OemToAnsi(STR0005)  // "Comunica‡„o Banc ria - Envio Cobrança"

AcertSX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros ³
//³ mv_par01		 // Do Bordero 		  ³
//³ mv_par02		 // Ate o Bordero 	  ³
//³ mv_par03		 // Arq.Config 		  ³
//³ mv_par04		 // Arq. Saida    	  ³
//³ mv_par05		 // Banco     			  ³
//³ mv_par06		 // Agenciao     		  ³
//³ mv_par07		 // Conta   			  ³
//³ mv_par08		 // Sub-Conta  		  ³
//³ mv_par09		 // Cnab 1 / Cnab 2    ³
//³ mv_par10		 // Considera Filiais  ³
//³ mv_par11		 // De Filial   		  ³
//³ mv_par12		 // Ate Filial         ³
//³ mv_par13		 // Quebra por ?		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Pergunte("AFI150",.T.)
	dbSelectArea("SE1")
	dbSetOrder(1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o log de processamento                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcLogIni( aButtons )
	
	If nPosAuto <> Nil
		lOk	:= .T.
	Else
		aADD(aSays,STR0015) // "Esta rotina permite gerar o arquivo de envio do CNAB de cobrança, com base nas ocorrências"
		aADD(aSays,STR0016) // "cadastradas e com os borderôs de cobrança gerados."
		aADD(aButtons, { 5,.T.,{|| Pergunte("AFI150",.T. ) } } )
		aADD(aButtons, { 1,.T.,{|| lOk := .T.,FechaBatch()}} )
		aADD(aButtons, { 2,.T.,{|| FechaBatch() }} )

		FormBatch( cCadastro, aSays, aButtons ,,,540)
		
	Endif	

	If lOk
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza o log de processamento   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ProcLogAtu("INICIO")
		
		U_Ca150Gera("SE1")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza o log de processamento   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ProcLogAtu("FIM")
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recupera a Integridade dos dados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE1")
	dbSetOrder(1)
EndIf

Return 	
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fA150Gera³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comunica‡„o Banc ria - Envio                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fA150Gera(cAlias)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FinA150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ca150Gera(cAlias)
PRIVATE cBanco,cAgencia,xConteudo
PRIVATE nHdlBco    	:= 0
PRIVATE nHdlSaida  	:= 0
PRIVATE nSeq       	:= 0
PRIVATE nSomaValor	:= 0
PRIVATE nSomaVlLote	:= 0
PRIVATE nQtdTotTit	:= 0
PRIVATE nQtdTitLote	:= 0
PRIVATE nSomaAcres	:= 0
PRIVATE nSomaDecre	:= 0
PRIVATE nBorderos		:= 0
PRIVATE xBuffer,nLidos 	:= 0
PRIVATE nTotCnab2			:= 0 // Contador de Lay-out nao deletar 
PRIVATE nLinha				:= 0 // Contador de Linhas nao deletar 


Processa({|lEnd| fa150Ger(cAlias)})  // Chamada com regua

nBorderos  := 0
nSeq		  := 0
nSomaValor := 0
nSomaVlLote:= 0
nQtdTotTit := 0
nQtdTitLote:= 0

FCLOSE(nHdlBco)
FCLOSE(nHdlSaida)


Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fA150Ger ³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comunica‡„o Banc ria - Envio                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fA150Ger()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FinA150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fA150Ger(cAlias)
LOCAL nTamArq:=0,lResp:=.t.
LOCAL lHeader:=.F.,lFirst:=.F.,lFirst2:=.F.
LOCAL nTam,nDec,nUltDisco:=0,nGrava:=0,aBordero:={}
LOCAL nSavRecno := recno()
Local lRecicl	:= GETMV("MV_RECICL")
Local cDbf
LOCAL lFIN150_1  := ExistBlock("FIN150_1")
LOCAL lFIN150_2  := ExistBlock("FIN150_2")
LOCAL lFIN150_3  := ExistBlock("FIN150_3")
LOCAL lFINA150   := ExistBlock("FIN150")
Local lFinCnab2  := ExistBlock("FINCNAB2")
LOCAL oDlg,oBmp,nMeter := 1
LOCAL cTexto := "CNAB"
LOCAL nRegEmp := SM0->(RecNo())
LOCAL cFilDe
LOCAL cFilAte
LOCAL cNumBorAnt := CRIAVAR("E1_NUMBOR",.F.)
LOCAL cCliAnt	  := CRIAVAR("E1_CLIENTE",.F.)
LOCAL lFirstBord := .T.
LOCAL lBorBlock := .F.
LOCAL lAchouBord := .F.
Local lF150Exc := ExistBlock("F150EXC")
LOCAL lIdCnab := .T.
Local cArqGerado := ""
Local lF150Sum := ExistBlock("F150SUM")
Local lAtuDsk := .F.
Local lCnabEmail := .F.
Local cFilBor := ""
Local nOrdSE1:=5
Local lF150Ord := ExistBlock("F150ORD")                                       
Local lNovoLote := .F.
Local lF150SumA := ExistBlock("F150SUMA")
Local lF150SumD := ExistBlock("F150SUMD")
Local cAliasTrb
#IFNDEF TOP
	Local cIndexSe1
	Local nIndexSe1
#ELSE
	Local cQuery 
#ENDIF
Local lHeadMod2 := .F.
Local bWhile
Local cOrder
Local nValor

ProcRegua(SE1->(RecCount()))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona no Banco indicado                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBanco  := mv_par05
cAgencia:= mv_par06
cConta  := mv_par07
cSubCta := mv_par08

dbSelectArea("SA6")
If !(dbSeek(xFilial("SA6")+cBanco+cAgencia+cConta))
	Help(" ",1,"FA150BCO")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o log de processamento com o erro  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcLogAtu("ERRO","FA150BCO",Ap5GetHelp("FA150BCO"))

	Return .F.
Endif

dbSelectArea("SEE")
SEE->( dbSeek(xFilial("SEE")+cBanco+cAgencia+cConta+cSubCta) )
If !SEE->( found() )
	Help(" ",1,"PAR150")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o log de processamento com o erro  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcLogAtu("ERRO","PAR150",Ap5GetHelp("PAR150"))

	Return .F.
Else
	If !Empty(SEE->EE_FAXFIM) .and. !Empty(SEE->EE_FAXATU) .and. Val(SEE->EE_FAXFIM)-Val(SEE->EE_FAXATU) < 100
		Help(" ",1,"FAIXA150")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza o log de processamento com o erro  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ProcLogAtu("ERRO","FAIXA150",Ap5GetHelp("FAIXA150"))
	
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona no Bordero Informado pelo usuario                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if mv_par10 == 2
	cFilDe := cFilAnt
	cFilAte:= cFilAnt
Else
	cFilDe := mv_par11
	cFilAte:= mv_par12
Endif

nTotCnab2 := 0
nSeq := 0

If lRecicl
	cDbf := "RECICL" + Substr(cNumEmp,1,2)
	If !File(cDbf+GetDBExtension())
		lRecicl := .F.
	Else
		dbUseArea(.T.,,cDbf,"cTemp",.F.,.F.)
		IndRegua("cTemp",cDbf,"FILIAL+NOSSONUM",,,OemToAnsi(STR0008))  //"Selecionando Registros..."
	EndIf
EndIf		

If lF150Ord
	nOrdSE1 := ExecBlock("F150ORD",.F.,.F.)
EndIf

dbSelectArea("SM0")
dbSeek(cEmpAnt+cFilDe,.T.)
lAchouBord := .F.

While !Eof() .and. M0_CODIGO == cEmpAnt .and. M0_CODFIL <= cFilAte

	cFilAnt := M0_CODFIL

	dbSelectArea("SE1")
	SE1->( dbSetOrder(5) )
//	SE1->( dbSetOrder(nOrdSE1) )

	If (mv_par13 == 1 .And. mv_par09 == 2) .Or.;
		mv_par13 == 3 .Or. mv_par09 == 1 // Quebra por Bordero no CNAB modelo 2, ou se nao quebra ou se for CNAB modelo 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia a leitura do arquivo de Titulos                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SE1->( MSSeek(xFilial("SE1")+mv_par01,.T.))
		bWhile := { || !SE1->( Eof()) .and. E1_NUMBOR >= mv_par01 .AND. E1_NUMBOR <= mv_par02 .and. xFilial("SE1")==E1_FILIAL }
		cAliasTrb := "SE1"
	Elseif mv_par13 == 2 .And. mv_par09 == 2 // Quebra por Cliente no CNAB modelo 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia a leitura do arquivo de Titulos                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrder := "E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO"
		#IFDEF TOP
			cAliasTrb := GetNextAlias()
			cQuery := "SELECT SE1.R_E_C_N_O_ RECNOSE1 "
			cQuery += "FROM "+	RetSqlName("SE1") + " SE1"
			cQuery += " WHERE E1_FILIAL = '" + xFilial("SE1") + "'"
			cQuery += " AND E1_NUMBOR <> '" + Space(Len(SE1->E1_NUMBOR)) + "'"
			cQuery += " AND E1_NUMBOR between '" + mv_par01        + "' AND '" + mv_par02 + "'"
			cQuery += " AND D_E_L_E_T_ <> '*' "
			cQuery += " ORDER BY "+SqlOrder(cOrder)
			cQuery := ChangeQuery(cQuery)
			dbSelectArea("SA1")
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasTrb, .F., .T.)
		#ELSE
			cAliasTrb := "SE1"
			cIndexSe1 := CriaTrab(nil,.f.)
			IndRegua("SE1",cIndexSe1,cOrder,,"E1_FILIAL = '"+xFilial("SE1")+"' .AND. !Empty(SE1->E1_NUMBOR) .And. E1_NUMBOR >= '"+mv_par01+"' .And. E1_NUMBOR <= '" +mv_par02 + "'","Selecionando dados no servidor")
			nIndexSE1 := RetIndex("SE1")
			dbSetIndex(cIndexSe1+OrdBagExt())
			dbSetOrder(nIndexSe1+1)
			MsSeek(xFilial("SE1"))
		#ENDIF	
		bWhile := { || !(cAliasTrb)->( Eof()) }
	Endif	
	// Processa SE1 filtrado por bordero em ordem de cliente ou em ordem de bordero
	While Eval(bWhile)
	
		#IFDEF TOP 
			If mv_par13 == 2 .And. mv_par09 == 2 // quebra por cliente, CNAB modelo 2
				SE1->(MsGoto((cAliasTrb)->RECNOSE1))
			Endif	
		#ENDIF
		
		lAchouBord := .T.
		IncProc()

		IF Empty(SE1->E1_NUMBOR) .or. (SE1->E1_NUMBOR == cNumBorAnt .and. lBorBlock)
			(cAliasTrb)->( dbSkip() )
			Loop
		EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verificacao do usuario se o bordero deve ser considerado     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lF150Exc
			If !(ExecBlock("F150EXC",.F.,.F.))
				(cAliasTrb)->( dbSkip() )
				Loop
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o portador do bordero ‚ o mesmo dos parametros   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		// Se mudou o bordero ou se CNAB modelo 2, com quebra por cliente e mudou o cliente
		If SE1->E1_NUMBOR != cNumBorAnt .Or. (mv_par13 == 2 .And. mv_par09 == 2 .And. SE1->E1_CLIENTE != cCliAnt) .or. lFirstBord
			// Se CNAB modelo 2 e mudou o bordero ou cliente
			If (mv_par09 == 2 .And. (mv_par13 == 1 .And. SE1->E1_NUMBOR != cNumBorAnt) .Or. (mv_par13 == 2 .And. SE1->E1_CLIENTE != cCliAnt)) .And. !lFirstBord
				lNovoLote := .T. // Para criar Trailler de Lote e Header do novo lote
			Endif	
			lFirstBord := .F.
			dbSelectArea("SEA")
			If Fa150PesqBord(SE1->E1_NUMBOR,@cFilBor)
				While SEA->EA_NUMBOR == SE1->E1_NUMBOR .and. SEA->EA_FILIAL == xFilial("SEA") .and. !Eof()
					If SEA->EA_CART == "R"
						cNumBorAnt := SE1->E1_NUMBOR
						cCliAnt	  := SE1->E1_CLIENTE
						lBorBlock := .F.
						If cBanco+cAgencia+cConta != SEA->(EA_PORTADO+EA_AGEDEP+EA_NUMCON)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Bordero pertence a outro Bco/Age/Cta ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							Help(" ",1,"NOBCOBORD",,cNumBorAnt,4,1) 

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Atualiza o log de processamento com o erro  ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							ProcLogAtu("ERRO","NOBCOBORD",Ap5GetHelp("NOBCOBORD")+cNumBorAnt)
						
							lBorBlock := .T.
						Endif
						Exit
					Else
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Bordero pertence a outra Carteira (Pagar) ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						lBorBlock := .T.
						SEA->(dbSkip())
						Loop
					Endif
				Enddo
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Bordero nÆo foi achado no SEA        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				Help(" ",1,"BORNOXADO",,SE1->E1_NUMBOR,4,1)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza o log de processamento com o erro  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				ProcLogAtu("ERRO","BORNOXADO",Ap5GetHelp("BORNOXADO")+SE1->E1_NUMBOR)

				lBorBlock := .T.
			Endif
		Endif
		dbSelectArea(cAliasTrb)
		If lBorBlock
			(cAliasTrb)->( dbSkip() )
			Loop
		Endif

		IF SE1->E1_TIPO $ MVRECANT+"/"+MVPROVIS
			(cAliasTrb)->( dbSkip() )
			Loop
		EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³ Posiciona no cliente                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA1")
		MsSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
		// Se o Header do arquivo nao foi criado, cria.
		If !lHeadMod2  //Modelo 2
			lHeadMod2:=AbrePar(@cArqGerado)	//Abertura Arquivo ASC II
			// Se houve erro na criacao do arquivo, abandona o processo
			If ! lHeadMod2
				Exit
			Endif
		Endif	
		lCnabEmail := If(FieldPos("A1_BLEMAIL") > 0, A1_BLEMAIL == "1", .F.)
		If lFin150_1
			Execblock("FIN150_1",.F.,.F.)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³ Posiciona no Contrato bancario                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE9")
		dbSetOrder(1)
		MsSeek(xFilial("SE9")+SE1->(E1_CONTRAT+E1_PORTADO+E1_AGEDEP))
		
		dbSelectArea(cAliasTrb)
		
		// Mudou de Bordero e nao eh o primeiro bordero. Cria Trailler de Lote e Novo Header de lote.
		If lNovoLote .And. mv_par09 == 2 .And. (mv_par13 == 1 .Or. mv_par13 == 2)
			// CNAB Modelo 2, gera Trailler do Lote anterior e Header do novo lote
			RodaLote2(nHdlSaida,MV_PAR03)
			HeadLote2(nHdlSaida,MV_PAR03)
			lNovoLote := .F.
			nQtdTitLote := 0
			nSomaVlLote := 0
		Endif

		If lRecicl
			dbSelectArea("cTemp")
			MsSeek(xFilial("SE1")+SE1->E1_NUMBCO)
			RecLock("cTemp",.t.)
			dbDelete()
			MsUnLock()
		EndIf
	
		nSeq++
		nQtdTitLote ++
		nQtdTotTit ++
		
		If lF150Sum
			nValor := ExecBlock("F150SUM",.F.,.F.)
			nSomaValor	+= nValor
			nSomaVlLote += nValor
		Else
			nSomaValor	+= SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE
			nSomaVlLote += SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE
   	Endif
   	If lF150SumA
			nSomaAcres += ExecBlock("F150SUMA",.F.,.F.)
		Else
		  	nSomaAcres += SE1->E1_SDACRES
		Endif
		
		If lF150SumD
			nSomaDecre += ExecBlock("F150SUMD",.F.,.F.)
		Else
		  	nSomaDecre += SE1->E1_SDDECRE
		Endif
		If ( MV_PAR09 == 1 )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Le Arquivo de Parametrizacao                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nLidos:=0
			FSEEK(nHdlBco,0,0)
			nTamArq:=FSEEK(nHdlBco,0,2)
			FSEEK(nHdlBco,0,0)
			lIdCnab := .T.
	
			While nLidos <= nTamArq

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica o tipo qual registro foi lido                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				xBuffer:=Space(85)
				FREAD(nHdlBco,@xBuffer,85)
	
				Do Case
					Case SubStr(xBuffer,1,1) == CHR(1)
						IF lHeader
							nLidos+=85
							Loop
						EndIF
					Case SubStr(xBuffer,1,1) == CHR(2)
						lFirst2 := .F. //Controle do detalhe tipo 5	
						IF !lFirst
							lFirst := .T.
							FWRITE(nHdlSaida,CHR(13)+CHR(10))
							If lFina150
								Execblock("FIN150",.F.,.F.)
							Endif
						EndIF
					Case SubStr(xBuffer,1,1) == CHR(4) .and.  lCnabEmail
						IF !lFirst2
							nSeq++
							lFirst2 := .T.
							FWRITE(nHdlSaida,CHR(13)+CHR(10))
						Endif
					Case SubStr(xBuffer,1,1) == CHR(3)
						nLidos+=85
						Loop
					Otherwise
						nLidos+=85
						Loop
				EndCase

				nTam := 1+(Val(SubStr(xBuffer,20,3))-Val(SubStr(xBuffer,17,3)))
				nDec := Val(SubStr(xBuffer,23,1))
				cConteudo:= SubStr(xBuffer,24,60)
				nGrava := fA150Grava(nTam,nDec,cConteudo,@aBordero,,lFinCnab2,@lIdCnab,cFilBor)
				If nGrava != 1
					nSeq--
					Exit
				Endif
				dbSelectArea("SE1")
				nLidos+=85
			EndDO
			If nGrava == 3
				Exit
			Endif
		Else
			nGrava := fA150Grava(,,,@aBordero,,lFinCnab2,@lIdCnab)
		EndIf
		
	   If nGrava == 1
			lAtuDsk := .T.
			If ( MV_PAR09 == 1 )
				lIdCnab := .T.	// Para obter novo identificador do registro CNAB na rotina 
									// FA150GRAVA
	   		fWrite(nHdlSaida,CHR(13)+CHR(10))
				IF !lHeader
					lHeader := .T.
				EndIF
			Endif
			dbSelectArea("SEA")
			If (MsSeek(cFilBor+SE1->E1_NUMBOR+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO))
				Reclock("SEA")
				SEA -> EA_TRANSF := "S"
				MsUnlock()
			Endif
			If lRecicl
				dbSelectArea("SE1")
				RecLock("SE1")
				Replace E1_OCORREN With "01"
				MsUnLock()
			EndIf	
   	Endif

		If lFin150_2
			nSeq++
			If !(Execblock("FIN150_2",.f.,.f.))		// N„o incrementou
				nSeq--
			Endif
		Endif
		dbSelectArea("SE1")
		(cAliasTrb)->( dbSkip())
	Enddo
	#IFDEF TOP
		If mv_par13 == 2 .And. mv_par09 == 2 // Quebra por cliente CNAB modelo 2
			(cAliasTrb)->(DbCloseAre())
		Endif	
	#ENDIF
	If Empty(xFilial("SE1"))
		Exit
	Endif
	dbSelectArea("SM0")
	dbSkip()
EndDO

SM0->(dbgoto(nRegEmp))
cFilAnt := SM0->M0_CODFIL

If !lAchouBord
	Help(" ",1,"BORD150")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o log de processamento com o erro  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcLogAtu("ERRO","BORD150",Ap5GetHelp("BORD150"))

	Return .F.
EndIF
// Se conseguiu criar o Header do arquivo, entao cria o Trailler
If lHeadMod2
	If ( mv_par09 == 1 )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta Registro Trailler                              		  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nSeq++
		nLidos:=0
		FSEEK(nHdlBco,0,0)
		nTamArq:=FSEEK(nHdlBco,0,2)
		FSEEK(nHdlBco,0,0)
		While nLidos <= nTamArq
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Tipo qual registro foi lido                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			xBuffer:=Space(85)
			FREAD(nHdlBco,@xBuffer,85)
	
			IF SubStr(xBuffer,1,1) == CHR(3)
				nTam := 1+(Val(SubStr(xBuffer,20,3))-Val(SubStr(xBuffer,17,3)))
				nDec := Val(SubStr(xBuffer,23,1))
				cConteudo:= SubStr(xBuffer,24,60)
				nGrava:=fA150Grava( nTam,nDec,cConteudo,@aBordero,.T.,lFinCnab2,.F.,cFilBor)
			Endif
			nLidos+=85
		End
	Else
		RodaCnab2(nHdlSaida,MV_PAR03)
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza Numero do ultimo Disco                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SEE")
	IF !Eof() .and. nGrava != 3 .and. lAtuDsk
		Reclock("SEE")
		nUltDisco:=VAL(EE_ULTDSK)+1
	   Replace EE_ULTDSK With StrZero(nUltDisco,TamSx3("EE_ULTDSK")[1])
	   MsUnlock()
	EndIF
	
	If ( MV_PAR09 == 1 )
		// Se nao existir o campo que determina se deve ou nao saltar
		// a linha na gravacao do trailler do arquivo, ou se existir e 
		// estiver como "1-Sim", Grava o final de linha (Chr(13)+Chr(10))
		If SEE->(FieldPos("EE_FIMLIN")) == 0 .Or. SEE->EE_FIMLIN == "1"
			FWRITE(nHdlSaida,CHR(13)+CHR(10))
		Endif	
	EndIf
	dbSelectArea( cAlias )
	dbGoTo( nSavRecno )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fecha o arquivos utilizados                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	FCLOSE(nHdlBco)
	FCLOSE(nHdlSaida)
	
	If nGrava == 3 // Abandonou a rotina, quando o bordero ja foi enviado.
		// Apaga o arquivo de saida, para nao caracterizar um erro no programa
		// a geracao incompleta do arquivo quando o usuario cancelar.
		FErase(cArqGerado)
		ProcLogAtu("ERRO","",STR0019) //"Processo Cancelado por usuário. Arquivo não gerado"
	Else
		ProcLogAtu("ALERTA","",STR0020+cArqGerado) //"Processo Finalizado. Arquivo gerado: "
	Endif
	
	If lRecicl 
		dbSelectArea("cTemp")
		Pack
		DbCloseArea()
	EndIF	
	
	If lFin150_3
		Execblock("FIN150_3",.F.,.F.)
	Endif	
Endif
dbSelectArea( cAlias )
dbGoTo( nSavRecno )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SE1")
dbSetOrder(1)
dbClearFilter()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AbrePar   ³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Abre arquivo de Parametros                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³AbrePar()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FinA150                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AbrePar(cArqGerado)
LOCAL cArqEnt:=mv_par03,cArqSaida

IF AT(".",mv_par04)>0
	cArqSaida:=SubStr(TRIM(mv_par04),1,AT(".",mv_par04)-1)+"."+TRIM(SEE->EE_EXTEN)
Else
	cArqSaida:=TRIM(mv_par04)+"."+TRIM(SEE->EE_EXTEN)
EndIF

cArqGerado := cArqSaida

IF !FILE(cArqEnt)
	Help(" ",1,"NOARQPAR")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o log de processamento com o erro  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcLogAtu("ERRO","NOARQPAR",Ap5GetHelp("NOARQPAR"))

	Return .F.
Else
	If ( MV_PAR09 == 1 )
		nHdlBco:=FOPEN(cArqEnt,0+64)
	Endif
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo Saida                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( MV_PAR09 == 1 )
	nHdlSaida:=MSFCREATE(cArqSaida,0)
Else
	nHdlSaida:=HeadCnab2(cArqSaida,MV_PAR03)
Endif

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fA150Grava³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina de Geracao do Arquivo de Remessa de Comunicacao      ³±±
±±³          ³Bancaria                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ExpL1:=fa150Grava(ExpN1,ExpN2,ExpC1)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FinA150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function fA150Grava( nTam,nDec,cConteudo,aBordero,lTrailler,lFinCnab2,lIdCnab,cFilBor)
Local nRetorno := 1
Local nX       := 1
Local oDlg, oRad, nTecla
Local cIdCnab
Local aGetArea := GetArea()
Local aOrdSe1  := {}

DEFAULT lIdCnab := .F.
DEFAULT cFilBor := xFilial("SEA")

lTrailler := IIF( lTrailler==NIL, .F., lTrailler ) // Para imprimir o trailler
                                                   // caso se deseje abandonar
                                                   // a gera‡Æo do arquivo
                                                   // de envio pela metade

lFinCnab2 := Iif( lFinCnab2 == Nil, .F., lFinCnab2 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ O retorno podera' ser :                                  ³
//³ 1 - Grava Ok                                             ³
//³ 2 - Ignora bordero                                       ³
//³ 3 - Abandona rotina                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se titulo ja' foi enviado                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SEA")
If	(!SE1->( Eof()) .and. SE1->E1_NUMBOR >= mv_par01 .AND. SE1->E1_NUMBOR <= mv_par02 .and. xFilial("SE1")==SE1->E1_FILIAL) .And.;
	(MsSeek(cFilBor+SE1->E1_NUMBOR+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO))
	If SEA->EA_TRANSF == "S"
		nX := ASCAN(aBordero,SubStr(SE1->E1_NUMBOR,1,6))
		If nX == 0
			nOpc := 0
			DEFINE MSDIALOG oDlg FROM  35,   37 TO 188,383 TITLE OemToAnsi(STR0009) PIXEL  // "Bordero Existente"
			@ 11, 7 SAY OemToAnsi(STR0010) 			SIZE 58, 7 OF oDlg PIXEL  // "O border“ n£mero:"
			@ 11, 68 MSGET SE1->E1_NUMBOR When .F. SIZE 37, 10 OF oDlg PIXEL
			@ 24, 7 SAY OemToAnsi(STR0011) 			SIZE 82, 7 OF oDlg PIXEL  // "j  foi enviado ao banco."
			@ 37, 6 TO 69, 120 LABEL OemToAnsi(STR0012) OF oDlg  PIXEL  //"Para prosseguir escolha uma das op‡äes"
			@ 45, 11 RADIO oRad VAR nTecla 3D 		SIZE 65, 11 PROMPT OemToAnsi(STR0013),OemToAnsi(STR0014) OF oDlg PIXEL  // "Gera com esse border“"###"Ignora esse border“"

			DEFINE SBUTTON FROM 11, 140 TYPE 1 ENABLE OF oDlg Action (nOpc:=1,oDlg:End())
			DEFINE SBUTTON FROM 24, 140 TYPE 2 ENABLE OF oDlg Action (nopc:=0,oDlg:End())
			ACTIVATE MSDIALOG oDlg Centered
			If nOpc == 1
				If nTecla == 1
					nRetorno := 1
					nBorderos++
				Else
					nRetorno := 2
				EndIf
			Else
				nRetorno := 3
			EndIf				
		Else
			nRetorno := Int(Val(SubStr(aBordero[nX],7,1)))
		EndIf
	EndIf
EndIf
If nRetorno == 1 .or. ( lTrailler .and. nBorderos > 0 )
	If ( MV_PAR09 == 1 )
		If !lTrailler .and. lIdCnab .And. Empty(SE1->E1_IDCNAB) // So gera outro identificador, caso o titulo
															 // ainda nao o tenha, pois pode ser um re-envio do arquivo
			// Gera identificador do registro CNAB no titulo enviado
			cIdCnab := GetSxENum("SE1", "E1_IDCNAB","E1_IDCNAB"+cEmpAnt,16)
			dbSelectArea("SE1")
			aOrdSE1 := SE1->(GetArea())
			dbSetOrder(16)
			While SE1->(MsSeek(xFilial("SE1")+cIdCnab))
				If ( __lSx8 )
					ConfirmSX8()
				EndIf
				cIdCnab := GetSxENum("SE1", "E1_IDCNAB","E1_IDCNAB"+cEmpAnt,16)
			EndDo
			SE1->(RestArea(aOrdSE1))
			Reclock("SE1")
			SE1->E1_IDCNAB := cIdCnab
			MsUnlock()
			ConfirmSx8()
			lIdCnab := .F. // Gera o identificacao do registro CNAB apenas uma vez no
								// titulo enviado
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Analisa conteudo                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF Empty(cConteudo)
			cCampo:=Space(nTam)
		Else
			lConteudo := fa150Orig( cConteudo )
			IF !lConteudo
				RestArea(aGetArea)
				Return nRetorno
			Else
				IF ValType(xConteudo)="D"
					cCampo := GravaData(xConteudo,.F.)
				Elseif ValType(xConteudo)="N"
					cCampo:=Substr(Strzero(xConteudo,nTam,nDec),1,nTam)
				Else
					cCampo:=Substr(xConteudo,1,nTam)
				EndIf
			EndIf
		EndIf
		If Len(cCampo) < nTam  //Preenche campo a ser gravado, caso menor
			cCampo:=cCampo+Space(nTam-Len(cCampo))
		EndIf
		Fwrite( nHdlSaida,cCampo,nTam )
	Else
		nTotCnab2++
		DetCnab2(nHdlSaida,MV_PAR03,lIdCnab,"SE1")
		lIdCnab := .T.	// Para obter novo identificador do registro CNAB na rotina 
							// DetCnab2
		If lFinCnab2
			nSeq := Execblock("FINCNAB2",.F.,.F.,{nHdlSaida,nSeq,nTotCnab2})
		EndIf
	EndIf
EndIf
If nX == 0
	Aadd(aBordero,Substr(SE1->E1_NUMBOR,1,6)+Str(nRetorno,1))
EndIf
RestArea(aGetArea)
Return nRetorno

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ NossoNum ³ Autor ³ Paulo Boschetti       ³ Data ³ 05/11/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna digito de controle                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 		                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function NossoNum( )

Local cNumero := ""
Local nTam := TamSx3("EE_FAXATU")[1]

// Enquanto nao conseguir criar o semaforo, indica que outro usuario
// esta tentando gerar o nosso numero.
cNumero := StrZero(Val(SEE->EE_FAXATU),nTam)

While !MayIUseCode( SEE->(EE_FILIAL+EE_CODIGO+EE_AGENCIA+EE_CONTA+EE_SUBCTA))  //verifica se esta na memoria, sendo usado
	cNumero := Soma1(cNumero)										// busca o proximo numero disponivel 
EndDo

If Empty(SE1->E1_NUMBCO)
	
	RecLock("SE1",.F.)
	Replace SE1->E1_NUMBCO With cNumero
	SE1->( MsUnlock( ) )
	
	RecLock("SEE",.F.)
	Replace SEE->EE_FAXATU With Soma1(cNumero, nTam)
	SEE->( MsUnlock() )
	
EndIf	

Leave1Code(SEE->(EE_FILIAL+EE_CODIGO+EE_AGENCIA+EE_CONTA+EE_SUBCTA))
DbSelectArea("SE1")

	       
Return(SE1->E1_NUMBCO)
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Fa150Chav³ Autor ³ Paulo Boschetti       ³ Data ³ 10/11/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Fa150Num()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINA130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fa150Chav()
LOCAL lRetorna := .T.
If !Empty(m->ee_codigo) .And. !Empty(m->ee_agencia) .And. !Empty(m->ee_conta) .And. !Empty(m->ee_subcta)
	dbSelectArea("SEE")
	SEE->( MsSeek(xFilial("SEE")+m->ee_codigo+m->ee_agencia+m->ee_conta+m->ee_subcta) )
	If SEE->( Found() )
		Help(" ",1,"FA150NUM")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza o log de processamento com o erro  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ProcLogAtu("ERRO","FA150NUM",Ap5GetHelp("FA150NUM"))
	
		lRetorna := .F.
	EndIf
EndIf
Return lRetorna


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fa150Orig ³ Autor ³ Wagner Xavier         ³ Data ³ 10/11/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se expressao e' valida para Remessa CNAB.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Fina150                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fa150Orig( cForm )
Local bBlock:=ErrorBlock()
Private lRet := .T.

BEGIN SEQUENCE
	xConteudo := &cForm
END SEQUENCE
ErrorBlock(bBlock)
Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SomaValor³ Autor ³ Vinicius Barreira     ³ Data ³ 09/01/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o valor total dos titulos remetidos                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ SomaValor()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function SomaValor()
Return nSomaValor * 100
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SomaVlLote³ Autor ³ Claudio Donizete      ³ Data ³ 28/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o valor dos titulos remetidos do lote              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ SomaVlLote()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function SomaVlLote()
Return nSomaVlLote * 100
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QtdTotTit ³ Autor ³ Claudio Donizete      ³ Data ³ 28/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna a qtde. total dos titulos remetidos                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QtdTotTit()  	                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QtdTotTit()
Return nQtdTotTit
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QtdTitLote³ Autor ³ Claudio Donizete      ³ Data ³ 28/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna a qtde. dos titulos remetidos do lote              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QtdTitLote()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QtdTitLote()
Return nQtdTitLote

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Fa150PesqB³ Autor ³ Claudio D. de Souza   ³ Data ³ 20/09/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pesquisa Bordero em todas as filiais e atualiza o parametro|±±
±±³          ³ cFilBor com a filial em que foi encontrada o bordero       |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Fa420PesqBord(cNumBor,cFilBor)									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINA420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fa150PesqBord(cNumBor,cFilBor)
Local cFilOld := cFilAnt
Local aAreaSM0  := SM0->(GetArea())
Local cAliasAnt := Alias()
Local lRet := .F.

If !Empty(xFilial("SEA")) // Se o SEA for exclusivo, pesquisa o bordero em todas as filiais
	dbSelectArea("SM0")
	MsSeek(cEmpAnt+"  ",.T.)
	
	While !Eof() .And. SM0->M0_CODIGO == cEmpAnt .And. SM0->M0_CODFIL <= "zz"		// Processa todas as filiais
		cFilAnt := SM0->M0_CODFIL
		If SEA->(MsSeek(xFilial("SEA")+cNumBor))
			lRet := .T.
			cFilBor := SEA->EA_FILIAL
			Exit
		Endif
		SM0->(DbSkip())
	End
Else
	lRet := SEA->(MsSeek(xFilial("SEA")+SE1->E1_NUMBOR))
	cFilBor := SEA->EA_FILIAL
Endif	

// Restaura ambiente
cFilAnt := cFilOld
SM0->(RestArea(aAreaSm0))
DbSelectArea(cAliasAnt)

Return lRet


Static Function AcertSX1()
Local aHelpPor := {}
Local aHelpEng := {}
Local aHelpSpa := {}
Local aPergs := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros ³
//³ mv_par01		 // Do Bordero 		  ³
//³ mv_par02		 // Ate o Bordero 	  ³
//³ mv_par03		 // Arq.Config 		  ³
//³ mv_par04		 // Arq. Saida    	  ³
//³ mv_par05		 // Banco     			  ³
//³ mv_par06		 // Agenciao     		  ³
//³ mv_par07		 // Conta   			  ³
//³ mv_par08		 // Sub-Conta  		  ³
//³ mv_par09		 // Cnab 1 / Cnab 2    ³
//³ mv_par10		 // Considera Filiais  ³
//³ mv_par11		 // De Filial   		  ³
//³ mv_par12		 // Ate Filial         ³
//³ mv_par13		 // Quebra por ?		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aHelpPor := {}
aHelpEng := {}
aHelpSpa := {}

AADD(aHelpPor,"Escolha o nivel de quebra desejado para ")
AADD(aHelpPor,"incluir, no arquivo gerado CNAB modelo 2")
AADD(aHelpPor,"um registro totalizador a cada mudança ")
AADD(aHelpPor,"de borderô ou cliente, quando a geração")
AADD(aHelpPor,"do arquivo ocorrer para vários borderôs")
AADD(aHelpPor,"e estiver configurado para gerar Header")
AADD(aHelpPor,"ou Trailler de lote no arquivo de confi-")
AADD(aHelpPor,"guração utilizado")

AADD(aHelpEng,"Choose the desired break level to add, to")
AADD(aHelpEng,"to the CNAB model 2 file generated, a ")
AADD(aHelpEng,"totalizer record for each change of ")
AADD(aHelpEng,"bordereau, when the file generation ")
AADD(aHelpEng,"occurs for several bordereaus and is ")
AADD(aHelpEng,"configured to generate a lot Header or ")
AADD(aHelpEng,"Trailer in the configuration file used.")

AADD(aHelpSpa,"Elija el nível de division deseado para ")
AADD(aHelpSpa,"incluir en el archivo generado del CNAB ")
AADD(aHelpSpa,"modelo 2 un registro totalizador en cada ")
aADD(aHelpSpa,"cambio de bordero, cuando la generacion del" )
AADD(aHelpSpa,"archivo ocurra para varios borderos y este ")
AADD(aHelpSpa,"configurado para generar Encabezamiento o ")
AADD(aHelpSpa,"Trailer de lote em el archivo de configu-")
AADD(aHelpSpa,"racion utilizado")

Aadd(aPergs,{"Quebra por ?","¿Division por?","Break by?","mv_chn","N",1,0,3,"C","","mv_par13","Borderô","Bordero","bordereau","","","Cliente","Cliente","Costumer","","","Não quebra","Nao Quebra","Don't Break","","","","","","","","","","","","","","S","",aHelpPor,aHelpEng,aHelpSpa})

AjustaSx1("AFI150",aPergs)

Return 