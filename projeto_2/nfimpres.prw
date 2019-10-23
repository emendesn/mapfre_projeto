#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 01/08/01

User Function NFIMPRES()        // incluido pelo assistente de conversao do AP5 IDE em 01/08/01

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
                        
SetPrvt("CBTXT,CBCONT,NORDEM,ALFA,Z,M")
SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("NLIN,WNREL,NTAMNF,CSTRING,CPEDANT,NLININI")
SetPrvt("XNUM_NF,XSERIE,XEMISSAO,XTOT_FAT,XLOJA,XFRETE")
SetPrvt("XSEGURO,XBASE_ICMS,XBASE_IPI,XVALOR_ICMS,XICMS_RET,XVALOR_IPI")
SetPrvt("XVALOR_MERC,XNUM_DUPLIC,XCOND_PAG,XPBRUTO,XPLIQUI,XTIPO")
SetPrvt("XESPECIE,XVOLUME,CPEDATU,CITEMATU,XPED_VEND,XITEM_PED")
SetPrvt("XNUM_NFDV,XPREF_DV,XICMS,XCOD_PRO,XQTD_PRO,XPRE_UNI")
SetPrvt("XPRE_TAB,XIPI,XVAL_IPI,XDESC,XVAL_DESC,XVAL_MERC")
SetPrvt("XTES,XCF,XICMSOL,XICM_PROD,XPESO_PRO,XPESO_UNIT")
SetPrvt("XDESCRICAO,XUNID_PRO,XCOD_TRIB,XMEN_TRIB,XCOD_FIS,XCLAS_FIS")
SetPrvt("XMEN_POS,XISS,XTIPO_PRO,XLUCRO,XCLFISCAL,XPESO_LIQ")
SetPrvt("I,NPELEM,_CLASFIS,NPTESTE,XPESO_LIQUID,XPED")
SetPrvt("XPESO_BRUTO,XP_LIQ_PED,XCLIENTE,XTIPO_CLI,XCOD_MENS,XMENSAGEM")
SetPrvt("XTPFRETE,XCONDPAG,XCOD_VEND,XDESC_NF,XDESC_PAG,XPED_CLI")
SetPrvt("XDESC_PRO,J,XCOD_CLI,XNOME_CLI,XEND_CLI,XBAIRRO")
SetPrvt("XCEP_CLI,XCOB_CLI,XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI")
SetPrvt("XINSC_CLI,XTRAN_CLI,XTEL_CLI,XFAX_CLI,XSUFRAMA,XCALCSUF")
SetPrvt("ZFRANCA,XVENDEDOR,XBSICMRET,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP")
SetPrvt("XEST_TRANSP,XVIA_TRANSP,XCGC_TRANSP,XTEL_TRANSP,XPARC_DUP,XVENC_DUP")
SetPrvt("XVALOR_DUP,XDUPLICATAS,XNATUREZA,XFORNECE,XNFORI,XPEDIDO")
SetPrvt("XPESOPROD,XFAX,NOPC,CCOR,NTAMDET,XB_ICMS_SOL")
SetPrvt("XV_ICMS_SOL,NCONT,NCOL,NTAMOBS,NAJUSTE,BB")
SetPrvt("NTOT_PA,NTOT_ISS,NTOT_IR,NTOT_MO,XVALISS,XVAL_IRRF,NLIMITE,XCOD_CLASS,X,Y,A,B")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  �  RFATR01 � Autor �   Anderson Rodrigues  � Data � 31/07/01 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Nota Fiscal de Entrada/Saida e Servicos                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Especifico para Cesvi do Brasil                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Ambientais                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Da Nota Fiscal                       �
//� mv_par02             // Ate a Nota Fiscal                    �
//� mv_par03             // Da Serie                             �
//� mv_par04             // Nota Fiscal de Entrada/Saida         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
CbTxt:=""
CbCont:=""
nOrdem :=0
Alfa := 0
Z:=0
M:=0
tamanho:="P"
limite:=80
titulo :=PADC("Nota Fiscal - CESVI",74)
cDesc1 :=PADC("Este programa ira emitir a Nota Fiscal de Entrada/Saida",74)
cDesc2 :=""
cDesc3 :=PADC("da CESVI",74)
cNatureza:=""
aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog:="RFATR01"
cPerg:="NFSIGW"
nLastKey:= 0
lContinua := .T.
nLin:=0
wnrel    := "RFATR01"
nTot_MO  := 0
nTot_PA  := 0
nTot_IR  := 0
nTot_ISS := 0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Tamanho do Formulario de Nota Fiscal (em Linhas)          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

nTamNf:=100     // Apenas Informativo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Verifica as perguntas selecionadas, busca o padrao da Nfiscal           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Pergunte(cPerg,.F.)               // Pergunta no SX1

cString:="SF2"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica Posicao do Formulario na Impressora                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

VerImp()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                                                              �
//� Inicio do Processamento da Nota Fiscal                       �
//�                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> 	RptStatus({|| Execute(RptDetail)})
Return
// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> 	Function RptDetail
Static Function RptDetail()

If mv_par04 == 2
	dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
	dbSetOrder(1)
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	dbSelectArea("SD2")                // * Itens de Venda da Nota Fiscal
	dbSetOrder(3)
	dbSeek(xFilial()+mv_par01+mv_par03)
	cPedant := SD2->D2_PEDIDO
Else
	dbSelectArea("SF1")                // * Cabecalho da Nota Fiscal Entrada
	DbSetOrder(1)
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	dbSelectArea("SD1")                // * Itens da Nota Fiscal de Entrada
	dbSetOrder(3)
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicializa  regua de impressao                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SetRegua(Val(mv_par02)-Val(mv_par01))
If mv_par04 == 2
	dbSelectArea("SF2")
	While !eof() .and. SF2->F2_DOC    <= mv_par02 .and. lContinua
		
		If SF2->F2_SERIE #mv_par03    // Se a Serie do Arquivo for Diferente
			DbSkip()                    // do Parametro Informado !!!
			Loop
		Endif
		
		
		IF lAbortPrint
			@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
			lContinua := .F.
			Exit
		Endif
		
		nLinIni:=nLin                         // Linha Inicial da Impressao
		
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Inicio de Levantamento dos Dados da Nota Fiscal              �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		// * Cabecalho da Nota Fiscal
		
		xNUM_NF     :=SF2->F2_DOC             // Numero
		xSERIE      :=SF2->F2_SERIE           // Serie
		xEMISSAO    :=SF2->F2_EMISSAO         // Data de Emissao
		xTOT_FAT    :=SF2->F2_VALFAT          // Valor Total da Fatura
		if xTOT_FAT == 0
			xTOT_FAT := SF2->F2_VALMERC+SF2->F2_VALIPI+SF2->F2_SEGURO+SF2->F2_FRETE
		endif
		xLOJA       :=SF2->F2_LOJA            // Loja do Cliente
		xFRETE      :=SF2->F2_FRETE           // Frete
		xSEGURO     :=SF2->F2_SEGURO          // Seguro
		xBASE_ICMS  :=SF2->F2_BASEICM         // Base   do ICMS
		xBASE_IPI   :=SF2->F2_BASEIPI         // Base   do IPI
		xBASE_ISS   :=SF2->F2_BASEISS         // Base   do IPI
		xVALOR_ICMS :=SF2->F2_VALICM          // Valor  do ICMS
		xICMS_RET   :=SF2->F2_ICMSRET         // Valor  do ICMS Retido
		xVALOR_IPI  :=SF2->F2_VALIPI          // Valor  do IPI
		xVALOR_MERC :=SF2->F2_VALMERC         // Valor  da Mercadoria
		xNUM_DUPLIC :=SF2->F2_DUPL            // Numero da Duplicata
		xCOND_PAG   :=SF2->F2_COND            // Condicao de Pagamento
		xPBRUTO     :=SF2->F2_PBRUTO          // Peso Bruto
		xPLIQUI     :=SF2->F2_PLIQUI          // Peso Liquido
		xTIPO       :=SF2->F2_TIPO            // Tipo do Cliente
		xESPECIE    :=SF2->F2_ESPECI1         // Especie 1 no Pedido
		xVOLUME     :=SF2->F2_VOLUME1         // Volume 1 no Pedido
		xVALISS     :=SF2->F2_VALISS
	
	 	dbSelectArea("SE4") // COND. DE PGTO
		dbSetOrder(1)
		dbSeek(xFilial()+xCOND_PAG)
		If Found()
		   xDESCR_PAG := SE4->E4_DESCRI
		Endif   
		
		
		dbSelectArea("SD2")                   // * Itens de Venda da N.F.
		dbSetOrder(3)
		dbSeek(xFilial()+xNUM_NF+xSERIE)
		
		cPedAtu := SD2->D2_PEDIDO
		cItemAtu := SD2->D2_ITEMPV
		
		xPED_VEND:={}                         // Numero do Pedido de Venda
		xITEM_PED:={}                         // Numero do Item do Pedido de Venda
		xNUM_NFDV:={}                         // nUMERO QUANDO HOUVER DEVOLUCAO
		xPREF_DV :={}                         // Serie  quando houver devolucao
		xICMS    :={}                         // Porcentagem do ICMS
		xCOD_PRO :={}                         // Codigo  do Produto
		xQTD_PRO :={}                         // Peso/Quantidade do Produto
		xPRE_UNI :={}                         // Preco Unitario de Venda
		xPRE_TAB :={}                         // Preco Unitario de Tabela
		xIPI     :={}                         // Porcentagem do IPI
		xVAL_IPI :={}                         // Valor do IPI
		xDESC    :={}                         // Desconto por Item
		xVAL_DESC:={}                         // Valor do Desconto
		xVAL_MERC:={}                         // Valor da Mercadoria
		xTES     :={}                         // TES
		xCF      :={}                         // Classificacao quanto natureza da Operacao
		xICMSOL  :={}                         // Base do ICMS Solidario
		xICM_PROD:={}                         // ICMS do Produto
		
		while !eof() .and. SD2->D2_DOC==xNUM_NF .and. SD2->D2_SERIE==xSERIE
			If SD2->D2_SERIE #mv_par03        // Se a Serie do Arquivo for Diferente
				DbSkip()                   // do Parametro Informado !!!
				Loop
			Endif
			AADD(xPED_VEND ,SD2->D2_PEDIDO)
			AADD(xITEM_PED ,SD2->D2_ITEMPV)
			AADD(xNUM_NFDV ,IIF(Empty(SD2->D2_NFORI),"",SD2->D2_NFORI))
			AADD(xPREF_DV  ,SD2->D2_SERIORI)
			AADD(xICMS     ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
			AADD(xCOD_PRO  ,SD2->D2_COD)
			AADD(xQTD_PRO  ,SD2->D2_QUANT)     // Guarda as quant. da NF
			AADD(xPRE_UNI  ,SD2->D2_PRCVEN)
			AADD(xPRE_TAB  ,SD2->D2_PRUNIT)
			AADD(xIPI      ,IIF(Empty(SD2->D2_IPI),0,SD2->D2_IPI))
			AADD(xVAL_IPI  ,SD2->D2_VALIPI)
			AADD(xDESC     ,SD2->D2_DESC)
			AADD(xVAL_MERC ,SD2->D2_TOTAL)
			AADD(xTES      ,SD2->D2_TES)
			AADD(xCF       ,SD2->D2_CF)
			AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
			dbskip()
		End
		
		dbSelectArea("SB1")                     // * Desc. Generica do Produto
		dbSetOrder(1)
		xPESO_PRO:={}                           // Peso Liquido
		xPESO_UNIT :={}                         // Peso Unitario do Produto
		xDESCRICAO :={}                         // Descricao do Produto
		xUNID_PRO:={}                           // Unidade do Produto
		xCOD_TRIB:={}                           // Codigo de Tributacao
		xMEN_TRIB:={}                           // Mensagens de Tributacao
		xCOD_FIS :={}                           // Cogigo Fiscal
		xCLAS_FIS:={}                           // Classificacao Fiscal
		xMEN_POS :={}                           // Mensagem da Posicao IPI
		xISS     :={}                           // Aliquota de ISS
		xTIPO_PRO:={}                           // Tipo do Produto
		xLUCRO   :={}                           // Margem de Lucro p/ ICMS Solidario
		xCLFISCAL   :={}
		xPESO_LIQ := 0
		//I:=1
		
		For I:=1 to Len(xCOD_PRO)
			
			dbSeek(xFilial()+xCOD_PRO[I])
			AADD(xPESO_PRO ,SB1->B1_PESO * xQTD_PRO[I])
			xPESO_LIQ  := xPESO_LIQ + xPESO_PRO[I]
			AADD(xPESO_UNIT , SB1->B1_PESO)
			AADD(xUNID_PRO ,SB1->B1_UM)
			AADD(xDESCRICAO ,SB1->B1_DESC)
			AADD(xCOD_TRIB ,SB1->B1_ORIGEM)
			If Ascan(xMEN_TRIB, SB1->B1_ORIGEM)==0
				AADD(xMEN_TRIB ,SB1->B1_ORIGEM)
			Endif
			
			npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)
			
			if npElem == 0
				AADD(xCLAS_FIS  ,SB1->B1_POSIPI)
			endif
			
			npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)
			
			DO CASE
				CASE npElem == 1
					_CLASFIS := "A"
					
				CASE npElem == 2
					_CLASFIS := "B"
					
				CASE npElem == 3
					_CLASFIS := "C"
					
				CASE npElem == 4
					_CLASFIS := "D"
					
				CASE npElem == 5
					_CLASFIS := "E"
					
				CASE npElem == 6
					_CLASFIS := "F"
					
			ENDCASE
			nPteste := Ascan(xCLFISCAL,_CLASFIS)
			If nPteste == 0
				AADD(xCLFISCAL,_CLASFIS)
			Endif
			
			AADD(xCOD_FIS ,_CLASFIS)
			If SB1->B1_ALIQISS > 0
				AADD(xISS ,SB1->B1_ALIQISS)
			Endif
			AADD(xTIPO_PRO ,SB1->B1_TIPO)
			AADD(xLUCRO    ,SB1->B1_PICMRET)
			
			
			//
			// Calculo do Peso Liquido da Nota Fiscal
			//
			
			xPESO_LIQUID:=0                                 // Peso Liquido da Nota Fiscal
			For nI:=1 to Len(xPESO_PRO)
				xPESO_LIQUID:=xPESO_LIQUID+xPESO_PRO[nI]
			Next
			
		Next
		
		dbSelectArea("SC5")                            // * Pedidos de Venda
		dbSetOrder(1)
		
		xPED        := {}
		xPESO_BRUTO := 0
		xP_LIQ_PED  := 0
		
		For I:=1 to Len(xPED_VEND)
			
			dbSeek(xFilial()+xPED_VEND[I])
			
			If ASCAN(xPED,xPED_VEND[I])==0
				dbSeek(xFilial()+xPED_VEND[I])
				xCLIENTE    :=SC5->C5_CLIENTE            // Codigo do Cliente
				xTIPO_CLI   :=SC5->C5_TIPOCLI            // Tipo de Cliente
				xCOD_MENS   :=SC5->C5_MENPAD             // Codigo da Mensagem Padrao
				xMENSAGEM   :=SC5->C5_MENNOTA            // Mensagem para a Nota Fiscal
				xTPFRETE    :=SC5->C5_TPFRETE            // Tipo de Entrega
				xCONDPAG    :=SC5->C5_CONDPAG            // Condicao de Pagamento
				xPESO_BRUTO :=SC5->C5_PBRUTO             // Peso Bruto
				xP_LIQ_PED  :=xP_LIQ_PED + SC5->C5_PESOL // Peso Liquido
				xCOD_VEND:= {SC5->C5_VEND1,;             // Codigo do Vendedor 1
				SC5->C5_VEND2,;             // Codigo do Vendedor 2
				SC5->C5_VEND3,;             // Codigo do Vendedor 3
				SC5->C5_VEND4,;             // Codigo do Vendedor 4
				SC5->C5_VEND5}              // Codigo do Vendedor 5
				xDESC_NF := {SC5->C5_DESC1,;             // Desconto Global 1
				SC5->C5_DESC2,;             // Desconto Global 2
				SC5->C5_DESC3,;             // Desconto Global 3
				SC5->C5_DESC4}              // Desconto Global 4
				AADD(xPED,xPED_VEND[I])
			Endif
			
			If xP_LIQ_PED >0
				xPESO_LIQ := xP_LIQ_PED
			Endif
			
		Next
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Pesquisa da Condicao de Pagto               �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		
		dbSelectArea("SE4")                    // Condicao de Pagamento
		dbSetOrder(1)
		dbSeek(xFilial("SE4")+xCONDPAG)
		xDESC_PAG := SE4->E4_DESCRI
		
		dbSelectArea("SC6")                    // * Itens de Pedido de Venda
		dbSetOrder(1)
		xPED_CLI :={}                          // Numero de Pedido
		xDESC_PRO:={}                          // Descricao aux do produto
		J:=Len(xPED_VEND)
		For I:=1 to J
			dbSeek(xFilial()+xPED_VEND[I]+xITEM_PED[I])
			AADD(xPED_CLI ,SC6->C6_PEDCLI)
			AADD(xDESC_PRO,SC6->C6_DESCRI)
			AADD(xVAL_DESC,SC6->C6_VALDESC)
		Next
		
		If xTIPO=='N' .OR. xTIPO=='C' .OR. xTIPO=='P' .OR. xTIPO=='I' .OR. xTIPO=='S' .OR. xTIPO=='T' .OR. xTIPO=='O'
			
			dbSelectArea("SA1")                // * Cadastro de Clientes
			dbSetOrder(1)
			dbSeek(xFilial()+xCLIENTE+xLOJA)
			xCOD_CLI :=SA1->A1_COD             // Codigo do Cliente
			xNOME_CLI:=alltrim(SA1->A1_NOME)   // Nome
			xEND_CLI :=alltrim(SA1->A1_END)    // Endereco
			xBAIRRO  :=alltrim(SA1->A1_BAIRRO) // Bairro
			xCEP_CLI :=SA1->A1_CEP             // CEP
			xCOB_CLI :=alltrim(SA1->A1_ENDCOB) // Endereco de Cobranca
			xREC_CLI :=alltrim(SA1->A1_ENDENT) // Endereco de Entrega
			xMUN_CLI :=alltrim(SA1->A1_MUN)    // Municipio
			xEST_CLI :=SA1->A1_EST             // Estado
			xCGC_CLI :=SA1->A1_CGC             // CGC
			xINSC_CLI:=SA1->A1_INSCR           // Inscricao estadual
			xTRAN_CLI:=SA1->A1_TRANSP          // Transportadora
			xTEL_CLI :=SA1->A1_TEL             // Telefone
			xFAX_CLI :=SA1->A1_FAX             // Fax
			xSUFRAMA :=SA1->A1_SUFRAMA            // Codigo Suframa
			xCALCSUF :=SA1->A1_CALCSUF            // Calcula Suframa
			// Alteracao p/ Calculo de Suframa
			if !empty(xSUFRAMA) .and. xCALCSUF =="S"
				IF XTIPO == 'D' .OR. XTIPO == 'B'
					zFranca := .F.
				else
					zFranca := .T.
				endif
			Else
				zfranca:= .F.
			endif
			
		Else
			zFranca:=.F.
			dbSelectArea("SA2")                // * Cadastro de Fornecedores
			dbSetOrder(1)
			dbSeek(xFilial()+xCLIENTE+xLOJA)
			xCOD_CLI :=SA2->A2_COD             // Codigo do Fornecedor
			xNOME_CLI:=SA2->A2_NOME            // Nome Fornecedor
			xEND_CLI :=SA2->A2_END             // Endereco
			xBAIRRO  :=SA2->A2_BAIRRO          // Bairro
			xCEP_CLI :=SA2->A2_CEP             // CEP
			xCOB_CLI :=""                      // Endereco de Cobranca
			xREC_CLI :=""                      // Endereco de Entrega
			xMUN_CLI :=SA2->A2_MUN             // Municipio
			xEST_CLI :=SA2->A2_EST             // Estado
			xCGC_CLI :=SA2->A2_CGC             // CGC
			xINSC_CLI:=SA2->A2_INSCR           // Inscricao estadual
			xTRAN_CLI:=SA2->A2_TRANSP          // Transportadora
			xTEL_CLI :=SA2->A2_TEL             // Telefone
			xFAX_CLI :=SA2->A2_FAX             // Fax
		Endif
		dbSelectArea("SA3")                   // * Cadastro de Vendedores
		dbSetOrder(1)
		xVENDEDOR:={}                         // Nome do Vendedor
		//I:=1
		J:=Len(xCOD_VEND)
		For I:=1 to J
			dbSeek(xFilial()+xCOD_VEND[I])
			Aadd(xVENDEDOR,SA3->A3_NREDUZ)
		Next
		
		If xICMS_RET >0                          // Apenas se ICMS Retido > 0
			dbSelectArea("SF3")                   // * Cadastro de Livros Fiscais
			dbSetOrder(4)
			dbSeek(xFilial()+SA1->A1_COD+SA1->A1_LOJA+SF2->F2_DOC+SF2->F2_SERIE)
			If Found()
				xBSICMRET:=F3_VALOBSE
			Else
				xBSICMRET:=0
			Endif
		Else
			xBSICMRET:=0
		Endif
		dbSelectArea("SA4")                   // * Transportadoras
		dbSetOrder(1)
		dbSeek(xFilial()+SF2->F2_TRANSP)
		xNOME_TRANSP :=SA4->A4_NOME           // Nome Transportadora
		xEND_TRANSP  :=SA4->A4_END            // Endereco
		xMUN_TRANSP  :=SA4->A4_MUN            // Municipio
		xEST_TRANSP  :=SA4->A4_EST            // Estado
		xVIA_TRANSP  :=SA4->A4_VIA            // Via de Transporte
		xCGC_TRANSP  :=SA4->A4_CGC            // CGC
		xTEL_TRANSP  :=SA4->A4_TEL            // Fone
		
		dbSelectArea("SE1")                   // * Contas a Receber
		dbSetOrder(1)
		xPARC_DUP  :={}                       // Parcela
		xVENC_DUP  :={}                       // Vencimento
		xVALOR_DUP :={}                       // Valor   
                   
 		xDUPLICATAS:=IIF(dbSeek(xFilial()+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas
		                 
			
		while !eof() .and. SE1->E1_NUM==xNUM_DUPLIC .and. xDUPLICATAS==.T.
			If !("NF" $ SE1->E1_TIPO)
				dbSkip()
				Loop
			Endif
			AADD(xPARC_DUP ,SE1->E1_PARCELA)
			AADD(xVENC_DUP ,SE1->E1_VENCTO)
			AADD(xVALOR_DUP,SE1->E1_VALOR)
			dbSkip()
		EndDo
	
	    dbSelectArea("SE1")    //*********************
        dbSetOrder(1)          
        dbSeek(xFilial()+SF2->F2_SERIE+SF2->F2_DOC)
        If found()
           _xDup := SE1->E1_VENCTO
        Endif   
	
		
		dbSelectArea("SF4")                   // * Tipos de Entrada e Saida
		DbSetOrder(1)
		dbSeek(xFilial()+xTES[1])
		xNATUREZA:=SF4->F4_TEXTO              // Natureza da Operacao
		
		
		Imprime()
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Termino da Impressao da Nota Fiscal                          �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		IncRegua()                    // Termometro de Impressao
		
		nLin:=0
		dbSelectArea("SF2")
		dbSkip()                      // passa para a proxima Nota Fiscal
		
	EndDo
Else
	
	dbSelectArea("SF1")              // * Cabecalho da Nota Fiscal Entrada
	
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	While !eof() .and. SF1->F1_DOC <= mv_par02 .and. SF1->F1_SERIE == mv_par03 .and. lContinua
		
		If SF1->F1_SERIE #mv_par03    // Se a Serie do Arquivo for Diferente
			DbSkip()                    // do Parametro Informado !!!
			Loop
		Endif
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Inicializa  regua de impressao                            �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		SetRegua(Val(mv_par02)-Val(mv_par01))
		
		
		IF lAbortPrint
			@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
			lContinua := .F.
			Exit
		Endif
		
		
		nLinIni:=nLin                         // Linha Inicial da Impressao
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Inicio de Levantamento dos Dados da Nota Fiscal              �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		xNUM_NF     :=SF1->F1_DOC             // Numero
		xSERIE      :=SF1->F1_SERIE           // Serie
		xFORNECE    :=SF1->F1_FORNECE         // Cliente/Fornecedor
		xEMISSAO    :=SF1->F1_EMISSAO         // Data de Emissao
		xTOT_FAT    :=SF1->F1_VALBRUT         // Valor Bruto da Compra
		xLOJA       :=SF1->F1_LOJA            // Loja do Cliente
		xFRETE      :=SF1->F1_FRETE           // Frete
		xSEGURO     :=SF1->F1_DESPESA         // Despesa
		xBASE_ICMS  :=SF1->F1_BASEICM         // Base   do ICMS
		xBASE_IPI   :=SF1->F1_BASEIPI         // Base   do IPI
		xBASE_ISS   := 0
		xBSICMRET   :=SF1->F1_BRICMS          // Base do ICMS Retido
		xVALOR_ICMS :=SF1->F1_VALICM          // Valor  do ICMS
		xICMS_RET   :=SF1->F1_ICMSRET         // Valor  do ICMS Retido
		xVALOR_IPI  :=SF1->F1_VALIPI          // Valor  do IPI
		xVALOR_MERC :=SF1->F1_VALMERC         // Valor  da Mercadoria
		xNUM_DUPLIC :=SF1->F1_DUPL            // Numero da Duplicata
		xCOND_PAG   :=SF1->F1_COND            // Condicao de Pagamento
		xTIPO       :=SF1->F1_TIPO            // Tipo do Cliente
		xNFORI      :=SF1->F1_NFORI           // NF Original
		xPREF_DV    :=SF1->F1_SERIORI         // Serie Original
		xVALISS     := ""
		
		dbSelectArea("SD1")                   // * Itens da N.F. de Compra
		dbSetOrder(1)
		dbSeek(xFilial()+xNUM_NF+xSERIE+xFORNECE+xLOJA)
		
		cPedAtu := SD1->D1_PEDIDO
		cItemAtu:= SD1->D1_ITEMPC
		
		xPEDIDO  :={}                         // Numero do Pedido de Compra
		xITEM_PED:={}                         // Numero do Item do Pedido de Compra
		xNUM_NFDV:={}                         // Numero quando houver devolucao
		xPREF_DV :={}                         // Serie  quando houver devolucao
		xICMS    :={}                         // Porcentagem do ICMS
		xCOD_PRO :={}                         // Codigo  do Produto
		xQTD_PRO :={}                         // Peso/Quantidade do Produto
		xPRE_UNI :={}                         // Preco Unitario de Compra
		xIPI     :={}                         // Porcentagem do IPI
		xPESOPROD:={}                         // Peso do Produto
		xVAL_IPI :={}                         // Valor do IPI
		xDESC    :={}                         // Desconto por Item
		xVAL_DESC:={}                         // Valor do Desconto
		xVAL_MERC:={}                         // Valor da Mercadoria
		xTES     :={}                         // TES
		xCF      :={}                         // Classificacao quanto natureza da Operacao
		xICMSOL  :={}                         // Base do ICMS Solidario
		xICM_PROD:={}                         // ICMS do Produto
		
		while !eof() .and. SD1->D1_DOC==xNUM_NF
			If SD1->D1_SERIE #mv_par03        // Se a Serie do Arquivo for Diferente
				DbSkip()                      // do Parametro Informado !!!
				Loop
			Endif
			
			AADD(xPEDIDO ,SD1->D1_PEDIDO)           // Ordem de Compra
			AADD(xITEM_PED ,SD1->D1_ITEMPC)         // Item da O.C.
			AADD(xNUM_NFDV ,IIF(Empty(SD1->D1_NFORI),"",SD1->D1_NFORI))
			AADD(xPREF_DV  ,SD1->D1_SERIORI)        // Serie Original
			AADD(xICMS     ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
			AADD(xCOD_PRO  ,SD1->D1_COD)            // Produto
			AADD(xQTD_PRO  ,SD1->D1_QUANT)          // Guarda as quant. da NF
			AADD(xPRE_UNI  ,SD1->D1_VUNIT)          // Valor Unitario
			AADD(xIPI      ,SD1->D1_IPI)            // % IPI
			AADD(xVAL_IPI  ,SD1->D1_VALIPI)         // Valor do IPI
			AADD(xPESOPROD ,SD1->D1_PESO)           // Peso do Produto
			AADD(xDESC     ,SD1->D1_DESC)           // % Desconto
			AADD(xVAL_MERC ,SD1->D1_TOTAL)          // Valor Total
			AADD(xTES      ,SD1->D1_TES)            // Tipo de Entrada/Saida
			AADD(xCF       ,SD1->D1_CF)             // Codigo Fiscal
			AADD(xICM_PROD ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
			dbskip()
		End
		
		dbSelectArea("SB1")                     // * Desc. Generica do Produto
		dbSetOrder(1)
		xUNID_PRO:={}                           // Unidade do Produto
		xDESC_PRO:={}                           // Descricao do Produto
		xMEN_POS :={}                           // Mensagem da Posicao IPI
		xDESCRICAO :={}                         // Descricao do Produto
		xCOD_TRIB:={}                           // Codigo de Tributacao
		xMEN_TRIB:={}                           // Mensagens de Tributacao
		xCOD_FIS :={}                           // Cogigo Fiscal
		xCLAS_FIS:={}                           // Classificacao Fiscal
		xISS     :={}                           // Aliquota de ISS
		xTIPO_PRO:={}                           // Tipo do Produto
		xLUCRO   :={}                           // Margem de Lucro p/ ICMS Solidario
		xCLFISCAL   :={}
		xSUFRAMA :=""
		xCALCSUF :=""
		
		//I:=1
		For I:=1 to Len(xCOD_PRO)
			
			dbSeek(xFilial()+xCOD_PRO[I])
			dbSelectArea("SB1")
			
			AADD(xDESC_PRO ,SB1->B1_DESC)
			AADD(xUNID_PRO ,SB1->B1_UM)
			AADD(xCOD_TRIB ,SB1->B1_ORIGEM)
			If Ascan(xMEN_TRIB, SB1->B1_ORIGEM)==0
				AADD(xMEN_TRIB ,SB1->B1_ORIGEM)
			Endif
			AADD(xDESCRICAO ,SB1->B1_DESC)
			AADD(xMEN_POS  ,SB1->B1_POSIPI)
			If SB1->B1_ALIQISS > 0
				AADD(xISS,SB1->B1_ALIQISS)
			Endif
			AADD(xTIPO_PRO ,SB1->B1_TIPO)
			AADD(xLUCRO    ,SB1->B1_PICMRET)
			
			npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)
			
			if npElem == 0
				AADD(xCLAS_FIS  ,SB1->B1_POSIPI)
			endif
			npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)
			
			DO CASE
				CASE npElem == 1
					_CLASFIS := "A"
					
				CASE npElem == 2
					_CLASFIS := "B"
					
				CASE npElem == 3
					_CLASFIS := "C"
					
				CASE npElem == 4
					_CLASFIS := "D"
					
				CASE npElem == 5
					_CLASFIS := "E"
					
				CASE npElem == 6
					_CLASFIS := "F"
					
			EndCase
			nPteste := Ascan(xCLFISCAL,_CLASFIS)
			If nPteste == 0
				AADD(xCLFISCAL,_CLASFIS)
			Endif
			AADD(xCOD_FIS ,_CLASFIS)
			
		Next
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Pesquisa da Condicao de Pagto               �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		
		dbSelectArea("SE4")                    // Condicao de Pagamento
		dbSetOrder(1)
		dbSeek(xFilial("SE4")+xCOND_PAG)
		xDESC_PAG := SE4->E4_DESCRI
		
		If xTIPO == "D"
			
			dbSelectArea("SA1")                // * Cadastro de Clientes
			dbSetOrder(1)
			dbSeek(xFilial()+xFORNECE)
			xCOD_CLI :=SA1->A1_COD             // Codigo do Cliente
			xNOME_CLI:=SA1->A1_NOME            // Nome
			xEND_CLI :=SA1->A1_END             // Endereco
			xBAIRRO  :=SA1->A1_BAIRRO          // Bairro
			xCEP_CLI :=SA1->A1_CEP             // CEP
			xCOB_CLI :=SA1->A1_ENDCOB          // Endereco de Cobranca
			xREC_CLI :=SA1->A1_ENDENT          // Endereco de Entrega
			xMUN_CLI :=SA1->A1_MUN             // Municipio
			xEST_CLI :=SA1->A1_EST             // Estado
			xCGC_CLI :=SA1->A1_CGC             // CGC
			xINSC_CLI:=SA1->A1_INSCR           // Inscricao estadual
			xTRAN_CLI:=SA1->A1_TRANSP          // Transportadora
			xTEL_CLI :=SA1->A1_TEL             // Telefone
			xFAX_CLI :=SA1->A1_FAX             // Fax
			
		Else
			
			dbSelectArea("SA2")                // * Cadastro de Fornecedores
			dbSetOrder(1)
			dbSeek(xFilial()+xFORNECE+xLOJA)
			xCOD_CLI :=SA2->A2_COD                // Codigo do Cliente
			xNOME_CLI:=SA2->A2_NOME               // Nome
			xEND_CLI :=SA2->A2_END                // Endereco
			xBAIRRO  :=SA2->A2_BAIRRO             // Bairro
			xCEP_CLI :=SA2->A2_CEP                // CEP
			xCOB_CLI :=""                         // Endereco de Cobranca
			xREC_CLI :=""                         // Endereco de Entrega
			xMUN_CLI :=SA2->A2_MUN                // Municipio
			xEST_CLI :=SA2->A2_EST                // Estado
			xCGC_CLI :=SA2->A2_CGC                // CGC
			xINSC_CLI:=SA2->A2_INSCR              // Inscricao estadual
			xTRAN_CLI:=SA2->A2_TRANSP             // Transportadora
			xTEL_CLI :=SA2->A2_TEL                // Telefone
			xFAX     :=SA2->A2_FAX                // Fax
			
		EndIf
		
		dbSelectArea("SE1")                   // * Contas a Receber
		dbSetOrder(1)
		xPARC_DUP  :={}                       // Parcela
		xVENC_DUP  :={}                       // Vencimento
		xVALOR_DUP :={}                       // Valor
		xDUPLICATAS:=IIF(dbSeek(xFilial()+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas
		
		while !eof() .and. SE1->E1_NUM==xNUM_DUPLIC .and. xDUPLICATAS==.T.
			AADD(xPARC_DUP ,SE1->E1_PARCELA)
			AADD(xVENC_DUP ,SE1->E1_VENCTO)
			AADD(xVALOR_DUP,SE1->E1_VALOR)
			dbSkip()
		EndDo
		
		dbSelectArea("SF4")                   // * Tipos de Entrada e Saida
		dbSetOrder(1)
		dbSeek(xFilial()+SD1->D1_TES)
		xNATUREZA:=SF4->F4_TEXTO              // Natureza da Operacao
		
		xNOME_TRANSP :=" "           // Nome Transportadora
		xEND_TRANSP  :=" "           // Endereco
		xMUN_TRANSP  :=" "           // Municipio
		xEST_TRANSP  :=" "           // Estado
		xVIA_TRANSP  :=" "           // Via de Transporte
		xCGC_TRANSP  :=" "           // CGC
		xTEL_TRANSP  :=" "           // Fone
		xTPFRETE     :=" "           // Tipo de Frete
		xVOLUME      := 0            // Volume
		xESPECIE     :=" "           // Especie
		xPESO_LIQ    := 0            // Peso Liquido
		xPESO_BRUTO  := 0            // Peso Bruto
		xCOD_MENS    :=" "           // Codigo da Mensagem
		xMENSAGEM    :=" "           // Mensagem da Nota
		xPESO_LIQUID :=" "
		
		
		Imprime()
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Termino da Impressao da Nota Fiscal                          �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		IncRegua()                    // Termometro de Impressao
		
		nLin:=0
		dbSelectArea("SF1")
		dbSkip()                     // e passa para a proxima Nota Fiscal
		
	EndDo
Endif
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                                                              �
//�                      FIM DA IMPRESSAO                        �
//�                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Fechamento do Programa da Nota Fiscal                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

dbSelectArea("SF2")
Retindex("SF2")
dbSelectArea("SF1")
Retindex("SF1")
dbSelectArea("SD2")
Retindex("SD2")
dbSelectArea("SD1")
Retindex("SD1")
Set Device To Screen

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Fim do Programa                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                                                              �
//�                   FUNCOES ESPECIFICAS                        �
//�                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � VERIMP   � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Verifica posicionamento de papel na Impressora             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function VerImp
Static Function VerImp()

nLin:= 0                // Contador de Linhas
nLinIni:=0
If aReturn[5]==2
	
	nOpc       := 1
	
	While .T.
		
		SetPrc(0,0)
		dbCommitAll()
		
		@ nLin ,000 PSAY " "
		@ nLin ,004 PSAY "*"
		@ nLin ,022 PSAY "."
		
		IF MsgYesNo("Fomulario esta posicionado ? ")
			nOpc := 1
		ElseIF MsgYesNo("Tenta Novamente ? ")
			nOpc := 2
		Else
			nOpc := 3
		Endif
		
		
		Do Case
			Case nOpc==1
				lContinua:=.T.
				Exit
			Case nOpc==2
				Loop
			Case nOpc==3
				lContinua:=.F.
				Return
		EndCase
	End
Endif

Return

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � IMPDET   � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao de Linhas de Detalhe da Nota Fiscal              낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function IMPDET
Static Function IMPDET()

nTamDet :=10            // Tamanho da Area de Detalhe

//I:=1
J:=1

xB_ICMS_SOL:=0          // Base  do ICMS Solidario
xV_ICMS_SOL:=0          // Valor do ICMS Solidario

For I:=1 to nTamDet
	
	If I<= Len(xCOD_PRO)
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbSeek(xFilial("SF4")+xTes[I],.F.)
		
		If SF4->F4_ISS == "N"
			@ nLin,  05  PSAY Alltrim(xCOD_PRO[I])
			@ nLin,  25  PSAY SubStr(Alltrim(xDESCRICAO[I]),1,43)
    			If Len(Alltrim(xDESCRICAO[I])) > 43
    		       nlin:= nlin + 1
            		@ nLin,  25  PSAY SubStr(Alltrim(xDESCRICAO[I]),44,43)
 	  		    EndIf   
    		@ nLin, 080  PSAY xUNID_PRO[I]
			@ nLin, 082  PSAY xQTD_PRO[I]               Picture"@E 999,999"
			@ nLin, 097  PSAY xPRE_UNI[I]               Picture"@E 99,999,999.99"
			@ nLin, 120  PSAY xVAL_MERC[I]              Picture"@E 99,999,999.99"
			J:=J+1
			nLin := nLin + 1
		Endif
	Endif
Next
nLin :=31
_lServ := .T.
For I:=1 to nTamDet
	
	If I<= Len(xCOD_PRO)
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbSeek(xFilial("SF4")+xTes[I],.F.)
		
		If SF4->F4_ISS == "S"
			If _lServ
				@ nLin,  04  PSAY "COD.PROD."
				@ nLin,  17  PSAY "DESCRICAO"
				@ nLin,  80  PSAY "QUANT"
				@ nLin,  90  PSAY "VL.UNIT."
				@ nLin, 103  PSAY "VL TOTAL."
				nLin :=nLin+1
				_lServ := .F.
			Endif
			@ nLin,  04  PSAY Alltrim(xCOD_PRO[I])
			@ nLin,  17  PSAY SubStr(Alltrim(xDESCRICAO[I]),1,43)
				If Len(Alltrim(xDESCRICAO[I])) > 43
    		       nlin:= nlin + 1
            		@ nLin,  17 Psay SubStr(Alltrim(xDESCRICAO[I]),44,43)
 	  		    EndIf      
			@ nLin, 076  PSAY xQTD_PRO[I]               Picture"@E 999,999"
			@ nLin, 085  PSAY xPRE_UNI[I]               Picture"@E 99,999,999.99"
			@ nLin, 099  PSAY xVAL_MERC[I]              Picture"@E 99,999,999.99"
			nLin := nLin + 1
			j:= J + 1
			
		Endif
	Endif
Next

Return

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�


/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � CLASFIS  � Autor �   Marcos Simidu       � Data � 16/11/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao de Array com as Classificacoes Fiscais           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function CLASFIS

Static Function CLASFIS()

@ nLin,006 PSAY "Classificacao Fiscal"
nLin := nLin + 1
For nCont := 1 to Len(xCLFISCAL) .And. nCont <= 12
	nCol := If(Mod(nCont,2) != 0, 06, 33)
	@ nLin, nCol   PSAY xCLFISCAL[nCont] + "-"
	@ nLin, nCol+ 05 PSAY Transform(xCLAS_FIS[nCont],"@r 99.99.99.99.99")
	nLin := nLin + If(Mod(nCont,2) != 0, 0, 1)
Next

Return


/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � IMPMENP  � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao Mensagem Padrao da Nota Fiscal                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function IMPMENP
Static Function IMPMENP()

nCol:= 05

dbSelectArea("SE1")    // Preciso pegar o titulo com E1_TIPO == "NF "
dbSetOrder(1)          // quando ativer IR
dbSeek(xFilial()+SF2->F2_SERIE+SF2->F2_DOC)
If found()
   _xDup := SE1->E1_VENCTO
Endif   

nValIrf :=0
While !Eof() .and. SE1->E1_PREFIXO == SF2->F2_SERIE .and. SE1->E1_NUM == SF2->F2_DOC
	If E1_TIPO == "IR-"
		nValIrf := nValIrf + SE1->E1_VALOR
	Endif
	DbSkip()
Enddo
If nValIrf > 0
	nLin := 58
	@ nLin, 004 PSAY "IMPOSTO DE RENDA RETIDO NA FONTE 1,5 % R$" +Str(nValIrf,11,2)
Endif  

ReTurn

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � IMPFORM  � Autor �   Andreza Favero      � Data � 03/09/01 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao Mensagem Padrao da Nota Fiscal (cadastro Formulas)�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function IMPMENP
Static Function IMPFORM()

nCol:= 04

If !Empty(xCOD_MENS)  

nLin:= 59
   @ nLin, NCol PSAY SubStr(FORMULA(xCOD_MENS),1,70)
     nlin:= nlin+1
   @ nLin, NCol PSAY SubStr(FORMULA(xCOD_MENS),71,70)


Endif

Return

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�
                      


/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � MENSOBS  � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao Mensagem no Campo Observacao                     낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function MENSOBS
Static Function MENSOBS()

nLin:= 59
nTamObs:=70
nCol:=04
@ nLin, nCol PSAY UPPER(SUBSTR(xMENSAGEM,1,nTamObs))
nlin:=nlin+1
@ nLin, nCol PSAY UPPER(SUBSTR(xMENSAGEM,71,nTamObs))
nlin:=nlin+1
@ nLin, nCol PSAY UPPER(SUBSTR(xMENSAGEM,141,nTamObs)) 
                                
 
///// nlin:=nlin+1
//////@ nLin, nCol PSAY "Vencimento : " + _xDUP
nlin:=nlin+1
nAjuste := 0  

@ nLin,ncol psay "VENCIMENTO EM " + ALLTRIM(xDESCR_PAG) + " : "  
nCol:=25

For BB:= 1 to Len(xVALOR_DUP)
     If xDUPLICATAS==.T. .and. BB<=Len(xVALOR_DUP)
        ncol := ncol + 10
	    @ nLin,ncol psay xVENC_DUP[BB]  
	//    ncol := ncol -10
	
	Endif  
	
	   
	
Next

Return

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � DUPLIC   � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao do Parcelamento das Duplicacatas                 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function DUPLIC
Static Function DUPLIC()
//nCol := 7   
nCol := 10
nAjuste := 0
For BB:= 1 to Len(xVALOR_DUP)
	If xDUPLICATAS==.T. .and. BB<=Len(xVALOR_DUP)
	    @ nLin, nCol + nAjuste      PSAY xNUM_DUPLIC + " " + xPARC_DUP[BB]
		@ nLin, nCol + 16 + nAjuste      PSAY xVENC_DUP[BB]
		@ nLin, nCol + 31 + nAjuste PSAY xVALOR_DUP[BB] Picture("@E 9,999,999.99")
		nAjuste := nAjuste + 50
	  
	Endif    
	
	Next

Return

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � LI       � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Pula 1 linha                                               낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Generico RDMAKE                                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�

//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�


/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � IMPRIME  � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Imprime a Nota Fiscal de Entrada e de Saida                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Generico RDMAKE                                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 01/08/01 ==> Function Imprime
Static Function Imprime()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                                                              �
//�              IMPRESSAO DA N.F. DA Nfiscal                    �
//�                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Impressao do Cabecalho da N.F.      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

//@ 00,000 PSAY AvalImp(Limite)
@ 00, 000 PSAY Chr(15)                // Compressao de Impressao
@ 03, 127 PSAY xNUM_NF               // Numero da Nota Fiscal

If mv_par04 == 1
	@ 04, 103 PSAY "X"
Else
	@ 04, 090 PSAY "X"
Endif


@ 09, 004 PSAY xNATUREZA               // Texto da Natureza de Operacao
@ 09, 044 PSAY xCF[1] Picture"@R 9.999" // Codigo da Natureza de Operacao

 

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Impressao dos Dados do Cliente      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 
cBairro :=  XBairro
@ 12, 004 PSAY ALLTRIM(xNOME_CLI)              //Nome do Cliente  Inserido Alltrim - Dennys 210306

If !EMPTY(xCGC_CLI)                   // Se o C.G.C. do Cli/Forn nao for Vazio
	@ 12, 093 PSAY xCGC_CLI Picture"@R 99.999.999/9999-99"
Else
	@ 12, 093 PSAY " "                // Caso seja vazio
Endif

@ 12, 129 PSAY xEMISSAO              // Data da Emissao do Documento


@ 14, 004 PSAY ALLTRIM(xEND_CLI)                                 // Endereco


@ 14, 077 PSAY cBairro//alltrim(xBAIRRO) //+"."                                  // Bairro
@ 14, 113 PSAY xCEP_CLI Picture"@R 99999-999"           // CEP
@ 14, 129 PSAY xEMISSAO
@ 16, 004 PSAY xMUN_CLI                               // Municipio
@ 16, 064 PSAY xTEL_CLI                               // Telefone/FAX
@ 16, 087 PSAY xEST_CLI                               // U.F.
@ 16, 094 PSAY xINSC_CLI                              // Insc. Estadual

//If mv_par04 == 2

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Impressao da Fatura/Duplicata       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// nLin:=19
// BB:=1
// nCol := 10             //  duplicatas
// DUPLIC()

//Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Dados dos Produtos Vendidos         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

nLin := 20
ImpDet()                 // Detalhe da NF
If xValIss > 0
  nLin := 39
  @ nLin, 119 PSAY xVALISS Picture"@E@Z 999,999,999.99"  
Endif
If  xBase_Iss > 0
   nLin := 42
   @ nLin, 119 PSAY xBase_Iss Picture"@E@Z 999,999,999.99"  
Endif


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Prestacao de Servicos Prestados     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Calculo dos Impostos                �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�


If xBase_Icms > 0
   @ 45, 009  PSAY xBASE_ICMS  Picture"@E@Z 999,999,999.99"  // Base do ICMS
Endif
If xVALOR_ICMS > 0
   @ 45, 036  PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS
Endif

_nValProd := xVALOR_MERC - xBase_Iss
If xBSICMRET > 0 
   @ 45, 064  PSAY xBSICMRET   Picture"@E@Z 999,999,999.99"  // Base ICMS Ret.
Endif
If xICMS_RET > 0
   @ 45, 091  PSAY xICMS_RET   Picture"@E@Z 999,999,999.99"  // Valor  ICMS Ret.
Endif
If _nValProd > 0
   @ 45, 119  PSAY _nValProd  Picture"@E@Z 999,999,999.99"  // Valor Tot. Prod.
Endif
If xFRETE > 0
   @ 47, 009  PSAY xFRETE      Picture"@E@Z 999,999,999.99"  // Valor do Frete
Endif
If xSEGURO > 0
   @ 47, 036  PSAY xSEGURO     Picture"@E@Z 999,999,999.99"  // Valor Seguro
Endif
If xVALOR_IPI > 0
   @ 47, 091  PSAY xVALOR_IPI  Picture"@E@Z 999,999,999.99"  // Valor do IPI
Endif
If xTOT_FAT > 0
   @ 47, 119  PSAY xTOT_FAT    Picture"@E@Z 999,999,999.99"  // Valor Total NF
Endif

Impmenp()
Impform()
MensObs()

@ 68, 006 PSAY xNUM_NF                   // Numero da Nota Fiscal

@ 72, 000 PSAY chr(18)                   // Descompressao de Impressao

//SetPrc(0,0)                              // (Zera o Formulario)

Return .t.