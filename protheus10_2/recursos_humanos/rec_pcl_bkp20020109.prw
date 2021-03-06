#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/08/00
//#include "INKEY.CH"
#INCLUDE "rec_pcl.CH"
#INCLUDE "avprint.CH"

User Function rec_pcl2()        // incluido pelo assistente de conversao do AP5 IDE em 30/08/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � GPER030  � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Emissao de Recibos de Pagamento                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � GPER030(void)                                              낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇�         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             낢�
굇쳐컴컴컴컴컴컫컴컴컴컴쩡컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛rogramador � Data   � BOPS �  Motivo da Alteracao                     낢�
굇쳐컴컴컴컴컴컵컴컴컴컴탠컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Kleber     �13/05/99퀈xxxxx� SaveScreen somente em DOS.               낢�
굇� Kleber     �19/05/99�20508A� Alt. p/ Imprimir o Periodo da Semana.    낢�
굇� Kleber     �26/05/99�------� Tirar de uso a fun눯o REPORTINI.         낢�
굇� Kleber     �20/07/99�------� Chamada funcao Persemana() Somente Folha.낢�
굇� Kleber     �13/08/99퀈xxxxx� Carregar Semana Gravada Ano c/ 2 digitos.낢�
굇�            �        �      � na Funcao PerSemana().                   낢�
굇� Marina     �17/01/00�001829� Acerto Salario Base no recibo pagto. de  낢�
굇�            �        �      � Movimentos Anteriores.                   낢�
굇� Marina     �14/02/00�------� Acerto do salario base no recibo de movi-낢�
굇�            �        �      � mentos anteriores para SQL.              낢�
굇� Emerson    �16/05/00�------� Substituicao de "Index On" por "IndRegua"낢�
굇� Marina     �05/06/00�------� Acerto de nValSal qdo.nao ha aumento sa- 낢�
굇�            �        �      � larial.                                  낢�
굇� Marina     �08/06/00�002841� Quebrar pagina p/Rec.zebrado na linha 64.낢�
굇� Marina     �06/07/00�005015� Considerar somente verba do Salario Base 낢� 
굇�            �        �      � na funcao fBuscaSlr.                     낢�
굇� Emerson    �29/08/00�------� Testar controle de acessos e fil. validas낢�
굇�            �        �------� Imprimir mov anteriores a partir dDataRef낢�
굇� Maam       �01/11/01�------� Transformar em impressao a Laser utilizan낢�
굇�            �        �------� do padroes PLC                           낢�
굇� Maam       �04/01/02�------� Transformar de impressao a Laser utilizan낢�
굇�            �        �------� do padroes PLC, para comandos avprint    낢�
굇읕컴컴컴컴컴컨컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cString:="SRA"        // alias do arquivo principal (Base)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Programa)                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nExtra := 0
cIndCond := ""
cIndRc  := ""
Baseaux := "S"
cDemit := "N"
cMesAnoRef := ""

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Private(Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private aLinha   := { },nLastKey := 0
Private cPerg    :="RECPCL"
Private cSem_De  := "  /  /    "
Private cSem_Ate := "  /  /    "
Private nAteLim , nBaseFgts , nFgts , nBaseIr , nBaseIrFe
/*
ValidPerg()
*/
Valid508()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Private(Programa)                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private aLanca := {}
Private aProve := {}
Private aDesco := {}
Private aBases := {}
Private aInfo  := {}
Private aCodFol:= {}
Private li     := 0
Private Titulo := STR0011               //"EMISS랳 DE RECIBOS DE PAGAMENTOS"
_nTotFunc      := 0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
pergunte("RECPCL",.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

If LastKey() = 27 .Or. nLastKey = 27
	Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Carregando variaveis mv_par?? para Variaveis do Sistema.     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01        //  Data de Referencia para a impressao      �
//� mv_par02        //  Tipo de Recibo (Pre/Zebrado)             �
//� mv_par03        //  Emitir Recibos(Adto/Folha/1�/2�/V.Extra) �
//� mv_par04        //  Numero da Semana                         �
//� mv_par05        //  Filial De                                �
//� mv_par06        //  Filial Ate                               �
//� mv_par07        //  Centro de Custo De                       �
//� mv_par08        //  Centro de Custo Ate                      �
//� mv_par09        //  Matricula De                             �
//� mv_par10        //  Matricula Ate                            �
//� mv_par11        //  Nome De                                  �
//� mv_par12        //  Nome Ate                                 �
//� mv_par13        //  Chapa De                                 �
//� mv_par14        //  Chapa Ate                                �
//� mv_par15        //  Mensagem 1                               �
//� mv_par16        //  Mensagem 2                               �
//� mv_par17        //  Mensagem 3                               �
//� mv_par18        //  Situacoes a Imprimir                     �
//� mv_par19        //  Categorias a Imprimir                    �
//� mv_par20        //  Imprimir Bases                           �
//� mv_par21        //  Imprimir FRENTE/VERSO/AMBOS              �
//� mv_par22        //  Ordem                                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
cBaseAux   := If(mv_par20 == 1,"S","N")
_cTpImp    := If(mv_par21 == 1,"F","V")
nOrdem     := mv_par22

cMesAnoRef := StrZero(Val(SubStr( DtoS(dDataRef),5,2) ),2)+StrZero( Val( SubStr( Dtos( dDataRef ),1,4 ) ) ,4) 

RptStatus({|lEnd| R030Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio


Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � R030IMP  � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Processamento Para emissao do Recibo                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � R030IMP(lEnd,Wnrel,cString)                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function R030Imp(lEnd,WnRel,cString,cMesAnoRef)
Static Function R030Imp(lEnd,WnRel,cString,cMesAnoRef)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸       
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

Local lIgual                 //Vari쟶el de retorno na compara놹o do SRC
Local cArqNew                //Vari쟶el de retorno caso SRC #SX3
Local tamanho     := "P"
Local limite      := 80
Local aOrdBag     := {}
Local cMesArqRef  := If(Esc == 4,"13"+Right(cMesAnoRef,4),cMesAnoRef)
Local cArqMov     := ""
Local cAliasMov   := ""
Local _cArqPclFre := ""
Local _cArqPclVer := ""

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Verifica se existe o arquivo de fechamento do mes informado  |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
lAtual := ( !fExistArq( cMesArqRef,,0 ) .And. MesAno(dDataRef) == MesAno(dDataBase) )

If !lAtual
	If !fIniArqMov( cMesArqRef, @cAliasMov , @aOrdBag , @cArqMov )
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//| Se nao encontrar o arquivo retorna o arquivo atual           |
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	    ChkFile( cAliasMov , .F. )
	    Return
	EndIf
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Selecionando a Ordem de impressao escolhida no parametro.    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Selecionando o Primeiro Registro e montando Filtro.          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Carrega Regua Processamento                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Movimenta Regua Processamento                                �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	IncRegua()  // Anda a regua

	If lEnd    
	    li += 100
	    oPrn:Say( li,200,cCancel,oFont1 )
		Exit
	Endif    

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste Parametrizacao do Intervalo de Impressao            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste situacao e categoria dos funcionarios                           |
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If !lAtual
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Termino do relatorio                                         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Impressao� Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � IMRESSAO DO RECIBO FORMULARIO CONTINUO                     낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fImpressao()                                               낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fImpressao()
Static Function fImpressao()

Local nConta  := nContr := nContrT:=0
Local aDriver := LEDriver()
_nSomLin := 1010

/*                 
Foi alterado de 16 para 28, pois o miolo na laser � maior
Private nLinhas:=16              // Numero de Linhas do Miolo do Recibo
*/
Private nLinhas:=28              // Numero de Linhas do Miolo do Recibo
/*
If  _cTpImp == "A" //Imprime frente e verso

		Ordem_Rel := 1
		fCabec()
		fCabecV()
		
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
*/		
If  _cTpImp == "V" //imprime o verso frente do recibo com o dados
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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Cabec    � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � IMRESSAO Cabe놹lho Form Continuo                           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fCabec()                                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fCabec()   // Cabecalho do Recibo
Static Function fCabec()   // Cabecalho do Recibo()

@ LI,00 PSAY _cIniLin1
LI ++
If !Empty(Semana) .And. Semana #'99' .And.  Upper(SRA->RA_TIPOPGT) == 'S'
	_cDescSem := STR0013 + Semana + ' (' + cSem_De + STR0014 + ;    //'Semana '###' a '
		    cSem_Ate + ')'
Else
	_cDescSem := MesExtenso(MONTH(dDataRef))+"/"+STR(YEAR(dDataRef),4)
EndIf   
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

/*
LI++
@ LI,01 PSAY + _cFimLin1
//Li++ 
*/
Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯CabecV    � Autor � Maam                 � Data � 01.11.01 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � IMRESSAO Cabe놹lho na impressora laser                     낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fCabecV()                                                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fCabec()   // Cabecalho do Recibo
Static Function fCabecV()   // Cabecalho do Recibo()
LI ++
If !Empty(Semana) .And. Semana #'99' .And.  Upper(SRA->RA_TIPOPGT) == 'S'
	_cDescSem := STR0013 + Semana + ' (' + cSem_De + STR0014 + ;    //'Semana '###' a '
		    cSem_Ate + ')'
Else
	_cDescSem := SubStr(MesExtenso( MONTH(dDataRef) ),1,3)+"/"+STR(YEAR(dDataRef),4)
EndIf   
oPrn:Say(0480,0040,DESC_Fil,oFont1,,,,3)
oPrn:Say(0480,1200,SubStr(DESC_CGC,1,2)+"."+SubStr(DESC_CGC,3,3)+"."+SubStr(DESC_CGC,6,3)+;
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
oPrn:Say(0630,0050,SRA->RA_MAT ,oFont1,,,,3)
oPrn:Say(0630,0450,SRA->RA_NOME,oFont1,,,,3)
oPrn:Say(0630,1955,TransForm( nValSal , "@E 999,999,999.99" ),oFont1,,,,3)
oPrn:Say(0740,0050,SRA->RA_CC,oFont1,,,,3)
oPrn:Say(0740,0630,DESC_CC   ,oFont1,,,,3)
oPrn:Say(0740,1230,DESC_FUNC ,oFont1,,,,3)
Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Lanca    � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao das Verbas (Lancamentos) Form. Continuo          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fLanca()                                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fLanca(nConta)   // Impressao dos Lancamentos
Static Function fLanca(nConta)   // Impressao dos Lancamentos()

Local cString := Transform(aLanca[nConta,5],"@E 99,999,999.99")
Local nCol := If(aLanca[nConta,1]="P",1175,If(aLanca[nConta,1]="D",1765,127))
Li+=50
oPrn:Say(li,0025,aLanca[nConta,2],oFont1,,,,3)
oPrn:Say(li,0230,aLanca[nConta,3],oFont1,,,,3)

If aLanca[nConta,1] #"B"        // So Imprime se nao for base
    oPrn:Say(li,0975,TRANSFORM(aLanca[nConta,4],"999.99"),oFont1,,,,3)
Endif
oPrn:Say(li,ncol,cString,oFont1,,,,3)
Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Continua � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressap da Continuacao do Recibo                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fContinua()                                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
// Substituido pelo assistente de conversao do AP5 IDE em 30/08/00 ==> Static Function fContinua()    // Continuacao do Recibo
Static Function fContinua()    // Continuacao do Recibo()

Li+=1   
   oPrn:Say(2670,0225,STR0037,oFont1,,,,3)
Li+=8
Return Nil


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Rodape   � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao do Rodape                                        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fRodape()                                                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
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
       oPrn:Say(2305,0065,Transform(nBaseFgts,"@E 999,999,999.99"),oFont1,,,,3)
	   oPrn:Say(2305,0612,Transform(nAteLim,"@E 999,999,999.99")  ,oFont1,,,,3)	
       oPrn:Say(2305,1240,Transform(TOTVENC  ,"@E 999,999,999.99"),oFont1,,,,3)	   
       oPrn:Say(2305,1715,Transform(TOTDESC  ,"@E 999,999,999.99"),oFont1,,,,3)       
	   
       oPrn:Say(2400,0065,Transform(nFgts    ,"@E 999,999,999.99"),oFont1,,,,3)
	   oPrn:Say(2400,0612,Transform(nBaseIr  ,"@E 999,999,999.99")  ,oFont1,,,,3)	
	   oPrn:Say(2400,1240,Transform(StrZero( Val(SRA->RA_DEPIR),2 ),"@E 99"),oFont1,,,,3)	
       oPrn:Say(2400,1715,Transform(TOTVENC - TOTDESC ,"@E 999,999,999.99"),oFont1,,,,3)       

       oPrn:Say(2500,0050,TransForm( 0.00,"@E 999,999,999.99" ),oFont1,,,,3)
       oPrn:Say(2500,1715,TransForm( _nValAdt13,"@E 999,999,999.99" ),oFont1,,,,3)
       
	   oPrn:Say(2600,0050,SubStr( SRA->RA_BCDEPSA ,1,3),oFont1,,,,3)
	   oPrn:Say(2600,0612,SubStr( SRA->RA_BCDEPSA ,4,5),oFont1,,,,3)
	   oPrn:Say(2600,1240,SRA->RA_CTDEPSA,oFont1,,,,3)
	   oPrn:Say(2600,1695,Dtoc( dDataRef ),oFont1,,,,3)
	Endif                                                          
li+=1
DESC_MSG0:= ""
MESCOMP = IIF(MONTH(dDataRef) + 1 > 12,01,MONTH(dDataRef))
IF MESCOMP = MONTH(SRA->RA_NASC)
    DESC_MSG0:="F E L I Z   A N I V E R S A R I O  ! !"
ENDIF
oPrn:Say(2710,0300,DESC_MSG0,oFont1,,,,3)
oPrn:Say(2760,0300,DESC_MSG1+Space(01)+DESC_MSG2+Space(01)+DESC_MSG3,oFont1,,,3)
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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯SomaPd   � Autor � R.H. - Mauro          � Data � 24.09.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Somar as Verbas no Array                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fSomaPd(Tipo,Verba,Horas,Valor)                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯BoxVerso � Autor � R.H. - MAAM           � Data � 05.01.02 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Imprimir o Box para que os dados sejam impressos           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fBoxVerso()                                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
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
oSend(oPrn,"SayBitmap", 0200,0030,"CESVI.BMP",0450,0200 ) // Logotipo
oPrn:Say(0330,0700,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont9,,,,3)
// Box da Primeira Linha de dados - Empresa
oPrn:Box(0430,0020,0530,1165)
oPrn:Box(0430,1165,0530,1555)
oPrn:Box(0430,1555,0530,1940)
oPrn:Box(0430,1940,0530,2350) 
oPrn:Say(0435,0025,"Empresa" ,oFont3,,,,3)
oPrn:Say(0435,1170,"CNPJ"    ,oFont3,,,,3)
oPrn:Say(0435,1560,"Mes Ref.",oFont3,,,,3)
oPrn:Say(0435,1945,"Seq."    ,oFont3,,,,3)

// Box da Segunda Linha de dados - Matricula
oPrn:Box(0580,0020,0680,0420)
oPrn:Box(0580,0420,0680,1930)
oPrn:Box(0580,1930,0680,2350)
oPrn:Say(0585,0025,"Matricula"   ,oFont3,,,,3)
oPrn:Say(0585,0425,"Nome"        ,oFont3,,,,3)
oPrn:Say(0585,1935,"Salario Base",oFont3,,,,3)

//Box da Terceira Linha de dados - Centro de Custo
oPrn:Box(0690,0020,0790,0600)
oPrn:Box(0690,0600,0790,1200)
oPrn:Box(0690,1200,0790,2350)
oPrn:Say(0695,0025,"Centro de Custo",oFont3,,,,3)
oPrn:Say(0695,0605,"Secao"          ,oFont3,,,,3)
oPrn:Say(0695,1205,"Funcao"         ,oFont3,,,,3)

//Box com cabecalho das verbas
oPrn:Box(0800,0020,0900,0220)
oPrn:Box(0800,0220,0900,0970)
oPrn:Box(0800,0970,0900,1170)
oPrn:Box(0800,1170,0900,1760)
oPrn:Box(0800,1760,0900,2350)
oPrn:Say(0805,0025,"Evento"   ,oFont3,,,,3)
oPrn:Say(0805,0225,"Descricao",oFont3,,,,3)
oPrn:Say(0805,0975,"Ref"      ,oFont3,,,,3)
oPrn:Say(0805,1175,"Proventos",oFont3,,,,3)
oPrn:Say(0805,1765,"Descontos",oFont3,,,,3)


//Box para preenchimento das verbas
oPrn:Box(0900,0020,2250,0220)
oPrn:Box(0900,0220,2250,0970)
oPrn:Box(0900,0970,2250,1170)
oPrn:Box(0900,1170,2250,1760)
oPrn:Box(0900,1760,2250,2350)

//Rodade para as bases
oPrn:Box(2250,0020,2350,0577)
oPrn:Box(2250,0577,2350,1134)
oPrn:Box(2250,1134,2350,1690)
oPrn:Box(2250,1690,2350,2350)
oPrn:Say(2255,0025,"Base para FGTS"      ,oFont3,,,,3)
oPrn:Say(2255,0582,"Sal.Cont.Inss"       ,oFont3,,,,3)
oPrn:Say(2255,1139,"Total de Vencimentos",oFont3,,,,3)
oPrn:Say(2255,1695,"Total de Descontos"  ,oFont3,,,,3)

oPrn:Box(2350,0020,2450,0577)
oPrn:Box(2350,0577,2450,1134)
oPrn:Box(2350,1134,2450,1690)
oPrn:Box(2350,1690,2450,2350)
oPrn:Say(2355,0025,"Fgts do Mes"     ,oFont3,,,,3)
oPrn:Say(2355,0582,"Base Ir"         ,oFont3,,,,3)
oPrn:Say(2355,1139,"Dep Ir"          ,oFont3,,,,3)
oPrn:Say(2355,1695,"Liquido a Receber",oFont3,,,,3)

oPrn:Box(2450,0020,2550,0577)
oPrn:Box(2450,0577,2550,1134)
oPrn:Box(2450,1134,2550,1690)
oPrn:Box(2450,1690,2550,2350)
oPrn:Say(2455,0025,"Saldo FGTS Banco"   ,oFont3,,,,3)
oPrn:Say(2455,0582,"Cap.Seg.Vida-Func"  ,oFont3,,,,3)
oPrn:Say(2455,1139,"Cap.Seg.Vida-Conj"  ,oFont3,,,,3)
oPrn:Say(2455,1695,"Adto.13 Sal. no Ano",oFont3,,,,3)

oPrn:Box(2550,0020,2650,0577)
oPrn:Box(2550,0577,2650,1134)
oPrn:Box(2550,1134,2650,1690)
oPrn:Box(2550,1690,2650,2350)
oPrn:Say(2555,0025,"Banco Pagamento"   ,oFont3,,,,3)
oPrn:Say(2555,0582,"Agencia Bancaria"  ,oFont3,,,,3)
oPrn:Say(2555,1139,"Conta Corrente"    ,oFont3,,,,3)
oPrn:Say(2555,1695,"Data do Credito"   ,oFont3,,,,3)

//Box da mensagem
oPrn:Say(2660,0020,"Observa寤es:",oFont3,,,,3)
oPrn:Box(2660,0280,2860,2350)

/*
AvEndPage                        
AvEndPrint
*/

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯BoxFrent � Autor � R.H. - MAAM           � Data � 05.01.02 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Imprimir o Box para que os dados sejam impressos           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fBoxFrent()                                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/

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
oSend(oPrn,"SayBitmap", 0200,0030,"CESVI.BMP",0450,0200 ) // Logotipo
oPrn:Say(0370,1120,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont7,,,,3)
// Box para colar a etiqueta
oPrn:Box(0430,0020,1030,2350)
oPrn:Box(1040,0020,3300,2350)

// Preenchimento do achurado com confidencial                        
_nCont := 1045
For iaCont := 1 to 45
    oPrn:Say(_nCont,0020,Replicate("CONFIDENCIAL ",8)+"CONFIDENC",oFont2,,,,3)
    _nCont += 50
Next iaCont
/*
AvEndPage                        
AvEndPrint
*/
Return
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    쿣ALIDPERG � Autor � AP5 IDE            � Data �  01/11/01   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Verifica a existencia das perguntas criando-as caso seja   볍�
굇�          � necessario (caso nao existam).                             볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
"GPR030","01","Data de Refer늧cia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""
"GPR030","02","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""
"GPR030","03","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1쪷arc.","","","2쪷arc.","","","Val.Extras","","",""
"GPR030","04","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""
"GPR030","05","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""
"GPR030","06","Filial At�         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""
"GPR030","07","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""
"GPR030","08","Centro de Custo At�?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""
"GPR030","09","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""
"GPR030","10","Matricula At�      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""
"GPR030","11","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""
"GPR030","12","Nome At�           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""
"GPR030","13","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""
"GPR030","14","Chapa At�          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""
"GPR030","15","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""
"GPR030","16","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""
"GPR030","17","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""
"GPR030","18","Situa뇯es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""
"GPR030","19","Categorias a Imp.  ?","mv_chj","C",10,0,0,"G","fCategoria","mv_par19","","CDHMST","","","","","","","","","","","","","",""
"GPR030","20","Imprime Bases      ?","mv_chk","C",1,0,1,"C","","mv_par20","Sim","","","Nao","","","","","","","","","","","",""
"GPR030","21","Imprimir           ?","mv_chl","C",1,0,1,"C","","mv_par21","Frente","","","Verso","","","","","","","","","","","",""
"GPR030","22","Ordem              ?","mv_chm","C",1,0,1,"C","","mv_par22","Matric","","","C.Custo","","","Nome","","","Chapa","","","CC+Nome","","",""
//"Matricula"###"C.Custo"###"Nome"###"Chapa"###"C.Custo + Nome"
*/
aAdd(aRegs,{cPerg,"01","Data de Refer늧cia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1쪷arc.","","","2쪷arc.","","","Val.Extras","","",""})
aAdd(aRegs,{cPerg,"04","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"06","Filial At�         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"07","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"08","Centro de Custo At�?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"09","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"10","Matricula At�      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"11","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Nome At�           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Chapa At�          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18","Situa뇯es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""})
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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    쿣ALID508  � Autor � AP5 IDE            � Data �  01/11/01   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Verifica a existencia das perguntas criando-as caso seja   볍�
굇�          � necessario (caso nao existam).                             볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function Valid508

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
"GPR030","01","Data de Refer늧cia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""
"GPR030","02","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""
"GPR030","03","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1쪷arc.","","","2쪷arc.","","","Val.Extras","","",""
"GPR030","04","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""
"GPR030","05","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""
"GPR030","06","Filial At�         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""
"GPR030","07","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""
"GPR030","08","Centro de Custo At�?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""
"GPR030","09","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""
"GPR030","10","Matricula At�      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""
"GPR030","11","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""
"GPR030","12","Nome At�           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""
"GPR030","13","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""
"GPR030","14","Chapa At�          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""
"GPR030","15","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""
"GPR030","16","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""
"GPR030","17","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""
"GPR030","18","Situa뇯es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""
"GPR030","19","Categorias a Imp.  ?","mv_chj","C",10,0,0,"G","fCategoria","mv_par19","","CDHMST","","","","","","","","","","","","","",""
"GPR030","20","Imprime Bases      ?","mv_chk","C",1,0,1,"C","","mv_par20","Sim","","","Nao","","","","","","","","","","","",""
"GPR030","21","Imprimir           ?","mv_chl","C",1,0,1,"C","","mv_par21","Frente","","","Verso","","","","","","","","","","","",""
"GPR030","22","Ordem              ?","mv_chm","C",1,0,1,"C","","mv_par22","Matric","","","C.Custo","","","Nome","","","Chapa","","","CC+Nome","","",""
//"Matricula"###"C.Custo"###"Nome"###"Chapa"###"C.Custo + Nome"
*/
aAdd(aRegs,{cPerg,"01","Data de Refer늧cia ?","Data de Refer늧cia ?","Data de Refer늧cia ?","mv_ch1","D",8,0,0,"G","naovazio","mv_par01","","'30/10/01'","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Pre Impr./Zebrado  ?","Pre Impr./Zebrado  ?","Pre Impr./Zebrado  ?","mv_ch2","N",1,0,2,"C","","mv_par02","Pre-Impresso","","","Zebrado","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Imprimir Recibos   ?","Imprimir Recibos   ?","Imprimir Recibos   ?","mv_ch3","N",1,0,2,"C","","mv_par03","Adto.","","","Folha","","","1쪷arc.","","","2쪷arc.","","","Val.Extras","","",""})
aAdd(aRegs,{cPerg,"04","Numero da Semana   ?","Numero da Semana   ?","Numero da Semana   ?","mv_ch4","C",2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Filial De          ?","Filial De          ?","Filial De          ?","mv_ch5","C",2,0,0,"G","naovazio","mv_par05","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"06","Filial At�         ?","Filial At�         ?","Filial At�         ?","mv_ch6","C",2,0,0,"G","naovazio","mv_par06","","01","","","","","","","","","","","","","SM0",""})
aAdd(aRegs,{cPerg,"07","Centro de Custo De ?","Centro de Custo De ?","Centro de Custo De ?","mv_ch7","C",9,0,0,"G","naovazio","mv_par07","","000000000","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"08","Centro de Custo At�?","Centro de Custo At�?","Centro de Custo At�?","mv_ch8","C",9,0,0,"G","naovazio","mv_par08","","999999999","","","","","","","","","","","","","SI3",""})
aAdd(aRegs,{cPerg,"09","Matricula De       ?","Matricula De       ?","Matricula De       ?","mv_ch9","C",6,0,0,"G","naovazio","mv_par09","","000000","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"10","Matricula At�      ?","Matricula At�      ?","Matricula At�      ?","mv_cha","C",6,0,0,"G","naovazio","mv_par10","","999999","","","","","","","","","","","","","SRA",""})
aAdd(aRegs,{cPerg,"11","Nome De            ?","Nome De            ?","Nome De            ?","mv_chb","C",30,0,0,"G","naovazio","mv_par11","","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Nome At�           ?","Nome At�           ?","Nome At�           ?","mv_chc","C",30,0,0,"G","naovazio","mv_par12","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Chapa De           ?","Chapa De           ?","Chapa De           ?","mv_chd","C",5,0,0,"G","","mv_par13","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Chapa At�          ?","Chapa At�          ?","Chapa At�          ?","mv_che","C",5,0,0,"G","","mv_par14","","99999","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Mensagem 1         ?","Mensagem 1         ?","Mensagem 1         ?","mv_chf","C",1,0,0,"G","","mv_par15","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Mensagem 2         ?","Mensagem 2         ?","Mensagem 2         ?","mv_chg","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Mensagem 3         ?","Mensagem 3         ?","Mensagem 3         ?","mv_chh","C",1,0,0,"G","","mv_par17","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18","Situa뇯es a Imp.   ?","Situa뇯es a Imp.   ?","Situa뇯es a Imp.   ?","mv_chi","C",5,0,0,"G","fSituacao","mv_par18",""," ADFT","","","","","","","","","","","","","",""})
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
