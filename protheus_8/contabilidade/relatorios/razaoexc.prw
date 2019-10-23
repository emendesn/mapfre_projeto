#INCLUDE "rwmake.ch"                    
#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"
#Include "CTBR400.Ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±                         
±±ºPrograma  ³ RAZAOEXC º Autor ³ Juscelino Alves dos SantosºData ³11/11/13º±±          
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±             
±±ºDescricao ³ Relatório Movimentos x Conta                               º±±          
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±             
±±ºUso       ³ Específico                                                º±±                    
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±               
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                  
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                    

User Function RAZAOEXC( cContaIni, cContaFim, dDataIni, dDataFim, cMoeda, cSaldos,;
cBook, lCusto, cCustoIni, cCustoFim, lItem, cItemIni, cItemFim,;                               
lClVl, cClvlIni, cClvlFim,lSaltLin,cMoedaDesc,aSelFil,;                                         
lEnd,wnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,;
lAnalitico,Titulo,nTamlinha,aCtbMoeda, nTamConta,aSelFil)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local aArea := GetArea()
Local aCtbMoeda := {}

Local cArqTmp := ""
Local lOk := .T.
Local lExterno := cContaIni <> Nil


PRIVATE cDirDocs   	:= MsDocPath()
PRIVATE cPath	   	:= AllTrim(GetTempPath())  
Private cArqTmp := ""
Private cPerg := "CTR400"
Private Tamanho := "G"
Private lSalLin := .T.   

PRIVATE cTipoAnt := ""
PRIVATE cPerg := "CTR400"
PRIVATE nomeProg := "CTBR400"
PRIVATE nSldTransp := 0 // Esta variavel eh utilizada para calcular o valor de transporte
PRIVATE oReport
PRIVATE nLin := 0
Private nLinha := 6
DEFAULT lCusto := .F.
DEFAULT lItem := .F.
DEFAULT lCLVL := .F.
DEFAULT lSaltLin := .T.
DEFAULT cMoedaDesc := cMoeda // RFC - 18/01/07 | BOPS 103653
DEFAULT aSelFil := {}        

CtAjustSx1('CTR400')

lOk := AMIIn(34) // Acesso somente pelo SIGACTB
If !Pergunte("CTR400", .T.)
   Return 
EndIf

lAnalitico := ( mv_par08 == 1 )
nTamLinha := If( lAnalitico, 220, 132)

If lOk
   If !lExterno
      lCusto := Iif(mv_par12 == 1,.T.,.F.)
      lItem := Iif(mv_par15 == 1,.T.,.F.)
      lCLVL := Iif(mv_par18 == 1,.T.,.F.)
      // Se aFil nao foi enviada, exibe tela para selecao das filiais
      If lOk .And. mv_par36 == 1 .And. Len( aSelFil ) <= 0
         aSelFil := AdmGetFil()

         If Len( aSelFil ) <= 0
            lOk := .F.
         EndIf
      EndIf
   Else //Caso seja externo, atualiza os parametros do relatorio com os dados passados como parametros.
      mv_par01 := cContaIni
      mv_par02 := cContaFim
      mv_par03 := dDataIni
      mv_par04 := dDataFim
      mv_par05 := cMoeda
      mv_par06 := cSaldos
      mv_par07 := cBook
      mv_par12 := If(lCusto =.T.,1,2)
      mv_par13 := cCustoIni
      mv_par14 := cCustoFim
      mv_par15 := If(lItem =.T.,1,2)
      mv_par16 := cItemIni
      mv_par17 := cItemFim
      mv_par18 := If(lClVl =.T.,1,2)
      mv_par19 := cClVlIni
      mv_par20 := cClVlFim
      mv_par31 := If(lSaltLin==.T.,1,2)
      mv_par32 := 56
      mv_par34 := cMoedaDesc
   Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! ct040Valid(mv_par07) // Set Of Books
   lOk := .F.
EndIf

If lOk .And. mv_par32 < 10
   ShowHelpDlg("MINQTDELIN", {"Valor informado inválido do","'Num. linhas p/ o razão'"},5,{"Favor preencher uma quantidade","mínima de 10 linhas"},5)
   lOk := .F.
EndIf

If lOk
   aCtbMoeda := CtbMoeda(MV_PAR05) // Moeda?
   If Empty( aCtbMoeda[1] )
      Help(" ",1,"NOMOEDA")
      lOk := .F.
   Endif

   IF lOk .And. ! Empty( mv_par34 )
      aCtbMoeddesc := CtbMoeda(mv_par34) // Moeda?

      If Empty( aCtbMoeddesc[1] )
         Help(" ",1,"NOMOEDA")
         lOk := .F.
      Endif
      aCtbMoeddesc := nil
   Endif
Endif

aSetOfBook := CTBSetOf(mv_par07)


RptStatus({|lEnd| CTR400Imp(@lEnd,wnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,;
lAnalitico,Titulo,nTamlinha,aCtbMoeda, nTamConta,aSelFil)})


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CtbGerRaz ³ Autor Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Cria Arquivo Temporario para imprimir o Razao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe ³CtbGerRaz(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,cContaFim³±±
±±³ ³cCustoIni,cCustoFim,cItemIni,cItemFim,cCLVLIni,cCLVLFim, ³±±
±±³ ³cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo,lJunta, ³±±
±±³ ³cTipo,lAnalit) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno ³Nome do arquivo temporario ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter ³±±
±±³ ³ ExpO2 = Objeto oText ³±±
±±³ ³ ExpO3 = Objeto oDlg ³±±
±±³ ³ ExpL1 = Acao do Codeblock ³±±
±±³ ³ ExpC1 = Arquivo temporario ³±±
±±³ ³ ExpC2 = Conta Inicial ³±±
±±³ ³ ExpC3 = Conta Final ³±±
±±³ ³ ExpC4 = C.Custo Inicial ³±±
±±³ ³ ExpC5 = C.Custo Final ³±±
±±³ ³ ExpC6 = Item Inicial ³±±
±±³ ³ ExpC7 = Cl.Valor Inicial ³±±
±±³ ³ ExpC8 = Cl.Valor Final ³±±
±±³ ³ ExpC9 = Moeda ³±±
±±³ ³ ExpD1 = Data Inicial ³±±
±±³ ³ ExpD2 = Data Final ³±±
±±³ ³ ExpA1 = Matriz aSetOfBook ³±±
±±³ ³ ExpL2 = Indica se imprime movimento zerado ou nao. ³±±
±±³ ³ ExpC10= Tipo de Saldo ³±±
±±³ ³ ExpL3 = Indica se junta CC ou nao. ³±±
±±³ ³ ExpC11= Tipo do lancamento ³±±
±±³ ³ ExpL4 = Indica se imprime analitico ou sintetico ³±±
±±³ ³ c2Moeda = Indica moeda 2 a ser incluida no relatorio ³±±
±±³ ³ cUFilter= Conteudo Txt com o Filtro de Usuario (CT2) ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CtbGerRaz(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,lAnalit,c2Moeda,;
nTipo,cUFilter,lSldAnt,aSelFil,lExterno)

Local aTamConta := TAMSX3("CT1_CONTA")
Local aTamCusto := TAMSX3("CT3_CUSTO")
Local aTamVal := TAMSX3("CT2_VALOR")
Local aCtbMoeda := {}
Local aSaveArea := GetArea()
Local aCampos
Local cChave
Local nTamHist := Len(CriaVar("CT2_HIST"))
Local nTamItem := Len(CriaVar("CTD_ITEM"))
Local nTamCLVL := Len(CriaVar("CTH_CLVL"))
Local nDecimais := 0
Local cMensagem := STR0030// O plano gerencial nao esta disponivel nesse relatorio.
Local lCriaInd := .F.
Local nTamFilial := 2 //IIf( lFWCodFil, FWGETTAMFILIAL, TamSx3( "CT2_FILIAL" )[1] )

DEFAULT c2Moeda := ""
DEFAULT nTipo := 1
DEFAULT cUFilter:= ""
DEFAULT lSldAnt := .F.
DEFAULT aSelFil := {}
DEFAULT lExterno := .F.
DEFAULT cUFilter := ""

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

aCampos :={ { "CONTA" , "C", aTamConta[1], 0 },; // Codigo da Conta
{ "DCONTA" , "C", 040 , 0 },; // Descrição da Conta 
{ "XPARTIDA" , "C", aTamConta[1] , 0 },; // Contra Partida
{ "TIPO" , "C", 01 , 0 },; // Tipo do Registro (Debito/Credito/Continuacao)
{ "LANCDEB" , "N", aTamVal[1]+2, nDecimais },; // Debito
{ "LANCCRD" , "N", aTamVal[1]+2 , nDecimais },; // Credito
{ "SALDOSCR" , "N", aTamVal[1]+2, nDecimais },; // Saldo
{ "TPSLDANT" , "C", 01, 0 },; // Sinal do Saldo Anterior => Consulta Razao
{ "TPSLDATU" , "C", 01, 0 },; // Sinal do Saldo Atual => Consulta Razao
{ "HISTORICO" , "C", nTamHist , 0 },; // Historico
{ "CCUSTO" , "C", aTamCusto[1], 0 },; // Centro de Custo
{ "CCUSTO_DES" , "C", 040, 0 },; // Centro de Custo Descrição
{ "ITEM" , "C", nTamItem , 0 },; // Item Contabil
{ "ITEM_DES" , "C", 040 , 0 },; // Item Contabil Descrição
{ "CLVL" , "C", nTamCLVL , 0 },; // Classe de Valor
{ "CLVL_DES" , "C", 040 , 0 },; // Classe de Valor Descrição 
{ "DATAL" , "D", 10 , 0 },; // Data do Lancamento
{ "LOTE" , "C", 06 , 0 },; // Lote
{ "SUBLOTE" , "C", 03 , 0 },; // Sub-Lote
{ "DOC" , "C", 06 , 0 },; // Documento
{ "LINHA" , "C", 03 , 0 },; // Linha
{ "SEQLAN" , "C", 03 , 0 },; // Sequencia do Lancamento
{ "SEQHIST" , "C", 03 , 0 },; // Seq do Historico
{ "EMPORI" , "C", 02 , 0 },; // Empresa Original
{ "FILORI" , "C", nTamFilial , 0 },; // Filial Original
{ "NOMOV" , "L", 01 , 0 },; // Conta Sem Movimento
{ "FILIAL" , "C", nTamFilial , 0 },; // Filial do sistema
{ "CODNAT" , "C", 010 , 0 },; // Filial do sistema
{ "DESNAT" , "C", 030 , 0 },; // Filial do sistema
{ "CODPROD" , "C", 015 , 0 },; // Filial do sistema
{ "DESPROD" , "C", 045 , 0 },; // Filial do sistema
{ "LOGUSU" , "C", 20 , 0 },; // Historico        
{ "FORNECE" , "C", 06 , 0 },; // Historico
{ "LOJA" , "C", 02 , 0 },; // Historico
{ "FORCNPJ" , "C", 15 , 0 },; // Historico
{ "FORDESC" , "C" , 30, 0 }} // Historico




/*
Descrição da Conta : CT1_CONTA / CT1_DESC01 - OK
Natureza : ED_CODIGO / ED_DESCRIC           - OK 
Produto : D1_COD / B1_DESC  - OK
Mês / Ano da Contabilização : CT2_DATA
Data da Contabilização : CT2_DATA
Data do Vencimento : ???
Lote : CT2_LOTE
Valor Credito / Debito    : CT2_VALOR
Debito /  Credito    : CT2_DEBITO / CT2_CREDIT
Codigo do Favorecido : ???
Descrição do Favorecido : ???    
Historico de Lançamento : CT2_HIST
Codigo do Centro de Custo     :  CT2_CCD / CT2_CCC - OK
Descrição do Centro de Custo :  CTT_DESC01    - OK
Codigo Item da Conta : CT2_ITEMD / CT2_ITEMC  - OK
Descrição do Item da Conta : CTD_DESC01     - OK
*/


//{ "HISTNFE" , "C",150 , 0 }} // Historico


If cPaisLoc $ "CHI|ARG"
   Aadd(aCampos,{"SEGOFI","C",TamSx3("CT2_SEGOFI")[1],0})
EndIf
If ! Empty(c2Moeda)
   Aadd(aCampos, { "LANCDEB_1" , "N", aTamVal[1]+2, nDecimais }) // Debito
   Aadd(aCampos, { "LANCCRD_1" , "N", aTamVal[1]+2, nDecimais }) // Credito
   Aadd(aCampos, { "TXDEBITO" , "N", aTamVal[1]+2, 6 }) // Taxa Debito
   Aadd(aCampos, { "TXCREDITO" , "N", aTamVal[1]+2, 6 }) // Taxa Credito
Endif

// Se o arquivo temporario de trabalho esta aberto
If ( Select ( "cArqTmp" ) > 0 )
   cArqTmp->(dbCloseArea())
EndIf

cArqTmp := CriaTrab(aCampos, .T.)
dbUseArea( .T.,, cArqTmp, "cArqTmp", .F., .F. )
lCriaInd := .T.

DbSelectArea("cArqTmp")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice Temporario do Arquivo de Trabalho 1. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cTipo == "1" // Razao por Conta
   If FunName() <> "CTBC400"
      //cChave := "CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
      cChave := "CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
   Else
      //cChave := "CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+EMPORI+FILORI+LINHA"
   EndIf
ElseIf cTipo == "2" // Razao por Centro de Custo
   If lAnalit // Se o relatorio for analitico
      If FunName() <> "CTBC440"
         cChave := "CCUSTO+CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
      Else
         cChave := "CCUSTO+CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+EMPORI+FILORI+LINHA"
      EndIf
   Else
      cChave := "CCUSTO+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
   Endif
ElseIf cTipo == "3" //Razao por Item Contabil
   If lAnalit // Se o relatorio for analitico
      If FunName() <> "CTBC480"
         cChave := "ITEM+CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
      Else
        cChave := "ITEM+CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+EMPORI+FILORI+LINHA"
      Endif
   Else
      cChave := "ITEM+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
   Endif
ElseIf cTipo == "4" //Razao por Classe de Valor
   If lAnalit // Se o relatorio for analitico
      If FunName() <> "CTBC490"
         cChave := "CLVL+CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
      Else
         cChave := "CLVL+CONTA+DTOS(DATAL)+LOTE+SUBLOTE+DOC+EMPORI+FILORI+LINHA"
      EndIf
   Else
      cChave := "CLVL+DTOS(DATAL)+LOTE+SUBLOTE+DOC+LINHA+EMPORI+FILORI"
   Endif
EndIf

dbSelectArea("cArqTmp")

If lCriaInd
   IndRegua("cArqTmp",cArqTmp,cChave,,,STR0017) //"Selecionando Registros..."
   dbSelectArea("cArqTmp")
   dbSetIndex(cArqTmp+OrdBagExt())
Endif
dbSetOrder(1)

If !Empty(aSetOfBook[5])
   MsgAlert(cMensagem)
   Return
EndIf

// Monta Arquivo para gerar o Razao
CtbRazao(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,nTipo,cUFilter,lSldAnt,aSelFil,lExterno)

RestArea(aSaveArea)

Return cArqTmp

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CtbRazao ³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Realiza a "filtragem" dos registros do Razao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe ³CtbRazao(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim, ³±±
±±³ ³cCustoIni,cCustoFim, cItemIni,cItemFim,cCLVLIni,cCLVLFim, ³±±
±±³ ³cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo,lJunta, ³±±
±±³ ³cTipo) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno ³Nenhum ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter ³±±
±±³ ³ ExpO2 = Objeto oText ³±±
±±³ ³ ExpO3 = Objeto oDlg ³±±
±±³ ³ ExpL1 = Acao do Codeblock ³±±
±±³ ³ ExpC2 = Conta Inicial ³±±
±±³ ³ ExpC3 = Conta Final ³±±
±±³ ³ ExpC4 = C.Custo Inicial ³±±
±±³ ³ ExpC5 = C.Custo Final ³±±
±±³ ³ ExpC6 = Item Inicial ³±±
±±³ ³ ExpC7 = Cl.Valor Inicial ³±±
±±³ ³ ExpC8 = Cl.Valor Final ³±±
±±³ ³ ExpC9 = Moeda ³±±
±±³ ³ ExpD1 = Data Inicial ³±±
±±³ ³ ExpD2 = Data Final ³±±
±±³ ³ ExpA1 = Matriz aSetOfBook ³±±
±±³ ³ ExpL2 = Indica se imprime movimento zerado ou nao. ³±±
±±³ ³ ExpC10= Tipo de Saldo ³±±
±±³ ³ ExpL3 = Indica se junta CC ou nao. ³±±
±±³ ³ ExpC11= Tipo do lancamento ³±±
±±³ ³ c2Moeda = Indica moeda 2 a ser incluida no relatorio ³±±
±±³ ³ cUFilter= Conteudo Txt com o Filtro de Usuario (CT2) ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CtbRazao(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,nTipo,cUFilter,lSldAnt,aSelFil,lExterno)

Local cCpoChave := ""
Local cTmpChave := ""
Local cContaI := ""
Local cContaF := ""
Local cCustoI := ""
Local cCustoF := ""
Local cItemI := ""
Local cItemF := ""
Local cClVlI := ""
Local cClVlF := ""
Local cVldEnt := ""
Local cAlias := ""
Local lUFilter := !Empty(cUFilter) //// SE O FILTRO DE USUÁRIO NÃO ESTIVER VAZIO - TEM FILTRO DE USUÁRIO
Local cFilMoeda := ""
Local cAliasCT2 := "CT2"
Local bCond := {||.T.}
Local cQryFil := '' // variavel de condicional da query

#IFDEF TOP
Local cQuery := ""
Local cOrderBy := ""
Local nI := 0
Local aStru := {}
#ENDIF

DEFAULT cUFilter := ".T."
DEFAULT lSldAnt := .F.
DEFAULT aSelFil := {}
DEFAULT lExterno := .F.

cQryFil := " CT2_FILIAL " + GetRngFil( aSelFil ,"CT2")

cCustoI := CCUSTOINI
cCustoF := CCUSTOFIM
cContaI := CCONTAINI
cContaF := CCONTAFIM
cItemI := CITEMINI
cItemF := CITEMFIM
cClvlI := CCLVLINI
cClVlF := CCLVLFIM

#IFDEF TOP
If TcSrvType() != "AS/400"
   If !Empty(c2Moeda)
      cFilMoeda := " (CT2_MOEDLC = '" + cMoeda + "' OR "
      cFilMoeda += " CT2_MOEDLC = '" + c2Moeda + "') "
   Else
      cFilMoeda := " CT2_MOEDLC = '" + cMoeda + "' "
   EndIf
Else
#ENDIF
   If !Empty(c2Moeda)
      cFilMoeda := " (CT2_MOEDLC = '" + cMoeda + "' .Or. "
      cFilMoeda += " CT2_MOEDLC = '" + c2Moeda + "') "
   Else
      cFilMoeda := " CT2_MOEDLC = '" + cMoeda + "' "
   EndIf
#IFDEF TOP
EndIf
#ENDIF

If !lExterno
   oMeter:nTotal := CT1->(RecCount())
Endif

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Obt?m os d?bitos ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If cTipo <> "1"
   If cTipo = "2" .And. Empty(cCustoIni)
      CTT->(DbSeek(xFilial("CTT")))
      cCustoIni := CTT->CTT_CUSTO
   Endif
   If cTipo = "3" .And. Empty(cItemIni)
      CTD->(DbSeek(xFilial("CTD")))
      cItemIni := CTD->CTD_ITEM
   Endif
   If cTipo = "4" .And. Empty(cClVlIni)
      CTH->(DbSeek(xFilial("CTH")))
      cClVlIni := CTH->CTH_CLVL
   Endif
Endif

#IFDEF TOP
If TcSrvType() != "AS/400"

   If cTipo == "1"
      dbSelectArea("CT2")
      dbSetOrder(2)
      cValid := "CT2_DEBITO>='" + cContaIni + "' AND " +;
      "CT2_DEBITO<='" + cContaFim + "'"
      cVldEnt := "CT2_CCD>='" + cCustoIni + "' AND " +;
      "CT2_CCD<='" + cCustoFim + "' AND " +;
      "CT2_ITEMD>='" + cItemIni + "' AND " +;
      "CT2_ITEMD<='" + cItemFim + "' AND " +;
      "CT2_CLVLDB>='" + cClVlIni + "' AND " +;
      "CT2_CLVLDB<='" + cClVlFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_DEBITO, CT2_DATA "
   ElseIf cTipo == "2"
      dbSelectArea("CT2")
      dbSetOrder(4)
      cValid := "CT2_CCD >= '" + cCustoIni + "' AND " +;
      "CT2_CCD <= '" + cCustoFim + "'"
      cVldEnt := "CT2_DEBITO >= '" + cContaIni + "' AND " +;
      "CT2_DEBITO <= '" + cContaFim + "' AND " +;
      "CT2_ITEMD >= '" + cItemIni + "' AND " +;
      "CT2_ITEMD <= '" + cItemFim + "' AND " +;
      "CT2_CLVLDB >= '" + cClVlIni + "' AND " +;
      "CT2_CLVLDB <= '" + cClVlFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_CCD, CT2_DATA "
   ElseIf cTipo == "3"
      dbSelectArea("CT2")
      dbSetOrder(6)
      cValid := "CT2_ITEMD >= '" + cItemIni + "' AND " +;
      "CT2_ITEMD <= '" + cItemFim + "'"
      cVldEnt := "CT2_DEBITO >= '" + cContaIni + "' AND " +;
      "CT2_DEBITO <= '" + cContaFim + "' AND " +;
      "CT2_CCD >= '" + cCustoIni + "' AND " +;
      "CT2_CCD <= '" + cCustoFim + "' AND " +;
      "CT2_CLVLDB >= '" + cClVlIni + "' AND " +;
      "CT2_CLVLDB <= '" + cClVlFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_ITEMD, CT2_DATA "
   ElseIf cTipo == "4"
      dbSelectArea("CT2")
      dbSetOrder(8)
      cValid := "CT2_CLVLDB >= '" + cClVlIni + "' AND " +;
      "CT2_CLVLDB <= '" + cClVlFim + "'"
      cVldEnt := "CT2_DEBITO >= '" + cContaIni + "' AND " +;
      "CT2_DEBITO <= '" + cContaFim + "' AND " +;
      "CT2_CCD >= '" + cCustoIni + "' AND " +;
      "CT2_CCD <= '" + cCustoFim + "' AND " +;
      "CT2_ITEMD >= '" + cItemIni + "' AND " +;
      "CT2_ITEMD <= '" + cItemFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_CLVLDB, CT2_DATA "
   EndIf

   cAliasCT2 := "cAliasCT2"

   cQuery := " SELECT * "
   cQuery += " FROM " + RetSqlName("CT2")
   cQuery += " WHERE " + cQryFil + " AND "
   cQuery += cValid + " AND "
   cQuery += " CT2_DATA >= '" + DTOS(dDataIni) + "' AND "
   cQuery += " CT2_DATA <= '" + DTOS(dDataFim) + "' AND "
   cQuery += cVldEnt+ " AND "
   cQuery += cFilMoeda + " AND "
   cQuery += " CT2_TPSALD = '"+ cSaldo + "'"
   cQuery += " AND (CT2_DC = '1' OR CT2_DC = '3')"
   cQuery += " AND CT2_VALOR <> 0 "
   cQuery += " AND D_E_L_E_T_ = ' ' "
   cQuery += " ORDER BY "+ cOrderBy
   cQuery := ChangeQuery(cQuery)

   dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasCT2,.T.,.F.)
   aStru := CT2->(dbStruct())

   For ni := 1 to Len(aStru)
     If aStru[ni,2] != 'C'
        TCSetField(cAliasCT2, aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
     Endif
   Next ni

   If lUFilter //// ADICIONA O FILTRO DEFINIDO PELO USUÁRIO SE NÃO ESTIVER EM BRANCO
      If !Empty(cVldEnt)
         cVldEnt += " AND " /// SE JÁ TIVER CONTEUDO, ADICIONA "AND"
         cVldEnt += cUFilter /// ADICIONA O FILTRO DE USUÁRIO
      EndIf
   EndIf

   If (!lUFilter) .or. Empty(cUFilter)
      cUFilter := ".T."
   EndIf

   dbSelectArea(cAliasCT2)
   While !Eof()
                        
     If &cUFilter
        CtbGrvRAZ(lJunta,cMoeda,cSaldo,"1",c2Moeda,cAliasCT2,nTipo)
        dbSelectArea(cAliasCT2)
     EndIf
     dbSkip()
   EndDo
   If ( Select ( "cAliasCT2" ) <> 0 )
      dbSelectArea ( "cAliasCT2" )
      dbCloseArea ()
   Endif

Else
#ENDIF
   If cTipo == "1"
      dbSelectArea("CT2")
      dbSetOrder(2)
      cValid := "CT2_DEBITO>='" + cContaIni + "' .And. " +;
      "CT2_DEBITO<='" + cContaFim + "'"
      cVldEnt := "CT2_CCD>='" + cCustoIni + "' .And. " +;
      "CT2_CCD<='" + cCustoFim + "' .And. " +;
      "CT2_ITEMD>='" + cItemIni + "' .And. " +;
      "CT2_ITEMD<='" + cItemFim + "' .And. " +;
      "CT2_CLVLDB>='" + cClVlIni + "' .And. " +;
      "CT2_CLVLDB<='" + cClVlFim + "'"
      bCond := { ||CT2->CT2_DEBITO >= cContaIni .And. CT2->CT2_DEBITO <= cContaFim}
   ElseIf cTipo == "2"
      dbSelectArea("CT2")
      dbSetOrder(4)
      cValid := "CT2_CCD >= '" + cCustoIni + "' .And. " +;
      "CT2_CCD <= '" + cCustoFim + "'"
      cVldEnt := "CT2_DEBITO >= '" + cContaIni + "' .And. " +;
      "CT2_DEBITO <= '" + cContaFim + "' .And. " +;
      "CT2_ITEMD >= '" + cItemIni + "' .And. " +;
      "CT2_ITEMD <= '" + cItemFim + "' .And. " +;
      "CT2_CLVLDB >= '" + cClVlIni + "' .And. " +;
      "CT2_CLVLDB <= '" + cClVlFim + "'"
   ElseIf cTipo == "3"
      dbSelectArea("CT2")
      dbSetOrder(6)
      cValid := "CT2_ITEMD >= '" + cItemIni + "' .And. " +;
      "CT2_ITEMD <= '" + cItemFim + "'"
      cVldEnt := "CT2_DEBITO >= '" + cContaIni + "' .And. " +;
      "CT2_DEBITO <= '" + cContaFim + "' .And. " +;
      "CT2_CCD >= '" + cCustoIni + "' .And. " +;
      "CT2_CCD <= '" + cCustoFim + "' .And. " +;
      "CT2_CLVLDB >= '" + cClVlIni + "' .And. " +;
      "CT2_CLVLDB <= '" + cClVlFim + "'"
   ElseIf cTipo == "4"
      dbSelectArea("CT2")
      dbSetOrder(8)
      cValid := "CT2_CLVLDB >= '" + cClVlIni + "' .And. " +;
      "CT2_CLVLDB <= '" + cClVlFim + "'"
      cVldEnt := "CT2_DEBITO >= '" + cContaIni + "' .And. " +;
      "CT2_DEBITO <= '" + cContaFim + "' .And. " +;
      "CT2_CCD >= '" + cCustoIni + "' .And. " +;
      "CT2_CCD <= '" + cCustoFim + "' .And. " +;
      "CT2_ITEMD >= '" + cItemIni + "' .And. " +;
      "CT2_ITEMD <= '" + cItemFim + "'"
   EndIf

   If lUFilter //// ADICIONA O FILTRO DEFINIDO PELO USUÁRIO SE NÃO ESTIVER EM BRANCO
      If !Empty(cVldEnt)
         cVldEnt += " .and. " /// SE JÁ TIVER CONTEUDO, ADICIONA ".AND."
      EndIf
   Endif

   cVldEnt += cUFilter /// ADICIONA O FILTRO DE USUÁRIO

   If cTipo == "1" /// TRATAMENTO CONTAS A CREDITO

      dbSelectArea("CT2")
      dbSetOrder(2)

      dbSelectArea("CT1")
      dbSetOrder(3)
      cFilCT1 := xFilial("CT1")
      cFilCT2 := xFilial("CT2")
      cContaIni := If(Empty(cContaIni),"",cContaIni) /// Se tiver espacos em branco usa "" p/ seek
      dbSeek(cFilCT1+"2"+cContaIni,.T.) /// Procura inicial analitica

      While CT1->(!Eof()) .and. CT1->CT1_FILIAL == cFilCT1 .And. CT1->CT1_CONTA <= cContaFim
         dbSelectArea("CT2")
         MsSeek(cFilCT2+CT1->CT1_CONTA+DTOS(dDataIni),.T.)
         While !Eof() .And. CT2->CT2_FILIAL == cFilCT2 .And. CT2->CT2_DEBITO == CT1->CT1_CONTA .and. CT2->CT2_DATA <= dDataFim
         
            If CT2->CT2_VALOR = 0
               dbSkip()
               Loop
            EndIf

            If Empty(c2Moeda)
              If CT2->CT2_MOEDLC <> cMoeda
                dbSkip()
                Loop
              EndIF
            Else
              If !(&(cFilMoeda))
                dbSkip()
                Loop
              EndIf
           EndIf
           
           If (CT2->CT2_DC == "1" .Or. CT2->CT2_DC == "3") .And. &(cValid) .And. &(cVldEnt) .And. CT2->CT2_TPSALD == cSaldo
              CT2->(CtbGrvRAZ(lJunta,cMoeda,cSaldo,"1",c2Moeda,cAliasCT2,nTipo))
           Endif
           dbSelectArea("CT2")
           dbSkip()
         EndDo
         CT1->(dbSkip())
      EndDo
   Else
      dbSelectArea("CT2")

      cTabCad := "CTT"
      cEntIni := cCustoIni
      bCond := { || CT2->CT2_CCD == CTT->CTT_CUSTO}
      bCondCad:= { || .T.}
      dbSetOrder(4)

      If cTipo == "3"
         cTabCad := "CTD"
         cEntIni := cItemIni
         bCond := { || CT2->CT2_ITEMD == CTD->CTD_ITEM}
         dbSetOrder(6)
      ElseIf cTipo == "4"
         cTabCad := "CTH"
         cEntIni := cCLVLIni
         bCond := { || CT2->CT2_CLVLDB == CTH->CTH_CLVL}
         dbSetOrder(8)
      EndIf

      dbSelectArea(cTabCad)
      dbSetOrder(2)
      cFilEnt := xFilial(cTabCad)
      cFilCT2 := xFilial("CT2")
      cEntIni := If(Empty(cEntIni),"",cEntIni) /// Se tiver espacos em branco usa "" p/ seek
      dbSeek(cFilEnt+"2"+cEntIni,.T.) /// Procura inicial analitica

      If cTipo == "2"
         bCondCad := {|| CTT->CTT_FILIAL == cFilEnt .and. CTT->CTT_CUSTO <= cCustoFim }
      ElseIf cTipo == "3"
         bCondCad := {|| CTD->CTD_FILIAL == cFilEnt .and. CTD->CTD_ITEM <= cItemFim }
      ElseIf cTipo == "4"
         bCondCad := {|| CTH->CTH_FILIAL == cFilEnt .and. CTH->CTH_CLVL <= cCLVLFim }
      EndIf

      While (cTabCad)->(!Eof()) .and. Eval(bCondCad) /// WHILE DO CADASTRO DE ENTIDADES

         dbSelectArea("CT2")
         If cTipo == "2"
            MsSeek(cFilCT2+CTT->CTT_CUSTO+DTOS(dDataIni),.T.)
         ElseIf cTipo == "3"
            MsSeek(cFilCT2+CTD->CTD_ITEM+DTOS(dDataIni),.T.)
         Else
            MsSeek(cFilCT2+CTH->CTH_CLVL+DTOS(dDataIni),.T.)
         EndIf

         dbSelectArea("CT2") /// WHILE CT2 - DEBITOS
         While CT2->(!Eof()) .And. CT2->CT2_FILIAL == cFilCT2 .and. Eval(bCond) .and. CT2->CT2_DATA <= dDataFim
         
            If CT2->CT2_VALOR = 0
               dbSkip()
               Loop
            EndIf

            If Empty(c2Moeda)
               If CT2->CT2_MOEDLC <> cMoeda
                  dbSkip()
                  Loop
               EndIF
            Else
               If !(&(cFilMoeda))
                  dbSkip()
                  Loop
               EndIf
            EndIf
            

            If (CT2->CT2_DC == "1" .Or. CT2->CT2_DC == "3") .And. &(cVldEnt) .And. CT2->CT2_TPSALD == cSaldo
               CT2->(CtbGrvRAZ(lJunta,cMoeda,cSaldo,"1",c2Moeda,cAliasCT2,nTipo))
            Endif
            dbSelectArea("CT2")
            dbSkip()
         EndDo
         (cTabCad)->(dbSkip())
      EndDo
   Endif

#IFDEF TOP
EndIf
#ENDIF


// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Obt?m os creditos³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cTipo == "1"
   dbSelectArea("CT2")
   dbSetOrder(3)
ElseIf cTipo == "2"
   dbSelectArea("CT2")
   dbSetOrder(5)
ElseIf cTipo == "3"
   dbSelectArea("CT2")
   dbSetOrder(7)
ElseIf cTipo == "4"
   dbSelectArea("CT2")
   dbSetOrder(9)
EndIf

#IFDEF TOP
If TcSrvType() != "AS/400"
   If cTipo == "1"
      cValid := "CT2_CREDIT>='" + cContaIni + "' AND " +;
      "CT2_CREDIT<='" + cContaFim + "'"
      cVldEnt := "CT2_CCC>='" + cCustoIni + "' AND " +;
      "CT2_CCC<='" + cCustoFim + "' AND " +;
      "CT2_ITEMC>='" + cItemIni + "' AND " +;
      "CT2_ITEMC<='" + cItemFim + "' AND " +;
      "CT2_CLVLCR>='" + cClVlIni + "' AND " +;
      "CT2_CLVLCR<='" + cClVlFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_CREDIT, CT2_DATA "
   ElseIf cTipo == "2"
      cValid := "CT2_CCC >= '" + cCustoIni + "' AND " +;
      "CT2_CCC <= '" + cCustoFim + "'"
      cVldEnt := "CT2_CREDIT >= '" + cContaIni + "' AND " +;
      "CT2_CREDIT <= '" + cContaFim + "' AND " +;
      "CT2_ITEMC >= '" + cItemIni + "' AND " +;
      "CT2_ITEMC <= '" + cItemFim + "' AND " +;
      "CT2_CLVLCR >= '" + cClVlIni + "' AND " +;
      "CT2_CLVLCR <= '" + cClVlFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_CCC, CT2_DATA "
   ElseIf cTipo == "3"
      cValid := "CT2_ITEMC >= '" + cItemIni + "' AND " +;
      "CT2_ITEMC <= '" + cItemFim + "'"
      cVldEnt := "CT2_CREDIT >= '" + cContaIni + "' AND " +;
      "CT2_CREDIT <= '" + cContaFim + "' AND " +;
      "CT2_CCC >= '" + cCustoIni + "' AND " +;
      "CT2_CCC <= '" + cCustoFim + "' AND " +;
      "CT2_CLVLCR >= '" + cClVlIni + "' AND " +;
      "CT2_CLVLCR <= '" + cClVlFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_ITEMC, CT2_DATA "
   ElseIf cTipo == "4"
      cValid := "CT2_CLVLCR >= '" + cClVlIni + "' AND " +;
      "CT2_CLVLCR <= '" + cClVlFim + "'"
      cVldEnt := "CT2_CREDIT >= '" + cContaIni + "' AND " +;
      "CT2_CREDIT <= '" + cContaFim + "' AND " +;
      "CT2_CCC >= '" + cCustoIni + "' AND " +;
      "CT2_CCC <= '" + cCustoFim + "' AND " +;
      "CT2_ITEMC >= '" + cItemIni + "' AND " +;
      "CT2_ITEMC <= '" + cItemFim + "'"
      cOrderBy:= " CT2_FILIAL, CT2_CLVLCR, CT2_DATA "
   EndIf

   cAliasCT2 := "cAliasCT2"

   cQuery := " SELECT * "
   cQuery += " FROM " + RetSqlName("CT2")
   cQuery += " WHERE " + cQryFil + " AND "
   cQuery += cValid + " AND "
   cQuery += " CT2_DATA >= '" + DTOS(dDataIni) + "' AND "
   cQuery += " CT2_DATA <= '" + DTOS(dDataFim) + "' AND "
   cQuery += cVldEnt+ " AND "
   cQuery += cFilMoeda + " AND "
   cQuery += " CT2_TPSALD = '"+ cSaldo + "' AND "
   cQuery += " (CT2_DC = '2' OR CT2_DC = '3') AND "
   cQuery += " CT2_VALOR <> 0 AND "
   cQuery += " D_E_L_E_T_ = ' ' "
   cQuery += " ORDER BY "+ cOrderBy
   cQuery := ChangeQuery(cQuery)

   dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasCT2,.T.,.F.)

   aStru := CT2->(dbStruct())

   For ni := 1 to Len(aStru)
      If aStru[ni,2] != 'C'
         TCSetField(cAliasCT2, aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
      Endif
   Next ni


   If lUFilter //// ADICIONA O FILTRO DEFINIDO PELO USUÁRIO SE NÃO ESTIVER EM BRANCO
      If !Empty(cVldEnt)
         cVldEnt += " AND " /// SE JÁ TIVER CONTEUDO, ADICIONA "AND"
         cVldEnt += cUFilter /// ADICIONA O FILTRO DE USUÁRIO
      EndIf
   EndIf

   If (!lUFilter) .or. Empty(cUFilter)
      cUFilter := ".T."
   EndIf

   dbSelectArea(cAliasCT2)
   While !Eof()
     If &cUFilter
     
        CtbGrvRAZ(lJunta,cMoeda,cSaldo,"2",c2Moeda,cAliasCT2,nTipo)
        dbSelectArea(cAliasCT2)
        
     EndIf
     dbSkip()
   EndDo

   If ( Select ( "cAliasCT2" ) <> 0 )
      dbSelectArea ( "cAliasCT2" )
      dbCloseArea ()
   Endif

Else
#ENDIF
   bCond := {||.T.}

   If cTipo == "1"
      cValid := "CT2_CREDIT>='" + cContaIni + "'.And." +;
      "CT2_CREDIT<='" + cContaFim + "'"
      cVldEnt := "CT2_CCC>='" + cCustoIni + "'.And." +;
      "CT2_CCC<='" + cCustoFim + "'.And." +;
      "CT2_ITEMC>='" + cItemIni + "'.And." +;
      "CT2_ITEMC<='" + cItemFim + "'.And." +;
      "CT2_CLVLCR>='" + cClVlIni + "'.And." +;
      "CT2_CLVLCR<='" + cClVlFim + "'"
      bCond := { ||CT2->CT2_CREDIT >= cContaIni .And. CT2->CT2_CREDIT <= cContaFim}
   ElseIf cTipo == "2"
      cValid := "CT2_CCC >= '" + cCustoIni + "' .And. " +;
      "CT2_CCC <= '" + cCustoFim + "'"
      cVldEnt := "CT2_CREDIT >= '" + cContaIni + "' .And. " +;
      "CT2_CREDIT <= '" + cContaFim + "' .And. " +;
      "CT2_ITEMC >= '" + cItemIni + "' .And. " +;
      "CT2_ITEMC <= '" + cItemFim + "' .And. " +;
      "CT2_CLVLCR >= '" + cClVlIni + "' .And. " +;
      "CT2_CLVLCR <= '" + cClVlFim + "'"
   ElseIf cTipo == "3"
      cValid := "CT2_ITEMC >= '" + cItemIni + "' .And. " +;
      "CT2_ITEMC <= '" + cItemFim + "'"
      cVldEnt := "CT2_CREDIT >= '" + cContaIni + "' .And. " +;
      "CT2_CREDIT <= '" + cContaFim + "' .And. " +;
      "CT2_CCC >= '" + cCustoIni + "' .And. " +;
      "CT2_CCC <= '" + cCustoFim + "' .And. " +;
      "CT2_CLVLCR >= '" + cClVlIni + "' .And. " +;
      "CT2_CLVLCR <= '" + cClVlFim + "'"
   ElseIf cTipo == "4"
      cValid := "CT2_CLVLCR >= '" + cClVlIni + "' .And. " +;
      "CT2_CLVLCR <= '" + cClVlFim + "'"
      cVldEnt := "CT2_CREDIT >= '" + cContaIni + "' .And. " +;
      "CT2_CREDIT <= '" + cContaFim + "' .And. " +;
      "CT2_CCC >= '" + cCustoIni + "' .And. " +;
      "CT2_CCC <= '" + cCustoFim + "' .And. " +;
      "CT2_ITEMC >= '" + cItemIni + "' .And. " +;
      "CT2_ITEMC <= '" + cItemFim + "'"
   EndIf

   If lUFilter //// ADICIONA O FILTRO DEFINIDO PELO USUÁRIO SE NÃO ESTIVER EM BRANCO
      If !Empty(cVldEnt)
         cVldEnt += " .and. " /// SE JÁ TIVER CONTEUDO, ADICIONA ".AND."
      EndIf
   Endif

   cVldEnt += cUFilter /// ADICIONA O FILTRO DE USUÁRIO

   If cTipo == "1" /// TRATAMENTO CONTAS A CREDITO
      dbSelectArea("CT2")
      dbSetOrder(3)

      dbSelectArea("CT1")
      dbSetOrder(3)
      cFilCT1 := xFilial("CT1")
      cFilCT2 := xFilial("CT2")
      cContaIni := If(Empty(cContaIni),"",cContaIni) /// Se tiver espacos em branco usa "" p/ seek
      dbSeek(cFilCT1+"2"+cContaIni,.T.) /// Procura inicial analitica

      While CT1->(!Eof()) .and. CT1->CT1_FILIAL == cFilCT1 .And. CT1->CT1_CONTA <= cContaFim
          dbSelectArea("CT2")
          MsSeek(cFilCT2+CT1->CT1_CONTA+DTOS(dDataIni),.T.)
          While !Eof() .And. CT2->CT2_FILIAL == cFilCT2 .And. CT2->CT2_CREDIT == CT1->CT1_CONTA .and. CT2->CT2_DATA <= dDataFim
          
             If CT2->CT2_VALOR = 0
                dbSkip()
                Loop
             EndIf

             If (CT2->CT2_DC == "2" .Or. CT2->CT2_DC == "3") .And. &(cValid) .And. &(cVldEnt) .And. CT2->CT2_TPSALD == cSaldo
                If Empty(c2Moeda)
                   If CT2->CT2_MOEDLC <> cMoeda
                       dbSkip()
                       Loop
                   EndIF
                Else
                   If !(&(cFilMoeda))
                      dbSkip()
                      Loop
                   EndIf
                EndIf
                CT2->(CtbGrvRAZ(lJunta,cMoeda,cSaldo,"2",c2Moeda,cAliasCT2,nTipo))
             Endif
             dbSelectArea("CT2")
             dbSkip()
          EndDo
          CT1->(dbSkip())
      EndDo
   Else
      dbSelectArea("CT2")

      cTabCad := "CTT"
      cEntIni := cCustoIni
      bCond := { || CT2->CT2_CCC == CTT->CTT_CUSTO}
      bCondCad:= { || .T.}
      dbSetOrder(5)

      If cTipo == "3"
         cTabCad := "CTD"
         cEntIni := cItemIni
         bCond := { || CT2->CT2_ITEMC == CTD->CTD_ITEM}
         dbSetOrder(7)
      ElseIf cTipo == "4"
         cTabCad := "CTH"
         cEntIni := cCLVLIni
         bCond := { || CT2->CT2_CLVLCR == CTH->CTH_CLVL}
         dbSetOrder(9)
      EndIf

      dbSelectArea(cTabCad)
      dbSetOrder(2)
      cFilEnt := xFilial(cTabCad)
      cFilCT2 := xFilial("CT2")
      cEntIni := If(Empty(cEntIni),"",cEntIni) /// Se tiver espacos em branco usa "" p/ seek
      dbSeek(cFilEnt+"2"+cEntIni,.T.) /// Procura inicial analitica

      If cTipo == "2"
         bCondCad := {|| CTT->CTT_FILIAL == cFilEnt .and. CTT->CTT_CUSTO <= cCustoFim }
      ElseIf cTipo == "3"
         bCondCad := {|| CTD->CTD_FILIAL == cFilEnt .and. CTD->CTD_ITEM <= cItemFim }
      ElseIf cTipo == "4"
         bCondCad := {|| CTH->CTH_FILIAL == cFilEnt .and. CTH->CTH_CLVL <= cCLVLFim }
      EndIf

      While (cTabCad)->(!Eof()) .and. Eval(bCondCad) /// WHILE DO CADASTRO DE ENTIDADES

         dbSelectArea("CT2")
         If cTipo == "2"
            MsSeek(cFilCT2+CTT->CTT_CUSTO+DTOS(dDataIni),.T.)
         ElseIf cTipo == "3"
           MsSeek(cFilCT2+CTD->CTD_ITEM+DTOS(dDataIni),.T.)
         Else
           MsSeek(cFilCT2+CTH->CTH_CLVL+DTOS(dDataIni),.T.)
         EndIf
         dbSelectArea("CT2") /// WHILE CT2 - CREDITO
         While CT2->(!Eof()) .And. CT2->CT2_FILIAL == cFilCT2 .and. Eval(bCond) .and. CT2->CT2_DATA <= dDataFim
         

              If CT2->CT2_VALOR = 0
                 dbSkip()
                 Loop
              EndIf

              If Empty(c2Moeda)
                 If CT2->CT2_MOEDLC <> cMoeda
                    dbSkip()
                    Loop
                 EndIF
              Else
                 If !(&(cFilMoeda))
                    dbSkip()
                    Loop
                 EndIf
              EndIf

              If (CT2->CT2_DC == "2" .Or. CT2->CT2_DC == "3") .And. &(cVldEnt) .And. CT2->CT2_TPSALD == cSaldo
                  CT2->(CtbGrvRAZ(lJunta,cMoeda,cSaldo,"2",c2Moeda,cAliasCT2,nTipo))
              Endif
              dbSelectArea("CT2")
              dbSkip()
         EndDo
         (cTabCad)->(dbSkip())
      EndDo
   EndIf
#IFDEF TOP
EndIf
#ENDIF

If lNoMov .or. lSldAnt
    If cTipo == "1"
       dbSelectArea("CT1")
       dbSetOrder(3)
       IndRegua( Alias(),CriaTrab(nil,.f.),IndexKey(),,;
       "CT1_FILIAL == '" + xFilial("CT1") + "' .And. CT1_CONTA >= '"+cContaI+ "' .And. CT1_CONTA <= '" +;
       cContaF + "' .And. CT1_CLASSE = '2'",STR0017)
       cCpoChave := "CT1_CONTA"
       cTmpChave := "CONTA"
    ElseIf cTipo == "2"
       dbSelectArea("CTT")
       dbSetOrder(2)
       IndRegua( Alias(),CriaTrab(nil,.f.),IndexKey(),,;
       "CTT_FILIAL == '" + xFilial("CTT") + "' .And. CTT_CUSTO >= '"+cCustoI+"' .And. CTT_CUSTO <= '" +;
       cCUSTOF + "' .And. CTT_CLASSE == '2'",STR0017)
       cCpoChave := "CTT_CUSTO"
       cTmpChave := "CCUSTO"
    ElseIf ctipo == "3"
       dbSelectArea("CTD")
       dbSetOrder(2)
       IndRegua( Alias(),CriaTrab(nil,.f.),IndexKey(),,;
       "CTD_FILIAL == '" + xFilial("CTD") + "' .And. CTD_ITEM >= '"+cItemI+"' .And. CTD_ITEM <= '" +;
       cITEMF + "' .And. CTD_CLASSE == '2'",STR0017)
       cCpoChave := "CTD_ITEM"
       cTmpChave := "ITEM"
    ElseIf ctipo == "4"
       dbSelectArea("CTH")
       dbSetOrder(2)
       IndRegua( Alias(),CriaTrab(nil,.f.),IndexKey(),,;
       "CTH_FILIAL == '" + xFilial("CTH") + "' .And. CTH_CLVL >= '"+cClVlI+"' .And. CTH_CLVL <= '" +;
       cCLVLF + "' .And. CTH_CLASSE == '2'",STR0017)
       cCpoChave := "CTH_CLVL"
       cTmpChave := "CLVL"
    EndIf

    cAlias := Alias()

    While ! Eof()
       dbSelectArea("cArqTmp")
       cKey2Seek := &(cAlias + "->" + cCpoChave)
       If !DbSeek(cKey2Seek)
          If lNoMov
              CtbGrvNoMov(cKey2Seek,dDataIni,cTmpChave)
          ElseIf cTipo == "1" /// SOMENTE PARA O RAZAO POR CONTA
              /// TRATA OS DADOS PARA A PERGUNTA "IMPRIME CONTA SEM MOVIMENTO" = "NAO C/ SLD.ANT."
              If SaldoCT7Fil(cKey2Seek,dDataIni,cMoeda,cSaldo,'CTBR400')[6] <> 0 .and. cArqTMP->CONTA <> cKey2Seek
                 /// SE TIVER SALDO ANTERIOR E NÃO TIVER MOVIMENTO GRAVADO
                 CtbGrvNoMov(cKey2Seek,dDataIni,cTmpChave)
              Endif
          EndIf
       Endif
       DbSelectArea(cAlias)
       DbSkip()
    EndDo

    DbSelectArea(cAlias)
    DbClearFil()
    RetIndex(cAlias)
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CtbGrvRaz ³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Grava registros no arq temporario - Razao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe ³CtbGrvRaz(lJunta,cMoeda,cSaldo,cTipo) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno ³Nenhum ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpL1 = Se Junta CC ou nao ³±±
±±³ ³ ExpC1 = Moeda ³±±
±±³ ³ ExpC2 = Tipo de saldo ³±±
±± ³ ExpC3 = Tipo do lancamento ³±±
±±³ ³ c2Moeda = Indica moeda 2 a ser incluida no relatorio ³±±
±±³ ³ cAliasQry = Alias com o conteudo selecionado do CT2 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CtbGrvRAZ(lJunta,cMoeda,cSaldo,cTipo,c2Moeda,cAliasCT2,nTipo)

Local cConta
Local cContra
Local cCusto
Local cItem
Local cCLVL
Local cChave := ""
Local lImpCPartida := GetNewPar("MV_IMPCPAR",.T.) // Se .T., IMPRIME Contra-Partida para TODOS os tipos de lançamento (Débito, Credito e Partida-Dobrada),
Local _flagsd1:=.F.
Local _cHissd1:=" "
// se .F., NÃO IMPRIME Contra-Partida para NENHUM tipo de lançamento.
DEFAULT cAliasCT2 := "CT2"

If !Empty(c2Moeda)
   If cTipo == "1"
      cChave := (cAliasCT2)->(CT2_DEBITO+DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA+CT2_EMPORI+CT2_FILORI)
   Else
      cChave := (cAliasCT2)->(CT2_CREDIT+DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA+CT2_EMPORI+CT2_FILORI)
   EndIf
EndIf

If cTipo == "1"
   cConta := (cAliasCT2)->CT2_DEBITO
   cContra := (cAliasCT2)->CT2_CREDIT
   cCusto := (cAliasCT2)->CT2_CCD
   cItem := (cAliasCT2)->CT2_ITEMD
   cCLVL := (cAliasCT2)->CT2_CLVLDB
EndIf

If cTipo == "2"
   cConta := (cAliasCT2)->CT2_CREDIT
   cContra := (cAliasCT2)->CT2_DEBITO
   cCusto := (cAliasCT2)->CT2_CCC
   cItem := (cAliasCT2)->CT2_ITEMC
   cCLVL := (cAliasCT2)->CT2_CLVLCR
EndIf

dbSelectArea("cArqTmp")
dbSetOrder(1)
If !Empty(c2Moeda)

   If MsSeek(cChave,.F.)
      Reclock("cArqTmp",.F.)
   Else
      RecLock("cArqTmp",.T.)
   EndIf
Else
   RecLock("cArqTmp",.T.)
EndIf


//46392130000118       
/*

If Alltrim(cConta)="DAP042" .And. (cAliasCT2)->CT2_VALOR=74.91
   _lixo:="xxx"
EndIf

  */
  

Replace FILIAL With (cAliasCT2)->CT2_FILIAL
Replace DATAL With (cAliasCT2)->CT2_DATA
Replace TIPO With cTipo
Replace LOTE With (cAliasCT2)->CT2_LOTE
Replace SUBLOTE With (cAliasCT2)->CT2_SBLOTE
Replace DOC With (cAliasCT2)->CT2_DOC
Replace LINHA With (cAliasCT2)->CT2_LINHA
Replace CONTA With cConta
Replace DCONTA With AllTrim(Posicione("CT1",1,xFilial("CT1")+cConta,"CT1->CT1_DESC01"))

If lImpCPartida
   Replace XPARTIDA With cContra
EndIf

/*
aCampos :={ { "CONTA" , "C", aTamConta[1], 0 },; // Codigo da Conta
{ "DCONTA" , "C", 040 , 0 },; // Descrição da Conta 
{ "XPARTIDA" , "C", aTamConta[1] , 0 },; // Contra Partida
{ "TIPO" , "C", 01 , 0 },; // Tipo do Registro (Debito/Credito/Continuacao)
{ "LANCDEB" , "N", aTamVal[1]+2, nDecimais },; // Debito
{ "LANCCRD" , "N", aTamVal[1]+2 , nDecimais },; // Credito
{ "SALDOSCR" , "N", aTamVal[1]+2, nDecimais },; // Saldo
{ "TPSLDANT" , "C", 01, 0 },; // Sinal do Saldo Anterior => Consulta Razao
{ "TPSLDATU" , "C", 01, 0 },; // Sinal do Saldo Atual => Consulta Razao
{ "HISTORICO" , "C", nTamHist , 0 },; // Historico
{ "CCUSTO" , "C", aTamCusto[1], 0 },; // Centro de Custo
{ "CCUSTO_DES" , "C", 040, 0 },; // Centro de Custo Descrição
{ "ITEM" , "C", nTamItem , 0 },; // Item Contabil
{ "ITEM_DES" , "C", 040 , 0 },; // Item Contabil Descrição
{ "CLVL" , "C", nTamCLVL , 0 },; // Classe de Valor
{ "CLVL_DES" , "C", 040 , 0 },; // Classe de Valor Descrição 
{ "DATAL" , "D", 10 , 0 },; // Data do Lancamento
{ "LOTE" , "C", 06 , 0 },; // Lote
{ "SUBLOTE" , "C", 03 , 0 },; // Sub-Lote
{ "DOC" , "C", 06 , 0 },; // Documento
{ "LINHA" , "C", 03 , 0 },; // Linha
{ "SEQLAN" , "C", 03 , 0 },; // Sequencia do Lancamento
{ "SEQHIST" , "C", 03 , 0 },; // Seq do Historico
{ "EMPORI" , "C", 02 , 0 },; // Empresa Original
{ "FILORI" , "C", nTamFilial , 0 },; // Filial Original
{ "NOMOV" , "L", 01 , 0 },; // Conta Sem Movimento
{ "FILIAL" , "C", nTamFilial , 0 },; // Filial do sistema
{ "CODNAT" , "C", 010 , 0 },; // Filial do sistema   ==> E1_NATUREZ   / ou / E2_NATUREZ
{ "DESNAT" , "C", 030 , 0 },; // Filial do sistema
{ "CODPROD" , "C", 015 , 0 },; // Filial do sistema
{ "DESPROD" , "C", 045 , 0 },; // Filial do sistema
{ "LOGUSU" , "C", 20 , 0 },; // Historico        
{ "FORNECE" , "C", 06 , 0 },; // Historico
{ "LOJA" , "C", 02 , 0 }} // Historico



Descrição da Conta : CT1_CONTA / CT1_DESC01 - OK - o
Natureza : ED_CODIGO / ED_DESCRIC           - OK 
Produto : D1_COD / B1_DESC  - OK
Mês / Ano da Contabilização : CT2_DATA
Data da Contabilização : CT2_DATA
Data do Vencimento : ???
Lote : CT2_LOTE
Valor Credito / Debito    : CT2_VALOR
Debito /  Credito    : CT2_DEBITO / CT2_CREDIT
Codigo do Favorecido : ???
Descrição do Favorecido : ???    
Historico de Lançamento : CT2_HIST
Codigo do Centro de Custo     :  CT2_CCD / CT2_CCC - OK
Descrição do Centro de Custo :  CTT_DESC01    - OK - o
Codigo Item da Conta : CT2_ITEMD / CT2_ITEMC  - OK  
Descrição do Item da Conta : CTD_DESC01     - OK  - o

*/
Replace CCUSTO With cCusto
Replace CCUSTO_DES With Posicione("CTT",1,xFilial("CTT")+cCusto,"CTT->CTT_DESC01" )
Replace ITEM With cItem
Replace ITEM_DES With Posicione("CTD",1,xFilial("CTD")+cItem,"CTD_DESC01")
Replace CLVL With cCLVL
Replace CLVL_DES With Posicione("CTH",1, xFilial("CTH")+cCLVL, "CTH_DESC01")
Replace HISTORICO With (cAliasCT2)->CT2_HIST
Replace EMPORI With (cAliasCT2)->CT2_EMPORI
Replace FILORI With (cAliasCT2)->CT2_FILORI
Replace SEQHIST With (cAliasCT2)->CT2_SEQHIST
Replace SEQLAN With (cAliasCT2)->CT2_SEQLAN
Replace NOMOV With .F. // Conta com movimento    

//// Rastreia o Registro na CV3
_cresusu:=" "
_nReg   :=CV3->(Recno())
_nordcv3:=CV3->(DbSetOrder())
_nReg2  :=0
CV3->(DbSetOrder(2))
If CV3->(DbSeek((cAliasCT2)->CT2_FILORI+Alltrim(Str((cAliasCT2)->R_E_C_N_O_))))     
  If  Alltrim(CV3->CV3_RECDES)=Alltrim(Str((cAliasCT2)->R_E_C_N_O_))  .And. CV3->(!Eof())
    If !Empty(CV3->CV3_TABORI) .And. !Empty(CV3->CV3_RECORI)
         _calias:=CV3->CV3_TABORI
         _nReg2:=(_calias)->(Recno())                                                  
         (_calias)->(DbGoto(Val(CV3->CV3_RECORI)))
         If (_calias)->(!Eof()) .And. Val(CV3->CV3_RECORI)=(_calias)->(Recno())
             _cvampor:=" "
             _ccampo:=SubStr(_calias,2,2)+"_USERLGI"    
           If (_calias)->(FieldPos(_ccampo)) > 0      
             _cvampor:=_ccampo
           Else 
             _ccampo:=_calias+"_USERLGI"    
             If (_calias)->(FieldPos(_ccampo)) > 0
                _cvampor:=_ccampo
             EndIf
           EndIf        
           If !Empty(_cvampor)
             Replace LOGUSU With UsrRetName( SubStr( Embaralha( (_calias)->&_cvampor, 1 ), 3, 6 ) )
           EndIf  
             // JAS linha original If UPPER(_calias)="SD1" .And. (_calias)->(FieldPos("D1_XREFERE")) > 0
           If UPPER(_calias)="SD1" .And. (_calias)->(FieldPos("D1_FORNECE")) > 0
                //Replace HISTNFE With (_calias)->D1_XREFERE 
                Replace FORNECE With (_calias)->D1_FORNECE,LOJA With (_calias)->D1_LOJA
           ElseIf UPPER(_calias)="SE1" .And. (_calias)->(FieldPos("E1_NATUREZ")) > 0   
                Replace CODNAT With (_calias)->E1_NATUREZ
                Replace DESNAT With Posicione("SED",1,xFilial("SED")+(_calias)->E1_NATUREZ,"ED_DESCRIC")
                Replace FORCNPJ With Posicione("SA1",1 ,xFilial("SA1")+(_calias)->E1_CLIENTE+(_calias)->E1_LOJA,"A1_CGC")
                Replace FORDESC With Posicione("SA1",1 ,xFilial("SA1")+(_calias)->E1_CLIENTE+(_calias)->E1_LOJA,"A1_NOME")
           ElseIf UPPER(_calias)="SE2" .And. (_calias)->(FieldPos("E2_NATUREZ")) > 0   
                Replace CODNAT With (_calias)->E2_NATUREZ
                Replace DESNAT With Posicione("SED",1,xFilial("SED")+(_calias)->E2_NATUREZ,"ED_DESCRIC")                
                Replace FORCNPJ With Posicione("SA2",1 ,xFilial("SA1")+(_calias)->E2_FORNECE+(_calias)->E2_LOJA,"A2_CGC")
                Replace FORDESC With Posicione("SA2",1 ,xFilial("SA1")+(_calias)->E2_FORNECE+(_calias)->E2_LOJA,"A2_NOME")
           ElseIf UPPER(_calias)="SF1"  .And. SD1->(FieldPos("D1_XREFERE")) > 0 
                  //////////////////////////////////////////////////////
				_cQuery    := "SELECT SD1.R_E_C_N_O_ SD1RECNO, SD1.D1_XREFERE, SD1.D1_TOTAL "
				_cQuery    += "FROM "+RetSqlName("SD1")+" SD1  "                                        
				_cQuery    += "WHERE SD1.D1_FILIAL='"+(_calias)->F1_FILIAL+"' AND "
				_cQuery    += "SD1.D1_DOC='"+(_calias)->F1_DOC+"' AND "
				_cQuery    += "SD1.D1_SERIE='"+(_calias)->F1_SERIE+"' AND "
				_cQuery    += "SD1.D1_FORNECE='"+(_calias)->F1_FORNECE+"' AND "
				_cQuery    += "SD1.D1_LOJA='"+(_calias)->F1_LOJA+"' AND "                
				_cQuery    += "SD1.D1_TIPO='"+(_calias)->F1_TIPO+"' AND "                                
				//_cQuery    += "SD1.D1_XREFERE <> ' ' AND "
				_cQuery    += "SD1.D_E_L_E_T_=' ' "
				_cQuery    += "ORDER BY D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,D1_ITEM,D1_COD "   
				_cQuery := ChangeQuery(_cQuery)
				//TcQuery _cQuery New Alias "TRBSD1"
				DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRBSD1",.T.,.T.)          
				TRBSD1->(DbGotop())
				If TRBSD1->(!Eof())                                     
				   _cfornece:=TRBSD1->D1_FORNECE
				   _cloja   :=TRBSD1->D1_LOJA
				   //_cHissd1:=TRBSD1->D1_XREFERE
				   While TRBSD1->(!Eof()) 
				      If !_flagsd1 .Or. Empty(_cfornece) //Empty(_cHissd1)
				         _flagsd1:=.T.
				         _cfornece:=TRBSD1->D1_FORNECE
				         _cloja   :=TRBSD1->D1_LOJA
				         //_cHissd1:=TRBSD1->D1_XREFERE
				      Endif   
				      If TRBSD1->D1_TOTAL=(cAliasCT2)->CT2_VALOR 
				      	 _cfornece:=TRBSD1->D1_FORNECE
				         _cloja   :=TRBSD1->D1_LOJA
				         //_cHissd1:=TRBSD1->D1_XREFERE
				         Exit
				      Endif   
				      TRBSD1->(DbSkip())
				   End-While                        
				EndIf   
				TRBSD1->(DbCloseArea())
				dbSelectArea("cArqTmp")
				If !Empty(_cfornece) //!Empty(_cHissd1)
				   //Replace HISTNFE With _cHissd1
				   Replace FORNECE With _cfornece,LOJA With _cloja
				EndIf
           EndIf                                                                  
           DbSelectArea("cArqTmp")
           //EndIf                                         
       EndIf   
       If _nReg2>0
         (_calias)->(Dbgoto(_nReg2))
       EndIf   
    EndIf    
  EndIf    
EndIf
If _nReg>0
   CV3->(Dbgoto(_nReg))
EndIf   

If cPaisLoc $ "CHI|ARG"
   Replace SEGOFI With (cAliasCT2)->CT2_SEGOFI// Correlativo para Chile
EndIf

If Empty(c2Moeda) //Se nao for Razao em 2 Moedas
   If cTipo == "1"
      Replace LANCDEB With LANCDEB + (cAliasCT2)->CT2_VALOR
   EndIf
   If cTipo == "2"
      Replace LANCCRD With LANCCRD + (cAliasCT2)->CT2_VALOR
   EndIf
   If (cAliasCT2)->CT2_DC == "3"
      Replace TIPO With cTipo
   Else
      Replace TIPO With (cAliasCT2)->CT2_DC
   EndIf
Else //Se for Razao em 2 Moedas
   If (nTipo = 1 .Or. nTipo = 3) .And. (cAliasCT2)->CT2_MOEDLC = cMoeda //Se Imprime Valor na Moeda ou ambos
      If cTipo == "1"   
         Replace LANCDEB With (cAliasCT2)->CT2_VALOR
      Else
         Replace LANCCRD With (cAliasCT2)->CT2_VALOR
      EndIf
   EndIf
   If (nTipo = 2 .Or. nTipo = 3) .And. (cAliasCT2)->CT2_MOEDLC = c2Moeda //Se Imprime Moeda Corrente ou Ambas
      If cTipo == "1"   
         Replace LANCDEB_1 With (cAliasCT2)->CT2_VALOR
      Else
         Replace LANCCRD_1 With (cAliasCT2)->CT2_VALOR
      Endif
   EndIf
   If LANCDEB_1 <> 0 .And. LANCDEB <> 0
      Replace TXDEBITO With LANCDEB_1 / LANCDEB
   Endif
   If LANCCRD_1 <> 0 .And. LANCCRD <> 0
      Replace TXCREDITO With LANCCRD_1 / LANCCRD
   EndIf
   If (cAliasCT2)->CT2_DC == "3"
      Replace TIPO With cTipo
   Else
      Replace TIPO With (cAliasCT2)->CT2_DC
   EndIf
EndIf

If nTipo = 1 .And. (LANCDEB + LANCCRD) = 0
   DbDelete()
ElseIf nTipo = 2 .And. (LANCDEB_1 + LANCCRD_1) = 0
   DbDelete()
Endif
If ! Empty(c2Moeda) .And. LANCDEB + LANCDEB_1 + LANCCRD + LANCCRD_1 = 0
   DbDelete()
Endif
MsUnlock()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CtbGrvNoMov ³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Grava registros no arq temporario sem movimento. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe ³CtbGrvNoMov(cConta) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno ³Nenhum ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ cConteudo = Conteudo a ser gravado no campo chave de acordo³±±
±±³ ³ com o razao impresso ³±±
±±³ ³ dDataL = Data para verificacao do movimento da conta ³±±
±±³ ³ cCpoChave = Nome do campo para gravacao no temporario ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CtbGrvNoMov(cConteudo,dDataL,cCpoTmp)

dbSelectArea("cArqTmp")
dbSetOrder(1)

RecLock("cArqTmp",.T.)
Replace &(cCpoTmp) With cConteudo
If cCpoTmp = "CONTA"
   Replace HISTORICO With STR0021 //"CONTA SEM MOVIMENTO NO PERIODO"
ElseIf cCpoTmp = "CCUSTO"
   Replace HISTORICO With Upper(AllTrim(CtbSayApro("CTT"))) + " " + STR0026 //"SEM MOVIMENTO NO PERIODO"
ElseIf cCpoTmp = "ITEM"
   Replace HISTORICO With Upper(AllTrim(CtbSayApro("CTD"))) + " " + STR0026 //"SEM MOVIMENTO NO PERIODO"
ElseIf cCpoTmp = "CLVL"
   Replace HISTORICO With Upper(AllTrim(CtbSayApro("CTH"))) + " " + STR0026 //"SEM MOVIMENTO NO PERIODO"
Endif
Replace DATAL WITH dDataL
// Grava filial do sistema para uso no relatorio
Replace FILORI With cFilAnt
MsUnlock()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³Ctr400Sint³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Imprime conta sintetica da conta do razao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe ³Ctr400Sint( cConta,cDescSint,cMoeda,cDescConta,cCodRes ³±±
±±³ | , cMoedaDesc) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno ³Conta Sintetic ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpC1 = Conta ³±±
±±³ ³ ExpC2 = Descricao da Conta Sintetica ³±±
±±³ ³ ExpC3 = Moeda ³±±
±±³ ³ ExpC4 = Descricao da Conta ³±±
±±³ ³ ExpC5 = Codigo reduzido ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Ctr400Sint(cConta,cDescSint,cMoeda,cDescConta,cCodRes,cMoedaDesc)

Local aSaveArea := GetArea()

Local nPosCT1 //Guarda a posicao no CT1
Local cContaPai := ""
Local cContaSint := ""

// seta o default da descrição da moeda para a moeda corrente
Default cMoedaDesc := cMoeda

dbSelectArea("CT1")
dbSetOrder(1)
If dbSeek(xFilial("CT1")+cConta)
   nPosCT1 := Recno()
   cDescConta := &("CT1->CT1_DESC" + cMoedaDesc )

   If Empty( cDescConta )
      cDescConta := CT1->CT1_DESC01
   Endif

   cCodRes := CT1->CT1_RES
   cContaPai := CT1->CT1_CTASUP

   If dbSeek(xFilial("CT1")+cContaPai)
      cContaSint := CT1->CT1_CONTA
      cDescSint := &("CT1->CT1_DESC" + cMoedaDesc )

      If Empty(cDescSint)
         cDescSint := CT1->CT1_DESC01
      Endif
   EndIf

   dbGoto(nPosCT1)
EndIf

RestArea(aSaveArea)

Return cContaSint

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CtbQryRaz ³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Realiza a "filtragem" dos registros do Razao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe ³CtbQryRaz(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim, ³±±
±±³ ³ cCustoIni,cCustoFim, cItemIni,cItemFim,cCLVLIni,cCLVLFim, ³±±
±±³ ³ cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo,lJunta, ³±±
±±³ ³ cTipo) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno ³Nenhum ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter ³±±
±±³ ³ ExpO2 = Objeto oText ³±±
±±³ ³ ExpO3 = Objeto oDlg ³±±
±±³ ³ ExpL1 = Acao do Codeblock ³±±
±±³ ³ ExpC2 = Conta Inicial ³±±
±±³ ³ ExpC3 = Conta Final ³±±
±±³ ³ ExpC4 = C.Custo Inicial ³±±
±±³ ³ ExpC5 = C.Custo Final ³±±
±±³ ³ ExpC6 = Item Inicial ³±±
±±³ ³ ExpC7 = Cl.Valor Inicial ³±±
±±³ ³ ExpC8 = Cl.Valor Final ³±±
±±³ ³ ExpC9 = Moeda ³±±
±±³ ³ ExpD1 = Data Inicial ³±±
±±³ ³ ExpD2 = Data Final ³±±
±±³ ³ ExpA1 = Matriz aSetOfBook ³±±
±±³ ³ ExpL2 = Indica se imprime movimento zerado ou nao. ³±±
±±³ ³ ExpC10= Tipo de Saldo ³±±
±±³ ³ ExpL3 = Indica se junta CC ou nao. ³±±
±±³ ³ ExpC11= Tipo do lancamento ³±±
±±³ ³ c2Moeda = Indica moeda 2 a ser incluida no relatorio ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CtbQryRaz(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,cUFilter,lSldAnt,aSelFil,lExterno)

Local aSaveArea := GetArea()
Local nMeter := 0
Local cQuery := ""
Local aTamVlr := TAMSX3("CT2_VALOR")
Local lNoMovim := .F.
Local cContaAnt := ""
Local cCampUSU := ""
local aStrSTRU := {}
Local nStr := 0
Local cQryFil := '' // variavel de condicional da query
Local lImpCPartida := GetNewPar( "MV_IMPCPAR" , .T.) // Se .T., IMPRIME Contra-Partida para TODOS os tipos de lançamento (Débito, Credito e Partida-Dobrada),
// se .F., NÃO IMPRIME Contra-Partida para NENHUM tipo de lançamento.
DEFAULT lSldAnt := .F.
DEFAULT aSelFil := {}
DEFAULT lExterno := .F.

// trataviva para o filtro de multifiliais
cQryFil := " CT2.CT2_FILIAL " + GetRngFil( aSelFil, "CT2" )

If !lExterno
   oMeter:SetTotal(CT2->(RecCount()))
   oMeter:Set(0)
Endif

cQuery := " SELECT CT2_FILIAL FILIAL, CT1_CONTA CONTA, ISNULL(CT2_CCD,'') CUSTO,ISNULL(CT2_ITEMD,'') ITEM, ISNULL(CT2_CLVLDB,'') CLVL, ISNULL(CT2_DATA,'') DDATA, ISNULL(CT2_TPSALD,'') TPSALD, "
cQuery += " ISNULL(CT2_DC,'') DC, ISNULL(CT2_LOTE,'') LOTE, ISNULL(CT2_SBLOTE,'') SUBLOTE, ISNULL(CT2_DOC,'') DOC, ISNULL(CT2_LINHA,'') LINHA, ISNULL(CT2_CREDIT,'') XPARTIDA, ISNULL(CT2_HIST,'') HIST, ISNULL(CT2_SEQHIS,'') SEQHIS, ISNULL(CT2_SEQLAN,'') SEQLAN, '1' TIPOLAN, "

////////////////////////////////////////////////////////////
//// TRATAMENTO PARA O FILTRO DE USUÁRIO NO RELATORIO
////////////////////////////////////////////////////////////
cCampUSU := "" //// DECLARA VARIAVEL COM OS CAMPOS DO FILTRO DE USUÁRIO
If !Empty(cUFilter) //// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
   aStrSTRU := CT2->(dbStruct()) //// OBTEM A ESTRUTURA DA TABELA USADA NA FILTRAGEM
   nStruLen := Len(aStrSTRU)
   For nStr := 1 to nStruLen //// LE A ESTRUTURA DA TABELA
      cCampUSU += aStrSTRU[nStr][1]+"," //// ADICIONANDO OS CAMPOS PARA FILTRAGEM POSTERIOR
   Next
Endif
cQuery += cCampUSU //// ADICIONA OS CAMPOS NA QUERY

////////////////////////////////////////////////////////////
cQuery += " ISNULL(CT2_VALOR,0) VALOR, ISNULL(CT2_EMPORI,'') EMPORI, ISNULL(CT2_FILORI,'') FILORI"
If cPaisLoc $ "CHI|ARG"
   cQuery += ", ISNULL(CT2_SEGOFI,'') SEGOFI"
EndIf

cQuery += " FROM "+ RetSqlName("CT1") + " CT1 LEFT JOIN " + RetSqlName("CT2") + " CT2 "
cQuery += " ON " + cQryFil

cQuery += " AND CT2.CT2_DEBITO = CT1.CT1_CONTA"
cQuery += " AND CT2.CT2_DATA >= '"+DTOS(dDataIni)+ "' AND CT2.CT2_DATA <= '"+DTOS(dDataFim)+"'"
cQuery += " AND CT2.CT2_CCD >= '" + cCustoIni + "' AND CT2.CT2_CCD <= '" + cCustoFim +"'"
cQuery += " AND CT2.CT2_ITEMD >= '" + cItemIni + "' AND CT2.CT2_ITEMD <= '"+ cItemFim +"'"
cQuery += " AND CT2.CT2_CLVLDB >= '" + cClvlIni + "' AND CT2.CT2_CLVLDB <= '" + cClVlFim +"'"
cQuery += " AND CT2.CT2_TPSALD = '"+ cSaldo + "'"
cQuery += " AND CT2.CT2_MOEDLC = '" + cMoeda +"'"
cQuery += " AND (CT2.CT2_DC = '1' OR CT2.CT2_DC = '3') "
cQuery += " AND CT2_VALOR <> 0 "
cQuery += " AND CT2.D_E_L_E_T_ = ' ' "
cQuery += " WHERE CT1.CT1_FILIAL = '"+xFilial("CT1")+"' "
cQuery += " AND CT1.CT1_CLASSE = '2' "
cQuery += " AND CT1.CT1_CONTA >= '"+ cContaIni+"' AND CT1.CT1_CONTA <= '"+cContaFim+"'"
cQuery += " AND CT1.D_E_L_E_T_ = '' "

cQuery += " UNION "

cQuery += " SELECT CT2_FILIAL FILIAL, CT1_CONTA CONTA, ISNULL(CT2_CCC,'') CUSTO, ISNULL(CT2_ITEMC,'') ITEM, ISNULL(CT2_CLVLCR,'') CLVL, ISNULL(CT2_DATA,'') DDATA, ISNULL(CT2_TPSALD,'') TPSALD, "
cQuery += " ISNULL(CT2_DC,'') DC, ISNULL(CT2_LOTE,'') LOTE, ISNULL(CT2_SBLOTE,'')SUBLOTE, ISNULL(CT2_DOC,'') DOC, ISNULL(CT2_LINHA,'') LINHA, ISNULL(CT2_DEBITO,'') XPARTIDA, ISNULL(CT2_HIST,'') HIST, ISNULL(CT2_SEQHIS,'') SEQHIS, ISNULL(CT2_SEQLAN,'') SEQLAN, '2' TIPOLAN, "

////////////////////////////////////////////////////////////
//// TRATAMENTO PARA O FILTRO DE USUÁRIO NO RELATORIO
////////////////////////////////////////////////////////////
cCampUSU := "" //// DECLARA VARIAVEL COM OS CAMPOS DO FILTRO DE USUÁRIO
If !Empty(cUFilter) //// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
   aStrSTRU := CT2->(dbStruct()) //// OBTEM A ESTRUTURA DA TABELA USADA NA FILTRAGEM
   nStruLen := Len(aStrSTRU)
   For nStr := 1 to nStruLen //// LE A ESTRUTURA DA TABELA
     cCampUSU += aStrSTRU[nStr][1]+"," //// ADICIONANDO OS CAMPOS PARA FILTRAGEM POSTERIOR
   Next
Endif

cQuery += cCampUSU //// ADICIONA OS CAMPOS NA QUERY

cQuery += " ISNULL(CT2_VALOR,0) VALOR, ISNULL(CT2_EMPORI,'') EMPORI, ISNULL(CT2_FILORI,'') FILORI"
If cPaisLoc $ "CHI|ARG"
   cQuery += ", ISNULL(CT2_SEGOFI,'') SEGOFI"
EndIf
cQuery += " FROM "+RetSqlName("CT1")+ ' CT1 LEFT JOIN '+ RetSqlName("CT2") + ' CT2 '
cQuery += " ON " + cQryFil

cQuery += " AND CT2.CT2_CREDIT = CT1.CT1_CONTA "
cQuery += " AND CT2.CT2_DATA >= '"+DTOS(dDataIni)+ "' AND CT2.CT2_DATA <= '"+DTOS(dDataFim)+"'"
cQuery += " AND CT2.CT2_CCC >= '" + cCustoIni + "' AND CT2.CT2_CCC <= '" + cCustoFim +"'"
cQuery += " AND CT2.CT2_ITEMC >= '" + cItemIni + "' AND CT2.CT2_ITEMC <= '"+ cItemFim +"'"
cQuery += " AND CT2.CT2_CLVLCR >= '" + cClvlIni + "' AND CT2.CT2_CLVLCR <= '" + cClVlFim +"'"
cQuery += " AND CT2.CT2_TPSALD = '"+ cSaldo + "'"
cQuery += " AND CT2.CT2_MOEDLC = '" + cMoeda +"'"
cQuery += " AND (CT2.CT2_DC = '2' OR CT2.CT2_DC = '3') "
cQuery += " AND CT2_VALOR <> 0 "
cQuery += " AND CT2.D_E_L_E_T_ = ' ' "
cQuery += " WHERE CT1.CT1_FILIAL = '"+xFilial("CT1")+"' "
cQuery += " AND CT1.CT1_CLASSE = '2' "
cQuery += " AND CT1.CT1_CONTA >= '"+ cContaIni+"' AND CT1.CT1_CONTA <= '"+cContaFim+"'"
cQuery += " AND CT1.D_E_L_E_T_ = ''"

cQuery := ChangeQuery(cQuery)

If Select("cArqCT2") > 0
   dbSelectArea("cArqCT2")
   dbCloseArea()
Endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqCT2",.T.,.F.)

TcSetField("cArqCT2","CT2_VLR"+cMoeda,"N",aTamVlr[1],aTamVlr[2])
TcSetField("cArqCT2","DDATA","D",8,0)

If !Empty(cUFilter) //// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
   For nStr := 1 to nStruLen //// LE A ESTRUTURA DA TABELA
      If aStrSTRU[nStr][2] <> "C" .and. cArqCT2->(FieldPos(aStrSTRU[nStr][1])) > 0
         TcSetField("cArqCT2",aStrSTRU[nStr][1],aStrSTRU[nStr][2],aStrSTRU[nStr][3],aStrSTRU[nStr][4])
      EndIf
   Next
Endif

dbSelectarea("cArqCT2")

dbSelectarea("cArqCT2")
If Empty(cUFilter)
   cUFilter := ".T."
Endif

While !Eof()
   If Empty(cArqCT2->DDATA) //Se nao existe movimento
      cContaAnt := cArqCT2->CONTA
      dbSkip()
      If Empty(cArqCT2->DDATA) .And. cContaAnt == cArqCT2->CONTA
         lNoMovim := .T.
      EndIf
   Endif

   If &("cArqCT2->("+cUFilter+")")
      If lNoMovim
        If lNoMov
          If CtbExDtFim("CT1")
             dbSelectArea("CT1")
             dbSetOrder(1)
             If MsSeek(xFilial()+cArqCT2->CONTA)
                If CtbVlDtFim("CT1",dDataIni)
                   CtbGrvNoMov(cArqCT2->CONTA,dDataIni,"CONTA") //Esta sendo passado "CONTA" fixo, porque essa funcao esta sendo
                EndIf //chamada somente para o CTBR400
             EndIf
          Else
             CtbGrvNoMov(cArqCT2->CONTA,dDataIni,"CONTA") //Esta sendo passado "CONTA" fixo, porque essa funcao esta sendo
          EndIf //chamada somente para o CTBR400
        ElseIf lSldAnt
            If SaldoCT7Fil(cArqCT2->CONTA,dDataIni,cMoeda,cSaldo,'CTBR400')[6] <> 0 .and. cArqTMP->CONTA <> cArqCT2->CONTA
               CtbGrvNoMov(cArqCT2->CONTA,dDataIni,"CONTA")
            Endif
        EndIf
     Else
        RecLock("cArqTmp",.T.)
        Replace FILIAL With cArqCT2->FILIAL
        Replace DATAL With cArqCT2->DDATA
        Replace TIPO With cArqCT2->DC
        Replace LOTE With cArqCT2->LOTE
        Replace SUBLOTE With cArqCT2->SUBLOTE
        Replace DOC With cArqCT2->DOC
        Replace LINHA With cArqCT2->LINHA
        Replace CONTA With cArqCT2->CONTA
        Replace CCUSTO With cArqCT2->CUSTO
        Replace ITEM With cArqCT2->ITEM
        Replace CLVL With cArqCT2->CLVL

        If lImpCPartida
           Replace XPARTIDA With cArqCT2->XPARTIDA
        EndIf

        Replace HISTORICO With cArqCT2->HIST
        Replace EMPORI With cArqCT2->EMPORI
        Replace FILORI With cArqCT2->FILORI
        Replace SEQHIST With cArqCT2->SEQHIS
        Replace SEQLAN With cArqCT2->SEQLAN

       If cPaisLoc $ "CHI|ARG"
          Replace SEGOFI With cArqCT2->SEGOFI// Correlativo para Chile
       EndIf

       If cArqCT2->TIPOLAN = '1'
          Replace LANCDEB With LANCDEB + cArqCT2->VALOR
       EndIf
       If cArqCT2->TIPOLAN = '2'
          Replace LANCCRD With LANCCRD + cArqCT2->VALOR
       EndIf
       MsUnlock()
     Endif
   EndIf
   lNoMovim := .F.
   dbSelectArea("cArqCT2")
   dbSkip()
   nMeter++

   If !lExterno
     oMeter:Set(nMeter)
   Endif

Enddo

RestArea(aSaveArea)

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CtCGCCabec³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³Monta Cabecalho do relatorio ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe ³CtCGCCabec(lItem,lCusto,lCLVL,Cabec1,Cabec2,dDataFim,Titulo ³±±
±±³ ³lAnalitico,cTipo,Tamanho) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno ³ Nenhum ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ExpL1 = Indica se imprime item ³±±
±±³ ³ExpL2 = Indica se imprime c.custo ³±±
±±³ ³ExpL3 = Indica se imprime classe de valor ³±±
±±³ ³ExpC1 = Conteudo da cabec1 ³±±
±±³ ³ExpC2 = Conteudo da cabec2 ³±±
±±³ ³ExpD1 = Data final do relatorio ³±±
±±³ ³ExpC3 = Titulo ³±±
±±³ ³ExpL4 = Indica se imprime analitico ³±±
±±³ ³ExpC4 = Tipo ³±±
±±³ ³ExpN1 = Tamanho ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CtCGCCabec(lItem,lCusto,lCLVL,Cabec1,Cabec2,dDataFim,Titulo,lAnalitico,cTipo,Tamanho,lCtrlPage)

DEFAULT Tamanho := "G"
DEFAULT lCtrlPage := .F. // Controla a numeração de pagina

SX3->( DbSetOrder(2) )
SX3->( MsSeek( "A1_CGC" , .T. ))

If cTipo == '1'
   Tamanho := Iif(((lItem .Or. lCusto .Or. lCLVL) .And. lAnalitico),"G",Tamanho)
   nTam := Iif(lItem .Or. lCusto .Or. lCLVL .or. Tamanho == "G", 218, 130)
ElseIf cTipo == '2'
   nTam := Iif(Tamanho == 'G', 218, 130)
Endif

RptFolha := GetNewPar( "MV_CTBPAG" , RptFolha )

If SM0->( Eof() )
   SM0->( MsSeek( cEmpAnt + cFilAnt , .T. ))
Endif

If lCtrlPage
// m_pag := m_pag - 1 // volta a numeração de pagina, alterada pela rotina "CABEC()"

// Renato F. Campos
// faz o controle de numeração de pagina
// as variaveis deverão ser declaradas no relatorio como private
   CtbQbPg( @lNewVars, @nPagIni, @nPagFim, @nReinicia, @m_pag, @nBloco, @nBlCount )
Endif

aCabec := { "",;
Left(Padc(AllTrim(SM0->M0_NOMECOM),nTam),nTam-Len(RptFolha+" "+TRANSFORM(m_pag,'999999')+ " "))+RptFolha+" "+TRANSFORM(m_pag,'999999')+ " ",;
Padc(Transform(Alltrim(SM0->M0_CGC),alltrim(SX3->X3_PICTURE)),nTam),;
Padc(Trim(Titulo),nTam),""}

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun??o ³CTR400Imp ³ Autor ³ Juscelino Alves dos SantosºData ³22/11/13º±±          
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri??o ³ Impressao do Razao ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe ³Ctr400Imp(lEnd,wnRel,cString,aSetOfBook,lCusto,lItem,; ³±±
±±³ ³ lCLVL,Titulo,nTamLinha,aCtbMoeda) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno ³Nenhum ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso ³ SIGACTB ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ lEnd - A?ao do Codeblock ³±±
±±³ ³ wnRel - Nome do Relatorio ³±±
±±³ ³ cString - Mensagem ³±±
±±³ ³ aSetOfBook - Array de configuracao set of book ³±±
±±³ ³ lCusto - Imprime Centro de Custo? ³±±
±±³ ³ lItem - Imprime Item Contabil? ³±±
±±³ ³ lCLVL - Imprime Classe de Valor? ³±±
±±³ ³ Titulo - Titulo do Relatorio ³±±
±±³ ³ nTamLinha - Tamanho da linha a ser impressa ³±±
±±³ ³ aCtbMoeda - Moeda ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CTR400Imp(lEnd,WnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,lAnalitico,Titulo,nTamlinha,aCtbMoeda,nTamConta,aSelFil)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aSaldo := {}
Local aSaldoAnt := {}
Local aColunas

Local cArqTmp
Local cSayCusto := CtbSayApro("CTT")
Local cSayItem := CtbSayApro("CTD")
Local cSayClVl := CtbSayApro("CTH")

Local cDescMoeda
Local cMascara1
Local cMascara2
Local cMascara3
Local cMascara4
Local cPicture
Local cSepara1 := ""
Local cSepara2 := ""
Local cSepara3 := ""
Local cSepara4 := ""
Local cSaldo := mv_par06
Local cContaIni := mv_par01
Local cContaFIm := mv_par02
Local cCustoIni := mv_par13
Local cCustoFim := mv_par14
Local cItemIni := mv_par16
Local cItemFim := mv_par17
Local cCLVLIni := mv_par19
Local cCLVLFim := mv_par20
Local cContaAnt := ""
Local cDescConta := ""
Local cCodRes := ""
Local cResCC := ""
Local cResItem := ""
Local cResCLVL := ""
Local cDescSint := ""
Local cMoeda := mv_par05
Local cContaSint := ""
Local cNormal := ""

Local dDataAnt := CTOD(" / / ")
Local dDataIni := mv_par03
Local dDataFim := mv_par04

Local lNoMov := Iif(mv_par09==1,.T.,.F.)
Local lSldAnt := Iif(mv_par09==3,.T.,.F.)
Local lJunta := Iif(mv_par10==1,.T.,.F.)
Local lSalto := Iif(mv_par21==1,.T.,.F.)
Local lFirst := .T.
Local lImpLivro := .t.
Local lImpTermos := .f.
Local lPrintZero := Iif(mv_par30==1,.T.,.F.)

Local nDecimais
Local nTotDeb := 0
Local nTotCrd := 0
Local nTotGerDeb := 0
Local nTotGerCrd := 0
Local nPagIni := mv_par22
Local nReinicia := mv_par24
Local nPagFim := mv_par23
Local nVlrDeb := 0
Local nVlrCrd := 0
Local nCont := 0
Local l1StQb := .T.
Local lQbPg := .F.
Local lEmissUnica := If(GetNewPar("MV_CTBQBPG","M") == "M",.T.,.F.) /// U=Quebra única (.F.) ; M=Multiplas quebras (.T.)
Local lNewPAGFIM := If(nReinicia > nPagFim,.T.,.F.)
Local LIMITE := If(TAMANHO=="G",220,If(TAMANHO=="M",132,80))
Local nInutLin := 1
Local nMaxLin := mv_par32

Local nBloco := 0
Local nBlCount := 0

Local lSldAntCta := Iif(mv_par33 == 1, .T.,.F.)
Local lSldAntCC := Iif(mv_par33 == 2, .T.,.F.)
Local lSldAntIt := Iif(mv_par33 == 3, .T.,.F.)
Local lSldAntCv := Iif(mv_par33 == 4, .T.,.F.)
Local cMoedaDesc := iif( Empty( mv_par34 ) , cMoeda , mv_par34)


lSalLin := If(mv_par31 ==1 ,.T.,.F.)
m_pag := 1

//If lEmissUnica
CtbQbPg(.T.,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb) /// FUNCAO PARA TRATAMENTO DA QUEBRA //.T. INICIALIZA VARIAVEIS
//Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
   Case mv_par29==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
   Case mv_par29==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
   Case mv_par29==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt := SPACE(10)
cbcont := 0
li := 80

cDescMoeda := Alltrim(aCtbMoeda[2])
nDecimais := DecimalCTB(aSetOfBook,cMoeda)

// Mascara da Conta
If Empty(aSetOfBook[2])
   cMascara1 := GetMv("MV_MASCARA")
Else
   cMascara1 := RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf

If lCusto .Or. lItem .Or. lCLVL
   // Mascara do Centro de Custo
   If Empty(aSetOfBook[6])
      cMascara2 := GetMv("MV_MASCCUS")
   Else
      cMascara2 := RetMasCtb(aSetOfBook[6],@cSepara2)
   EndIf

   // Mascara do Item Contabil
   If Empty(aSetOfBook[7])
      dbSelectArea("CTD")
      cMascara3 := ALLTRIM(STR(Len(CTD->CTD_ITEM)))
   Else
      cMascara3 := RetMasCtb(aSetOfBook[7],@cSepara3)
   EndIf

   // Mascara da Classe de Valor
   If Empty(aSetOfBook[8])
      dbSelectArea("CTH")
      cMascara4 := ALLTRIM(STR(Len(CTH->CTH_CLVL)))
   Else
      cMascara4 := RetMasCtb(aSetOfBook[8],@cSepara4)
   EndIf
EndIf

cPicture := aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulo do Relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("NewHead")== "U"
   IF lAnalitico
      Titulo := STR0007 //"RAZAO ANALITICO EM "
   Else
      Titulo := STR0008 //"RAZAO SINTETICO EM "
   EndIf
   Titulo += cDescMoeda //+ STR0009 + DTOC(dDataIni) +; // "DE"
   //STR0010 + DTOC(dDataFim) + CtbTitSaldo(mv_par06) // "ATE"
Else
   Titulo := NewHead
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Resumido ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// DATA DEBITO CREDITO SALDO ATUAL
// XX/XX/XXXX 99,999,999,999,999.99 99,999,999,999,999.99 99,999,999,999,999.99D
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cabe?alho Conta ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// DATA
// LOTE/SUB/DOC/LINHA H I S T O R I C O C/PARTIDA DEBITO CREDITO SALDO ATUAL"
// XX/XX/XXXX
// XXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX 9999999999999.99 9999999999999.99 9999999999999.99D
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
// 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cabe?alho Conta + CCusto + Item + Classe de Valor ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// DATA
// LOTE/SUB/DOC/LINHA H I S T O R I C O C/PARTIDA CENTRO CUSTO ITEM CLASSE DE VALOR DEBITO CREDITO SALDO ATUAL"
// XX/XX/XXXX
// XXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX 99,999,999,999,999.99 99,999,999,999,999.99 99,999,999,999,999.99D
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22

#DEFINE COL_NUMERO 1
#DEFINE COL_HISTORICO 2
#DEFINE COL_CONTRA_PARTIDA 3
#DEFINE COL_CENTRO_CUSTO 4
#DEFINE COL_ITEM_CONTABIL 5
#DEFINE COL_CLASSE_VALOR 6
#DEFINE COL_VLR_DEBITO 7
#DEFINE COL_VLR_CREDITO 8
#DEFINE COL_VLR_SALDO 9
#DEFINE TAMANHO_TM 10
#DEFINE COL_VLR_TRANSPORTE 11

If mv_par11 == 3 //// SE O PARAMETRO DO CODIGO ESTIVER PARA IMPRESSAO
   nTamConta := Len(CT1->CT1_CODIMP) //// USA O TAMANHO DO CAMPO CODIGO DE IMPRESSAO
Endif
If lAnalitico .And. (lCusto .Or. lItem .Or. lCLVL)
   nTamConta := 20 // Tamanho disponivel no relatorio para imprimir
EndIf
If ! lAnalitico
   aColunas := { 000, 019, , , , , 068, 090, 111, 19, 091 }
Else
   If ((!lCusto .And. !lItem .And. !lCLVL) .And. nTamConta<=22)
      aColunas := { 000, 019, 070, , , , 84, 100, 115, 15, 097}
   Else
     // aColunas := { 000, 019, 050, 082, 113, 134, 156, 178, 198, 20 ,178 }
     aColunas := { 000, 019, 050, 076, 102, 128, 154, 176, 196, 20 ,178 }

   Endif
Endif
If lAnalitico // Relatorio Analitico
   Cabec1 := STR0019 // "DATA"
   Cabec2 := ""
   If (!lCusto .And. !lItem .And. !lCLVL)
      If nTamConta <= 22
         Cabec2:= "LOTE/SUB/DOC/LINHA HISTORICO C/PARTIDA DEBITO CREDITO SALDO ATUAL"
      Else
         Cabec2 := STR0032 //LOTE/SUB/DOC/LINHA H I S T O R I C O C/PARTIDA DEBITO CREDITO SALDO ATUAL
      EndIf
   Else
      Cabec2 := STR0013 // "LOTE/SUB/DOC/LINHA H I S T O R I C O C/PARTIDA CENTRO CUSTO ITEM CLASSE DE VALOR DEBITO CREDITO SALDO ATUAL

      // impressão da descrição do custo
      If lCusto
         Cabec2 += Upper(cSayCusto)
      Else
         Cabec2 += Space( Len( cSayCusto ) )
      Endif

      Cabec2 += Space(16)

      // impressão da descrição do item
      If lItem
         Cabec2 += Upper(cSayItem)
      Else
         Cabec2 += Space( Len( cSayItem ) )
      Endif


      Cabec2 += Space(16)

      // impressão da descrição do clvl
      If lCLVL
         Cabec2 += Upper(cSayClVl)
      Else
         Cabec2 += Space( Len( cSayClVl ) )
      Endif

      // impressão dos totalizadores
      Cabec2 += Space(26) + STR0029
   EndIf
Else
   lCusto := .F.
   lItem := .F.
   lCLVL := .F.
   Cabec1 := STR0024 // "DATA DEBITO CREDITO SALDO ATUAL"
   Cabec2 := ""
EndIf

m_pag := mv_par22


//If lImpLivro
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({| oMeter, oText, oDlg, lEnd | ;
CTBGerRaz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
aSetOfBook,lNoMov,cSaldo,lJunta,"1",lAnalitico,,,,lSldAnt,aSelFil)},;
STR0018,; // "Criando Arquivo Tempor rio..."
STR0006) // "Emissao do Razao"

dbSelectArea("CT2")
If !Empty(dbFilter())
   dbClearFilter()
Endif
dbSelectArea("cArqTmp")
   
SetRegua(RecCount())
dbGoTop()      
   
_chistmp:=Space(20)
_chisnfe:=Space(20)
_cArqTRB:=CriaTrab(,.F.)
cArquivo	:= _cArqTRB + ".XLS"
cHTML		:= ""
Ferase(cArquivo)
nHdl := fCreate(cArquivo)
If nHdl == -1
   MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
   Return Nil
Endif
/////////////////////////////////
cHtml := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> '
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml"> '
cHtml += '<head> '
cHtml += '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> '
cHtml += '<title>Untitled Document</title> '
cHtml += '</head> '
cHtml += '<body> '
cHtml += '<table width="700" border="1"> '
cHtml += '  <tr> '
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Data</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Mês/Ano Contabilização</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Lote</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Sub Lote</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Doc</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Linha</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Historico</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Log de Registro</font></td>'   
cHtml += '     <td width="50%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Codigo Favorecido</font></td>'   
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Descrição Favorecido</font></td>'   
cHtml += '     <td width="30%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Tipo Lanc.</font></td>'   
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Conta</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Descrição</font></td>'
cHtml += '     <td width="30%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">X_Partida</font></td>'      
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Centro de Custo</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Descrição</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Item Contabil</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Descrição</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Classe de Valor</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Descrição</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Natureza</font></td>'
cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Descrição</font></td>'
cHtml += '     <td width="30%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Valor</font></td>'   
//cHtml += '     <td width="30%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Credito</font></td>'   
cHtml += '     <td width="30%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Saldo</font></td>'   
cHtml += '  </tr> '
fWrite(nHdl,cHTML,Len(cHTML))
cHtml := ''

dbGoTop() 
While .Not. Eof()
   
   If lSldAntCC
      aSaldo := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
      aSaldoAnt := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,aSelFil)
   ElseIf lSldAntIt
      aSaldo := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
      aSaldoAnt := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,aSelFil)
   ElseIf lSldAntCv
      aSaldo := SaldTotCTI(cClVlIni,cClVlFim,cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
      aSaldoAnt := SaldTotCTI(cClVlIni,cClVlFim,cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,aSelFil)
   Else
      aSaldo := SaldoCT7Fil(cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,,,,aSelFil)
      aSaldoAnt := SaldoCT7Fil(cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,"CTBR400",,,aSelFil)
   EndIf
      
   If !lNoMov //Se imprime conta sem movimento
      If aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0
         dbSelectArea("cArqTmp")
         dbSkip()
         Loop
      Endif
   Endif                                    

   If lNomov .And. aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0
      
      If CtbExDtFim("CT1")
         dbSelectArea("CT1")
         dbSetOrder(1)                                               
         If MsSeek(xFilial()+cArqTmp->CONTA)
            If !CtbVlDtFim("CT1",dDataIni)
               dbSelectArea("cArqTmp")
               dbSkip()
               Loop
            EndIf

            If !CtbVlDtIni("CT1",dDataFim)
               dbSelectArea("cArqTmp")
               dbSkip()
               Loop
            EndIf
         EndIf
         dbSelectArea("cArqTmp")
      EndIf
   EndIf
                 
   nSaldoAtu:= 0
   nTotDeb := 0
   nTotCrd := 0 
      
      
   nSaldoAtu := aSaldoAnt[6]
   nSaldoAtu := Iif(nSaldoAtu<0,Abs(nSaldoAtu),Iif(nSaldoAtu>0,nSaldoAtu*-1,0))
   dbSelectArea("cArqTmp")
   cContaAnt:= cArqTmp->CONTA
   dDataAnt := CTOD(" / / ")
   While cArqTmp->(!Eof()) .And. cArqTmp->CONTA == cContaAnt   
      
      
         nSaldoAtu := nSaldoAtu - cArqTmp->LANCCRD + cArqTmp->LANCDEB //nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD
         nTotDeb += cArqTmp->LANCDEB
         nTotCrd += cArqTmp->LANCCRD
         nTotGerDeb += cArqTmp->LANCDEB
         nTotGerCrd += cArqTmp->LANCCRD
        // If Alltrim(cArqTmp->FORCNPJ)="46392130000118"
        //    _lixo:="1111"
        // End
         cHtml := '    <tr>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Dtoc(cArqTmp->DATAL) +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ SubStr(Dtoc(cArqTmp->DATAL),4,2)+"/"+SubStr(Dtoc(cArqTmp->DATAL),7,2) +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->LOTE +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->SUBLOTE +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->DOC +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->LINHA +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->HISTORICO +'</font></td>'
	  		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->LOGUSU +'</font></td>'
			cHtml += '    <td width="50%" align="center"> <font face="Tahoma" size="1">'+ Iif(Len(cArqTmp->FORCNPJ)<15,chr(160)+cArqTmp->FORCNPJ+Space(15-Len(cArqTmp->FORCNPJ)),chr(160)+cArqTmp->FORCNPJ) +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->FORDESC +'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->TIPO +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->CONTA+'</font></td>'
            cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqTmp->DCONTA)+'</font></td>'			
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->XPARTIDA +'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->CCUSTO+'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqTmp->CCUSTO_DES)+'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->ITEM+'</font></td>'
            cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqTmp->ITEM_DES)+'</font></td>'	 		
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->CLVL+'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqTmp->CLVL_DES)+'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ cArqTmp->CODNAT+'</font></td>'
	 		cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqTmp->DESNAT)+'</font></td>'
	 		If !Empty(cArqTmp->LANCDEB)
	 		   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(cArqTmp->LANCDEB),cArqTmp->LANCDEB,0),"@E 9,999,999,999.99") +'</font></td>'
	 		Else   
	 		   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ '-'+Transform(Iif(!Empty(cArqTmp->LANCCRD),cArqTmp->LANCCRD,0),"@E 9,999,999,999.99") +'</font></td>'
	 		EndIf   
	 		cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+Transform(Iif(!Empty(nSaldoAtu),nSaldoAtu,0),"@E 9,999,999,999.99")+'</font></td>'
		cHtml += '    </tr> '
	
		fWrite(nHdl,cHTML,Len(cHTML))
		
		DbSkip()

   End-While                                               
      
End-While                                         
	

cHtml := '</table> '
cHtml += '</body> '                                                                 
cHtml += '</html> '     
		
fWrite(nHdl,cHTML,Len(cHTML))
		
fClose(nHdl)
   
CpyS2T( GetSrvProfString("StartPath","",GetAdv97()) + cArquivo, cPath, .T. )
ShellExecute("OPEN",cPath + cArquivo,"","",5)

Return