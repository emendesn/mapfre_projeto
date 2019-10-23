#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/08/00
//#include "INKEY.CH"
#INCLUDE "rec_pcl.CH"
#INCLUDE "avprint.CH"

User Function rec_pcl2()        // incluido pelo assistente de conversao do AP5 IDE em 30/08/00


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private  lIgual                 //Vari vel de retorno na compara‡ao do SRC
Private cArqNew                //Vari vel de retorno caso SRC #SX3
Private tamanho     := "P"
Private limite      := 80
Private aOrdBag     := {}
Private cMesArqRef  //:= If(Esc == 4,"13"+Right(cMesAnoRef,4),cMesAnoRef)
Private cArqMov     := ""
Private cAliasMov   := ""
Private _cArqPclFre := ""
Private _cArqPclVer := ""

SetPrvt("CSTRING,AORD,CDESC1,CDESC2,CDESC3,BASEAUX")
SetPrvt("CDEMIT,ARETURN,NOMEPROG,ALINHA,NLASTKEY,CPERG")
SetPrvt("CSEM_DE,CSEM_ATE,ALANCA,APROVE,ADESCO,ABASES")
SetPrvt("AINFO,ACODFOL,LI,TITULO,WNREL,NORDEM")
SetPrvt("-,NTIPREL,ESC,SEMANA,CFILDE,CFILATE")
SetPrvt("CCCDE,CCCATE,CMATDE,CMATATE,CNOMDE,CNOMATE")
SetPrvt("CHAPADE,CHAPAATE,MENSAG1,MENSAG2,MENSAG3,CSITUACAO")
SetPrvt("CCATEGORIA,CBASEAUX,CMESANOREF,TAMANHO,LIMITE,AORDBAG")
SetPrvt("CMESARQREF,CARQMOV,CALIASMOV,CACESSASR1,CACESSASRA,CACESSASRC")
SetPrvt("CACESSASRI,LATUAL,CARQNTX,CINDCOND,ADRIVER,CCOMPAC")
SetPrvt("CNORMAL,CINICIO,CFIM,TOTVENC,TOTDESC,FLAG")
SetPrvt("CHAVE,DESC_FIL,DESC_END,DESC_CC,DESC_FUNC,DESC_MSG1")
SetPrvt("DESC_MSG2,DESC_MSG3,CFILIALANT,CFUNCAOANT,CCCANT,VEZ")
SetPrvt("ORDEMZ,NATELIM,NBASEFGTS,NFGTS,NBASEIR,NBASEIRFE")
SetPrvt("ORDEM_REL,DESC_CGC,NCONTA,NCONTR,NCONTRT,NLINHAS")
SetPrvt("CDET,NCOL,NTERMINA,NCONT,NCONT1,NVALIDOS")
SetPrvt("NVALSAL,DESC_BCO,CCHAVESEM,DESC_PAGA,NPOS,CARRAY")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER030  ³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao de Recibos de Pagamento                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER030(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Kleber     ³13/05/99³xxxxxx³ SaveScreen somente em DOS.               ³±±
±±³ Kleber     ³19/05/99³20508A³ Alt. p/ Imprimir o Periodo da Semana.    ³±±
±±³ Kleber     ³26/05/99³------³ Tirar de uso a fun‡Æo REPORTINI.         ³±±
±±³ Kleber     ³20/07/99³------³ Chamada funcao Persemana() Somente Folha.³±±
±±³ Kleber     ³13/08/99³xxxxxx³ Carregar Semana Gravada Ano c/ 2 digitos.³±±
±±³            ³        ³      ³ na Funcao PerSemana().                   ³±±
±±³ Marina     ³17/01/00³001829³ Acerto Salario Base no recibo pagto. de  ³±±
±±³            ³        ³      ³ Movimentos Anteriores.                   ³±±
±±³ Marina     ³14/02/00³------³ Acerto do salario base no recibo de movi-³±±
±±³            ³        ³      ³ mentos anteriores para SQL.              ³±±
±±³ Emerson    ³16/05/00³------³ Substituicao de "Index On" por "IndRegua"³±±
±±³ Marina     ³05/06/00³------³ Acerto de nValSal qdo.nao ha aumento sa- ³±±
±±³            ³        ³      ³ larial.                                  ³±±
±±³ Marina     ³08/06/00³002841³ Quebrar pagina p/Rec.zebrado na linha 64.³±±
±±³ Marina     ³06/07/00³005015³ Considerar somente verba do Salario Base ³±± 
±±³            ³        ³      ³ na funcao fBuscaSlr.                     ³±±
±±³ Emerson    ³29/08/00³------³ Testar controle de acessos e fil. validas³±±
±±³            ³        ³------³ Imprimir mov anteriores a partir dDataRef³±±
±±³ Maam       ³01/11/01³------³ Transformar em impressao a Laser utilizan³±±
±±³            ³        ³------³ do padroes PLC                           ³±±
±±³ Maam       ³04/01/02³------³ Transformar de impressao a Laser utilizan³±±
±±³            ³        ³------³ do padroes PLC, para comandos avprint    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cString:="SRA"        // alias do arquivo principal (Base)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nExtra := 0
cIndCond := ""
cIndRc  := ""
Baseaux := "S"
cDemit := "N"
cMesAnoRef := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aLinha   := { },nLastKey := 0
Private cPerg    :="RECPCL"
Private cSem_De  := "  /  /    "
Private cSem_Ate := "  /  /    "
Private nAteLim , nBaseFgts , nFgts , nBaseIr , nBaseIrFe
/*
ValidPerg()
*/
Valid508()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aLanca := {}
Private aProve := {}
Private aDesco := {}
Private aBases := {}
Private aInfo  := {}
Private aCodFol:= {}
Private li     := 0
Private Titulo := STR0011               //"EMISSŽO DE RECIBOS DE PAGAMENTOS"
_nTotFunc      := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("RECPCL",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If LastKey() = 27 .Or. nLastKey = 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Data de Referencia para a impressao      ³
//³ mv_par02        //  Tipo de Recibo (Pre/Zebrado)             ³
//³ mv_par03        //  Emitir Recibos(Adto/Folha/1¦/2¦/V.Extra) ³
//³ mv_par04        //  Numero da Semana                         ³
//³ mv_par05        //  Filial De                                ³
//³ mv_par06        //  Filial Ate                               ³
//³ mv_par07        //  Centro de Custo De                       ³
//³ mv_par08        //  Centro de Custo Ate                      ³
//³ mv_par09        //  Matricula De                             ³
//³ mv_par10        //  Matricula Ate                            ³
//³ mv_par11        //  Nome De                                  ³
//³ mv_par12        //  Nome Ate                                 ³
//³ mv_par13        //  Chapa De                                 ³
//³ mv_par14        //  Chapa Ate                                ³
//³ mv_par15        //  Mensagem 1                               ³
//³ mv_par16        //  Mensagem 2                               ³
//³ mv_par17        //  Mensagem 3                               ³
//³ mv_par18        //  Situacoes a Imprimir                     ³
//³ mv_par19        //  Categorias a Imprimir                    ³
//³ mv_par20        //  Imprimir Bases                           ³
//³ mv_par21        //  Imprimir FRENTE/VERSO/AMBOS              ³
//³ mv_par22        //  Ordem                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("RECPCL",.T.)
dDataRef   := mv_par01
nTipRel    := mv_par02
Esc        := mv_par03
Semana     := mv_par04
cFilDe     := mv_par05
cFilAte    := mv_par06
cCcDe      := mv_par07
cCcAte     := mv_par08
cMatDe     := mv_par09
cMatAte    := mv_par10
cNomDe     := mv_par11
cNomAte    := mv_par12
ChapaDe    := mv_par13
ChapaAte   := mv_par14
Mensag1    := mv_par15
Mensag2    := mv_par16
Mensag3    := mv_par17
cSituacao  := mv_par18
cCategoria := mv_par19
cMesAnoRef := StrZero(Val(SubStr( DtoS(dDataRef),5,2) ),2)+StrZero( Val( SubStr( Dtos( dDataRef ),1,4 ) ) ,4) 
cMesArqRef := If(Esc == 4,"13"+Right(cMesAnoRef,4),cMesAnoRef)
cBaseAux   := If(mv_par20 == 1,"S","N")
_cTpImp    := If(mv_par21 == 1,"F",If(mv_par21 == 2,"V","A"))
nOrdem     := mv_par22

//cMesAnoRef := StrZero(Val(SubStr( DtoS(dDataRef),5,2) ),2)+StrZero( Val( SubStr( Dtos( dDataRef ),1,4 ) ) ,4) 

RptStatus({|lEnd| R030Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R030IMP  ³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao do Recibo                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R030IMP(lEnd,Wnrel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function R030Imp(lEnd,WnRel,cString,cMesAnoRef)
Static Function R030Imp(lEnd,WnRel,cString,cMesAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ       
AVPRINT oPrn NAME "Recibo de Pagamento"
oPrn:SetPortrait()
//                           Font                W  H  Bold          Underline Device
oFont1 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,09,,.F.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,09,,.T.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,20,,.T.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,15,,.F.,,,,,,,,,,,oPrn)  
oFont9 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  

aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8, oFont9 } 



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Verifica se existe o arquivo de fechamento do mes informado  |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lAtual := ( !fExistArq( cMesArqRef,,0 ) .And. MesAno(dDataRef) == MesAno(dDataBase) )


If !lAtual
	If !fIniArqMov( cMesArqRef, @cAliasMov , @aOrdBag , @cArqMov )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| Se nao encontrar o arquivo retorna o arquivo atual           |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    ChkFile( cAliasMov , .F. )
	    Return
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando a Ordem de impressao escolhida no parametro.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA")
If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
Elseif nOrdem == 4
	cArqNtx  := CriaTrab(NIL,.f.)
	cIndCond :="RA_Filial + RA_Chapa + RA_Mat"
	IndRegua("SRA",cArqNtx,cIndCond,,,STR0012)              //"Selecionando Registros..."
ElseIf nOrdem == 5
	dbSetOrder(8)
Endif
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando o Primeiro Registro e montando Filtro.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	dbSeek(cFilDe + cNomDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomAte + cMatAte
ElseIf nOrdem == 4
	dbSeek(cFilDe + ChapaDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_CHAPA + SRA->RA_MAT"
	cFim    := cFilAte + ChapaAte + cMatAte
ElseIf nOrdem == 5
	dbSeek(cFilDe + cCcDe + cNomDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME"
	cFim     := cFilAte + cCcAte + cNomAte
Endif

dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua Processamento                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())   // Total de elementos da regua



TOTVENC:= TOTDESC:= FLAG:= CHAVE := 0

Desc_Fil := Desc_End := DESC_CC:= DESC_FUNC:= ""
DESC_MSG1:= DESC_MSG2:= DESC_MSG3:= Space(01)
cFilialAnt := "  "
cFuncaoAnt := "    "
cCcAnt     := Space(9)
Vez        := 0
OrdemZ     := 0

dbSelectArea("SRA")
While !EOF() .And. &cInicio <= cFim
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()  // Anda a regua

	If lEnd    
	    li += 100
	    oPrn:Say( li,200,cCancel,oFont1 )
		Exit
	Endif    

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_CHAPA < ChapaDe) .Or. (SRA->Ra_CHAPa > ChapaAte) .Or. ;
		(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
		(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf

	aLanca:={}         // Zera Lancamentos
	aProve:={}         // Zera Lancamentos
	aDesco:={}         // Zera Lancamentos
	aBases:={}         // Zera Lancamentos
	nAteLim := nBaseFgts := nFgts := nBaseIr := nBaseIrFe := 0.00
	
	Ordem_rel := 1     // Ordem dos Recibos
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste situacao e categoria dos funcionarios                           |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( SRA->RA_SITFOLH $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	Endif
	If SRA->RA_SITFOLH $ "D" .And. Mesano(SRA->RA_DEMISSA) #Mesano(dDataRef)
		dbSkip()
		Loop
	Endif
    DESC_FUNC := DescFun(Sra->Ra_Codfunc,Sra->Ra_Filial)
	If SRA->RA_CODFUNC #cFuncaoAnt           // Descricao da Funcao
		DescFun(Sra->Ra_Codfunc,Sra->Ra_Filial)
		cFuncaoAnt:= Sra->Ra_CodFunc
	Endif
	DESC_CC := DescCC(Sra->Ra_Cc,Sra->Ra_Filial)
	If SRA->RA_CC #cCcAnt                   // Centro de Custo
		DescCC(Sra->Ra_Cc,Sra->Ra_Filial)
		cCcAnt:=SRA->RA_CC
	Endif
	
	If SRA->RA_Filial #cFilialAnt
		If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial) .Or. ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif
		Desc_Fil := aInfo[3]
		Desc_End := aInfo[4]                // Dados da Filial
		Desc_CGC := aInfo[8]
		DESC_MSG1:= DESC_MSG2:= DESC_MSG3:= Space(01)

		// MENSAGENS
		If MENSAG1 #SPACE(1)
			If FPHIST82(SRA->RA_FILIAL,"06",SRA->RA_FILIAL+MENSAG1)
				DESC_MSG1 := Left(SRX->RX_TXT,30)
			ElseIf FPHIST82(SRA->RA_FILIAL,"06","  "+MENSAG1)
				DESC_MSG1 := Left(SRX->RX_TXT,30)
			Endif
		Endif

		If MENSAG2 #SPACE(1)
			If FPHIST82(SRA->RA_FILIAL,"06",SRA->RA_FILIAL+MENSAG2)
				DESC_MSG2 := Left(SRX->RX_TXT,30)
			ElseIf FPHIST82(SRA->RA_FILIAL,"06","  "+MENSAG2)
				DESC_MSG2 := Left(SRX->RX_TXT,30)
			Endif
		Endif

		If MENSAG3 #SPACE(1)
			If FPHIST82(SRA->RA_FILIAL,"06",SRA->RA_FILIAL+MENSAG3)
				DESC_MSG3 := Left(SRX->RX_TXT,30)
			ElseIf FPHIST82(SRA->RA_FILIAL,"06","  "+MENSAG3)
				DESC_MSG3 := Left(SRX->RX_TXT,30)
			Endif
		Endif
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
	
	Totvenc := Totdesc := 0
	
	If Esc == 1 .OR. Esc == 2
		dbSelectArea("SRC")
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_MAT == SRA->RA_FILIAL+SRA->RA_MAT
				If SRC->RC_SEMANA #Semana
					dbSkip()
					Loop
				Endif
				If (Esc == 1) .And. (Src->Rc_Pd == aCodFol[7,1])      // Desconto de Adto
					fSomaPd("P",aCodFol[6,1],SRC->RC_HORAS,SRC->RC_VALOR)
					TOTVENC += Src->Rc_Valor
				Elseif (Esc == 1) .And. (Src->Rc_Pd == aCodFol[12,1])
					fSomaPd("D",aCodFol[9,1],SRC->RC_HORAS,SRC->RC_VALOR)
					TOTDESC += SRC->RC_VALOR
				Elseif (Esc == 1) .And. (Src->Rc_Pd == aCodFol[8,1])
					fSomaPd("P",aCodFol[8,1],SRC->RC_HORAS,SRC->RC_VALOR)
					TOTVENC += SRC->RC_VALOR
				Else
					If Val( SRC->RC_PD ) > 100 .And. Val( SRC->RC_PD ) < 400 
						If (Esc #1) .Or. (Esc == 1 .And. PosSrv(Src->Rc_Pd,Sra->Ra_Filial,"RV_ADIANTA") == "S")
							fSomaPd("P",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
							TOTVENC += Src->Rc_Valor
						Endif
					Elseif Val( SRC->RC_PD ) > 400 .And. Val( SRC->RC_PD ) < 700 
						If (Esc #1) .Or. (Esc == 1 .And. PosSrv(Src->Rc_Pd,Sra->Ra_Filial,"RV_ADIANTA") == "S")
							fSomaPd("D",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
							TOTDESC += Src->Rc_Valor
						Endif
					Elseif Val( SRC->RC_PD ) > 700 
						If (Esc #1) .Or. (Esc == 1 .And. PosSrv(Src->Rc_Pd,Sra->Ra_Filial,"RV_ADIANTA") == "S")
							fSomaPd("B",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
						Endif
					Endif
				Endif
				If ESC = 1
					If SRC->RC_PD == aCodFol[10,1]
						nBaseIr := SRC->RC_VALOR
					Endif
				ElseIf SRC->RC_PD == aCodFol[13,1]
					nAteLim += SRC->RC_VALOR
				Elseif SRC->RC_PD$ aCodFol[108,1]+'*'+aCodFol[17,1]
					nBaseFgts += SRC->RC_VALOR
				Elseif SRC->RC_PD$ aCodFol[109,1]+'*'+aCodFol[18,1]
					nFgts += SRC->RC_VALOR
				Elseif SRC->RC_PD == aCodFol[15,1]
					nBaseIr += SRC->RC_VALOR
				Elseif SRC->RC_PD == aCodFol[16,1]
					nBaseIrFe += SRC->RC_VALOR
				Endif
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
	Elseif Esc == 3
		dbSelectArea("SRC")
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
			While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT == SRC->RC_FILIAL + SRC->RC_MAT
				If SRC->RC_PD == aCodFol[22,1]
					fSomaPd("P",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
					TOTVENC += SRC->RC_VALOR
				Elseif SRC->RC_PD == aCodFol[172,1]
					fSomaPd("D",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
					TOTDESC += SRC->RC_VALOR
				Elseif SRC->RC_PD == aCodFol[108,1] .Or. SRC->RC_PD == aCodFol[109,1] .Or. SRC->RC_PD == aCodFol[173,1] 
					fSomaPd("B",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
				Endif
				
				If SRC->RC_PD == aCodFol[108,1]
					nBaseFgts := SRC->RC_VALOR
				Elseif SRC->RC_PD == aCodFol[109,1]
					nFgts     := SRC->RC_VALOR
				Endif
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
	Elseif Esc == 4
		dbSelectArea("SRI")
		dbSetOrder(2)
		If dbSeek(SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT)
			While !Eof() .And. SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT == SRI->RI_FILIAL + SRI->RI_CC + SRI->RI_MAT
			
				If Val( SRC->RC_PD ) > 100 .And. Val( SRC->RC_PD ) < 400 
				
					fSomaPd("P",SRI->RI_PD,SRI->RI_HORAS,SRI->RI_VALOR)
					TOTVENC = TOTVENC + SRI->RI_VALOR
					
				Elseif Val( SRC->RC_PD ) > 400 .And. Val( SRC->RC_PD ) < 700 
				
					fSomaPd("D",SRI->RI_PD,SRI->RI_HORAS,SRI->RI_VALOR)
					TOTDESC = TOTDESC + SRI->RI_VALOR
					
				Elseif Val( SRC->RC_PD ) > 700 
					fSomaPd("B",SRI->RI_PD,SRI->RI_HORAS,SRI->RI_VALOR)
				Endif

				If SRI->RI_PD == aCodFol[19,1]
					nAteLim += SRI->RI_VALOR
				Elseif SRI->RI_PD$ aCodFol[108,1]
					nBaseFgts += SRI->RI_VALOR
				Elseif SRI->RI_PD$ aCodFol[109,1]
					nFgts += SRI->RI_VALOR
				Elseif SRI->RI_PD == aCodFol[27,1]
					nBaseIr += SRI->RI_VALOR
				Endif
				dbSkip()
			Enddo
		Endif
	Elseif Esc == 5
		dbSelectArea("SR1")
		dbSetOrder(1)
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
			While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT ==      SR1->R1_FILIAL + SR1->R1_MAT
				If Semana #"99"                 
					If SR1->R1_SEMANA #Semana
						dbSkip()
						Loop
					Endif
				Endif                                   
				If Val( SRC->RC_PD ) > 100 .And. Val( SRC->RC_PD ) < 400 
					fSomaPd("P",SR1->R1_PD,SR1->R1_HORAS,SR1->R1_VALOR)
					TOTVENC = TOTVENC + SR1->R1_VALOR
				Elseif Val( SRC->RC_PD ) > 400 .And. Val( SRC->RC_PD ) < 700 
					fSomaPd("D",SR1->R1_PD,SR1->R1_HORAS,SR1->R1_VALOR)
					TOTDESC = TOTDESC + SR1->R1_VALOR
				Elseif Val( SRC->RC_PD ) > 700 
					fSomaPd("B",SR1->R1_PD,SR1->R1_HORAS,SR1->R1_VALOR)
				Endif
				dbskip()
			Enddo
		Endif
	Endif
	
	dbSelectArea("SRA")
	
	If TOTVENC = 0 .And. TOTDESC = 0
		dbSkip()
		Loop
	Endif
	
	If Vez == 0  .And.  Esc == 2 //--> Verifica se for FOLHA.
		PerSemana() // Carrega Datas referentes a Semana.
	EndIf
	
	If nTipRel == 1
		fImpressao()   // Impressao do Recibo de Pagamento
	Endif
	/*
	Verificar real necessidade para impressao na laser
	*/
	If Vez = 0
		Pergunte("GPR30A",.T.)
		If mv_par01 = 2 // Este mv_par e da "Pergunte" GPR30A" 
			dbSelectArea("SRA")
			TOTDESC := TOTVENC := 0
			LOOP
		ENDIF
		Vez = 1
	ENDIF
	dbSelectArea("SRA")
	dbSkip()
	TOTDESC := TOTVENC := 0
ENDDO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lAtual
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRC")
dbSetOrder(1)          // Retorno a ordem 1
dbSelectArea("SRI")
dbSetOrder(1)          // Retorno a ordem 1               

dbSelectArea("SRA")
SET FILTER TO
RetIndex("SRA")

If !(Type("cArqNtx") == "U")
	fErase(cArqNtx + OrdBagExt())
Endif
AvEndPrint

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fImpressao³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO DO RECIBO FORMULARIO CONTINUO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpressao()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fImpressao()
Static Function fImpressao()

Local nConta  := nContr := nContrT:=0
Local aDriver := LEDriver()
_nSomLin := 1010

/*                 
Foi alterado de 16 para 28, pois o miolo na laser é maior
Private nLinhas:=16              // Numero de Linhas do Miolo do Recibo
*/
Private nLinhas:=28              // Numero de Linhas do Miolo do Recibo
If  _cTpImp == "A" //Imprime frente e verso
        AVNEWPAGE
        fBFrentV()
		Ordem_Rel := 1
		fCabec() 
		AvEndPage
        AVNEWPAGE
        fBoxVerso()
		fCabecV()
		li:= 855
		For nConta = 1 To Len(aLanca)
			fLanca(nConta)
			nContr ++
			nContrT ++
			If nContr = nLinhas .And. nContrT < Len(aLanca)
				nContr:=0
				Ordem_Rel ++
				fContinua()
				fCabec()
			Endif 
		Next
		Li+=(nLinhas-nContr)
		Li+=3
		fRodape()
		Li+=6
		AvEndPage                        
ElseIf _cTpImp == "V" //imprime o verso frente do recibo com o dados
        AVNEWPAGE
        //Box para o verso
        fBoxVerso()
		Ordem_Rel := 1
		//fCabec()
		fCabecV()
		li:= 855
		For nConta = 1 To Len(aLanca)
			fLanca(nConta)
			nContr ++
			nContrT ++
			If nContr = nLinhas .And. nContrT < Len(aLanca)
				nContr:=0
				Ordem_Rel ++
				fContinua()
				fCabec()
			Endif 
		Next
		Li+=(nLinhas-nContr)
		Li+=3
		fRodape()
		Li+=6   
		AvEndPage                        
ElseIf  _cTpImp == "F" // Imprime a frente do recibo vazia para colocar a etiqueta
        AvNewPage
        fBoxFrent()                      
        AvEndPage                        
EndIf
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabec    ³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO Cabe‡alho Form Continuo                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCabec()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fCabec()   // Cabecalho do Recibo
Static Function fCabec()   // Cabecalho do Recibo()

LI ++
If !Empty(Semana) .And. Semana #'99' .And.  Upper(SRA->RA_TIPOPGT) == 'S'
	_cDescSem := STR0013 + Semana + ' (' + cSem_De + STR0014 + ;    //'Semana '###' a '
		    cSem_Ate + ')'
Else
	_cDescSem := MesExtenso(MONTH(dDataRef))+"/"+STR(YEAR(dDataRef),4)
EndIf   
oPrn:Say(0480,0130,DESC_Fil    ,oFont1,,,,3)
oPrn:Say(0480,1905,_cDescSem   ,oFont1,,,,3)
oPrn:Say(0580,0130,DESC_END    ,oFont1,,,,3)
oPrn:Say(0680,0130,SubStr(DESC_CGC,1,2)+"."+SubStr(DESC_CGC,3,3)+"."+SubStr(DESC_CGC,6,3)+;
       	       "/"+SubStr(DESC_CGC,9,4)+"-"+SubStr(DESC_CGC,13,2),oFont1,,,,3)
oPrn:Say(0780,0130,SRA->RA_CC  ,oFont1,,,,3)
oPrn:Say(0880,0130,DESC_CC     ,oFont1,,,,3)
oPrn:Say(0980,0130,SRA->RA_MAT ,oFont1,,,,3)
oPrn:Say(0980,0430,SRA->RA_NOME,oFont1,,,,3)
/*
@ LI,00 PSAY _cIniCab1+DESC_Fil+Space( 70 ) +_cDescSem + _cFimCab1 
LI+=2 
@ LI,09 PSAY DESC_END
LI+=3 
@ LI,09 PSAY  SubStr(DESC_CGC,1,2)+"."+SubStr(DESC_CGC,3,3)+"."+SubStr(DESC_CGC,6,3)+;
	       "/"+SubStr(DESC_CGC,9,4)+"-"+SubStr(DESC_CGC,13,2)
LI+=2 
@ LI,09 PSAY SRA->RA_CC 
LI+=2 
@ LI,09 PSAY DESC_CC
LI+=2 
//@ LI,09 PSAY SRA->RA_MAT + Space(08) + SRA->RA_NOME + _cFimLin1
@ LI,09 PSAY SRA->RA_MAT + Space(08) + SRA->RA_NOME 
LI++
@ LI,01 PSAY + _cFimLin1
//Li++ 
*/
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabecV    ³ Autor ³ Maam                 ³ Data ³ 01.11.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO Cabe‡alho na impressora laser                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCabecV()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fCabec()   // Cabecalho do Recibo
Static Function fCabecV()   // Cabecalho do Recibo()
LI ++
If !Empty(Semana) .And. Semana #'99' .And.  Upper(SRA->RA_TIPOPGT) == 'S'
	_cDescSem := STR0013 + Semana + ' (' + cSem_De + STR0014 + ;    //'Semana '###' a '
		    cSem_Ate + ')'
Else
	_cDescSem := SubStr(MesExtenso( MONTH(dDataRef) ),1,3)+"/"+STR(YEAR(dDataRef),4)
EndIf   
oPrn:Say(0480,0120,DESC_Fil,oFont1,,,,3)
oPrn:Say(0480,1080,SubStr(DESC_CGC,1,2)+"."+SubStr(DESC_CGC,3,3)+"."+SubStr(DESC_CGC,6,3)+;
	     "/"+SubStr(DESC_CGC,9,4)+"-"+SubStr(DESC_CGC,13,2),oFont1,,,,3)                   
oPrn:Say(0480,1565,_cDescSem,oFont1,,,,3)
If !lAtual
	nValSal := 0
	fBuscaSlr(@nValSal,MesAno(dDataRef))
	If nValSal ==0
		nValSal := SRA->RA_SALARIO
	EndIf
Else
	nValSal := SRA->RA_SALARIO
EndIf
oPrn:Say(0630,0130,SRA->RA_MAT ,oFont1,,,,3)
oPrn:Say(0630,0550,SRA->RA_NOME,oFont1,,,,3)
oPrn:Say(0630,1955,TransForm( nValSal , "@E 999,999,999.99" ),oFont1,,,,3)
oPrn:Say(0740,0130,SRA->RA_CC,oFont1,,,,3)
oPrn:Say(0740,0730,DESC_CC   ,oFont1,,,,3)
oPrn:Say(0740,1330,DESC_FUNC ,oFont1,,,,3)
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fLanca    ³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao das Verbas (Lancamentos) Form. Continuo          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fLanca()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fLanca(nConta)   // Impressao dos Lancamentos
Static Function fLanca(nConta)   // Impressao dos Lancamentos()

Local cString := Transform(aLanca[nConta,5],"@E 99,999,999.99")
Local nCol := If(aLanca[nConta,1]="P",1275,If(aLanca[nConta,1]="D",1865,227))
Li+=50
oPrn:Say(li,0130,aLanca[nConta,2],oFont1,,,,3)
oPrn:Say(li,0330,aLanca[nConta,3],oFont1,,,,3)

If aLanca[nConta,1] #"B"        // So Imprime se nao for base
    oPrn:Say(li,0975,TRANSFORM(aLanca[nConta,4],"999.99"),oFont1,,,,3)
Endif
oPrn:Say(li,ncol,cString,oFont1,,,,3)
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fContinua ³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressap da Continuacao do Recibo                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fContinua()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fContinua()    // Continuacao do Recibo
Static Function fContinua()    // Continuacao do Recibo()

Li+=1   
   oPrn:Say(2670,0225,STR0037,oFont1,,,,3)
Li+=8
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fRodape   ³ Autor ³ R.H. - Ze Maria       ³ Data ³ 14.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do Rodape                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fRodape()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fRodape()    // Rodape do Recibo
Static Function fRodape()    // Rodape do Recibo()
_nValAdt13 := If(SRF->(dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)),SRF->RF_PAR13AT,0.00)
If Esc = 1  // Bases de Adiantamento
/*
    If cBaseAux = "S" .And. nBaseIr #0
    
		@ LI,00 PSAY _cLinRod1 + nBaseFgts PICTURE "@E 999,999,999.99";
	@ Li,04 PSAY TransForm( 0.00,"@E 999,999,999.99" )
	@ Li,29 PSAY TransForm( 0.00,"@E 999,999,999.99" )
	@ Li,49 PSAY TOTVENC PICTURE "@E 999,999,999.99"
	@ Li,69 PSAY TOTDESC PICTURE "@E 999,999,999.99" 
	Li+=1
	@ LI,69 PSAY TOTVENC - TOTDESC PICTURE "@E 999,999,999.99" 
    Endif
*/
ElseIf Esc = 2 .Or. Esc = 4  // Bases de Folha e 13o. 2o.Parc.

	If cBaseAux = "S"
       oPrn:Say(2305,0105,Transform(nBaseFgts,"@E 999,999,999.99"),oFont1,,,,3)
	   oPrn:Say(2305,0612,Transform(nAteLim,"@E 999,999,999.99")  ,oFont1,,,,3)	
       oPrn:Say(2305,1240,Transform(TOTVENC  ,"@E 999,999,999.99"),oFont1,,,,3)	   
       oPrn:Say(2305,1715,Transform(TOTDESC  ,"@E 999,999,999.99"),oFont1,,,,3)       
	   
       oPrn:Say(2400,0105,Transform(nFgts    ,"@E 999,999,999.99"),oFont1,,,,3)
	   oPrn:Say(2400,0612,Transform(nBaseIr  ,"@E 999,999,999.99")  ,oFont1,,,,3)	
	   oPrn:Say(2400,1240,Transform(StrZero( Val(SRA->RA_DEPIR),2 ),"@E 99"),oFont1,,,,3)	
       oPrn:Say(2400,1715,Transform(TOTVENC - TOTDESC ,"@E 999,999,999.99"),oFont1,,,,3)       

       oPrn:Say(2500,0105,TransForm( 0.00,"@E 999,999,999.99" ),oFont1,,,,3)
       oPrn:Say(2500,1715,TransForm( _nValAdt13,"@E 999,999,999.99" ),oFont1,,,,3)
       
	   oPrn:Say(2600,0105,SubStr( SRA->RA_BCDEPSA ,1,3),oFont1,,,,3)
	   oPrn:Say(2600,0612,SubStr( SRA->RA_BCDEPSA ,4,5),oFont1,,,,3)
	   oPrn:Say(2600,1240,SRA->RA_CTDEPSA,oFont1,,,,3)
	   oPrn:Say(2600,1795,Dtoc( dDataRef ),oFont1,,,,3)
	Endif                                                          
li+=1
DESC_MSG0:= ""
MESCOMP = IIF(MONTH(dDataRef) + 1 > 12,01,MONTH(dDataRef))
IF MESCOMP = MONTH(SRA->RA_NASC)
    DESC_MSG0:="F E L I Z   A N I V E R S A R I O  ! !"
ENDIF
oPrn:Say(2710,0400,DESC_MSG0,oFont1,,,,3)
oPrn:Say(2760,0400,DESC_MSG1+Space(01)+DESC_MSG2+Space(01)+DESC_MSG3,oFont1,,,3)
EndIf
Return Nil

********************
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Function PerSemana() // Pesquisa datas referentes a semana.
Static Function PerSemana() // Pesquisa datas referentes a semana.()
********************

If !Empty(Semana) 
	cChaveSem := StrZero(Year(dDataRef),4)+StrZero(Month(dDataRef),2)+SRA->RA_TNOTRAB
	If !Srx->(dbSeek(If(cFilial=="  ","  ",SRA->RA_FILIAL) + "01" + cChaveSem + Semana , .T. )) .And. ;
		!Srx->(dbSeek(If(cFilial=="  ","  ",SRA->RA_FILIAL) + "01" + Subs(cChaveSem,3,9) + Semana , .T. )) .And. ;
		!Srx->(dbSeek(If(cFilial=="  ","  ",SRA->RA_FILIAL) + "01" + Left(cChaveSem,6)+"999"+ Semana , .T. )) .And. ;
		!Srx->(dbSeek(If(cFilial=="  ","  ",SRA->RA_FILIAL) + "01" + Subs(cChaveSem,3,4)+"999"+ Semana , .T. )) .And. ;
		HELP( " ",1,"SEMNAOCAD" )
		Return Nil
	Endif
	
	If Len(AllTrim(SRX->RX_COD)) == 9
		cSem_De  := Transforma(CtoD(Left(SRX->RX_TXT,8)))
		cSem_Ate := Transforma(CtoD(Subs(SRX->RX_TXT,10,8)))
	Else
	   cSem_De  := Transforma(If("/" $ SRX->RX_TXT , CtoD(SubStr( SRX->RX_TXT, 1,10)) , StoD(SubStr( SRX->RX_TXT, 1,8 ))))
	   cSem_Ate := Transforma(If("/" $ SRX->RX_TXT , CtoD(SubStr( SRX->RX_TXT, 12,10)), StoD(SubStr( SRX->RX_TXT,12,8 ))))
	EndIf
EndIf   

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fSomaPd   ³ Autor ³ R.H. - Mauro          ³ Data ³ 24.09.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Somar as Verbas no Array                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fSomaPd(Tipo,Verba,Horas,Valor)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fSomaPd(cTipo,cPd,nHoras,nValor)
Static Function fSomaPd(cTipo,cPd,nHoras,nValor)

Local Desc_paga

Desc_paga := DescPd(cPd,Sra->Ra_Filial)  // mostra como pagto

If cTipo #'B'
    //--Array para Recibo Pre-Impresso
    nPos := Ascan(aLanca,{ |X| X[2] = cPd })
    If nPos == 0
	Aadd(aLanca,{cTipo,cPd,Desc_Paga,nHoras,nValor})
    Else
       aLanca[nPos,4] += nHoras
       aLanca[nPos,5] += nValor
    Endif
Endif

//--Array para o Recibo Pre-Impresso
If cTipo = 'P'
   cArray := "aProve"
Elseif cTipo = 'D'
   cArray := "aDesco"
Elseif cTipo = 'B'
   cArray := "aBases"
Endif

nPos := Ascan(&cArray,{ |X| X[1] = cPd })
If nPos == 0
    Aadd(&cArray,{cPd+" "+Desc_Paga,nHoras,nValor })
Else
    &cArray[nPos,2] += nHoras
    &cArray[nPos,3] += nValor
Endif
Return

*-------------------------------------------------------
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function Transforma(dData) //Transforma as datas no formato DD/MM/AAAA
Static Function Transforma(dData) //Transforma as datas no formato DD/MM/AAAA()
*-------------------------------------------------------
Return(StrZero(Day(dData),2) +"/"+ StrZero(Month(dData),2) +"/"+ Right(Str(Year(dData)),4))

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBoxVerso ³ Autor ³ R.H. - MAAM           ³ Data ³ 05.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir o Box para que os dados sejam impressos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fBoxVerso()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fBoxVerso()
/*
#INCLUDE "rwmake.ch"
#INCLUDE  "avprint.ch"
AVPRINT oPrn NAME "BOX VERSO"
oPrn:SetPortrait()       
oFont1 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,10,,.T.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,09,,.T.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,14,,.F.,,,,,,,,,,,oPrn)  
oFont9 := oSend(TFont(),"New","Verdana"          ,0,15,,.T.,,,,,,,,,,,oPrn)  

aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8, oFont9 } 
AvNewPage
*/
oSend(oPrn,"SayBitmap", 0200,0100,"CESVI.BMP",0450,0200 ) // Logotipo
oPrn:Say(0330,0700,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont9,,,,3)
// Box da Primeira Linha de dados - Empresa
oPrn:Box(0430,0100,0530,1075)
oPrn:Box(0430,1075,0530,1555)
oPrn:Box(0430,1555,0530,1940)
oPrn:Box(0430,1940,0530,2250) 
oPrn:Say(0435,0105,"Empresa" ,oFont3,,,,3)
oPrn:Say(0435,1080,"CNPJ"    ,oFont3,,,,3)
oPrn:Say(0435,1560,"Mes Ref.",oFont3,,,,3)
oPrn:Say(0435,1945,"Seq."    ,oFont3,,,,3)

// Box da Segunda Linha de dados - Matricula
oPrn:Box(0580,0100,0680,0520)
oPrn:Box(0580,0520,0680,1830)
oPrn:Box(0580,1830,0680,2250)
oPrn:Say(0585,0105,"Matricula"   ,oFont3,,,,3)
oPrn:Say(0585,0525,"Nome"        ,oFont3,,,,3)
oPrn:Say(0585,1835,"Salario Base",oFont3,,,,3)

//Box da Terceira Linha de dados - Centro de Custo
oPrn:Box(0690,0100,0790,0700)
oPrn:Box(0690,0700,0790,1250)
oPrn:Box(0690,1250,0790,2250)
oPrn:Say(0695,0105,"Centro de Custo",oFont3,,,,3)
oPrn:Say(0695,0705,"Secao"          ,oFont3,,,,3)
oPrn:Say(0695,1255,"Funcao"         ,oFont3,,,,3)

//Box com cabecalho das verbas
oPrn:Box(0800,0100,0900,0300)
oPrn:Box(0800,0300,0900,0920)
oPrn:Box(0800,0920,0900,1120)
oPrn:Box(0800,1120,0900,1660)
oPrn:Box(0800,1660,0900,2250)
oPrn:Say(0805,0105,"Evento"   ,oFont3,,,,3)
oPrn:Say(0805,0305,"Descricao",oFont3,,,,3)
oPrn:Say(0805,0925,"Ref"      ,oFont3,,,,3)
oPrn:Say(0805,1125,"Proventos",oFont3,,,,3)
oPrn:Say(0805,1665,"Descontos",oFont3,,,,3)


//Box para preenchimento das verbas
oPrn:Box(0900,0100,2250,0300)
oPrn:Box(0900,0300,2250,0920)
oPrn:Box(0900,0920,2250,1120)
oPrn:Box(0900,1120,2250,1660)
oPrn:Box(0900,1660,2250,2250)

//Rodade para as bases
oPrn:Box(2250,0100,2350,0507)
oPrn:Box(2250,0507,2350,1084)
oPrn:Box(2250,1084,2350,1690)
oPrn:Box(2250,1690,2350,2250)
oPrn:Say(2255,0105,"Base para FGTS"      ,oFont3,,,,3)
oPrn:Say(2255,0512,"Sal.Cont.Inss"       ,oFont3,,,,3)
oPrn:Say(2255,1089,"Total de Vencimentos",oFont3,,,,3)
oPrn:Say(2255,1695,"Total de Descontos"  ,oFont3,,,,3)

oPrn:Box(2350,0100,2450,0507)
oPrn:Box(2350,0507,2450,1084)
oPrn:Box(2350,1084,2450,1690)
oPrn:Box(2350,1690,2450,2250)
oPrn:Say(2355,0105,"Fgts do Mes"     ,oFont3,,,,3)
oPrn:Say(2355,0512,"Base Ir"         ,oFont3,,,,3)
oPrn:Say(2355,1089,"Dep Ir"          ,oFont3,,,,3)
oPrn:Say(2355,1695,"Liquido a Receber",oFont3,,,,3)

oPrn:Box(2450,0100,2550,0507)
oPrn:Box(2450,0507,2550,1084)
oPrn:Box(2450,1084,2550,1690)
oPrn:Box(2450,1690,2550,2250)
oPrn:Say(2455,0105,"Saldo FGTS Banco"   ,oFont3,,,,3)
oPrn:Say(2455,0512,"Cap.Seg.Vida-Func"  ,oFont3,,,,3)
oPrn:Say(2455,1089,"Cap.Seg.Vida-Conj"  ,oFont3,,,,3)
oPrn:Say(2455,1695,"Adto.13 Sal. no Ano",oFont3,,,,3)

oPrn:Box(2550,0100,2650,0507)
oPrn:Box(2550,0507,2650,1084)
oPrn:Box(2550,1084,2650,1690)
oPrn:Box(2550,1690,2650,2250)
oPrn:Say(2555,0105,"Banco Pagamento"   ,oFont3,,,,3)
oPrn:Say(2555,0512,"Agencia Bancaria"  ,oFont3,,,,3)
oPrn:Say(2555,1089,"Conta Corrente"    ,oFont3,,,,3)
oPrn:Say(2555,1695,"Data do Credito"   ,oFont3,,,,3)

//Box da mensagem
oPrn:Say(2660,0100,"Observações:",oFont3,,,,3)
oPrn:Box(2660,0360,2860,2250)

/*
AvEndPage                        
AvEndPrint
*/

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBoxFrent ³ Autor ³ R.H. - MAAM           ³ Data ³ 05.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir o Box para que os dados sejam impressos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fBoxFrent()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fBoxFrent()
/*
#INCLUDE "rwmake.ch"
#INCLUDE  "avprint.ch"
AVPRINT oPrn NAME "BOX FRENTE"
oPrn:SetPortrait()       
oFont1 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,12,,.T.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,09,,.T.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,14,,.F.,,,,,,,,,,,oPrn)  
oFont9 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8, oFont9 } 
AvNewPage                                     
*/
oPrn:Say(0020,0900,"CONFIDENCIAL",oFont5,,,,3)
oSend(oPrn,"SayBitmap", 0200,0100,"CESVI.BMP",0450,0200 ) // Logotipo
oPrn:Say(0370,1020,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont7,,,,3)
// Box para colar a etiqueta
oPrn:Box(0430,0100,1030,2250)
oPrn:Box(1040,0100,3150,2250)

// Preenchimento do achurado com confidencial                        
_nCont := 1045
For iaCont := 1 to 42
    oPrn:Say(_nCont,0100,Replicate("CONFIDENCIAL ",7)+"CONFIDENCIAL",oFont2,,,,3)
    _nCont += 50
Next iaCont
/*
AvEndPage                        
AvEndPrint
*/
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBFrentV ³ Autor ³ R.H. - MAAM           ³ Data ³ 05.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir o Box para que os dados sejam impressos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fBoxFrent()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fBFrentV()
/*
#INCLUDE "rwmake.ch"
#INCLUDE  "avprint.ch"
AVPRINT oPrn NAME "BOX FRENTE"
oPrn:SetPortrait()       
oFont1 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,12,,.T.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,09,,.T.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,14,,.F.,,,,,,,,,,,oPrn)  
oFont9 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8, oFont9 } 
AvNewPage                                     
*/
oPrn:Say(0020,0900,"CONFIDENCIAL",oFont5,,,,3)
oSend(oPrn,"SayBitmap", 0200,0100,"CESVI.BMP",0450,0200 ) // Logotipo
oPrn:Say(0370,1020,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont7,,,,3)
// Box para colar a etiqueta
oPrn:Box(0430,0100,0530,1900)
oPrn:Box(0430,1900,0530,2250)
oPrn:Box(0530,0100,0630,2250)
oPrn:Box(0630,0100,0730,2250)
oPrn:Box(0730,0100,0830,2250)
oPrn:Box(0830,0100,0930,2250)
oPrn:Box(0930,0100,1030,0400)
oPrn:Box(0930,0400,1030,1800)
oPrn:Box(0930,1800,1030,2250)

oPrn:Say(0435,0105,"Empresa "           ,oFont3,,,,3)
oPrn:Say(0435,1905,"Mes Ref."           ,oFont3,,,,3)
oPrn:Say(0535,0105,"Endereco"           ,oFont3,,,,3)
oPrn:Say(0635,0105,"CNPJ"               ,oFont3,,,,3)
oPrn:Say(0735,0105,"Secao"              ,oFont3,,,,3)
oPrn:Say(0835,0105,"Centro Custo"       ,oFont3,,,,3)
oPrn:Say(0935,0105,"Matricula"          ,oFont3,,,,3)
oPrn:Say(0935,0405,"Nome do Funcionario",oFont3,,,,3)
oPrn:Say(0935,1805,"Seq"                ,oFont3,,,,3)

oPrn:Box(1040,0100,3150,2250)

// Preenchimento do achurado com confidencial                        
_nCont := 1045
For iaCont := 1 to 42
    oPrn:Say(_nCont,0100,Replicate("CONFIDENCIAL ",7)+"CONFIDENCIAL",oFont2,,,,3)
    _nCont += 50
Next iaCont
/*
AvEndPage                        
AvEndPrint
*/
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ AP5 IDE            º Data ³  01/11/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg  := PADR(cPerg,len(sx1->x1_grupo))

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
"GPR030","01","Data de Referˆncia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""
"GPR030","02","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""
"GPR030","03","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1¦Parc.","","","2¦Parc.","","","Val.Extras","","",""
"GPR030","04","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""
"GPR030","05","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""
"GPR030","06","Filial At‚         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""
"GPR030","07","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""
"GPR030","08","Centro de Custo At‚?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""
"GPR030","09","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""
"GPR030","10","Matricula At‚      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""
"GPR030","11","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""
"GPR030","12","Nome At‚           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""
"GPR030","13","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""
"GPR030","14","Chapa At‚          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""
"GPR030","15","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""
"GPR030","16","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""
"GPR030","17","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""
"GPR030","18","Situa‡”es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""
"GPR030","19","Categorias a Imp.  ?","mv_chj","C",10,0,0,"G","fCategoria","mv_par19","","CDHMST","","","","","","","","","","","","","",""
"GPR030","20","Imprime Bases      ?","mv_chk","C",1,0,1,"C","","mv_par20","Sim","","","Nao","","","","","","","","","","","",""
"GPR030","21","Imprimir           ?","mv_chl","C",1,0,1,"C","","mv_par21","Frente","","","Verso","","","","","","","","","","","",""
"GPR030","22","Ordem              ?","mv_chm","C",1,0,1,"C","","mv_par22","Matric","","","C.Custo","","","Nome","","","Chapa","","","CC+Nome","","",""
//"Matricula"###"C.Custo"###"Nome"###"Chapa"###"C.Custo + Nome"
*/
aAdd(aRegs,{cPerg,"01","Data de Referˆncia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1¦Parc.","","","2¦Parc.","","","Val.Extras","","",""})
aAdd(aRegs,{cPerg,"04","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"06","Filial At‚         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"07","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"08","Centro de Custo At‚?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"09","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"10","Matricula At‚      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"11","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Nome At‚           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Chapa At‚          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18","Situa‡”es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"19","Categorias a Imp.  ?","mv_chj","C",10,0,0,"G","fCategoria","mv_par19","","CDHMST","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"20","Imprime Bases      ?","mv_chk","C",1,0,1,"C","","mv_par20","Sim","","","Nao","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"21","Imprimir           ?","mv_chl","C",1,0,1,"C","","mv_par21","Frente","","","Verso","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"22","Ordem              ?","mv_chm","C",1,0,1,"C","","mv_par22","Matric","","","C.Custo","","","Nome","","","Chapa","","","CC+Nome","","",""})

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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALID508  º Autor ³ AP5 IDE            º Data ³  01/11/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Valid508

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg  := PADR(cPerg,len(sx1->x1_grupo))

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
"GPR030","01","Data de Referˆncia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""
"GPR030","02","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""
"GPR030","03","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1¦Parc.","","","2¦Parc.","","","Val.Extras","","",""
"GPR030","04","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""
"GPR030","05","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""
"GPR030","06","Filial At‚         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""
"GPR030","07","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""
"GPR030","08","Centro de Custo At‚?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""
"GPR030","09","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""
"GPR030","10","Matricula At‚      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""
"GPR030","11","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""
"GPR030","12","Nome At‚           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""
"GPR030","13","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""
"GPR030","14","Chapa At‚          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""
"GPR030","15","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""
"GPR030","16","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""
"GPR030","17","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""
"GPR030","18","Situa‡”es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""
"GPR030","19","Categorias a Imp.  ?","mv_chj","C",10,0,0,"G","fCategoria","mv_par19","","CDHMST","","","","","","","","","","","","","",""
"GPR030","20","Imprime Bases      ?","mv_chk","C",1,0,1,"C","","mv_par20","Sim","","","Nao","","","","","","","","","","","",""
"GPR030","21","Imprimir           ?","mv_chl","C",1,0,1,"C","","mv_par21","Frente","","","Verso","","","","","","","","","","","",""
"GPR030","22","Ordem              ?","mv_chm","C",1,0,1,"C","","mv_par22","Matric","","","C.Custo","","","Nome","","","Chapa","","","CC+Nome","","",""
//"Matricula"###"C.Custo"###"Nome"###"Chapa"###"C.Custo + Nome"
*/
aAdd(aRegs,{cPerg,"01","Data de Referˆncia ?","Data de Referˆncia ?","Data de Referˆncia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Pre Impr./Zebrado  ?","Pre Impr./Zebrado  ?","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Imprimir Recibos   ?","Imprimir Recibos   ?","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1¦Parc.","","","2¦Parc.","","","Val.Extras","","",""})
aAdd(aRegs,{cPerg,"04","Numero da Semana   ?","Numero da Semana   ?","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Filial De          ?","Filial De          ?","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"06","Filial At‚         ?","Filial At‚         ?","Filial At‚         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"07","Centro de Custo De ?","Centro de Custo De ?","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"08","Centro de Custo At‚?","Centro de Custo At‚?","Centro de Custo At‚?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"09","Matricula De       ?","Matricula De       ?","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"10","Matricula At‚      ?","Matricula At‚      ?","Matricula At‚      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"11","Nome De            ?","Nome De            ?","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Nome At‚           ?","Nome At‚           ?","Nome At‚           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Chapa De           ?","Chapa De           ?","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Chapa At‚          ?","Chapa At‚          ?","Chapa At‚          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Mensagem 1         ?","Mensagem 1         ?","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Mensagem 2         ?","Mensagem 2         ?","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Mensagem 3         ?","Mensagem 3         ?","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18","Situa‡”es a Imp.   ?","Situa‡”es a Imp.   ?","Situa‡”es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"19","Categorias a Imp.  ?","Categorias a Imp.  ?","Categorias a Imp.  ?","mv_chj","C",10,0,0,"G","fCategoria","mv_par19","","CDHMST","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"20","Imprime Bases      ?","Imprime Bases      ?","Imprime Bases      ?","mv_chk","C",1,0,1,"C","","mv_par20","Sim","","","Nao","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"21","Imprimir           ?","Imprimir           ?","Imprimir           ?","mv_chl","C",1,0,1,"C","","mv_par21","Frente","","","Verso","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"22","Ordem              ?","Ordem              ?","Ordem              ?","mv_chm","C",1,0,1,"C","","mv_par22","Matric","","","C.Custo","","","Nome","","","Chapa","","","CC+Nome","","",""})

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
