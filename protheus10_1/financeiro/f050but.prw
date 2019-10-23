#include "protheus.ch"
#include "fina050.ch"
#include "dbinfo.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F050BUT   ºAutor  ³Trade Consulting    º Data ³  22/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Cesvi Brasil                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F050BUT()
aBotao := {}
AAdd( aBotao, { "Exclusão", { || U_FA050EXC() }, "Exclusão de Título" } )

Return Nil


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³FA050Delet³ Autor ³ Wagner Xavier 	    ³ Data ³ 27/04/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Programa de exclus„o contas a pagar 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ FA050Delet(ExpC1,ExpN1,ExpN2) 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Alias do arquivo									  ³±±
±±³			 ³ ExpN1 = N£mero do registro 								  ³±±
±±³			 ³ ExpN2 = N£mero da op‡„o selecionada 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINA050													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FA050EXC(cAlias,nReg,nOpc)
LOCAL nOpcA
LOCAL nSavRec
LOCAL lTemCheq 	:= .f.
LOCAL nRecSef	:= 0
LOCAL cNum
LOCAL cPrefixo
LOCAL cParcela
LOCAL cNatureza
LOCAL lDigita
LOCAL lPadrao := .F.
LOCAL cPadrao
LOCAL cArquivo
LOCAL nTotal	:= 0
LOCAL nHdlPrv	:= 0
LOCAL cFornece
LOCAL cTipo
LOCAL cParcIr
LOCAL cParcIss
LOCAL cArq
LOCAL nIndex 	:= IndexOrd()
Local lOk := .T.    // Retorno do ExecBlock( FA050Del )
LOCAL nOrdSE2
Local nMoedSE2 := SE2->E2_MOEDA
Local cTipoSE2 := SE2->E2_TIPO
Local lHead := .F.
Local lDesdobr := .F.
Local nValSaldo := 0
LOCAL oDlg
LOCAL i
LOCAL nOrd
Local lAglutina
Local aBut050
Local cSEST  := GetMv("MV_SEST",,"")
Local nRegAtu:= 0
Local nProxReg := SE2->(Recno())
Local nPis		:= 0
Local nCofins	:= 0
Local nCsll		:= 0
Local	cParcPis
Local	cParcCof
Local	cParcCsll
Local	nVretPis := 0
Local	nVretCof := 0
Local	nVretCsl := 0
Local	nVretIrf := 0
Local nX := 0
Local aTitImp  := {}
Local aArea:={}
Local aAreaSE5:={}

Local lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"  .and. (!Empty( SE5->( FieldPos( "E5_VRETPIS" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_VRETCOF" ) ) ) .And. ;
!Empty( SE5->( FieldPos( "E5_VRETCSL" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_PRETPIS" ) ) ) .And. ;
!Empty( SE5->( FieldPos( "E5_PRETCOF" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_PRETCSL" ) ) ) .And. ;
!Empty( SE2->( FieldPos( "E2_SEQBX"   ) ) ) .And. !Empty( SFQ->( FieldPos( "FQ_SEQDES"  ) ) ) )

Local lContrRet := !Empty( SE2->( FieldPos( "E2_VRETPIS" ) ) ) .And. !Empty( SE2->( FieldPos( "E2_VRETCOF" ) ) ) .And. ;
!Empty( SE2->( FieldPos( "E2_VRETCSL" ) ) ) .And. !Empty( SE2->( FieldPos( "E2_PRETPIS" ) ) ) .And. ;
!Empty( SE2->( FieldPos( "E2_PRETCOF" ) ) ) .And. !Empty( SE2->( FieldPos( "E2_PRETCSL" ) ) )

Local lIrfMp232 := .F.
Local cChaveCV4
Local lRateioPCO

Local lDelTit  := .T.
nSavRec	 := RecNo()
cPrefixo  := E2_PREFIXO
cNum	    := E2_NUM
cParcela  := E2_PARCELA
cNatureza := E2_NATUREZ
cFornece  := E2_FORNECE
cTipo 	 := E2_TIPO
cParcIr	 := E2_PARCIR
cParcIss  := E2_PARCISS
cParcInss := E2_PARCINS
cParcSEST := E2_PARCSES
nIss	  := SE2->E2_ISS
nInss	  := SE2->E2_INSS
nSEST	  := E2_SEST
lF050Auto := IF(Type("lF050Auto") == "U", .F., lF050Auto)

SA2->(dbSetOrder(1))
SA2->(MSSeek(xFilial("SA2")+SE2->(E2_FORNECE+E2_LOJA)))

lIrfMp232 := !Empty( SA2->( FieldPos( "A2_CALCIRF" ) ) ) .and. SA2->A2_CALCIRF == "2" .and. ;
!Empty( SE2->( FieldPos( "E2_VRETIRF" ) ) ) .And. !Empty( SE2->( FieldPos( "E2_PRETIRF" ) ) ) .And. ;
!Empty( SE5->( FieldPos( "E5_VRETIRF" ) ) ) .And. !Empty( SE5->( FieldPos( "E5_PRETIRF" ) ) )

nPis		:= SE2->E2_PIS
nCofins	:= SE2->E2_COFINS
nCsll		:= SE2->E2_CSLL
cParcPis	:= SE2->E2_PARCPIS
cParcCof	:= SE2->E2_PARCCOF
cParcCsll:= SE2->E2_PARCSLL
If lContrRet
	nVretPis := SE2->E2_VRETPIS
	nVretCof := SE2->E2_VRETCOF
	nVretCsl := SE2->E2_VRETCSL
	If lIrfMP232
		nVretIrf := SE2->E2_VRETIRF
	Endif
Endif
PRIVATE aHeader:={}
PRIVATE nUsado := 0
PRIVATE aRatAFR		:= {}
PRIVATE bPMSDlgFI	:= {||PmsDlgFI(2,M->E2_PREFIXO,M->E2_NUM,M->E2_PARCELA,M->E2_TIPO,M->E2_FORNECE,M->E2_LOJA)}
PRIVATE _Opc := nOpc

lIntegracao := IF(GetMV("MV_EASY")=="S",.T.,.F.)

//Botoes adicionais na EnchoiceBar
aBut050 := fa050BAR('SE2->E2_PROJPMS == "1"')

// integração com o PMS
If IntePMS() .And. SE2->E2_PROJPMS == "1"
	SetKey(VK_F10, {|| Eval(bPMSDlgFI)})
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verificar se o documento foi ajustado por diferencia ³
//³de cambio.                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc == "ARG"
	SIX->(DbSetOrder(1))
	If SIX->(MsSeek('SFR'))
		SFR->(DbSetOrder(1))
		If SFR->(MsSeek(xFilial()+"2"+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
			Help( " ", 1, "FA084010",,Left(SFR->FR_CHAVDE,Len(SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO)),5)
			Return .F.
		Endif
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso tenha seja um INV, gerado pelo SigaEic e do Brasil nao podera se excluido      	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lIntegracao .and.  cPaisLoc <> "ARG"   .and. SE2->E2_Tipo = "INV" .and. UPPER(SE2->E2_Origem) = "SIGAEIC" ;
	.and. !lF050Auto   // EOS - 01/05/04
	HELP(" ",1,"FAORIEIC")
	Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso tenha seja um PR, gerado pelo SigaEic  nao podera ser excluido     	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lIntegracao .and. SE2->E2_Tipo = "PR" .and. UPPER(SE2->E2_Origem) = "SIGAEIC"
	HELP(" ",1,"FAORIEIC")
	Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Integracao com o Modulo de Plano de Saude (SIGAPLS) - BOPS 102731           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  SubStr(SE2->E2_ORIGEM, 1, 3) $ 'PLS' .And. !lF050Auto
	Help(" ",1,"NO_DELETE",,SE2->E2_ORIGEM,3,1) //Este titulo nao podera ser excluido pois foi gerado pelo modulo
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Integracao com o Modulo de Transporte (SIGATMS)                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  AllTrim(SE2->E2_ORIGEM) $ 'SIGATMS' .And. !lF050Auto
	Help(" ",1,"FA050TMS",,SE2->E2_ORIGEM,4,1) //Este titulo nao podera ser excluido pois foi gerado pelo modulo
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se for um PA ou um cheque gerado por um PA deverá cancelar a Ordem de Pago. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc $ "ARG"
	If (SE2->E2_TIPO=="PA " .And.!Empty(SE2->E2_ORDPAGO)).Or.(SE2->E2_TIPO == "CH ".And.!Empty(SE2->E2_ORDPAGO))
		Help(" ",1,"OrdPago")
		Return .F.
	Endif
Endif

//Permito deletar titulo de impostos gerado pelo modulo financeiro e que nao possuir titulo pai
If SE2->E2_TIPO == MVTAXA .And. "FINA" $ Upper(SE2->E2_ORIGEM) .And. !Fa050Pai()
	lDelTit := .F.
Else
	lDelTit := .T.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se os dados nao foram gravados por outro modulo			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(SE2->E2_ORIGEM) .And. !(Upper(Trim(SE2->E2_ORIGEM)) $ "FINA050") .And. ;
	Upper(Trim(SE2->E2_ORIGEM)) <> "SIGATMS" .and. !lF050Auto .AND. cModulo <> "EIC" ;
	.AND. !("GPE" $ SE2->E2_ORIGEM) .And. lDelTit
	Help(" ",1,"NO_DELETE2")
	Return .F.
Else
	If Empty((SE2->E2_ORIGEM)) .and. SE2->E2_TIPO == "TX " .and. ;
		(Alltrim(SE2->E2_NATUREZ) == Alltrim(SuperGetMv("MV_ICMS",.F.,"ICMS")) .or. ;
		Alltrim(SE2->E2_NATUREZ) == Alltrim(SuperGetMv("MV_IPI",.F.,"IPI"))  .or. ;
		Alltrim(SE2->E2_NATUREZ) $ "ICMS#IPI" )
		Help(" ",1,"NO_DELETE2")
		Return
	Endif
EndIf


//Permito exclusão de titulo gerado pela folha
If "GPE" $ SE2->E2_ORIGEM .And. !lF050Auto
	If !(MSGYESNO(STR0120+CHR(10)+CHR(13)+STR0121,STR0026))		//"Este titulo foi gerado pelo modulo SIGAGPE - Gestao de Pessoal."###"Deseja realmente deleta-lo ?"###"Atencao"
		Return
	Endif
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o titulo nao esta em bordero                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(SE2->E2_NUMBOR)
	Help("",1,"FA050BORD")
	Return  .F.
Else
	// Caso seja o titulo principal, verifica se existe titulo de impostos
	// gerado, e confirma se estes estao ou nao em um outro bordero.
	aTitImp := ImpCtaPg()
	For nX := 1 To Len(aTitImp)
		If !Empty(aTitImp[nX][8])
			Help("",1,"FA050BORD")
			Return  .F.
		Endif
	Next
EndIf

If !Empty(E2_BAIXA)
	Help(" ",1,"FA050BAIXA")
	Return .F.
EndIf

If E2_VALOR != E2_SALDO
	Help(" ",1,"BAIXAPARC")
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se data do movimento n„o ‚ menor que data limite de ³
//³ movimentacao no financeiro    										  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If E2_TIPO$MVPAGANT .AND. !DtMovFin(E2_EMISSAO)
	Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se nao ‚ um titulo de ISS ou IR ou INSS ou SEST ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF E2_TIPO $ MVISS+"/"+MVTAXA+"/"+MVTXA+"/"+MVINSS+"/"+"SES"
	If Fa050Pai()
		Help(" ",1,"NOVALORIR")
		Return .F.
	EndIf
EndIf
// Se nao for titulo de imposto, verifica se um dos titulos de impostos já foi baixado e nao permite a exclusao
If ! E2_TIPO $ MVISS+"/"+MVTAXA+"/"+MVTXA+"/"+MVINSS+"/"+"SES"
	If !Fa050Filho(.T.)
		// Se o titulo filho sofreu baixa, verifica se o ponto de entrada permitira a exclusao
		// do titulo, senao, nao permite a exclusao.
		If !ExistBlock("F050DEL1") .Or. !ExecBlock("F050DEL1", .F., .F.)
			Help(" ",1,"NODELETA",,STR0131, 4, 0) // "Este titulo possui impostos e"+chr(13)+"um desses impostos sofreu baixa"
			Return .F.
		Endif
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi emitido cheque para este titulo							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF E2_IMPCHEQ == "S"
	Help( " ", 1, "EXISTCHEQ" )
	Return( .F. )
END

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi emitido cheque para um dos titulos de impostos		 ³
//³ Verifica na delecao do titulo pai                             		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Fa050VerImp()
	Help( " ", 1, "EXISTCHEQ" )
	Return( .F. )
EndIf

IF ExistBlock("FA050UPD")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ponto de Entrada para Pre-Vaidacao de Exclusao      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF !ExecBlock("FA050UPD",.f.,.f.)
		Return .F.
	Endif
Endif

PRIVATE aTELA[0][0],aGETS[0]

nOpcA:=1
dbSelectArea("SA2")
dbSeek(cFilial+SE2->E2_FORNECE+SE2->E2_LOJA)
dbSelectArea("SED")
dbSeek(cFilial+SE2->E2_NATUREZ)
If !SoftLock( "SE2" )
	Return  .F.
EndIf
dbSelectArea(cAlias)
dbSetOrder(1)

bCampo := {|nCPO| Field(nCPO) }
FOR i := 1 TO FCount()
	M->&(EVAL(bCampo,i)) := FieldGet(i)
NEXT i
If !Type("lF050Auto") == "L" .or. !lF050Auto
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM 9,0 TO 28,80 OF oMainWnd
	EnChoice( cAlias, nReg, nOpc, ,"AC", OemToAnsi(STR0008) ) //"Quanto … exclus„o?"
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpca := 2,oDlg:End()},{|| nOpca := 1,oDlg:End()},,aBut050)
Else
	nOpcA := 2
EndIf

If nOpcA == 2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa a gravacao dos lancamentos do SIGAPCO          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PcoIniLan("000002")
	
	//.......
	//      Conforme situacao do parametro abaixo, integra com o SIGAGSP ³
	//      MV_SIGAGSP - 0-Nao / 1-Integra                   ³
	//      - Na Exclusao para estornar os Lancamentos de Empenhos de Orcamentos
	//      .....
	If GetNewPar("MV_SIGAGSP","0") == "1"
		lOk := GSPF070()
		If !lOk
			Return .F.
		Endif
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Execblock para verificacao se o titulo pode ser excluido ou nao.   ³
	//³ Se retornar .T. continua o processo de exclusao, se .F. retorna    ³
	//³ sem excluir o titulo.                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (ExistBlock("FA050Del"))
		lOk := ExecBlock("FA050Del",.F.,.F.)
	Endif
	If !lOk
		Return .F.
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o titulo foi gerado por desdobramento.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SE2->E2_DESDOBR == "S"
		lDesdobr := .T.
	Endif
	// Verifica se o titulo foi distribuido por multiplas naturezas para contabilizar o
	// cancelamento via SE2 ou SEV
	If SE2->E2_MULTNAT == "1"
		DbSelectArea("SEV")
		If MsSeek(RetChaveSev("SE2"))
			// Vai para o final para nao contabilizar duas vezes o LP 515
			DbGoBottom()
			DbSkip()
		Endif
		DbSelectArea("SE2")
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o titulo PA pode ser baixado 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SE2->E2_TIPO $ MVPAGANT
		If ! Fa050DelPa(.T., @lTemCheq, @nRecSef)
			Return  .F.
		Endif
	EndIf
	
	//Inicia processo do lancamento no Pco quando possui rateio
	lRateioPCO := .F.
	If SE2->E2_RATEIO=="S" .And. !Empty(SE2->E2_ARQRAT)
		PcoIniLan("000021")
		lRateioPCO := .T.
	EndIf	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio do bloco protegido via TTS					³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Begin Transaction
	
	If ExistBlock("FA050B01")
		ExecBlock("FA050B01",.F.,.F.)
	EndIf
	dbSelectArea("SE2")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualizacao dos dados do Modulo SIGAPMS    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PmsWriteFI(2,"SE2")	//Estorno
	PmsWriteFI(3,"SE2")	//Exclusao
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga os lancamentos nas contas orcamentarias SIGAPCO    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SE2->E2_TIPO $ MVPAGANT
		PcoDetLan("000002","02","FINA050",.T.)
	Else
		PcoDetLan("000002","01","FINA050",.T.)
	EndIf
	
	IF !E2_TIPO $ MVPROVIS .or. mv_par02 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no registro referente ao Fornecedor		  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA2")
		dbSeek(cFilial+SE2->E2_FORNECE+SE2->E2_LOJA)
		dbSelectArea("SE2")
		If !CtbInUse()
			cPadrao:=Iif(SE2->E2_RATEIO=="S","511","515")
		Else
			cPadrao:=Iif(SE2->E2_RATEIO=="S","512","515")
		EndIf
		IF SE2->E2_TIPO $ MVPAGANT
			cPadrao:="514"
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se titulos foram gerados via desdobramento ³
		//³ e altera o lancamento padrao para 578.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lDesdobr
			cPadrao:="578"
		Endif
		lPadrao:=VerPadrao(cPadrao)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Deleta os titulos de Desdobramento em aberto        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lDesdobr
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apaga os lancamentos de desdobramento - SIGAPCO  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			PcoDetLan("000002","03","FINA050",.T.)
			
			nValSaldo := 0
			VALOR := 0
			lHead := .F.
			dDtEmiss := SE2->E2_EMISSAO
			nMoedSE2 := SE2->E2_MOEDA
			nOrdSE2 := IndexOrd()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Gera o lancamento contabil para delecao de titulos  ³
			//³ gerados via desdobramento.                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF lPadrao .and. SubStr(SE2->E2_LA,1,1) == "S"
				If !lHead
					nHdlPrv:=HeadProva(cLote,"FINA050",Substr(cUsuario,7,6),@cArquivo)
					lHead := .T.
				Endif
				nTotal+=DetProva(nHdlPrv,cPadrao,"FINA050",cLote)
				nValSaldo += SE2->E2_VALOR
			Endif
			
			nRegAtu := SE2->(Recno())
			dbSkip()
			nProxReg := SE2->(Recno())
			dbGoto(nRegAtu)
			
			
			
			RecLock("SE2",.F.,.T.)
			dbDelete()
			If nTotal > 0
				dbSelectArea ("SE2")
				dbGoBottom()
				dbSkip()
				VALOR := nValSaldo
				nTotal+=DetProva(nHdlPrv,cPadrao,"FINA050",cLote)
			Endif
			
			IF lPadrao .and. nTotal > 0
				RodaProva(nHdlPrv,nTotal)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Envia para Lan‡amento Cont bil - desdobramentos   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				lDigita:=IIF(mv_par01==1,.T.,.F.)
				cA100Incl(cArquivo,nHdlPrv,3,cLote,lDigita,mv_par07 == 1)
				SE2->(dbSetOrder(nOrdSE2))
			Endif
		Else
			dDtEmiss := SE2->E2_EMISSAO
			nValSaldo := SE2->E2_VALOR
			nMoedSE2 := SE2->E2_MOEDA
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta contabiliza‡„o - exceto desdobramentos 	   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF lPadrao .and. SubStr(SE2->E2_LA,1,1) == "S" .and. !lDesdobr
			IF cPadrao == "511"
				If !CtbInUse()
					cArq := fa050rate( cPadrao , "FINA050" ,"E",@nHdlPrv,@cArquivo)
					If !Empty(cArquivo)
						lAglutina := Iif(mv_par07 == 1,.t.,.f.)
						cA100Incl(cArquivo,nHdlPrv,3,cLote,.T.,lAglutina)
					EndIf
				EndIf
			ElseIf cPadrao == "512"
				If CtbInUse()
					CtbRatFin(cPadrao,"FINA050",cLote,3," ",nOpc)
				EndIf
			Else
				nHdlPrv:=HeadProva(cLote,"FINA050",Substr(cUsuario,7,6),@cArquivo)
				nTotal+=DetProva(nHdlPrv,cPadrao,"FINA050",cLote)
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Busca moeda na qual se faz o controle de saldos em  ³
		//³ moeda forte. A contabilizacao altera o valor da va- ³
		//³ riavel NMOEDA para 5, independente da moeda na qual ³
		//³ se faz esse controle.                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nMoeda 	 := Int(Val(GetMv("MV_MCUSTO")))
		
		If !cNatureza$&(GetMv("MV_IRF"))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza saldo do fornecedor                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			RecLock("SA2")
			If !(SE2->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG+"/"+MVABATIM)
				SA2->A2_SALDUP -= Round(NoRound(xMoeda(nValSaldo,nMoedSE2,1,dDtEmiss,3),3),2)
				SA2->A2_SALDUPM-= Round(NoRound(xMoeda(nValSaldo,nMoedSE2,nMoeda,dDtEmiss,3),3),2)
			Else
				SA2->A2_SALDUP += Round(NoRound(xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,1,SE2->E2_EMISSAO,3),3),2)
				SA2->A2_SALDUPM+= Round(NoRound(xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,nMoeda,SE2->E2_EMISSAO,3),3),2)
			EndIf
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz tratamento do titulos de Recebimento antecipado ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SE2->E2_TIPO $ MVPAGANT
		Fa050DelPa(.F., lTemCheq, nRecSef)
	Else
		//Limpa chaves de relacionamento (SE5 e SEF)
		dbSelectArea("SE5")
		dbSetOrder(7)
		If dbSeek(xFilial("SE5")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA))
			While !Eof() .and. xFilial("SE5") == SE5->E5_FILIAL .and. ;
				SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA) == ;
				SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)
				nAtuRec := SE5->(RECNO())
				dbSkip()
				nProxRec := SE5->(Recno())
				dbGoto(nAtuRec)
				RecLock("SE5")
				Replace E5_KEY with E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA
				Replace E5_PREFIXO With ""
				Replace E5_NUMERO With ""
				Replace E5_PARCELA With ""
				Replace E5_TIPO With ""
				Replace E5_LA With  "S"
				MsUnlock()
				FKCOMMIT()
				dbGoto(nProxRec)
			Enddo
		Endif
		
		dbSelectArea("SEF")
		dbSetOrder(7)
		If dbSeek(xFilial("SEF")+"P"+SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO))
			While !Eof() .and. xFilial("SEF") == SEF->EF_FILIAL .and. ;
				SEF->(EF_PREFIXO+EF_TITULO+EF_PARCELA+EF_TIPO) == ;
				SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)
				
				nAtuRec := SE5->(RECNO())
				dbSkip()
				nProxRec := SE5->(Recno())
				dbGoto(nAtuRec)
				
				If SEF->(EF_FORNECE+EF_LOJA) == SE2->(E2_FORNECE+E2_LOJA)
					RecLock("SEF")
					Replace EF_KEY with EF_PREFIXO+EF_TITULO+EF_PARCELA+EF_TIPO+EF_FORNECE+EF_LOJA
					Replace EF_PREFIXO With ""
					Replace EF_TITULO With ""
					Replace EF_PARCELA With ""
					Replace EF_TIPO With ""
					MsUnlock()
					FKCOMMIT()
				Endif
				dbGoto(nProxRec)
			Enddo
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga  o registro (exceto desdobramento)	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lDesdobr .or. (SE2->E2_TIPO $ MVPROVIS .and. lDesdobr)
		// Se estiver utilizando multiplas naturezas por titulo
		If SE2->E2_MULTNAT == "1"
			DelMultNat("SE2",@nHdlPrv,@nTotal,@cArquivo) // Apaga as naturezas geradas para o titulo
		Endif
		
		dbSelectArea(cAlias)
		nRegAtu := SE2->(Recno())
		//Limpo referencias de apuracao de impostos.
		If lContrRet
			aRecSE2 := FImpExcTit("SE2",SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_FORNECE,SE2->E2_LOJA)
			For nX := 1 to Len(aRecSE2)
				SE2->(MSGoto(aRecSE2[nX]))
				FaAvalSE2(4)
			Next
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Exclui os registros de relacionamentos do SFQ                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SE2->(dbGoto(nRegAtu))
			If lPCCBaixa .And. SE2->E2_TIPO $ MVPAGANT //Se for PA (geracao de tx's pela emissao), exclui o SFQ pelo SE5.
				FImpExcSFQ("SE5",SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_FORNECE,SE2->E2_LOJA)
			Else
				FImpExcSFQ("SE2",SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_FORNECE,SE2->E2_LOJA)
			Endif
			
		Endif
		// Apaga os registros referentes ao rateio do titulo
		If !Empty(SE2->E2_ARQRAT) .And. CtbInUse()
			cChaveCV4 := RTrim(SE2->E2_ARQRAT)
			RecLock(cAlias ,.F.,.T.)
			SE2->E2_ARQRAT := "" // Limpa Relacionamento com CV4
			MsUnlock()
			FKCOMMIT()
			CV4->(dbSetOrder(1))
			If CV4->(MsSeek(cChaveCV4))   // Chave jah contem filial
				While CV4->(!Eof()) .And.;
					CV4->CV4_FILIAL+DTOS(CV4->CV4_DTSEQ)+CV4->CV4_SEQUEN == cChaveCV4
					//Exclui lancamento para o modulo PCO 
					PcoDetLan("000021","01","FINA050",.T.)
					RecLock("CV4",.F.,.T.)
					CV4->(dbDelete())
					MsUnlock()
					CV4->(DbSkip())
				End
			Endif
		Endif
		RecLock(cAlias ,.F.,.T.)
		dbDelete()
	Endif
	
	IF nISS != 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos-ISS   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcIss+MVISS)
		While !Eof() .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPrefixo+cNum+cParcIss+"ISS"
			IF AllTrim(E2_NATUREZ) = AllTrim(&(GetMv("MV_ISS"))) .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do ISS gerado no PCO
				PCODetLan("000002","09","FINA050",.T.)
				RecLock( "SE2" ,.F.,.T.)
				dbDelete( )
			EndIf
			dbSkip()
		Enddo
	EndIf
	
	IF nINSS != 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos-INSS  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcInss+MVINSS)
		While !Eof( ) .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPrefixo+cNum+cParcInss+MVINSS
			IF AllTrim(E2_NATUREZ) = AllTrim(&(GetMv("MV_INSS")))  .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do INSS gerado no PCO
				PCODetLan("000002","07","FINA050",.T.)
				RecLock( "SE2" ,.F.,.T.)
				dbDelete( )
			EndIf
			dbSkip()
		Enddo
	EndIf
	
	IF nSEST != 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos-SEST  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcSEST+"SES")
		While !Eof( ) .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPrefixo+cNum+cParcSEST+"SES"
			IF AllTrim(E2_NATUREZ) = AllTrim(cSEST)  .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do SEST/SENAT gerado no PCO
				PCODetLan("000002","08","FINA050",.T.)
				RecLock( "SE2" ,.F.,.T.)
				dbDelete( )
			EndIf
			dbSkip()
		Enddo
	EndIf
	
	IF nPis != 0 .or. (nPis == 0 .and. nVretPis > 0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos-PIS	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcPis+Iif(cTipoSE2 $ MVPAGANT+"/"+MV_CPNEG .And. !lPCCBaixa,MVTXA,MVTAXA))
		While !Eof( ) .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPrefixo+cNum+cParcPis+Iif(cTipoSE2 $ MVPAGANT+"/"+MV_CPNEG .And. !lPCCBaixa,MVTXA,MVTAXA)
			IF AllTrim(E2_NATUREZ) = AllTrim(GetMv("MV_PISNAT"))  .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do PIS gerado no PCO
				PCODetLan("000002","10","FINA050",.T.)
				RecLock( "SE2" ,.F.,.T.)
				dbDelete( )
			EndIf
			dbSkip()
		Enddo
	EndIf
	IF nCofins != 0 .or. (nCofins == 0 .and. nVretCof > 0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos-COFINS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcCof+Iif(cTipoSE2 $ MVPAGANT+"/"+MV_CPNEG .And. !lPCCBaixa,MVTXA,MVTAXA))
		While !Eof( ) .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPRefixo+cNum+cParcCof+Iif(cTipoSE2 $ MVPAGANT+"/"+MV_CPNEG .And. !lPCCBaixa,MVTXA,MVTAXA)
			IF AllTrim(E2_NATUREZ) = AllTrim(GetMv("MV_COFINS"))  .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do COFINS gerado no PCO
				PCODetLan("000002","11","FINA050",.T.)
				RecLock( "SE2" ,.F.,.T.)
				dbDelete( )
			EndIf
			dbSkip()
		Enddo
	EndIf
	IF nCsll != 0  .or. (nCsll == 0 .and. nVretCsl > 0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos-CSLL  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcCsll+Iif(cTipoSE2 $ MVPAGANT+"/"+MV_CPNEG .And. !lPCCBaixa,MVTXA,MVTAXA))
		While !Eof( ) .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPrefixo+cNum+cParcCsll+Iif(cTipoSE2 $ MVPAGANT+"/"+MV_CPNEG .And. !lPCCBaixa,MVTXA,MVTAXA)
			IF AllTrim(E2_NATUREZ) = AllTrim(GetMv("MV_CSLL"))  .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do CSLL gerado no PCO
				PCODetLan("000002","12","FINA050",.T.)
				RecLock( "SE2" ,.F.,.T.)
				dbDelete( )
			EndIf
			dbSkip()
		Enddo
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga tambem os registros agregados-SE2	   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( SE2->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG+"/"+MVABATIM)
		dbSelectArea("SE2")
		dbSeek(cFilial+cPrefixo+cNum+cParcela)
		While !EOF() .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA == ;
			cFilial+cPrefixo+cNum+cParcela
			IF SE2->E2_TIPO $ MVABATIM .and. E2_FORNECE == cFornece
				RecLock("SE2" ,.F.,.T.)
				If lPadrao .and. !lDesdobr .And. SubStr(SE2->E2_LA,1,1) == "S"
					nTotal+=DetProva(nHdlPrv,cPadrao,"FINA050",cLote)
				Endif
				dbDelete()
				dbSelectArea("SA2")
				Reclock("SA2")
				SA2->A2_SALDUP += Round(NoRound(xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,1,SE2->E2_EMISSAO,3),3),2)
				SA2->A2_SALDUPM+= Round(NoRound(xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,nMoeda,SE2->E2_EMISSAO,3),3),2)
				dbSelectArea( "SE2" )
			EndIf
			dbSkip()
		Enddo
	Endif
	
	If !cNatureza$&(GetMv("MV_IRF"))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga tambem os registro de impostos		  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		nOrd		:= IndexOrd()
		dbSetOrder(1)
		dbSeek(cFilial+cPrefixo+cNum+cParcIr+IIF(cTipo $ MVPAGANT+"/"+MV_CPNEG,MVTXA,MVTAXA))
		While !EOF() .And. E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO == ;
			cFilial+cPrefixo+cNum+cParcIr+IIF(cTipo $ MVPAGANT+"/"+MV_CPNEG,MVTXA,MVTAXA)
			IF E2_NATUREZA = &(GetMv("MV_IRF")) .And. SE2->E2_SALDO != 0
				// Apaga o lancamento do IRRF gerado no PCO
				PCODetLan( "000002", "06", "FINA050", .T. )
				RecLock( "SE2" ,.F.,.T.)
				dbDelete()
			EndIF
			dbSkip()
		EndDo
		dbSetOrder(nOrd)
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza a gravacao dos lancamentos do SIGAPCO            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PcoFinLan("000002")
	If nTotal > 0
		RodaProva(nHdlPrv,nTotal)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia para Lan‡amento Cont bil 							  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lDigita:=IIF(mv_par01==1,.T.,.F.)
		cA100Incl(cArquivo,nHdlPrv,3,cLote,lDigita,mv_par07==1)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Final do bloco protegido via TTS						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	End Transaction
	
	//Finaliza o processo do lancamento no Pco quando E2_RATEIO == "S"
	If lRateioPCO
		PcoFinLan("000021")
	EndIf	
Else
	MsUnlock()
	dbSelectArea(cAlias)
	dbGoto(nProxReg)
	dbSetOrder(nIndex)
	Return .F.
Endif

// Verifica o arquivo de rateio, e apaga o arquivo temporario
// para que no proximo rateio seja criado novamente
If Select("TMP1") > 0
	DbSelectArea( "TMP1" )
	cArq := DbInfo(DBI_FULLPATH)
	cArq := AllTrim(SubStr(cArq,Rat("\",cArq)+1))
	DbCloseArea()
	FErase(cArq)
EndIf

If IntePMS() .And. SE2->E2_PROJPMS == "1"
	SetKey(VK_F10, Nil)
EndIf

dbSelectArea(cAlias)
dbGoto(nProxReg)
dbSetOrder(nIndex)
Return .T.