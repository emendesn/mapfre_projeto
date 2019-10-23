#Include "Ctbr265.Ch"
#Include "PROTHEUS.Ch"
#INCLUDE "topconn.ch"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA 			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_DESCRICAO		4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_COLUNA1       	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_COLUNA2       	8
#DEFINE 	COL_SEPARA5			9
#DEFINE 	COL_COLUNA3       	10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_COLUNA4   		12
#DEFINE 	COL_SEPARA7			13
#DEFINE 	COL_COLUNA5   		14
#DEFINE 	COL_SEPARA8			15
#DEFINE 	COL_COLUNA6   		16
#DEFINE 	COL_SEPARA9			17
#DEFINE 	COL_COLUNA7			18
#DEFINE 	COL_SEPARA10		19
#DEFINE 	COL_COLUNA8			20
#DEFINE 	COL_SEPARA11		21
#DEFINE 	COL_COLUNA9			22
#DEFINE 	COL_SEPARA12		23
#DEFINE 	COL_COLUNA10		24
#DEFINE 	COL_SEPARA13		25
#DEFINE 	COL_COLUNA11		26
#DEFINE 	COL_SEPARA14		27
#DEFINE 	COL_COLUNA12		28
#DEFINE 	COL_SEPARA15		29
#DEFINE 	TAM_VALOR 			20

// 17/08/2009 -- Filial com mais de 2 caracteres

//TraduÁ„o PTG


/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo	≥ Ctbr265≥ Autor ≥ Juscelino Alves dos Santos ≥ Data ≥ 04.12.14≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Balancete Comparativo de Movim. de Contas x 12 Colunas	  ≥±±
±±             e Custo                                               	  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥ Ctbr265()                               			 		  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno	 ≥ Nenhum       											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso    	 ≥ Generico     											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum													  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function Ctbr265C()

Private Titulo		:= ""
Private NomeProg	:= "CTBR265"        
Private aSelFil    := {}

U_Ctb265C1()

Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo	≥ Ctbr265≥ Autor ≥ Juscelino Alves dos Santos ≥ Data ≥ 04.12.14≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Balancete Comparativo de Movim. de Contas x 12 Colunas	  ≥±±
±±             e Custo                                               	  ≥±±
±±≥Sintaxe   ≥ Ctbr265()                               			 		  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno	 ≥ Nenhum       											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso    	 ≥ Generico     											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum													  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function Ctb265C1()
Local aSetOfBook
Local aCtbMoeda		:= {}
LOCAL cDesc1 		:= STR0001	//"Este programa ira imprimir o Comparativo de Contas Contabeis."
LOCAL cDesc2 		:= STR0002  //" Os valores sao ref. a movimentacao do periodo solicitado. "
Local cDesc3		:= ""
LOCAL wnrel
LOCAL cString		:= "CT1"
Local titulo 		:= STR0003 	//"Comparativo  de Contas Contabeis "
Local lRet			:= .T.
Local nDivide		:= 1
Local lAtSlBase		:= Iif(GETMV("MV_ATUSAL")== "S",.T.,.F.)

PRIVATE Tamanho		:="G"
PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR265"
PRIVATE aReturn 	:= { STR0013, 1,STR0014, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  	:= "CTBR265"

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf
li 		:= 80
m_pag	:= 1

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Mostra tela de aviso - processar exclusivo					 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
cMensagem := STR0017+chr(13)  		//"Caso nao atualize os saldos  basicos  na"
cMensagem += STR0018+chr(13)  		//"digitacao dos lancamentos (MV_ATUSAL='N'),"
cMensagem += STR0019+chr(13)  		//"rodar a rotina de atualizacao de saldos "
cMensagem += STR0020+chr(13)  		//"para todas as filiais solicitadas nesse "
cMensagem += STR0021+chr(13)  		//"relatorio."

IF !lAtSlBase
	IF !MsgYesNo(cMensagem,STR0009)	//"ATENÄéO"
		Return
	Endif
EndIf

// Verifica e Cria a o Grupo de Perguntas        
fperg(cPerg)

If !Pergunte("CTR265",.T.) 
   Return
EndIf


//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Variaveis utilizadas para parametros								  ≥
//≥ mv_par01				// Data Inicial                  	  		  ≥
//≥ mv_par02				// Data Final                        		  ≥
//≥ mv_par03				// Conta Inicial                         	  ≥
//≥ mv_par04				// Conta Final  							  ≥
//≥ mv_par05				// Imprime Contas: Sintet/Analit/Ambas   	  ≥
//≥ mv_par06				// Set Of Books				    		      ≥
//≥ mv_par07				// Saldos Zerados?			     		      ≥
//≥ mv_par08				// Moeda?          			     		      ≥
//≥ mv_par09				// Pagina Inicial  		     		    	  ≥
//≥ mv_par10				// Saldos? Reais / Orcados	/Gerenciais   	  ≥
//≥ mv_par11				// Quebra por Grupo Contabil?		    	  ≥
//≥ mv_par12				// Filtra Segmento?					    	  ≥
//≥ mv_par13				// Conteudo Inicial Segmento?		   		  ≥
//≥ mv_par14				// Conteudo Final Segmento?		    		  ≥
//≥ mv_par15				// Conteudo Contido em?				    	  ≥
//≥ mv_par16				// Salta linha sintetica ?			    	  ≥
//≥ mv_par17				// Imprime valor 0.00    ?			    	  ≥
//≥ mv_par18				// Imprimir Codigo? Normal / Reduzido  		  ≥
//≥ mv_par19				// Divide por ?                   			  ≥
//≥ mv_par20				// Imprimir Ate o segmento?			   		  ≥
//≥ mv_par21				// Posicao Ant. L/P? Sim / Nao         		  ≥
//≥ mv_par22				// Data Lucros/Perdas?                 		  ≥
//≥ mv_par23				// Totaliza periodo ?                  		  ≥
//≥ mv_par24				// Se Totalizar ?                  		  	  ≥
//≥ mv_par25				// Tipo de Comparativo?(Movimento/Acumulado)  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

wnrel	:= "CTBR265"            //Nome Default do relatorio em Disco
  
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano≥
//≥ Gerencial -> montagem especifica para impressao)			 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
If !ct040Valid(mv_par06)
	lRet := .F.
Else
   aSetOfBook := CTBSetOf(mv_par06)
Endif

If mv_par19 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par19 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par19 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
	If Empty(aCtbMoeda[1])                       
      Help(" ",1,"NOMOEDA")
      lRet := .F.
   Endif
Endif    

RptStatus({|lEnd| CTR265Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,nDivide)})

Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Program   ≥CTR265IMP ≥ Autor ≥ Simone Mie Sato       ≥ Data ≥ 30.10.02 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Imprime relatorio  									      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥CTR265Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda)          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno   ≥ Nenhum                                                     ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ Generico                                                   ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ lEnd    	  - Aáao do Codeblock                             ≥±±
±±≥          ≥ WnRel   	  - T°tulo do relat¢rio                           ≥±±
±±≥          ≥ cString 	  - Mensagem                                      ≥±±
±±≥          ≥ aSetOfBook - Matriz ref. Config. Relatorio                 ≥±±
±±≥          ≥ aCtbMoeda  - Matriz ref. a moeda                           ≥±±
±±≥          ≥ nDivde     - Fator de divisao para impressao dos valores   ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function CTR265Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,nDivide)

Local aColunas		:= {}
LOCAL CbTxt			:= Space(10)
Local CbCont		:= 0
LOCAL limite		:= 220
Local cabec1   		:= ""
Local cabec2   		:= ""
Local cSeparador	:= ""
Local cPicture
Local cDescMoeda
Local cCodMasc		:= ""
Local cMascara
Local cGrupo		:= ""
Local cArqTmp
Local dDataIni		:= mv_par01
Local dDataFim 		:= mv_par02
Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par17==1,.T.,.F.)
Local lPula			:= Iif(mv_par16==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par18==1,.T.,.F.)
Local nDecimais
Local aTotCol		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aTotGrp		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local cSegmento		:= mv_par12
Local cSegAte   	:= mv_par20
Local cSegIni		:= mv_par13
Local cSegFim		:= mv_par14
Local cFiltSegm		:= mv_par15
Local nDigitAte		:= 0
Local lImpAntLP		:= Iif(mv_par21 == 1,.T.,.F.)
Local dDataLP		:= mv_par22
Local aMeses		:= {}          
Local nTotGeral		:= 0
Local aPeriodos
Local nMeses		:= 1
Local nCont			:= 0
Local nDigitos		:= 0
Local nVezes		:= 0
Local nPos			:= 0 
Local lVlrZerado	:= Iif(mv_par07 == 1,.T.,.F.)
Local lImpSint		:= Iif(mv_par05 = 2,.F.,.T.)
Local lSinalMov		:= CtbSinalMov()
Local cHeader 		:= ""
Local cTpComp		:= If( mv_par25 == 1,"M","S" )	//	Comparativo : "M"ovimento ou "S"aldo Acumulado  
Local TAM_VAL3		:= 12
Local lImpTotS		:= .F. // Iif(mv_par29 == 1,.T.,.F.)
Private aSelFil    := {}
cDescMoeda 	:= Alltrim(aCtbMoeda[2])

IF lImpAntLP .And. !Empty (dDataLp) .And. !Empty(dDataIni)
	If dDataLP <= dDataIni
    	MsgAlert(STR0032)
		Return                                
	Endif
EndIf
If !Empty(aCtbMoeda[6])
	cDescMoeda += STR0007 + aCtbMoeda[6]			// Indica o divisor
EndIf	

nDecimais := DecimalCTB(aSetOfBook,mv_par08)
cPicture  := AllTrim( Right(AllTrim(aSetOfBook[4]),12) )

aPeriodos := ctbPeriodos(mv_par08, mv_par01, mv_par02, .T., .F.)

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02 
		If nMeses <= 12
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})	
			nMeses += 1           					
		EndIf
	EndIf
Next                                                                   

If nMeses == 1
	cMensagem := STR0022	//"Por favor, verifique se o calend.contabil e a amarracao moeda/calendario "
	cMensagem += STR0023	//"foram cadastrados corretamente..."		
	MsgAlert(cMensagem)
	Return
EndIf                                                      

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
	cCodMasc := ""
Else
	cCodmasc	:= aSetOfBook[2]
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf     

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Carrega titulo do relatorio: Analitico / Sintetico			  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
IF mv_par05 == 1
	Titulo:=	STR0008	//"COMPARATIVO SINTETICO DE "
ElseIf mv_par05 == 2
	Titulo:=	STR0005	//"COMPARATIVO ANALITICO DE "
ElseIf mv_par05 == 3
	Titulo:=	STR0012 //"COMPARATIVO DE "
EndIf

Titulo += 	DTOC(mv_par01) + STR0006 + Dtoc(aMeses[Len(aMeses)][3]) + ;
				STR0007 + cDescMoeda

If mv_par25 == 2
	Titulo += " - "+STR0026
Endif				
If mv_par10 > "1"			
	Titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
Endif                     

aColunas := { 000, 001, 019, 020, 039, 040, 054, 055, 069, 070, 084, 085, 099, 100, 114,  115, 129, 130, 144, 145, 159, 160, 174, 175, 189, 190 , 204, 205, 219} 

cabec1 := STR0004  //"|CODIGO            |DESCRICAO          |  PERIODO 01  |  PERIODO 02  |  PERIODO 03  |  PERIODO 04  |  PERIODO 05  |  PERIODO 06  |  PERIODO 07  |  PERIODO 08  |  PERIODO 09  |  PERIODO 10  |  PERIODO 11  |  PERIODO 12  |

If mv_par25 == 2				/// SE IMPRIME SALDO ACUMULADO
	mv_par23 := 2				/// N√O DEVE TOTALIZAR (O ULTIMO PERIODO … A POSICAO FINAL)
Endif

If mv_par23 = 1		// Com total, nao imprime descricao
	If mv_par24 = 2
		Cabec1 := Stuff(Cabec1, 2, 10, Subs(Cabec1, 21, 10))
	Endif
	Cabec1 := Stuff(Cabec1, 21, 20, "")
	Cabec1 += " TOTAL PERIODO|"
	For nCont := 6 To Len(aColunas)
		aColunas[nCont] -= 20
	Next	
	For nCont := 3 To Len(aColunas)
		If mv_par24 = 2
			aColunas[nCont] += 5
		Endif
	Next
	If mv_par24 = 2
		Cabec1 := Stuff(Cabec1, 19, 0, Space(5))
		cabec2 := "|                       |"
	Else
		cabec2 := "|                  |"
	Endif
Else
	If mv_par18 = 2
		Cabec1 := 	Left(Cabec1, 11) + "|" + Subs(Cabec1, 21, 15) + Space(12) + "|" +;
					Subs(Cabec1, 41)
		Cabec2 := 	"|          |                           |"
	Else
		cabec2 := "|                  |                   |" 
	Endif
Endif
For nCont := 1 to Len(aMeses)
	If mv_par25 == 2	/// SE FOR ACUMULADO … O SALDO ATE A DATA FINAL
		cabec2 += " "+STR0027+" - "
	Else
		cabec2 += SPACE(1)+Strzero(Day(aMeses[nCont][2]),2)+"/"+Strzero(Month(aMeses[nCont][2]),2)+ " - "	
	Endif
	cabec2 += Strzero(Day(aMeses[nCont][3]),2)+"/"+Strzero(Month(aMeses[nCont][3]),2)+"|"
Next

For nCont:= Len(aMeses)+1 to 12
	cabec2+=SPACE(14)+"|"
Next         

If mv_par23 = 1		// Com total, nao imprime descricao
	Cabec2 += "              |"
Endif
                                                                                                    
If mv_par18 = 2 .And. mv_par23 = 2		// Reduzido
	aColunas[COL_SEPARA2]	:= 11
	aColunas[COL_DESCRICAO]	:= 12
Endif

m_pag := mv_par09

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)                
    nDigitAte	:= CtbRelDig(cSegAte,cMascara) 	
EndIf

If !Empty(cSegmento)
	If Empty(mv_par06)
		Help("",1,"CTN_CODIGO")
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+cCodMasc)
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cCodMasc
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(cSegmento),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)      
				Exit
			EndIf	
			dbSkip()
		EndDo	
	Else
		Help("",1,"CTM_CODIGO")
		Return
	EndIf	
EndIf	

If mv_par25 == 2
	cHeader := "SLD"			/// Indica que dever· obter o saldo na 1™ coluna (Comparativo de Saldo Acumulado)
Endif

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta Arquivo Temporario para Impressao							  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				U_CTGerCMA(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
				mv_par10,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				.F.,.F.,mv_par11,cHeader,lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,aReturn[7])},;
				STR0015, STR0003)//"Criando Arquivo Tempor†rio..."				 	//"Comparativo de Contas Contabeis "

/*
If Select("cArqPri") == 0
	Return
EndIf			
  */
aTmpLogc:={}  
DbSelectArea("cArqPri")
dbGoTop()        
While cArqPri->(!Eof())
   aadd(aTmpLogc, {Alltrim(cArqPri->CONTA),cArqPri->(Recno())})         
   cArqPri->(DbSkip())
End-While
dbGoTop()          
  
_cQuery := "SELECT CT1_CONTA,CT1_DESC01    			   			"
_cQuery += "FROM "+RetSqlName("CT1")+" CT1 						"   
_cQuery += "WHERE 												"
_cQuery += "CT1.CT1_FILIAL		= '"+xFilial("CT1")+"'	   		"  
_cQuery += "AND CT1.CT1_CLASSE = '2' "
_cQuery += "AND CT1.CT1_BLOQ = '2' "
_cQuery += "AND CT1.D_E_L_E_T_ <> '*'					 		"
_cQuery += "GROUP BY  CT1_CONTA,CT1_DESC01                		"
_cQuery += "ORDER BY  CT1_CONTA                         		"
ChangeQuery(_cQuery)
If Select("_QRYC") > 0
       //_QRY->(DbSelectArea)
   _QRYC->(DbCloseArea())
Endif
TCQUERY _cQuery NEW ALIAS "_QRYC" 
_QRYC->(dbGoTop())  
_QRYC->(SetRegua(RecCount()))

If _QRYC->(!Eof())

   dbSelectArea("cArqPri")

   //Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
   //nao esta disponivel e sai da rotina.
   If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	 dbCloseArea()
	 FErase(cArqPri+GetDBExtension())
	 FErase("cArqInd"+OrdBagExt())
	 Return
   Endif

   cSayCC		:= CtbSayApro("CTT")
 

   cDirDocs   	:= MsDocPath()
   cPath	   	:= AllTrim(GetTempPath())  
   cArqPri     := ""

   _cArqTRB:=CriaTrab(,.F.)
   cArquivo	:= _cArqTRB + ".XLS"
   cHTML		:= ""
   Ferase(cArquivo)
   nHdl := fCreate(cArquivo)
   If nHdl == -1
      MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
      Return Nil
   Endif
   // GeraÁ„o do HTML CABE«ARIO 
   cHtml := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> '
   cHtml += '<html xmlns="http://www.w3.org/1999/xhtml"> '
   cHtml += '<head> '
   cHtml += '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> '
   cHtml += '<title>Untitled Document</title> '
   cHtml += '</head> '
   cHtml += '<body> '
   cHtml += '<table width="700" border="1"> '
   cHtml += '  <tr> '
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Conta</font></td>'
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">DescriÁ„o</font></td>'
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Saldo Anterior</font></td>'
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Centro de Custo</font></td>'
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">DescriÁ„o</font></td>'

   For nCont := 1 to Len(aMeses)
     cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">'+SPACE(1)+Strzero(Day(aMeses[nCont][2]),2)+"/"+Strzero(Month(aMeses[nCont][2]),2)+" - ";
     +Strzero(Day(aMeses[nCont][3]),2)+"/"+Strzero(Month(aMeses[nCont][3]),2)+'</font></td>'
   Next  
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Total Periodo</font></td>'
   cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">Saldo Atual</font></td>'

   cHtml += '  </tr> '
   fWrite(nHdl,cHTML,Len(cHTML))
   cHtml := ''
Else
  _QRYC->(DbCloseArea())
  Return 
EndIf       

_vsalantf:=0
_nvalfins:=0
While _QRYC->(!Eof())                 


	If lEnd
		Exit
	EndIF   
	
	If alltrim(cArqPri->CONTA)='1110601' //'1320106'  .Or. alltrim(cArqPri->CONTA)='1110601'
	   _lixo:="lixo"
	EndIf  


IncRegua("Conta :"+_QRYC->CT1_CONTA)

_nPos := Ascan(aTmpLogc,{|x| x[1]== Alltrim(_QRYC->CT1_CONTA)})

If _nPos <>0

dbSelectArea("cArqPri")
//SetRegua(RecCount())

cGrupo := GRUPO
_nsalcon  :=0

dbGoto(aTmpLogc[_nPos,2])        
While cArqPri->(!Eof()) .And. Alltrim(cArqPri->CONTA)=Alltrim(_QRYC->CT1_CONTA)


	******************** "FILTRAGEM" PARA IMPRESSAO *************************
                    
	If mv_par05 == 1					// So imprime Sinteticas
		If TIPOCONTA == "2"
			cArqPri->(dbSkip())
			Loop
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If TIPOCONTA == "1"
			cArqPri->(dbSkip())
			Loop
		EndIf
	EndIf

	If (Abs(COLUNA1)+Abs(COLUNA2)+Abs(COLUNA3)+Abs(COLUNA4)+Abs(COLUNA5)+Abs(COLUNA6)+;
	    Abs(COLUNA7)+Abs(COLUNA8)+Abs(COLUNA9)+Abs(COLUNA10)+Abs(COLUNA11)+Abs(COLUNA12)) == 0
		If mv_par07 == 2						// Saldos Zerados nao serao impressos
			cArqPri->(dbSkip())
			Loop	
		ElseIf  mv_par07 == 1		//Se imprime saldos zerados, verificar a data de existencia da entidade
			If CtbExDtFim("CT1") 
				dbSelectArea("CT1")
				dbSetOrder(1)
				If MsSeek(xFilial()+cArqPri->CONTA)
					If !CtbVlDtFim("CT1",mv_par01) 
			     		dbSelectArea("cArqPri")
			     		cArqPri->(dbSkip())
			     		Loop		
					EndIf
				EndIf		
			EndIf
			dbSelectArea("cArqPri")
		EndIf
	EndIf      	
	
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqPri->CONTA)) > nDigitAte
			cArqPri->(dbSkip())
			Loop
		Endif
	EndIf

	If !Empty(cSegmento)
		If Empty(cSegIni) .And. Empty(cSegFim) .And. !Empty(cFiltSegm)
			If  !(Substr(cArqPri->CONTA,nPos,nDigitos) $ (cFiltSegm) ) 
				cArqPri->(dbSkip())
				Loop
			EndIf	
		Else
			If Substr(cArqPri->CONTA,nPos,nDigitos) < Alltrim(cSegIni) .Or. ;
				Substr(cArqPri->CONTA,nPos,nDigitos) > Alltrim(cSegFim)
				cArqPri->(dbSkip())
				Loop
			EndIf	
		Endif
	EndIf	       
	
	
	////////////////////////////////// Busca SALDO da CONTA //////////////////////////////////////////////
	aSaldo := SaldoCT7Fil(cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,,,,aSelFil)
    aSaldoAnt := SaldoCT7Fil(cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,"CTBR400",,,aSelFil)
    nSaldoAtu := aSaldoAnt[6]
    nSaldoAtu := Iif(nSaldoAtu<0,Abs(nSaldoAtu),Iif(nSaldoAtu>0,nSaldoAtu*-1,0))
	_nsalcon  := nSaldoAtu
	
	If alltrim(cArqPri->CONTA)='2110413' //'1320106'  //.Or. alltrim(cArqPri->CONTA)='1110601'
	  _lixo:="lixo"
	EndIf  
	
	************************* ROTINA DE IMPRESSAO *************************
   
    /////////////////////////// CALCULO DO CUSTO INICIO /////////////////////////////////////
    //⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    //≥ Monta Arquivo Temporario para capturar tosdos os custos do MÍs de saldo ANTERIOR
    //¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ    
     aTmpcusa:={}
     _nsalcusa:=0
     If mv_par29=2
       _cQuery := "SELECT CT3_CUSTO              			   			"
       _cQuery += "FROM "+RetSqlName("CT3")+" CT3 						"   
       _cQuery += "WHERE 												"
       _cQuery += "CT3.CT3_FILIAL		= '"+xFilial("CT3")+"'	   		"  
       _cQuery += "AND CT3.CT3_CONTA 	= '"+cArqPri->CONTA+"'	    	"
       _cQuery += "AND CT3_MOEDA       = '"+mv_par08+"'                "  
       _cQuery += "AND CT3_TPSALD      = '"+mv_par10+"'                "  
       _cQuery += "AND CT3.D_E_L_E_T_ <> '*'					 		"
       _cQuery += "GROUP BY  CT3_CUSTO                         		"

       ChangeQuery(_cQuery)
       If Select("_QRYCC") > 0
       //_QRY->(DbSelectArea)
          _QRYCC->(DbCloseArea())
       Endif
       TCQUERY _cQuery NEW ALIAS "_QRYCC" 
       _QRYCC->(dbGoTop())
	   While _QRYCC->(!Eof())   
	      aSaldo    := SaldTotCT3(_QRYCC->CT3_CUSTO,_QRYCC->CT3_CUSTO,cArqPri->CONTA,cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,aSelFil)
          aSaldoAnt := SaldTotCT3(_QRYCC->CT3_CUSTO,_QRYCC->CT3_CUSTO,cArqPri->CONTA,cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,aSelFil)                            
          nSaldoAtu := aSaldoAnt[6]                               
          nSaldoAtu := Iif(nSaldoAtu<0,Abs(nSaldoAtu),Iif(nSaldoAtu>0,nSaldoAtu*-1,0))
          If nSaldoAtu <> 0
             aadd(aTmpcusa, {Alltrim(cArqPri->CONTA)+_QRYCC->CT3_CUSTO,cArqPri->CONTA,Left(cArqPri->DESCCTA,18),_QRYCC->CT3_CUSTO,Alltrim(Posicione("CTT",1,xFilial("CTT")+_QRYCC->CT3_CUSTO,"CTT->CTT_DESC01"))+" - ANTERIOR",nSaldoAtu,.T.})         
             _nsalcusa+=nSaldoAtu
          EndIf   
	      _QRYCC->(DbSkip())
       End-While
       _QRYCC->(DbCloseArea())
       If _nsalcusa<>_nsalcon .And. _nsalcon<>0
          _ndifcus:=_nsalcon-_nsalcusa
          aadd(aTmpcusa, {Alltrim(cArqPri->CONTA),cArqPri->CONTA,Left(cArqPri->DESCCTA,18),"","Saldo sem Custo ANTERIROR",_ndifcus,.F.})         
       EndIf   
       If _nsalcon<>0
          //aadd(aTmpcusa, {Alltrim(cArqPri->CONTA),cArqPri->CONTA,Left(cArqPri->DESCCTA,18),"","Saldo Conta ANTERIOR",_nsalcon,.T.})         
       EndIf   
    EndIf   
    dbSelectArea("cArqPri")
////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    //≥ Monta Arquivo Temporario para Impressao						 ≥
    //¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
    If mv_par28=2
    MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT3","",cArqPri->CONTA,cArqPri->CONTA,"","ZZZZZZZZZ",,,,,mv_par08,;
				mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
				.F.,.F.,,"CTT",lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,"CTT",/*oCentroCusto:GetAdvplExp()/*aReturn[7]*/,.T.)},;
				STR0013,;  //"Criando Arquivo Tempor†rio..."
				STR0003+Upper(Alltrim(cSayCC)) +" / " +  STR0011 )     //"Balancete Verificacao C.CUSTO / CONTA				
	EndIf			
    /////////////////////////// CALCULO DO CUSTO FINAL /////////////////////////////////////

	If mv_par11 == 1							// Grupo Diferente - Totaliza e Quebra
		If cGrupo != GRUPO
			cHtml := '    <tr>'              
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[1]),aTotGrp[1],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[2]),aTotGrp[2],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[3]),aTotGrp[3],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[4]),aTotGrp[4],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[5]),aTotGrp[5],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[6]),aTotGrp[6],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[7]),aTotGrp[7],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[8]),aTotGrp[8],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[9]),aTotGrp[9],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[10]),aTotGrp[10],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[11]),aTotGrp[11],0),"@E 9,999,999,999.99") +'</font></td>'            
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[12]),aTotGrp[12],0),"@E 9,999,999,999.99") +'</font></td>'
			//If mv_par23 = 1		// Imprime Total
				_nvltmp := aTotGrp[1] + aTotGrp[2] + aTotGrp[3] + aTotGrp[4] + aTotGrp[5] + aTotGrp[6] + aTotGrp[7] + aTotGrp[8] +;
							aTotGrp[9] + aTotGrp[10] + aTotGrp[11] + aTotGrp[12]
				cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nvltmp),_nvltmp,0),"@E 9,999,999,999.99") +'</font></td>'			
			//Endif			
			cHtml += '    </tr> '			
			fWrite(nHdl,cHTML,Len(cHTML))
			cGrupo		:= GRUPO
			aTotGrp 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
		EndIf		
	Else
		If NIVEL1				// Sintetica de 1o. grupo
			//  li 	:= 60
		EndIf
	EndIf

	IF li > 58 
		If !lFirstPage
			//  @Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		// CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
		lFirstPage := .F.
	End

	aTmpLog:={}
	_totcc01 :=0
	_totcc02 :=0
	_totcc03 :=0
	_totcc04 :=0
	_totcc05 :=0
	_totcc06 :=0
	_totcc07 :=0
	_totcc08 :=0
	_totcc09 :=0
	_totcc10 :=0
	_totcc11 :=0
	_totcc12 :=0
	
	
	_val1:=0
	_val2:=0
	_val3:=0
	_val4:=0
	_val5:=0
	_val6:=0
	_val7:=0
	_val8:=0
	_val9:=0
	_val10:=0
	_val11:=0
	_val12:=0
	_vsalacuc:=0
	
	If mv_par28=2
    If !cArqTmp->(Eof()) 
       While !cArqTmp->(Eof())       
            
           
           If !Empty(mv_par26) .Or. !Empty(mv_par27) 
               If !(cArqTmp->CUSTO>=mv_par26 .And. cArqTmp->CUSTO<=mv_par27)
                  cArqTmp->(DbSkip())
                  Loop
               Endif   
           Endif
            
            nPos := Ascan(aTmpLog,{|x| x[1]== Alltrim(cArqPri->CONTA)+cArqTmp->CUSTO})
            
            If nPos>0
               cArqTmp->(DbSkip())
               Loop
            EndIf
            
            nPos := Ascan(aTmpcusa,{|x| x[1]== Alltrim(cArqPri->CONTA)+cArqTmp->CUSTO}) 
            
            If nPos>0 
               aTmpcusa[nPos,7]:=.F. 
            EndIf
            
            aadd(aTmpLog, {Alltrim(cArqPri->CONTA)+cArqTmp->CUSTO})         
            
            
            If alltrim(cArqPri->CONTA)='1110204' //'1320106'  .Or. alltrim(cArqPri->CONTA)='1110601'
	           _lixo:="lixo"
	        EndIf  

       
            aSaldo    := SaldTotCT3(cArqTmp->CUSTO,cArqTmp->CUSTO,cArqPri->CONTA,cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,aSelFil)
            aSaldoAnt := SaldTotCT3(cArqTmp->CUSTO,cArqTmp->CUSTO,cArqPri->CONTA,cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,aSelFil)                            
            nSaldoAtu := aSaldoAnt[6]                               
            nSaldoAtu := Iif(nSaldoAtu<0,Abs(nSaldoAtu),Iif(nSaldoAtu>0,nSaldoAtu*-1,0))
	        _vsalacuc+=nSaldoAtu
	        _vsalantf+=nSaldoAtu
	
	
	        _val1:=Iif(cArqTmp->COLUNA1<0,Abs(cArqTmp->COLUNA1),Iif(cArqTmp->COLUNA1>0,cArqTmp->COLUNA1*-1,0))
	        _val2:=Iif(cArqTmp->COLUNA2<0,Abs(cArqTmp->COLUNA2),Iif(cArqTmp->COLUNA2>0,cArqTmp->COLUNA2*-1,0))
	        _val3:=Iif(cArqTmp->COLUNA3<0,Abs(cArqTmp->COLUNA3),Iif(cArqTmp->COLUNA3>0,cArqTmp->COLUNA3*-1,0))
	        _val4:=Iif(cArqTmp->COLUNA4<0,Abs(cArqTmp->COLUNA4),Iif(cArqTmp->COLUNA4>0,cArqTmp->COLUNA4*-1,0))
	        _val5:=Iif(cArqTmp->COLUNA5<0,Abs(cArqTmp->COLUNA5),Iif(cArqTmp->COLUNA5>0,cArqTmp->COLUNA5*-1,0))
	        _val6:=Iif(cArqTmp->COLUNA6<0,Abs(cArqTmp->COLUNA6),Iif(cArqTmp->COLUNA6>0,cArqTmp->COLUNA6*-1,0))
	        _val7:=Iif(cArqTmp->COLUNA7<0,Abs(cArqTmp->COLUNA7),Iif(cArqTmp->COLUNA7>0,cArqTmp->COLUNA7*-1,0))
	        _val8:=Iif(cArqTmp->COLUNA8<0,Abs(cArqTmp->COLUNA8),Iif(cArqTmp->COLUNA8>0,cArqTmp->COLUNA8*-1,0))
	        _val9:=Iif(cArqTmp->COLUNA9<0,Abs(cArqTmp->COLUNA9),Iif(cArqTmp->COLUNA9>0,cArqTmp->COLUNA9*-1,0))
	        _val10:=Iif(cArqTmp->COLUNA10<0,Abs(cArqTmp->COLUNA10),Iif(cArqTmp->COLUNA10>0,cArqTmp->COLUNA10*-1,0))
	        _val11:=Iif(cArqTmp->COLUNA11<0,Abs(cArqTmp->COLUNA11),Iif(cArqTmp->COLUNA11>0,cArqTmp->COLUNA11*-1,0))
	        _val12:=Iif(cArqTmp->COLUNA12<0,Abs(cArqTmp->COLUNA12),Iif(cArqTmp->COLUNA12>0,cArqTmp->COLUNA12*-1,0))
	
	
            //_nsalcon-=Iif(_nsalcon<>0,nSaldoAtu,0)
            cHtml := '    <tr>'              
            cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+Alltrim(cArqPri->CONTA)+'</font></td>'
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+Left(cArqPri->DESCCTA,18)+'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(nSaldoAtu),nSaldoAtu,0),"@E 9,999,999,999.99") +'</font></td>'
	        //cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+cArqTmp->CUSTO+'</font></td>'
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+cArqTmp->DESCCC+'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val1,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val2,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val3,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val4,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val5,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val6,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val7,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val8,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val9,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val10,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val11,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val12,"@E 9,999,999,999.99") +'</font></td>'
	        
	        Facum(TIPOCONTA,aMeses,NIVEL1,@aTotCol,@aTotGrp,cSegAte)
	        // Totaliza os Centro de Custos por Periodo
	        _totcc01 +=Iif(cArqTmp->COLUNA1<0,Abs(cArqTmp->COLUNA1),Iif(cArqTmp->COLUNA1>0,cArqTmp->COLUNA1*-1,0))
	        _totcc02 +=Iif(cArqTmp->COLUNA2<0,Abs(cArqTmp->COLUNA2),Iif(cArqTmp->COLUNA2>0,cArqTmp->COLUNA2*-1,0))
        	_totcc03 +=Iif(cArqTmp->COLUNA3<0,Abs(cArqTmp->COLUNA3),Iif(cArqTmp->COLUNA3>0,cArqTmp->COLUNA3*-1,0))
        	_totcc04 +=Iif(cArqTmp->COLUNA4<0,Abs(cArqTmp->COLUNA4),Iif(cArqTmp->COLUNA4>0,cArqTmp->COLUNA4*-1,0))
        	_totcc05 +=Iif(cArqTmp->COLUNA5<0,Abs(cArqTmp->COLUNA5),Iif(cArqTmp->COLUNA5>0,cArqTmp->COLUNA5*-1,0))
        	_totcc06 +=Iif(cArqTmp->COLUNA6<0,Abs(cArqTmp->COLUNA6),Iif(cArqTmp->COLUNA6>0,cArqTmp->COLUNA6*-1,0))
        	_totcc07 +=Iif(cArqTmp->COLUNA7<0,Abs(cArqTmp->COLUNA7),Iif(cArqTmp->COLUNA7>0,cArqTmp->COLUNA7*-1,0))
        	_totcc08 +=Iif(cArqTmp->COLUNA8<0,Abs(cArqTmp->COLUNA8),Iif(cArqTmp->COLUNA8>0,cArqTmp->COLUNA8*-1,0))
        	_totcc09 +=Iif(cArqTmp->COLUNA9<0,Abs(cArqTmp->COLUNA9),Iif(cArqTmp->COLUNA9>0,cArqTmp->COLUNA9*-1,0))
        	_totcc10 +=Iif(cArqTmp->COLUNA10<0,Abs(cArqTmp->COLUNA10),Iif(cArqTmp->COLUNA10>0,cArqTmp->COLUNA10*-1,0))
        	_totcc11 +=Iif(cArqTmp->COLUNA11<0,Abs(cArqTmp->COLUNA11),Iif(cArqTmp->COLUNA11>0,cArqTmp->COLUNA11*-11,0))
        	_totcc12 +=Iif(cArqTmp->COLUNA12<0,Abs(cArqTmp->COLUNA12),Iif(cArqTmp->COLUNA12>0,cArqTmp->COLUNA12*-1,0))
	        
	        //If mv_par23 = 1		// Imprime Total
	        /*
		       _tottmp:=cArqTmp->COLUNA1+cArqTmp->COLUNA2+cArqTmp->COLUNA3+cArqTmp->COLUNA4+cArqTmp->COLUNA5+cArqTmp->COLUNA6+cArqTmp->COLUNA7+;
		       cArqTmp->COLUNA8+cArqTmp->COLUNA9+cArqTmp->COLUNA10+cArqTmp->COLUNA11+cArqTmp->COLUNA12
		       cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(_tottmp<0,Abs(_tottmp),Iif(_tottmp>0,_tottmp*-1,0)),"@E 9,999,999,999.99") +'</font></td>'
		       */
		       _tottmp:=_val1+_val2+_val3+_val4+_val5+_val6+_val7+_val8+_val9+_val10+_val11+_val12
		       cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_tottmp,"@E 9,999,999,999.99") +'</font></td>'
	        //Endif  
	          cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_tottmp+nSaldoAtu,"@E 9,999,999,999.99") +'</font></td>'
	          _nvalfins+=_tottmp+nSaldoAtu
	        
	        cHtml += '    </tr> '	
	        fWrite(nHdl,cHTML,Len(cHTML))		
            cArqTmp->(DbSkip())
       End-While
       
	EndIf
	EndIf
	
	If mv_par28=1
	  //cArqTmp->(dbGoBottom())
	  //cArqTmp->(DbSkip())
	  _ceof:="mv_par28=1"
	Else
	   cArqTmp->(dbGoTop())
	   _ceof:="cArqTmp->(Eof())"
	EndIf
    If &_ceof //cArqTmp->(Eof()) 
    
	   _val1:=Iif(cArqPri->COLUNA1<0,Abs(cArqPri->COLUNA1),Iif(cArqPri->COLUNA1>0,cArqPri->COLUNA1*-1,0))
	   _val2:=Iif(cArqPri->COLUNA2<0,Abs(cArqPri->COLUNA2),Iif(cArqPri->COLUNA2>0,cArqPri->COLUNA2*-1,0))
	   _val3:=Iif(cArqPri->COLUNA3<0,Abs(cArqPri->COLUNA3),Iif(cArqPri->COLUNA3>0,cArqPri->COLUNA3*-1,0))
	   _val4:=Iif(cArqPri->COLUNA4<0,Abs(cArqPri->COLUNA4),Iif(cArqPri->COLUNA4>0,cArqPri->COLUNA4*-1,0))
	   _val5:=Iif(cArqPri->COLUNA5<0,Abs(cArqPri->COLUNA5),Iif(cArqPri->COLUNA5>0,cArqPri->COLUNA5*-1,0))
	   _val6:=Iif(cArqPri->COLUNA6<0,Abs(cArqPri->COLUNA6),Iif(cArqPri->COLUNA6>0,cArqPri->COLUNA6*-1,0))
	   _val7:=Iif(cArqPri->COLUNA7<0,Abs(cArqPri->COLUNA7),Iif(cArqPri->COLUNA7>0,cArqPri->COLUNA7*-1,0))
	   _val8:=Iif(cArqPri->COLUNA8<0,Abs(cArqPri->COLUNA8),Iif(cArqPri->COLUNA8>0,cArqPri->COLUNA8*-1,0))
	   _val9:=Iif(cArqPri->COLUNA9<0,Abs(cArqPri->COLUNA9),Iif(cArqPri->COLUNA9>0,cArqPri->COLUNA9*-1,0))
	   _val10:=Iif(cArqPri->COLUNA10<0,Abs(cArqPri->COLUNA10),Iif(cArqPri->COLUNA10>0,cArqPri->COLUNA10*-1,0))
	   _val11:=Iif(cArqPri->COLUNA11<0,Abs(cArqPri->COLUNA11),Iif(cArqPri->COLUNA11>0,cArqPri->COLUNA11*-1,0))
	   _val12:=Iif(cArqPri->COLUNA12<0,Abs(cArqPri->COLUNA12),Iif(cArqPri->COLUNA12>0,cArqPri->COLUNA12*-1,0))
	   //_vsalantf+=nSaldoAtu
    
	   // Inicio do HTML LINHA
	   cHtml := '    <tr>'              
	   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqPri->CONTA) +'</font></td>'
	   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Left(cArqPri->DESCCTA,18) +'</font></td>'
	   If mv_par28=1 
	      cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nsalcon),_nsalcon,0),"@E 9,999,999,999.99") +'</font></td>'
	      _vsalantf+=_nsalcon
	   Else
	      cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(nSaldoAtu),nSaldoAtu,0),"@E 9,999,999,999.99") +'</font></td>'
	      _vsalantf+=nSaldoAtu
	   EndIf
	   //cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	   // IMPRIME OS MESES EM HTML
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val1,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val2,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val3,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val4,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val5,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val6,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val7,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val8,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val9,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val10,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val11,"@E 9,999,999,999.99") +'</font></td>'
	   cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val12,"@E 9,999,999,999.99") +'</font></td>'

	   Facum(TIPOCONTA,aMeses,NIVEL1,@aTotCol,@aTotGrp,cSegAte)
	   //If mv_par23 = 1		// Imprime Total
	   /*
		 _tottmp:=cArqPri->COLUNA1+cArqPri->COLUNA2+cArqPri->COLUNA3+cArqPri->COLUNA4+cArqPri->COLUNA5+cArqPri->COLUNA6+cArqPri->COLUNA7+;
		 cArqPri->COLUNA8+cArqPri->COLUNA9+cArqPri->COLUNA10+cArqPri->COLUNA11+cArqPri->COLUNA12
		 cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(_tottmp<0,Abs(_tottmp),Iif(_tottmp>0,_tottmp*-1,0)),"@E 9,999,999,999.99") +'</font></td>'
		 */
		 _tottmp:=_val1+_val2+_val3+_val4+_val5+_val6+_val7+_val8+_val9+_val10+_val11+_val12
		 cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_tottmp,"@E 9,999,999,999.99") +'</font></td>'
	   //Endif       
	     If mv_par28=1 
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_nsalcon+_tottmp,"@E 9,999,999,999.99") +'</font></td>'
	        _nvalfins+=_nsalcon+_tottmp
	     Else
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(nSaldoAtu+_tottmp,"@E 9,999,999,999.99") +'</font></td>'
	        _nvalfins+=nSaldoAtu+_tottmp
	     EndIf   
	   cHtml += '    </tr> '			
	   fWrite(nHdl,cHTML,Len(cHTML))
    
    Else
    
            IF cArqPri->COLUNA12<>0
               _lixo:=0
            EndIf

             
       If mv_par28=2
	     _tottmp:=cArqPri->COLUNA1+cArqPri->COLUNA2+cArqPri->COLUNA3+cArqPri->COLUNA4+cArqPri->COLUNA5+cArqPri->COLUNA6+cArqPri->COLUNA7+;
	     cArqPri->COLUNA8+cArqPri->COLUNA9+cArqPri->COLUNA10+cArqPri->COLUNA11+cArqPri->COLUNA12
		 
	     _tottmpc:=_totcc01+_totcc02+_totcc03+_totcc04+_totcc05+_totcc06+_totcc07+_totcc08+_totcc09+_totcc10+_totcc11+_totcc12
	     
	     
	     _nsaltmp:=0
	     nPos := Ascan(aTmpcusa,{|x| x[1]== Alltrim(cArqPri->CONTA)}) 
         If nPos>0 
            For _ww=nPos To Len(aTmpcusa)
               If aTmpcusa[_ww,2]=Alltrim(cArqPri->CONTA) .And. aTmpcusa[_ww,5]="Saldo sem Custo ANTERIROR"
                  _nsaltmp:=aTmpcusa[_ww,6]
                  Exit
               EndIf
               If aTmpcusa[_ww,2]<>Alltrim(cArqPri->CONTA)   
                  Exit
               EndIf
            Next _ww
         EndIf

	     
	   
	     If Iif(_tottmp<0,Abs(_tottmp),Iif(_tottmp>0,_tottmp*-1,0))-_tottmpc<>0	 .Or. _nsaltmp<>0
	     
	     	_val1:=Iif(cArqPri->COLUNA1<0,Abs(cArqPri->COLUNA1)-_totcc01,Iif(cArqPri->COLUNA1>0,(cArqPri->COLUNA1*-1)-_totcc01,0))
	        _val2:=Iif(cArqPri->COLUNA2<0,Abs(cArqPri->COLUNA2)-_totcc02,Iif(cArqPri->COLUNA2>0,(cArqPri->COLUNA2*-1)-_totcc02,0))
	        _val3:=Iif(cArqPri->COLUNA3<0,Abs(cArqPri->COLUNA3)-_totcc03,Iif(cArqPri->COLUNA3>0,(cArqPri->COLUNA3*-1)-_totcc03,0))
	        _val4:=Iif(cArqPri->COLUNA4<0,Abs(cArqPri->COLUNA4)-_totcc04,Iif(cArqPri->COLUNA4>0,(cArqPri->COLUNA4*-1)-_totcc04,0))
	        _val5:=Iif(cArqPri->COLUNA5<0,Abs(cArqPri->COLUNA5)-_totcc05,Iif(cArqPri->COLUNA5>0,(cArqPri->COLUNA5*-1)-_totcc05,0))
	        _val6:=Iif(cArqPri->COLUNA6<0,Abs(cArqPri->COLUNA6)-_totcc06,Iif(cArqPri->COLUNA6>0,(cArqPri->COLUNA6*-1)-_totcc06,0))
	        _val7:=Iif(cArqPri->COLUNA7<0,Abs(cArqPri->COLUNA7)-_totcc07,Iif(cArqPri->COLUNA7>0,(cArqPri->COLUNA7*-1)-_totcc07,0))
	        _val8:=Iif(cArqPri->COLUNA8<0,Abs(cArqPri->COLUNA8)-_totcc08,Iif(cArqPri->COLUNA8>0,(cArqPri->COLUNA8*-1)-_totcc08,0))
	        _val9:=Iif(cArqPri->COLUNA9<0,Abs(cArqPri->COLUNA9)-_totcc09,Iif(cArqPri->COLUNA9>0,(cArqPri->COLUNA9*-1)-_totcc09,0))
	        _val10:=Iif(cArqPri->COLUNA10<0,Abs(cArqPri->COLUNA10)-_totcc10,Iif(cArqPri->COLUNA10>0,(cArqPri->COLUNA10*-1)-_totcc10,0))
	        _val11:=Iif(cArqPri->COLUNA11<0,Abs(cArqPri->COLUNA11)-_totcc11,Iif(cArqPri->COLUNA11>0,(cArqPri->COLUNA11*-1)-_totcc11,0))
	        _val12:=Iif(cArqPri->COLUNA12<0,Abs(cArqPri->COLUNA12)-_totcc12,Iif(cArqPri->COLUNA12>0,(cArqPri->COLUNA12*-1)-_totcc12,0))
	        _vsalantf+=_nsaltmp //Iif(_nsalcon<>0 .And. _vsalacuc<>0,(_nsalcon-_vsalacuc),0)
	        _nvalsalc:=Iif(_nsalcon<>0 .And. _vsalacuc<>0,(_nsalcon-_vsalacuc),0)
		 	 
	        // Inicio do HTML LINHA
	        cHtml := '    <tr>'              
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(cArqPri->CONTA) +'</font></td>'
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Left(cArqPri->DESCCTA,18) +'</font></td>'
	        If Empty(_nsaltmp)
	           cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'   // _vsalacuc  // _nsalcon
	        Else
	           cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_nsaltmp,"@E 9,999,999,999.99") +'</font></td>'
	        EndIf   
	        //cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_nvalsalc,"@E 9,999,999,999.99") +'</font></td>'
	        //cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	         
	        If alltrim(cArqPri->CONTA)='1110204' //'1320106'  //.Or. alltrim(cArqPri->CONTA)='1110601'
	          _lixo:="lixo"
	        EndIf  
	                 
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	        cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+"Sem Centro de Custo"+'</font></td>'
	        // IMPRIME OS MESES EM HTML
	   
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val1,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val2,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val3,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val4,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val5,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val6,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val7,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val8,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val9,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val10,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val11,"@E 9,999,999,999.99") +'</font></td>'
	        cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_val12,"@E 9,999,999,999.99") +'</font></td>'
	        Facum(TIPOCONTA,aMeses,NIVEL1,@aTotCol,@aTotGrp,cSegAte)
	        _tottmp:=_val1+_val2+_val3+_val4+_val5+_val6+_val7+_val8+_val9+_val10+_val11+_val12
            //If mv_par23 = 1		// Imprime Total
		      //cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(_tottmp<0,Abs(_tottmp),Iif(_tottmp>0,(_tottmp*-1),0)),"@E 9,999,999,999.99") +'</font></td>'
		      cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_tottmp,"@E 9,999,999,999.99") +'</font></td>'
	        //Endif           
	        If Empty(_nsaltmp)
	           cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_tottmp,"@E 9,999,999,999.99") +'</font></td>'
	           _nvalfins+=_tottmp
	        Else
	           cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_tottmp+_nsaltmp,"@E 9,999,999,999.99") +'</font></td>'
	           _nvalfins+=_tottmp+_nsaltmp
	        EndIf    
	        
	        cHtml += '    </tr> '			
	        fWrite(nHdl,cHTML,Len(cHTML))
         EndIf
         
         If Len(aTmpcusa)>0
            For _xx=1 to Len(aTmpcusa)   
               If aTmpcusa[_xx,7]
                  // Inicio do HTML LINHA                                                                          
                  // Alltrim(CONTA)+cArqTmp->CUSTO,CONTA,Left(DESCCTA,18),cArqTmp->CUSTO,cArqTmp->DESCCC+" - ANTERIOR",nSaldoAtu,.T.
                  If aTmpcusa[_xx,5]<>"Saldo Conta ANTERIOR"
                     _vsalantf+=aTmpcusa[_xx,6]
                  EndIf   
	              cHtml := '    <tr>'              
	              cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(aTmpcusa[_xx,2]) +'</font></td>'
	              cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ aTmpcusa[_xx,3] +'</font></td>'
	              //cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'   // _vsalacuc  // _nsalcon
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTmpcusa[_xx,6],"@E 9,999,999,999.99") +'</font></td>'
	              //cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ aTmpcusa[_xx,4] +'</font></td>'
	              cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ aTmpcusa[_xx,5] +'</font></td>'
	              // IMPRIME OS MESES EM HTML
	   
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	              
	              cHtml += '    </tr> '			
	              fWrite(nHdl,cHTML,Len(cHTML))
	           EndIf   
            Next _xx
         EndIf
         
       EndIf

    EndIf
	
	
	lJaPulou := .F.
	
	If lPula .And. TIPOCONTA == "1"				// Pula linha entre sinteticas
		//If mv_par23 <> 1		// Com total, nao imprime descricao
			// JAS @ li,aColunas[COL_SEPARA3] PSAY "|"	
		//Endif
		lJaPulou := .T.
	Else
		li++
	EndIf			

	************************* FIM   DA  IMPRESSAO *************************
                    /*
	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If TIPOCONTA == "1"			
			If NIVEL1      
				For nVezes := 1 to Len(aMeses) 
					//aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))				
					//aTotGrp[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))
					aTotCol[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))				
					aTotGrp[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))
				Next	
			EndIf
		EndIf
	Else									// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If TIPOCONTA == "2"
				For nVezes := 1 to Len(aMeses)   // _val
					//aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))
					//aTotGrp[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))									
					aTotCol[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))
					aTotGrp[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))
				Next							
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If TIPOCONTA == "1"
				If NIVEL1
					For nVezes := 1 to Len(aMeses)
						//aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))				
						aTotCol[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))				
					Next							
				EndIf
			EndIf
    	Endif			
	EndIf             */

	cArqPri->(DbSkip())       
	If lPula .And. TIPOCONTA == "1" 			// Pula linha entre sinteticas
		If !lJaPulou
			//If mv_par23 <> 1		// Com total, nao imprime descricao
		//		@ li,aColunas[COL_SEPARA3] PSAY "|"	
			//Endif
		EndIf	
	EndIf		
Enddo                                                                                   
Else                      
    aSaldo := SaldoCT7Fil(_QRYC->CT1_CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,,,,aSelFil)
    aSaldoAnt := SaldoCT7Fil(_QRYC->CT1_CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,"CTBR400",,,aSelFil)
    nSaldoAtu := aSaldoAnt[6]
    nSaldoAtu := Iif(nSaldoAtu<0,Abs(nSaldoAtu),Iif(nSaldoAtu>0,nSaldoAtu*-1,0))
    _vsalantf+=nSaldoAtu
                    
	cHtml := '    <tr>'              
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Alltrim(_QRYC->CT1_CONTA) +'</font></td>'
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Left(_QRYC->CT1_DESC01,18) +'</font></td>'
    cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(nSaldoAtu,"@E 9,999,999,999.99") +'</font></td>'
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+"Conta Fora do Periodo"+'</font></td>'
	// IMPRIME OS MESES EM HTML                
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    </tr> '			
	fWrite(nHdl,cHTML,Len(cHTML))
EndIf
   _QRYC->(DbSkip())
End-While	


IF li != 80 .And. !lEnd
	IF li > 58 
		li++
	End
	If mv_par11 == 1							// Grupo Diferente - Totaliza e Quebra
		If cGrupo != GRUPO
			li++
			cHtml := '    <tr>'              
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
			
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[1]),aTotGrp[1],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[2]),aTotGrp[2],0),"@E 9,999,999,999.99") +'</font></td>'
            cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[3]),aTotGrp[3],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[4]),aTotGrp[4],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[5]),aTotGrp[5],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[6]),aTotGrp[6],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[7]),aTotGrp[7],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[8]),aTotGrp[8],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[9]),aTotGrp[9],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[10]),aTotGrp[10],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[11]),aTotGrp[11],0),"@E 9,999,999,999.99") +'</font></td>'
			cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(aTotGrp[12]),aTotGrp[12],0),"@E 9,999,999,999.99") +'</font></td>'
			//If mv_par23 = 1		// Imprime Total
				_vltmp :=aTotGrp[1] + aTotGrp[2] + aTotGrp[3] + aTotGrp[4] + aTotGrp[5] + aTotGrp[6] + aTotGrp[7] + aTotGrp[8] +;
				aTotGrp[9] + aTotGrp[10] + aTotGrp[11] + aTotGrp[12]
				
				cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_vltmp),_vltmp,0),"@E 9,999,999,999.99") +'</font></td>'
				
			//Endif			
			cGrupo		:= GRUPO
			aTotGrp 	:= {0,0,0,0,0,0}
			cHtml += '    </tr> '			
			fWrite(nHdl,cHTML,Len(cHTML))
		EndIf		
	EndIf

	cHtml := '    <tr>'              
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_vsalantf,"@E 9,999,999,999.99") +'</font></td>'
	//cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+'</font></td>'
	cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+" T O T A L   G E R A L "+'</font></td>'
	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[1],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[2],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[3],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[4],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[5],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[6],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[7],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[8],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[9],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[10],"@E 9,999,999,999.99") +'</font></td>'

    cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[11],"@E 9,999,999,999.99") +'</font></td>'

	cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(aTotCol[12],"@E 9,999,999,999.99") +'</font></td>'

	//If mv_par23 = 1		// Imprime Total

		_valtmp := aTotCol[1] + aTotCol[2] + aTotCol[3] + aTotCol[4] + aTotCol[5] + aTotCol[6] + aTotCol[7] + aTotCol[8] + ;
					aTotCol[9] + aTotCol[10] + aTotCol[11] + aTotCol[12]
		cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_valtmp,"@E 9,999,999,999.99") +'</font></td>'			
		
		cHtml += '    <td width="30%" align="right"> <font face="Tahoma" size="1">'+ Transform(_nvalfins,"@E 9,999,999,999.99") +'</font></td>'			
					
	//Endif			
    cHtml += '    </tr> '			 
    fWrite(nHdl,cHTML,Len(cHTML))

	Set Filter To	
EndIF

cHtml := '</table> '
cHtml += '</body> '                                                                 
cHtml += '</html> '     
		
fWrite(nHdl,cHTML,Len(cHTML))
		
fClose(nHdl)
   
CpyS2T( GetSrvProfString("StartPath","",GetAdv97()) + cArquivo, cPath, .T. )
ShellExecute("OPEN",cPath + cArquivo,"","",5)

dbSelectArea("cArqPri")
Set Filter To
dbCloseArea() 
If Select("cArqPri") == 0
	FErase(cArqPri+GetDBExtension())
	FErase(cArqPri+OrdBagExt())
EndIF	
dbselectArea("CT2")


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±≥FunáÖo≥ CTGerCMA≥ Autor ≥ Juscelino Alves dos Santos ≥ Data ≥ 04.12.14≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Balancete Comparativo de Movim. de Contas x 12 Colunas	  ≥±±
±±             e Custo                                               	  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno   ≥ .T. / .F.                                                  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ ExpO1 = Objeto oMeter                                      ≥±±
±±≥          ≥ ExpO2 = Objeto oText                                       ≥±±
±±≥          ≥ ExpO3 = Objeto oDlg                                        ≥±±
±±≥          ≥ ExpL1 = lEnd                                               ≥±±
±±≥          ≥ ExpD1 = Data Inicial                                       ≥±±
±±≥          ≥ ExpD2 = Data Final                                         ≥±±
±±≥          ≥ ExpC1 = Alias do Arquivo                                   ≥±±
±±≥          ≥ ExpC2 = Conta Inicial                                      ≥±±
±±≥          ≥ ExpC3 = Conta Final                                        ≥±±
±±≥          ≥ ExpC4 = Centro de Custo Inicial                            ≥±±
±±≥          ≥ ExpC5 = Centro de Custo Final                              ≥±±
±±≥          ≥ ExpC6 = Centro de Custo Inicial                            ≥±±
±±≥          ≥ ExpC7 = Centro de Custo Final                              ≥±±
±±≥          ≥ ExpC8 = Item Inicial                                       ≥±±
±±≥          ≥ ExpC9 = Item Final                                         ≥±±
±±≥          ≥ ExpC10= Classe de Valor Inicial                            ≥±±
±±≥          ≥ ExpC11= Classe de Valor Final                              ≥±±
±±≥          ≥ ExpC12= Moeda		                                      ≥±±
±±≥          ≥ ExpC13= Saldo	                                          ≥±±
±±≥          ≥ ExpA1 = Set Of Book	                                      ≥±±
±±≥          ≥ ExpC13= Ate qual segmento sera impresso (nivel)			  ≥±±
±±≥          ≥ ExpC8 = Filtra por Segmento		                          ≥±±
±±≥          ≥ ExpC9 = Segmento Inicial		                              ≥±±
±±≥          ≥ ExpC10= Segmento Final  		                              ≥±±
±±≥          ≥ ExpC11= Segmento Contido em  	                          ≥±±
±±≥          ≥ ExpL2 = Se Imprime Entidade sem movimento                  ≥±±
±±≥          ≥ ExpL3 = Se Imprime Conta                                   ≥±±
±±≥          ≥ ExpN1 = Grupo                                              ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function CTGerCMA(oMeter,oText,oDlg,lEnd,cArqtmp,;
						dDataIni,dDataFim,cAlias,cIdent,cContaIni,;
				  		cContaFim,cCCIni,cCCFim,cItemIni,cItemFim,cClvlIni,	cClVlFim,cMoeda,;
				  		cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				  		lNImpMov,lImpConta,nGrupo,cHeader,lImpAntLP,dDataLP,nDivide,cTpVlr,;
				  		lFiliais,aFiliais,lMeses,aMeses,lVlrZerado,lEntid,aEntid,lImpSint,cString,;
				  		cFilUSU,lImpTotS,lImp4Ent,c1aEnt,c2aEnt,c3aEnt,c4aEnt,lAtSlBase,lValMed,lSalAcum,aSelFil,lTodasFil)
						
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local aTamCC        := TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
Local aTamItem  	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCvRes 	:= TAMSX3("CTH_RES")
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local aCtbMoeda		:= {}
Local aSaveArea 	:= GetArea()
Local aCampos
Local aStruTMP		:= {}
Local cChave
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+cMoeda))
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+cMoeda))
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+cMoeda))
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+cMoeda))
Local nTamGrupo		:= Len(CriaVar("CT1->CT1_GRUPO"))
Local nDecimais		:= 0
Local cEntidIni		:= ""
Local cEntidFim		:= ""           
Local cEntidIni1	:= ""
Local cEntidFim1	:= ""
Local cEntidIni2	:= ""
Local cEntidFim2	:= ""
Local cArqTmp1		:= ""
Local lCusto		:= CtbMovSaldo("CTT")//Define se utiliza C.Custo
Local lItem 		:= CtbMovSaldo("CTD")//Define se utiliza Item
Local lClVl			:= CtbMovSaldo("CTH")//Define se utiliza Cl.Valor 
Local lAtSldBase	:= Iif(GetMV("MV_ATUSAL")== "S",.T.,.F.) 
Local lAtSldCmp		:= Iif(GetMV("MV_SLDCOMP")== "S",.T.,.F.)
Local nInicio		:= Val(cMoeda)
Local nFinal		:= Val(cMoeda)
Local cFilDe		:= xFilial(cAlias)
Local cFilate		:= xFilial(cAlias)
Local cMensagem		:= ""
Local nMeter		:= 0
Local lTemQry		:= .F.							/// SE UTILIZOU AS QUERYS PARA OBTER O SALDO DAS ANALITICAS
Local nTRB			:= 1
Local nCont			:= 0 
Local dDataAnt		:= CTOD("  /  /  ")
Local cFilXAnt		:= ""
Local nTamFilial 	:= TamSx3( "CT2_FILIAL" )[1] //IIf( lFWCodFil, FWGETTAMFILIAL, TamSx3( "CT2_FILIAL" )[1] )

#IFDEF TOP
	Local nMin	:= 0 
	Local nMax	:= 0 
#ENDIF

cIdent		:=	Iif(cIdent == Nil,'',cIdent)
nGrupo		:=	Iif(nGrupo == Nil,2,nGrupo)                                                 
cHeader		:= Iif(cHeader == Nil,'',cHeader)

DEFAULT lImpSint	:= .F.                                              
DEFAULT cMoeda		:= "01"		//// SE NAO FOR INFORMADA A MOEDA ASSUME O PADRAO 01
DEFAULT lEntid		:= .F.
DEFAULT lMeses		:= .F.
DEFAULT lImpTotS	:= .F.
DEFAULT lImp4Ent	:= .F.
DEFAULT c1aEnt		:= ""
DEFAULT c2aEnt		:= ""
DEFAULT c3aEnt		:= ""
DEFAULT c4aEnt		:= ""
DEFAULT lAtSlBase	:= .T.
DEFAULT lValMed		:= .F.
DEFAULT lSalAcum	:= .F.
DEFAULT lTodasFil   := .F.
dMinData := CTOD("")

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

aCampos := {{ "CONTA"		, "C", aTamConta[1], 0 },;  			// Codigo da Conta
	 		 { "NORMAL"		, "C", 01			, 0 },;			// Situacao
			 { "CTARES"		, "C", aTamCtaRes[1], 0 },;  			// Codigo Reduzido da Conta
			 { "DESCCTA"	, "C", nTamCta		, 0 },;  			// Descricao da Conta
             { "CUSTO"		, "C", aTamCC[1]	, 0 },; 	 		// Codigo do Centro de Custo
			 { "CCRES"		, "C", aTamCCRes[1], 0 },;  			// Codigo Reduzido do Centro de Custo
			 { "DESCCC" 	, "C", nTamCC		, 0 },;  			// Descricao do Centro de Custo
	         { "ITEM"		, "C", aTamItem[1]	, 0 },; 	 		// Codigo do Item          
			 { "ITEMRES" 	, "C", aTamItRes[1], 0 },;  			// Codigo Reduzido do Item
			 { "DESCITEM" 	, "C", nTamItem		, 0 },;  			// Descricao do Item
             { "CLVL"		, "C", aTamClVl[1]	, 0 },; 	 		// Codigo da Classe de Valor
             { "CLVLRES"	, "C", aTamCVRes[1], 0 },; 		 	// Cod. Red. Classe de Valor
			 { "DESCCLVL"   , "C", nTamClVl		, 0 },;  			// Descricao da Classe de Valor
			 { "COLUNA1"	, "N", aTamVal[1]+2, nDecimais},; 	// Saldo Anterior
   		 	 { "COLUNA2"   	, "N", aTamVal[1]+2	, nDecimais},; 	// Saldo Anterior Debito
 			 { "COLUNA3"   	, "N", aTamVal[1]+2	, nDecimais},; 	// Saldo Anterior Credito
			 { "COLUNA4" 	, "N", aTamVal[1]+2	, nDecimais},;  	// Debito
			 { "COLUNA5" 	, "N", aTamVal[1]+2	, nDecimais},;  	// Credito
			 { "COLUNA6"  	, "N", aTamVal[1]+2	, nDecimais},;  	// Saldo Atual             
			 { "COLUNA7"	, "N", aTamVal[1]+2	, nDecimais},; 	// Saldo Anterior
   		 	 { "COLUNA8"   	, "N", aTamVal[1]+2	, nDecimais},; 	// Saldo Anterior Debito
 			 { "COLUNA9"   	, "N", aTamVal[1]+2	, nDecimais},; 	// Saldo Anterior Credito
			 { "COLUNA10" 	, "N", aTamVal[1]+2	, nDecimais},;  	// Debito
			 { "COLUNA11" 	, "N", aTamVal[1]+2	, nDecimais},;  	// Credito
			 { "COLUNA12"  	, "N", aTamVal[1]+2	, nDecimais},;  	// Saldo Atual               			   
			 { "TIPOCONTA"	, "C", 01			, 0 },;			// Conta Analitica / Sintetica           
 			 { "TIPOCC"  	, "C", 01			, 0 },;			// Centro de Custo Analitico / Sintetico
 			 { "TIPOITEM"	, "C", 01			, 0 },;			// Item Analitica / Sintetica			 
 			 { "TIPOCLVL"	, "C", 01			, 0 },;			// Classe de Valor Analitica / Sintetica			 
  			 { "CTASUP"		, "C", aTamConta[1], 0 },;			// Codigo do Centro de Custo Superior
 			 { "CCSUP"		, "C", aTamCC[1]	, 0 },;			// Codigo do Centro de Custo Superior
			 { "ITSUP"		, "C", aTamItem[1]	, 0 },;			// Codigo do Item Superior
 			 { "CLSUP"	    , "C", aTamClVl[1] , 0 },;			// Codigo da Classe de Valor Superior
			 { "ORDEM"		, "C", 10			, 0 },;			// Ordem
			 { "GRUPO"		, "C", nTamGrupo	, 0 },;			// Grupo Contabil
		     { "TOTVIS"		, "C", 01			, 0 },;			 
		     { "SLDENT"		, "C", 01			, 0 },;			 
		     { "FATSLD"		, "C", 01			, 0 },;			 
		     { "VISENT"		, "C", 01			, 0 },;			 
		     { "IDENTIFI"	, "C", 01			, 0 },;			 			 
		     { "ESTOUR"  	, "C", 01			, 0 },;			//Define se eh conta estourada
			 { "NIVEL1"		, "L", 01			, 0 },;				// Logico para identificar se 
			 { "COLVISAO"	, "N", 01			, 0 },;				// Logico para identificar se 																	// eh de nivel 1 -> usado como
			 { "FILIAL"		, "C", nTamFilial	, 0 }}				// Filial
			 																	// eh de nivel 1 -> usado como
																	// totalizador do relatorio  																

///// TRATAMENTO PARA ATUALIZA«√O DE SALDO BASE
//Se os saldos basicos nao foram atualizados na dig. lancamentos
If !lAtSldBase
		dIniRep := ctod("")
  	If Need2Reproc(dDataFim,cMoeda,cSaldos,@dIniRep) 
		//Chama Rotina de Atualizacao de Saldos Basicos.
		oProcess := MsNewProcess():New({|lEnd|	CTBA190(.T.,dIniRep,dDataFim,cFilAnt,cFilAnt,cSaldos,.T.,cMoeda) },"","",.F.)
		oProcess:Activate()						
	EndIf
Endif

//// TRATAMENTO PARA ATUALIZA«√O DE SALDOS COMPOSTOS ANTES DE EXECUTAR A QUERY DE FILTRAGEM
Do Case
Case cAlias == 'CTU'
	//Verificar se tem algum saldo a ser atualizado
		//Verificar se tem algum saldo a ser atualizado por entidade
	If cIdent == "CTT"
		cOrigem := 	'CT3'
	ElseIf cIdent == "CTD"      
		cOrigem := 	'CT4'
	ElseIf cIdent == "CTH"
		cOrigem := 	'CTI'		
	Else
		cOrigem := 	'CTI'		
	Endif
	If lFiliais                         	
		For nCont := 1 to Len(aFiliais)
			Ct360Data(cOrigem,'CTU',@dMinData,lCusto,lItem,cFilDe,cFilAte,cSaldos,cMoeda,cMoeda,,,,,,,,,,aFiliais[nCont],,aSelFil,lTodasFil)		
			If !Empty(dMinData) 
				If nCont	== 1 
					dDataAnt	:= dMinData
				Else 
					If dMinData	< dDataAnt			
						dDataAnt	:= dMinData				
					EndIf
				EndIf
			EndIf		
		Next	
		//Menor data de todas as filiais		
		dMinData	:= dDataAnt
	Else	
		Ct360Data(cOrigem,'CTU',@dMinData,lCusto,lItem,cFilDe,cFilAte,cSaldos,cMoeda,cMoeda,,,,,,,,,,cFilAnt,,aSelFil,lTodasFil)
	Endif
Case cAlias == 'CTV'
	cOrigem := "CT4"
	//Verificar se tem algum saldo a ser atualizado
	Ct360Data(cOrigem,"CTV",@dMinData,lCusto,lItem,cFilDe,cFilAte,cSaldos,cMoeda,cMoeda,,,,,,,,,,cFilAnt,,aSelFil,lTodasFil)
Case cAlias == 'CTW'			
	cOrigem		:= 'CTI'	/// HEADER POR CLASSE DE VALORES
	//Verificar se tem algum saldo a ser atualizado
	Ct360Data(cOrigem,"CTW",@dMinData,lCusto,lItem,cFilDe,cFilAte,cSaldos,cMoeda,cMoeda,,,,,,,,,,cFilAnt,,aSelFil,lTodasFil)
Case cAlias == 'CTX'			
	cOrigem		:= 'CTI'		
	//Verificar se tem algum saldo a ser atualizado
	Ct360Data(cOrigem,"CTX",@dMinData,lCusto,lItem,cFilDe,cFilAte,cSaldos,cMoeda,cMoeda,,,,,,,,,,cFilAnt,,aSelFil,lTodasFil)
EndCase	

DO CASE
CASE cAlias$("CTU/CTV/CTW/CTX/CTY")
	//Se o parametro MV_SLDCOMP estiver com "S",isto e, se devera atualizar os saldos compost.
	//na emissao dos relatorios, verifica se tem algum registro desatualizado e atualiza as
	//tabelas de saldos compostos.
	If !Empty(dMinData)
		If lAtSldCmp	//Se atualiza saldos compostos
			If lFiliais
				cFilXAnt	:= cFilAnt
				
				For nCont := 1 to Len(aFiliais)
					cFilAnt	:= aFiliais[nCont] 
					cFilDe	:= cFilAnt
					cFilAte	:= cFilAnt
					oProcess := MsNewProcess():New({|lEnd|	CtAtSldCmp(oProcess,cAlias,cSaldos,cMoeda,dDataIni,cOrigem,dMinData,cFilDe,cFilAte,lCusto,lItem,lClVl,lAtSldBase,,,,aSelFil,lTodasFil)},"","",.F.)
					oProcess:Activate()	
				Next			      
				cFilAnt		:= cFilXAnt
				cFilDe		:= cFilAnt
				cFilAte		:= cFilAnt
			Else
				oProcess := MsNewProcess():New({|lEnd|	CtAtSldCmp(oProcess,cAlias,cSaldos,cMoeda,dDataIni,cOrigem,dMinData,cFilDe,cFilAte,lCusto,lItem,lClVl,lAtSldBase,,,cFilAnt,aSelFil,lTodasFil)},"","",.F.)
				oProcess:Activate()	
			EndIf
		Else		//Se nao atualiza os saldos compostos, somente da mensagem
			cMensagem	:= STR0016
			cMensagem	+= STR0017				
			MsgAlert(OemToAnsi(cMensagem))	//Os saldos compostos estao desatualizados...Favor atualiza-los					
			Return							//atraves da rotina de saldos compostos	
		EndIf    
	EndIf
ENDCASE

/// TRATAMENTO PARA OBTEN«√O DO SALDO DAS CONTAS ANALITICAS
Do Case
Case cAlias  == "CT7"            
	//Se for Comparativo de Conta por 6 meses/12 meses
	cEntidIni	:= cContaIni
	cEntidFim	:= cContaFim
	If nGrupo == 2
		cChave := "CONTA"
	Else									// Indice por Grupo -> Totaliza por grupo
		cChave := "CONTA+GRUPO"
	EndIf
	#IFDEF TOP		
		If TcSrvType() != "AS/400" .and. Empty(aSetOfBook[5])				/// S” H¡ QUERY SEM O PLANO GERENCIAL
			If Empty(cFilUSU)
				cFILUSU := ".T."
			Endif
			If lMeses				
				If cTpVlr == "S"			/// COMPARATIVO DE SALDO ACUMULADO
					CT7CompQry(dDataIni,dDataFim,cSaldos,cMoeda,cContaIni,cContaFim,aSetOfBook,lVlrZerado,lMeses,aMeses,cString,cFILUSU,lImpAntLP,dDataLP,.T.)                                                           							
				Else						/// COMPARATIVO DE MOVIMENTO DO PERIODO
					CT7CompQry(dDataIni,dDataFim,cSaldos,cMoeda,cContaIni,cContaFim,aSetOfBook,lVlrZerado,lMeses,aMeses,cString,cFILUSU,lImpAntLP,dDataLP,.F.)                                                           			
				Endif
			EndIf	
		EndIf
	#ENDIF
Case cAlias == "CTU" 
	If cIdent == "CTT"
		cEntidIni	:= cCCIni
		cEntidFim	:= cCCFim
		cChave		:= "CUSTO"
	EndIf
Case cAlias == "CT3"            

	If !Empty(aSetOfBook[5])
		cMensagem	:= OemToAnsi(STR0002)// O plano gerencial ainda nao esta disponivel nesse relatorio. 
		MsgInfo(cMensagem)
		RestArea(aSaveArea)
		Return
	Endif

	If cHeader == "CTT"
		cChave		:= "CUSTO+CONTA"
		cEntidIni1	:= cCCIni
		cEntidFim1	:= cCCFim
		cEntidIni2	:= cContaIni
		cEntidFim2	:= cContaFim
	ElseIf cHeader == "CT1"
		cChave		:= "CONTA+CUSTO"
		cEntidIni1	:= cContaIni
		cEntidFim1	:= cContaFim		
		cEntidIni2	:= cCCIni
		cEntidFim2	:= cCCFim	
	EndIf
	
	#IFDEF TOP	//// MONTA A QUERY E O ARQUIVO TEMPOR¡RIO TRBTMP J¡ COM OS SALDOS
		If TcSrvType() != "AS/400"                     			
			CT3CompQry(dDataIni,dDataFim,cCCIni,cCCFim,cContaIni,cContaFim,cMoeda,cSaldos,aSetOfBook,lImpAntLP,dDataLP,lMeses,aMeses,lVlrZerado,lEntid,aEntid,cHeader,cString,cFILUSU,cTpVlr=="S")
			If Empty(cFilUSU)
				cFILUSU := ".T."
			Endif
		EndIf
	#ENDIF
	
Case cAlias == "CTI"
	If lImp4Ent	//Se for Comparativo de 4 entidades
		#IFDEF TOP	//// MONTA A QUERY E O ARQUIVO TEMPOR¡RIO TRBTMP J¡ COM OS SALDOS
			If TcSrvType() != "AS/400"                     			
				CTICmp4Ent(dDataIni,dDataFim,cContaIni,cContafim,cCCIni,cCCFim,cItemIni,cItemFim,cClVlIni,cClVlFim,;
						cMoeda,cSaldos,aSetOfBook,lImpAntLP,dDataLP,cTpVlr,aMeses,cString,cFilUSU)
				If Empty(cFilUSU)
					cFILUSU := ".T."
				Endif
			EndIf
		#ENDIF
	EndIf		
	cChave	:= c1aEnt+"+"+c2aEnt+"+"+c3aEnt+"+"+c4aEnt	
Case cAlias == "CTV"	
	
	If !Empty(aSetOfBook[5])
		cMensagem	:= OemToAnsi(STR0002)// O plano gerencial ainda nao esta disponivel nesse relatorio. 
		MsgInfo(cMensagem)
		RestArea(aSaveArea)
		Return
	Endif
              
	If cHeader == "CTT"
		cChave	:=	"CUSTO+ITEM"	
		cEntidIni1	:=	cCCIni
		cEntidFim1	:=	cCCFim
		cEntidIni2	:=	cItemIni
		cEntidFim2	:=	cItemFim	         	
	ElseIf cHeader == "CTD"        
		cChave	:=	"ITEM+CUSTO"	
		cEntidIni1	:=	cItemIni
		cEntidFim1	:=	cItemFim
		cEntidIni2	:=	cCCIni 
		cEntidFim2	:=	cCCFim		         	
	EndIf
	#IFDEF TOP	//// MONTA A QUERY E O ARQUIVO TEMPOR¡RIO TRBTMP J¡ COM OS SALDOS
		If TcSrvType() != "AS/400"                     			
			CTVCompQry(dDataIni,dDataFim,cCCIni,cCCFim,cItemIni,cItemFim,cMoeda,cSaldos,aSetOfBook,lImpAntLP,dDataLP,lMeses,aMeses,lVlrZerado,lEntid,aEntid,cHeader,cString,cFILUSU)
			If Empty(cFilUSU)
				cFILUSU := ".T."
			Endif
		EndIf
	#ENDIF
Case cAlias == "CTX"
	If cHeader == "CTH"    
		cChave		:= "CLVL+ITEM"
		cEntidIni1	:=	cClVlIni
		cEntidFim1	:=	cClVlFim
		cEntidIni2	:=	cItemIni
		cEntidFim2	:= cItemFim	
	ElseIf cHeader == "CTD"
		cChave		:= "ITEM+CLVL"
		cEntidIni1	:=	cItemIni
		cEntidFim1	:=	cItemFim	
		cEntidIni2	:=	cClVlIni
		cEntidFim2	:= 	cClVlFim	
	EndIf	
	#IFDEF TOP	//// MONTA A QUERY E O ARQUIVO TEMPOR¡RIO TRBTMP J¡ COM OS SALDOS
		If TcSrvType() != "AS/400"                     			
			CTXCompQry(dDataIni,dDataFim,cItemIni,cItemFim,cClVlIni,cClVlFim,cMoeda,cSaldos,aSetOfBook,lImpAntLP,dDataLP,lMeses,aMeses,lVlrZerado,lEntid,aEntid,cHeader,cString,cFILUSU,lImpAntLP,dDataLP)
			If Empty(cFilUSU)
				cFILUSU := ".T."
			Endif
		EndIf
	#ENDIF
EndCase

If !Empty(aSetOfBook[5])				// Indica qual o Plano Gerencial Anexado
   cChave	:= "CONTA"
Endif

cArqPri := CriaTrab(aCampos, .T.)

	If ( Select ( "cArqPri" ) <> 0 )
		dbSelectArea ( "cArqPri" )
		dbCloseArea ()
	Endif
dbUseArea( .T.,, cArqPri, "cArqPri", .F., .F. )
	dbSelectArea("cArqPri")

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Cria Indice Temporario do Arquivo de Trabalho 1.             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
cArqInd	:= CriaTrab(Nil, .F.)

IndRegua("cArqPri",cArqInd,cChave,,,OemToAnsi(STR0001))  //"Selecionando Registros..."

If !Empty(aSetOfBook[5])				// Indica qual o Plano Gerencial Anexado
	cArqPri1 := CriaTrab(, .F.)
	IndRegua("cArqPri",cArqPri1,"ORDEM",,,OemToAnsi(STR0001))  //"Selecionando Registros..."
Endif	

dbSelectArea("cArqPri")
DbClearIndex()
dbSetIndex(cArqInd+OrdBagExt())

If !Empty(aSetOfBook[5])				// Indica qual o Plano Gerencial Anexado
	dbSetIndex(cArqPri1+OrdBagExt())
Endif

#IFDEF TOP  
	If TcSrvType() != "AS/400" .and. Empty(aSetOfBook[5])				/// S” H¡ QUERY SEM O PLANO GERENCIAL
		//// SE FOR DEFINI«√O TOP 
		If Select("TRBTMP") > 0		/// E O ALIAS TRBTMP ESTIVER ABERTO (INDICANDO QUE A QUERY FOI EXECUTADA)
  			dbSelectArea("TRBTMP")
			aStruTMP := dbStruct()			/// OBTEM A ESTRUTURA DO TMP
	
			dbSelectArea("TRBTMP")
			If ValType(oMeter) == "O"			
				oMeter:SetTotal((cAlias)->(RecCount()))
				oMeter:Set(0)
			EndIf
			dbGoTop()						/// POSICIONA NO 1∫ REGISTRO DO TMP
	
			While TRBTMP->(!Eof())			/// REPLICA OS DADOS DA QUERY (TRBTMP) PARA P/ O TEMPORARIO EM DISCO
				If ValType(oMeter) == "O"
					nMeter++
		    		oMeter:Set(nMeter)				
		   		EndIf	    		

				If &("TRBTMP->("+cFILUSU+")")
					RecLock("cArqPri",.T.)
					For nTRB := 1 to Len(aStruTMP)
						If Subs(aStruTmp[nTRB][1],1,6) == "COLUNA" .And. nDivide > 1 
							Field->&(aStruTMP[nTRB,1])	:=((TRBTMP->&(aStruTMP[nTRB,1])))/ndivide
						Else
							Field->&(aStruTMP[nTRB,1]) := TRBTMP->&(aStruTMP[nTRB,1])
						EndIf					
					Next 
					cArqPri->FILIAL	:= cFilAnt
					cArqPri->(MsUnlock())
				Endif

				TRBTMP->(dbSkip())
			Enddo

			dbSelectArea("TRBTMP")
			dbCloseArea()					/// FECHA O TRBTMP (RETORNADO DA QUERY)
			lTemQry := .T.
		Endif
	EndIf		
#ENDIF

dbSelectArea("cArqPri")
dbSetOrder(1)

If !Empty(aSetOfBook[5])				// Se houve Indicacao de Plano Gerencial Anexado
	// Monta Arquivo Lendo Plano Gerencial                                   
	// Neste caso a filtragem de entidades contabeis È desprezada!
	// Por enquanto a opcao de emitir o relatorio com Plano Gerencial ainda 
	// nao esta disponivel para esse relatorio. 
	If cAlias $ "CT7"					// Se for Entidade x Conta
		CtbPlGerCm(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cMoeda,aSetOfBook,;
					cAlias,cIdent,lImpAntLP,dDataLP,lVlrZerado,lFiliais,aFiliais,lMeses,aMeses,lImpSint,cTpVlr,,,cSaldos,lValMed,lSalAcum)
		dbSetOrder(2)
	Else
		cMensagem	:= OemToAnsi(STR0002)// O plano gerencial ainda nao esta disponivel nesse relatorio. 
		MsgInfo(cMensagem)	
	EndIf	
Else
	If cAlias $ 'CT7/CTU'		//So Imprime Entidade                                
		#IFDEF TOP
			If lMeses .And. TcSrvType() != "AS/400"
				//So ira gravar as contas sinteticas se mandar imprimir as contas sinteticas ou ambas.
				If lImpSint
					//Gravacao das contas superiores.
					SupCompCt7(oMeter,lMeses,aMeses,cMoeda,cTpVlr)
				Endif
			Else		
		#ENDIF
		CtCmpSoEnt(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni,cEntidFim,cMoeda,;
		cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,lNImpMov,cAlias,cIdent,;
		lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,lImpAntLP,dDataLP,nDivide,;
		cTpVlr,lFiliais,aFiliais,lMeses,aMeses,cFilUsu)
		#IFDEF TOP
			Endif
		#ENDIF		        
		
	ElseIf cAlias == "CT3"			
	
		If lMeses
			#IFNDEF TOP			
				/// SE FOR CODEBASE OU TOP SEM TER PASSADO PELAS QUERYS
				CtCmpComp(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
				cEntidFim2,cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				lNImpMov,cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
				cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado,aSelFil,lTodasFil)					
			#ELSE
				If TcSrvType() == "AS/400"                     		  					
					CtCmpComp(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
					cEntidFim2,cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
					lNImpMov,cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
					cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado,aSelFil,lTodasFil)					
				EndIf	
			#ENDIF        
			
			If lImpSint .Or. lImpTotS
				SupCompMes(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
				cEntidFim2,cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				lNImpMov,cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
				cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado)
			EndIf			
			
		EndIf			
	ElseIf cAlias == "CTI"
		If lImp4Ent // Se fro comparativo de 4 entidades		
			#IFNDEF TOP					                
				/// SE FOR CODEBASE OU TOP SEM TER PASSADO PELAS QUERYS
				CtCmp4Ent(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cContaIni,cContafim,cCCIni,cCCFim,cItemIni,cItemFim,cClVlIni,cClVlFim,;
						cMoeda,cSaldos,aSetOfBook,lImpAntLP,dDataLP,cTpVlr,aMeses,cString,cFilUSU,lAtSlBase,c1aEnt,c2aEnt,c3aEnt,c4aEnt,nDivide)			
			#ELSE
				If TcSrvType() == "AS/400"                     		  								
					CtCmp4Ent(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cContaIni,cContafim,cCCIni,cCCFim,cItemIni,cItemFim,cClVlIni,cClVlFim,;
							cMoeda,cSaldos,aSetOfBook,lImpAntLP,dDataLP,cTpVlr,aMeses,cString,cFilUSU,lAtSlBase,c1aEnt,c2aEnt,c3aEnt,c4aEnt,nDivide)			
				EndIf			
			#ENDIF					
		EndIf		
	ElseIf cAlias $ "CTV/CTX"				//// SE FOR ENTIDADE x ITEM CONTABIL
		If lEntid	//Relatorio Comparativo de 1 Entidade por 6 Entidades
		
			#IFNDEF TOP
				CtCmpEntid(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,;
				cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
				cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lVlrZerado,aEntid,aSelFil,lTodasFil)							
			#ELSE
				If TcSrvType() == "AS/400"                     		  								
					CtCmpEntid(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,;
					cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
					cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
					cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lVlrZerado,aEntid,aSelFil,lTodasFil)				
				EndIf
			#ENDIF  
			
			If lImpSint  // SE DEVE IMPRIMIR AS SINTETICAS
				/// Usa cHeader x cAlias invertidas para compor as entidades sintÈticas (neste caso sintetica do CTD ao invÈs do CTT)
				SupCompEnt(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
				cEntidFim2,cAlias,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				lNImpMov,cHeader,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
				cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado,lEntid,aEntid)
			Endif			
		Else
		
			/// RelatÛrios Comparativo 2 Entidades s/ Conta
			#IFNDEF TOP 
				CtCmpComp(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
				cEntidFim2,cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				lNImpMov,cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
				cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado,aSelFil,lTodasFil)		
			#ELSE
				If TcSrvType() == "AS/400"                     		  					
					CtCmpComp(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
					cEntidFim2,cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
					lNImpMov,cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
					cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado,aSelFil,lTodasFil)						
				EndIf
			#ENDIF		
			
			If lImpSint  // SE DEVE IMPRIMIR AS SINTETICAS
				SupCompEnt(oMeter,oText,oDlg,lEnd,dDataIni,dDataFim,cEntidIni1,cEntidFim1,cEntidIni2,;
				cEntidFim2,cHeader,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				lNImpMov,cAlias,lCusto,lItem,lClVl,lAtSldBase,lAtSldCmp,nInicio,nFinal,;
				cFilDe,cFilAte,lImpAntLP,dDataLP,nDivide,cTpVlr,lFiliais,aFiliais,lMeses,aMeses,lVlrZerado)
			Endif

		EndIf
	Endif
EndIf

RestArea(aSaveArea)

Return cArqPri


Static Function fperg(cPerg)  
//PutSx1(cPerg,"01","Dt. Admiss„o De      ","Dt. Admiss„o De      ","Dt. Admiss„o De             ","mv_ch1","D",08,0,1,"G","","   ","","","mv_par01"," "," "," ","",	" "," "," "," "," "," ", " "," "," "," ",	" "," ",{"Data Inicial a ser considerada"})
PutSx1(cPerg,"01","Data Inicial ?          ","Data Inicial ?          ","Data Inicial ?          ","mv_ch1","D",08,0,0,"G","",""   ,"","","mv_par01"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"02","Data Final   ?          ","Data Final   ?          ","Data Final   ?          ","mv_ch2","D",08,0,0,"G","",""   ,"","","mv_par02"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"03","Conta Inicial ?         ","Conta Inicial ?         ","Conta Inicial ?         ","mv_ch3","C",20,0,0,"G","","CT1","","","mv_par03"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"04","Conta Final   ?         ","Conta Final   ?         ","Conta Final   ?         ","mv_ch4","C",20,0,0,"G","","CT1","","","mv_par04"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"05","Imprime Contas ?        ","Imprime Contas ?        ","Imprime Contas ?        ","mv_ch5","N",01,0,2,"C","",""   ,"","","mv_par05","Sinteticas","Sinteticas","Sinteticas",,"Analiticas","Analiticas","Analiticas","Ambas","Ambas","Ambas",,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"06","Cod Conf Livros ?       ","Cod Conf Livros ?       ","Cod Conf Livros ?       ","mv_ch6","C",03,0,0,"G","","CTN","","","mv_par06",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"07","Saldos Zerados ?        ","Saldos Zerados ?        ","Saldos Zerados ?        ","mv_ch7","N",01,0,1,"C","",""   ,"","","mv_par07","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"08","Moeda ?                 ","Moeda ?                 ","Moeda ?                 ","mv_ch8","C",02,0,0,"G","","CTO","","","mv_par08",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"09","Folha Inicial ?         ","Folha Inicial ?         ","Folha Inicial ?         ","mv_ch9","N",06,0,0,"G","",""   ,"","","mv_par09",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"10","Tipo de Saldo ?         ","Tipo de Saldo ?         ","Tipo de Saldo ?         ","mv_chA","C",01,0,0,"G","","SLD","","","mv_par10",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"11","Quebra por Natureza ?   ","Quebra por Natureza ?   ","Quebra por Natureza ?   ","mv_chB","N",01,0,1,"C","",""   ,"","","mv_par11","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"12","Filtra Segmen No ?      ","Filtra Segmen No ?      ","Filtra Segmen No ?      ","mv_chC","C",02,0,0,"G","",""   ,"","","mv_par12",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"13","Conteudo Ini Segmen ?   ","Conteudo Ini Segmen ?   ","Conteudo Ini Segmen ?   ","mv_chD","C",20,0,0,"G","",""   ,"","","mv_par13",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"14","Conteudo Fim Segmen ?   ","Conteudo Fim Segmen ?   ","Conteudo Fim Segmen ?   ","mv_chE","C",20,0,0,"G","",""   ,"","","mv_par14",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"15","Conteudo Contido em ?   ","Conteudo Contido em ?   ","Conteudo Contido em ?   ","mv_chF","C",30,0,0,"G","",""   ,"","","mv_par15",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"16","Salta Linha Sinteticas ?","Salta Linha Sinteticas ?","Salta Linha Sinteticas ?","mv_chG","N",01,0,1,"C","",""   ,"","","mv_par16","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"17","Imprime Valor O,OO ?    ","Imprime Valor O,OO ?    ","Imprime Valor O,OO ?    ","mv_chH","N",01,0,1,"C","",""   ,"","","mv_par17","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"18","Imprime Codigo ?        ","Imprime Codigo ?        ","Imprime Codigo ?        ","mv_chI","N",01,0,2,"C","",""   ,"","","mv_par18","Normal","Normal","Normal",,"Reduzido","Reduzido","Reduzido",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"19","Divide por ?            ","Divide por ?            ","Divide por ?            ","mv_chJ","N",01,0,3,"C","",""   ,"","","mv_par19","Nao se Aplica","Nao se Aplica","Nao se Aplica",,"Cem","Cem","Cem","Mil","Mil","Mil",,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"20","Imprime ate o segmento ?","Imprime ate o segmento ?","Imprime ate o segmento ?","mv_chK","C",02,0,0,"G","",""   ,"","","mv_par20",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"21","Posicao Ant. L/P ?      ","Posicao Ant. L/P ?      ","Posicao Ant. L/P ?      ","mv_chL","N",01,0,2,"C","",""   ,"","","mv_par21","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"22","Data Lucros e Perdas ?  ","Data Lucros e Perdas ?  ","Data Lucros e Perdas ?  ","mv_chM","D",08,0,0,"G","",""   ,"","","mv_par22",,,,,,,,,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"23","Totaliza Periodo ?      ","Totaliza Periodo ?      ","Totaliza Periodo ?      ","mv_chN","N",01,0,1,"C","",""   ,"","","mv_par23","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"24","Se Totalizar Mostra ?   ","Se Totalizar Mostra ?   ","Se Totalizar Mostra ?   ","mv_chO","N",01,0,2,"C","",""   ,"","","mv_par24","Conta","Conta","Conta",,"DescriÁ„o","DescriÁ„o","DescriÁ„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"25","Comparar ?              ","Comparar ?              ","Comparar ?              ","mv_chP","N",01,0,2,"C","",""   ,"","","mv_par25","Mov.Periodo","Mov.Periodo","Mov.Periodo",,"Saldo Acumulado","Saldo Acumulado","Saldo Acumulado",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"26","Custo Inicial ?         ","Custo Inicial ?         ","Custo Inicial ?         ","mv_chQ","C",09,0,0,"G","","CTT","","","mv_par26"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"27","Custo Final   ?         ","Custo Final   ?         ","Custo Final   ?         ","mv_chR","C",09,0,0,"G","","CTT","","","mv_par27"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"28","Imprime Sem Custo ?     ","Imprime Sem Custo ?     ","Imprime Sem Custo ?     ","mv_chS","N",01,0,2,"C","",""   ,"","","mv_par28","Sim","Sim","Sim",,"N„o","N„o","N„o",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
PutSx1(cPerg,"29","Imprime Saldo Custo Ant.?","Imprime Saldo Custo Ant.?","Imprime Saldo Custo Ant.?","mv_chT","N",01,0,2,"C","",""   ,"","","mv_par29","N„o","N„o","N„o",,"Sim","Sim","Sim",,,,,,,,,,{},{},{}) //,,,,,,,,,,,,,,,{},{},{})
Return 

//////////////////// rascunho da formataÁ„o do calendario ////////////////////////////

Static Function Facum(TIPOCONTA,aMeses,NIVEL1,aTotCol,aTotGrp,cSegAte)
	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If TIPOCONTA == "1"			
			If NIVEL1      
				For nVezes := 1 to Len(aMeses) 
					//aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))				
					//aTotGrp[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))
					aTotCol[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))				
					aTotGrp[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))
				Next	
			EndIf
		EndIf
	Else									// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If TIPOCONTA == "2"
				For nVezes := 1 to Len(aMeses)   // _val
					//aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))
					//aTotGrp[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))									
					aTotCol[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))
					aTotGrp[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))
				Next							
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If TIPOCONTA == "1"
				If NIVEL1
					For nVezes := 1 to Len(aMeses)
						//aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))				
						aTotCol[nVezes] +=&("_val"+Alltrim(Str(nVezes,2)))				
					Next							
				EndIf
			EndIf
    	Endif			
	EndIf
	
	/*
	
	    aTmpLog   :={}
    aTmpcusa  :={}
    _ddtcusanI:=mv_par01-1
    _ddtcusanI:=CToD("01\"+StrZero(Month(_ddtcusanI),2)+"\"+AllTrim(Str(Year(_ddtcusanI))))
    _nmesbase:=Iif(Month(mv_par02)<>1,Month(mv_par02)-1,12)
    _nanobase:=Iif(_nmesbase<>12,Year(_ddtcusanI),Year(_ddtcusanI)-1)
    _ddtcusanF:=_ddtcusanI+200//CToD("31\"+StrZero(Month(_ddtcusanI),2)+"\"+AllTrim(Str(Year(_ddtcusanI))))
    _ddtcal   :=_ddtcusanF
    _ddtcusanF:=CToD("31\"+StrZero(Month(_ddtcusanF),2)+"\"+AllTrim(Str(Year(_ddtcusanF))))
    _ncontd:=31
    While Empty(_ddtcusanF)
       _ncontd--
       _ddtcusanF:=CToD(StrZero(_ncontd,2)+"\"+StrZero(Month(_ddtcal),2)+"\"+AllTrim(Str(Year(_ddtcal))))
    End-While
    MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				_ddtcusanI,_ddtcusanF,"CT3","",cArqPri->CONTA,cArqPri->CONTA,"","ZZZZZZZZZ",,,,,mv_par08,;
				mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
				/// .F.,.F.,,"CTT",lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,"CTT",/*oCentroCusto:GetAdvplExp()/*aReturn[7]*/
				/*
				,.T.)},;
				
				STR0013,;  //"Criando Arquivo Tempor†rio..."
				STR0003+Upper(Alltrim(cSayCC)) +" / " +  STR0011 )     //"Balancete Verificacao C.CUSTO / CONTA				
                _nsaltmp:=0
	            cArqTmp->(dbGoTop())
                If !cArqTmp->(Eof())   
                   While !cArqTmp->(Eof())       
           
                      If !Empty(mv_par26) .Or. !Empty(mv_par27) 
                         If !(cArqTmp->CUSTO>=mv_par26 .And. cArqTmp->CUSTO<=mv_par27)
                            cArqTmp->(DbSkip())
                            Loop
                         Endif   
                      Endif
            
                      nPos := Ascan(aTmpLog,{|x| x[1]== Alltrim(CONTA)+cArqTmp->CUSTO}) // aTmpLog[_xx,2]
            
                      If nPos>0 .Or. cArqTmp->COLUNA1=0
                         cArqTmp->(DbSkip())
                         Loop
                      EndIf
                      
                      If cArqTmp->COLUNA1<>0   
                         aSaldo    := SaldTotCT3(cArqTmp->CUSTO,cArqTmp->CUSTO,cArqPri->CONTA,cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,aSelFil)
                         aSaldoAnt := SaldTotCT3(cArqTmp->CUSTO,cArqTmp->CUSTO,cArqPri->CONTA,cArqPri->CONTA,MV_PAR01-1,MV_PAR08,MV_PAR10,aSelFil)                            
                         nSaldoAtu := aSaldoAnt[6]                               
                         nSaldoAtu := Iif(nSaldoAtu<0,Abs(nSaldoAtu),Iif(nSaldoAtu>0,nSaldoAtu*-1,0))
                         aadd(aTmpcusa, {Alltrim(CONTA)+cArqTmp->CUSTO,CONTA,Left(DESCCTA,18),cArqTmp->CUSTO,cArqTmp->DESCCC+" - ANTERIOR",nSaldoAtu,.T.})         
                         _nsaltmp+=nSaldoAtu
                      EndIf
                      cArqTmp->(DbSkip())
                   End-While   
                   If _nsaltmp<>0 .And. _nsalcon<>0 .And. _nsaltmp<>_nsalcon
                      aadd(aTmpcusa, {Alltrim(CONTA),CONTA,Left(DESCCTA,18),"","Saldo sem Custo ANTERIROR",_nsalcon-_nsaltmp,.T.})         
                   ElseIf _nsaltmp=0 .And. _nsalcon<>0
                      aadd(aTmpcusa, {Alltrim(CONTA),CONTA,Left(DESCCTA,18),"","Saldo sem Custo ANTERIROR",_nsalcon,.T.})         
                   EndIf   
                Else
                   aadd(aTmpcusa, {Alltrim(CONTA)+cArqTmp->CUSTO,CONTA,Left(DESCCTA,18)," "," ",_nsalcon,.T.})         
                Endif      
                cArqTmp->(DbCloseArea())
                */