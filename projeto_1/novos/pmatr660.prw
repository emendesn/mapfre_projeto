#INCLUDE "PROTHEUS.CH" 


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � MATR660  � Autor � Marco Bianchi         � Data � 03/07/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Resumo de Vendas                                           ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function PMATR660()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Marco Bianchi         � Data � 03/07/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �ExpO1: Objeto do relat�rio                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                      ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local oReport
Local cColuna	:= ""
Local cTitulo	:= "Nota Fiscal/Serie"
Local nQuant	:= 0
Local nPrcVen	:= 0
Local nTotal	:= 0
Local nValIpi	:= 0
Local nQuant1	:= 0
Local nPrcVen1	:= 0
Local nTotal1	:= 0
Local nValIpi1	:= 0
Local lValadi	:= .f.

Private cPerg   := PADR("MTR660",Len(SX1->X1_GRUPO))


//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport:= TReport():New("PMATR660","Resumo de Vendas",cPerg, {|oReport| ReportPrint(oReport)},"Resumo de Vendas")
oReport:SetPortrait(.T.) 
oReport:SetTotalInLine(.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
//�                                                                        �
//�TRCell():New                                                            �
//�ExpO1 : Objeto TSection que a secao pertence                            �
//�ExpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//�ExpC3 : Nome da tabela de referencia da celula                          �
//�ExpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//�ExpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//�ExpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//�ExpL7 : Informe se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//�ExpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
oResumoVen := TRSection():New(oReport,STR0054,{"TRB"},{STR0043,STR0044,STR0045,STR0046,STR0047,STR0048},/*Campos do SX3*/,/*Campos do SIX*/)	// "Resumo"###"Por Tp/Saida + Produto"###"Por Tipo"###"Por Grupo"###"P/Ct.Contab."###"Por Produto"###"Por Tp/Salida + Serie + Nota"
oResumoVen:SetTotalInLine(.F.)

TRCell():New(oResumoVen,"CCOLUNA" ,/*Tabela*/,cTitulo								,/*Picture*/	 			 ,TamSx3("D2_DOC"    )[1]+TamSx3("D2_SERIE")[1]+3,/*lPixel*/,{|| cColuna  })	
TRCell():New(oResumoVen,"NQUANT"  ,/*Tabela*/,"|"+CRLF+"|"+RetTitle("D2_QUANT"	)	,PesqPict("SD2","D2_QUANT"	),TamSx3("D2_QUANT"  )[1],/*lPixel*/,{|| nQuant   },,,"RIGHT")	// FATURAMENTO:		Quantidade
TRCell():New(oResumoVen,"NPRCVEN" ,/*Tabela*/,STR0052+CRLF+RetTitle("D2_PRCVEN")	,PesqPict("SD2","D2_PRCVEN"	),TamSx3("D2_PRCVEN" )[1],/*lPixel*/,{|| nPrcVen  },,,"RIGHT")	// FATURAMENTO:		Preco Unitario
If lValadi
	TRCell():New(oResumoVen,"NVALADI" ,/*Tabela*/,CRLF+Substr(RetTitle("D2_VALADI"),1,10)	,PesqPict("SD2","D2_VALADI"	),TamSx3("D2_VALADI" )[1],/*lPixel*/,{|| nValadi  },,,"RIGHT")	// OUTROS VALORES: ADIANTAMENTO
EndIf
TRCell():New(oResumoVen,"NTOTAL"  ,/*Tabela*/,CRLF+RetTitle("D2_TOTAL"	)			,PesqPict("SD2","D2_TOTAL"	),TamSx3("D2_TOTAL"  )[1],/*lPixel*/,{|| nTotal   },,,"RIGHT")	// FATURAMENTO:		Valot Total
If cPaisloc == "BRA"
	TRCell():New(oResumoVen,"NVALIPI" ,/*Tabela*/,CRLF+RetTitle("D2_VALIPI"	)	,PesqPict("SD2","D2_VALIPI"	),TamSx3("D2_VALIPI" )[1],/*lPixel*/,{|| nValIPI  },,,"RIGHT")	// FATURAMENTO:		Valor IPI
Else	
	TRCell():New(oResumoVen,"NVALIPI" ,/*Tabela*/,CRLF+Substr(RetTitle("D2_VALIMP1"),1,10)	,PesqPict("SD2","D2_VALIPI"	),TamSx3("D2_VALIPI" )[1],/*lPixel*/,{|| nValIPI  },,,"RIGHT")	// FATURAMENTO:		Valor IPI
EndIf	
TRCell():New(oResumoVen,"NQUANT1" ,/*Tabela*/,"|"+CRLF+"|"+RetTitle("D2_QUANT"	)	,PesqPict("SD2","D2_QUANT"	),TamSx3("D2_QUANT"  )[1],/*lPixel*/,{|| nQuant1  },,,"RIGHT")	// OUTROS VALORES:	Quantidade
TRCell():New(oResumoVen,"NPRCVEN1",/*Tabela*/,STR0053+CRLF+RetTitle("D2_PRCVEN")	,PesqPict("SD2","D2_PRCVEN"	),TamSx3("D2_PRCVEN" )[1],/*lPixel*/,{|| nPrcVen1 },,,"RIGHT")	// OUTROS VALORES:	Preco Unitario
TRCell():New(oResumoVen,"NTOTAL1" ,/*Tabela*/,CRLF+RetTitle("D2_TOTAL"	)			,PesqPict("SD2","D2_TOTAL"		),TamSx3("D2_TOTAL"  )[1],/*lPixel*/,{|| nTotal1  },,,"RIGHT")	// OUTROS VALORES:	Valor Total
If cPaisloc == "BRA"
	TRCell():New(oResumoVen,"NVALIPI1",/*Tabela*/,CRLF+AllTrim(RetTitle("D2_VALIPI"))+"|",PesqPict("SD2","D2_VALIPI"	),TamSx3("D2_VALIPI" )[1],/*lPixel*/,{|| nValIPI1 },,,"RIGHT")	// OUTROS VALORES:	Valor do IPI
Else
	TRCell():New(oResumoVen,"NVALIPI1",/*Tabela*/,CRLF+Substr(RetTitle("D2_VALIMP1"),1,10)+"|"					 ,PesqPict("SD2","D2_VALIPI"	),TamSx3("D2_VALIPI" )[1],/*lPixel*/,{|| nValIPI1 },,,"RIGHT")	// OUTROS VALORES:	Valor do IPI
EndIf
TRFunction():New(oResumoVen:Cell("NQUANT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
If lValadi
	TRFunction():New(oResumoVen:Cell("NVALADI"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
EndIf
TRFunction():New(oResumoVen:Cell("NTOTAL"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oResumoVen:Cell("NVALIPI"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oResumoVen:Cell("NQUANT1"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oResumoVen:Cell("NTOTAL1"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oResumoVen:Cell("NVALIPI1"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
                                  

//������������������������������������������������������������������������Ŀ
//� Estas Secoes servem apenas para receber as Querys do SD1 e SD2         �
//� que nao sao as tabelas da Section Principal. A tabela para impressao   �
//� e a TRB. Se deixamos o filtro de SD1 e SD2 na section principal,	   �
//� no momento do filtro do SD2 o sistema fecha o filtro do SD1 nao        �
//� reconhecendo o alias.											       �
//��������������������������������������������������������������������������
oTemp1 := TRSection():New(oReport,STR0055,{"SD1"},{STR0043,STR0044,STR0045,STR0046,STR0047,STR0048},/*Campos do SX3*/,/*Campos do SIX*/)	// "Itens - Notas Fiscais Entrada"###"Por Tp/Saida + Produto"###"Por Tipo"###"Por Grupo"###"P/Ct.Contab."###"Por Produto"###"Por Tp/Salida + Serie + Nota"
oTemp1:SetTotalInLine(.F.)

oTemp2 := TRSection():New(oReport,STR0056,{"SD2","SF2"},{STR0043,STR0044,STR0045,STR0046,STR0047,STR0048},/*Campos do SX3*/,/*Campos do SIX*/)	// "Itens - Notas Fiscais Saida"###"Por Tp/Saida + Produto"###"Por Tipo"###"Por Grupo"###"P/Ct.Contab."###"Por Produto"###"Por Tp/Salida + Serie + Nota"
oTemp2:SetTotalInLine(.F.)

//������������������������������������������������������������������������Ŀ
//� Impressao do Cabecalho no top da pagina                                �
//��������������������������������������������������������������������������
oReport:Section(1):SetHeaderPage()     

oReport:Section(2):SetEdit(.F.)
oReport:Section(2):SetEditCell(.F.)
oReport:Section(3):SetEditCell(.F.)

//������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas 									   �
//��������������������������������������������������������������������������
AjustaSX1()
Pergunte(oReport:uParam,.F.)

Return(oReport)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrin� Autor � Marco Bianchi         � Data � 03/07/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpO1: Objeto Report do Relat�rio                           ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport)

Local cAliasSD1 := ""
Local cAliasSD2 := ""
Local cAliasSF2 := ""
Local cOrder	:= ""
Local nCntFor 	:= 0
Local nVend		:= fa440CntVen()
Local lImprime 	:= .T.
Local cTexto	:= ""
Local cCampo	:= ""
Local nY		:= 0
Local aCampos	:= {}
Local cIndice 	:= ""
Local cIndTrab 	:= ""
Local lVend		:= .F.
Local cVend		:= "1"
Local cEstoq 	:= If( (MV_PAR05 == 1),"S",If( (MV_PAR05 == 2),"N","SN" ) )
Local cDupli 	:= If( (MV_PAR06 == 1),"S",If( (MV_PAR06 == 2),"N","SN" ) )
Local cCondicao := ""
Local cFilSF2   := ""
Local cFilSD2   := ""
Local nImpInc   := 0
Local nAuxImp	:= 0
Local lValadi	:= cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico
Local cExpAdi	:= Iif(lValadi,"%D2_VALADI,%","") 

#IFDEF TOP
	Local cWhere	:= ""
	Local cAliasSD1	:= ""
#ENDIF

Private nDecs:=msdecimais(mv_par08)
                     
//������������������������������������������������������������������������Ŀ
//� SetBlock: faz com que as variaveis locais possam ser                   �
//� utilizadas em outras funcoes nao precisando declara-las                �
//� como private.                                                          �
//��������������������������������������������������������������������������
oReport:Section(1):Cell("CCOLUNA" 	):SetBlock({|| cColuna		})
oReport:Section(1):Cell("NQUANT" 	):SetBlock({|| nQuant		})
oReport:Section(1):Cell("NPRCVEN" 	):SetBlock({|| nPrcVen		})
oReport:Section(1):Cell("NTOTAL" 	):SetBlock({|| nTotal		})
oReport:Section(1):Cell("NVALIPI" 	):SetBlock({|| nValIpi		})
oReport:Section(1):Cell("NQUANT1" 	):SetBlock({|| nQuant1		})
oReport:Section(1):Cell("NPRCVEN1" 	):SetBlock({|| nPrcVen1		})
oReport:Section(1):Cell("NTOTAL1" 	):SetBlock({|| nTotal1		})
oReport:Section(1):Cell("NVALIPI1" 	):SetBlock({|| nValIpi1		})
If lValadi
	oReport:Section(1):Cell("NVALADI"):SetBlock({|| nValadi		})
EndIf
cColuna		:= ""
nQuant		:= 0
nPrcVen		:= 0
nTotal		:= 0
nValIpi		:= 0
nQuant1		:= 0
nPrcVen1	:= 0
nTotal1		:= 0
nValIpi1	:= 0
nValadi		:= 0


//������������������������������������������������������������������������Ŀ
//� Altera o Titulo do Relatorio de acordo com parametros	 	           �
//��������������������������������������������������������������������������
oReport:SetTitle(oReport:Title() + " - " + IIf(oReport:Section(1):GetOrder() == 1,STR0043,IIF(oReport:Section(1):GetOrder()==2,STR0044,IIF(oReport:Section(1):GetOrder()==3,STR0045,IIF(oReport:Section(1):GetOrder()==4,STR0046,IIF(oReport:Section(1):GetOrder()==5,STR0047,STR0048))))) + " - " + GetMv("MV_MOEDA"+STR(mv_par08,1)) )	// "Resumo de Vendas"###"Por Tp/Saida + Produto"###"Por Tipo"###"Por Grupo"###"P/Ct.Contab."###"Por Produto"###"Por Tp/Salida + Serie + Nota"

//������������������������������������������������������������������������Ŀ
//�Transforma parametros Range em expressao SQL                            �
//��������������������������������������������������������������������������
MakeSqlExpr(oReport:uParam)

//������������������������������������������������������������������������Ŀ
//�Posiciona SB1 para antes da impressao                                   �
//��������������������������������������������������������������������������
TRPosition():New(oReport:Section(1),"SB1",1,{|| xFilial("SB1") + TRB->D2_COD })
//������������������������������������������������������������������������Ŀ
//�Filtragem do relat�rio                                                  �
//�Obs: Utilizamos SetFilter no SD1 e nao Query pois e dado dbSeek         �
//�no SD1 na funcao CALCDEVR4.                                             �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//� Inclui Devolucao                                                       �
//��������������������������������������������������������������������������

#IFDEF TOP
	
	cWhere := "%"
	//Adicao de filtro para nao considerar REMITOS
	If cPaisLoc<>"BRA"
		cWhere += " AND NOT ("+IsRemito(2,"D1_TIPODOC")+")"
	Endif
	cWhere += "%"
	
	cAliasSD1 := GetNextAlias()    

	oReport:Section(2):BeginQuery()		

	BeginSql Alias cAliasSD1

		SELECT D1_FILIAL,D1_COD,D1_SERIORI,D1_NFORI,D1_ITEMORI,D1_FORNECE,D1_LOJA,D1_DOC,D1_SERIE,D1_LOCAL,D1_TES,
					D1_TP,D1_GRUPO,D1_CONTA,D1_DTDIGIT,D1_TIPO,D1_QUANT,D1_TOTAL,D1_VALDESC,D1_VALIPI,D1_ITEM,D1_VALIMP1,D1_VUNIT
		FROM %table:SD1% SD1
			
		WHERE	D1_FILIAL   = %xFilial:SD1% AND 
				D1_TIPO     = 'D' AND
				D1_COD      >= %Exp:MV_PAR13% AND
				D1_COD   	<= %Exp:MV_PAR14% AND 											
				D1_DTDIGIT >= %Exp:Dtos(MV_PAR01)% AND 
				D1_DTDIGIT <= %Exp:Dtos(MV_PAR02)% AND 
				SD1.%NotDel%
				%Exp:cWhere%					
						
	EndSql 
	oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)

#ELSE
	cOrder	 := ""
	cCondicao:= ""
	If mv_par04 # 3
	cAliasSD1 := "SD1"
	dbSelectArea(cAliasSD1)
	dbSetOrder(2)
	cOrder := "D1_FILIAL+D1_COD+D1_SERIORI+D1_NFORI+D1_ITEMORI"
	cCondicao := 'D1_FILIAL=="'+xFilial("SD1")+'".And.D1_TIPO=="D"'
	cCondicao += ".And. D1_COD>='"+MV_PAR13+"'.And. D1_COD<='"+MV_PAR14+"'"
	cCondicao += '.And. !('+IsRemito(2,'D1_TIPODOC')+')'
	If (MV_PAR04 == 2)
		cCondicao +=".And.DTOS(D1_DTDIGIT)>='"+DTOS(MV_PAR01)+"'.And.DTOS(D1_DTDIGIT)<='"+DTOS(MV_PAR02)+"'"
	EndIf
	dbSelectArea(cAliasSD1)
	oReport:Section(2):SetFilter(cCondicao,cOrder)
	Endif
#ENDIF

//������������������������������������������������������������������������Ŀ
//� Seleciona Indice da Nota Fiscal de Saida                               �
//��������������������������������������������������������������������������
cAliasSF2 := "SF2"
dbSelectArea(cAliasSF2)
dbSetOrder(1)

#IFDEF TOP
	//������������������������������������������������������������������������Ŀ
	//�Query do relat�rio da secao 1                                           �
	//��������������������������������������������������������������������������
	//������������������������������������������������������������������������Ŀ
	//� Filtra Itens de Venda da Nota Fiscal                                   �
	//��������������������������������������������������������������������������
	cAliasSD2 := GetNextAlias()
	dbSelectArea("SD2")
	cWhere := ""
	cWhere := "% AND NOT ("+IsRemito(2,'D2_TIPODOC')+")"
	If mv_par04 == 3 .Or. mv_par11 == 2
		cWhere += " AND D2_TIPO NOT IN ('B','D','I')"
	Else
		cWhere += " AND D2_TIPO NOT IN ('B','I')"
	EndIf		
	cWhere += "%"

	//��������������������������������������������������������������Ŀ
	//� Verifica se ha necessidade de Indexacao no SD2               �
	//����������������������������������������������������������������
	If oReport:Section(1):GetOrder() = 1 .Or. oReport:Section(1):GetOrder() = 6	// Por Tes
		cOrder := "%D2_FILIAL,D2_TES,"+IIf(oReport:Section(1):GetOrder()==1,"D2_COD","D2_SERIE,D2_DOC") + "%"
	ElseIF oReport:Section(1):GetOrder() = 2			// Por Tipo
		SD2->(dbSetOrder(2))							// Tipo do Produto, Codigo do Produto)
		cOrder := "%" + IndexKey() + "%"
	ElseIF oReport:Section(1):GetOrder() = 3			// Por Grupo
		cOrder := "%D2_FILIAL,D2_GRUPO,D2_COD%"
	ElseIF oReport:Section(1):GetOrder() = 4			// Por Conta Contabil
		cOrder := "%D2_FILIAL,D2_CONTA,D2_COD%"
	Else						  						// Por Produto
		cOrder := "%D2_FILIAL,D2_COD,D2_LOCAL,D2_SERIE,D2_DOC%"
	EndIF
	
	oReport:Section(3):BeginQuery()	
	BeginSql Alias cAliasSD2
	SELECT 	D2_FILIAL,D2_COD,D2_LOCAL,D2_SERIE,D2_TES,D2_TP,D2_GRUPO,D2_CONTA,D2_EMISSAO,D2_TIPO,D2_DOC,D2_QUANT,D2_TOTAL,%Exp:cExpAdi%
			D2_VALIPI,D2_PRCVEN,D2_ITEM,D2_CLIENTE,D2_LOJA,F2_MOEDA,F2_TXMOEDA,D2_VALIMP1,D2_VALIMP2,D2_VALIMP3,D2_VALIMP4,D2_VALIMP5,D2_VALIMP6
	FROM %Table:SD2% SD2,%table:SF2% SF2
	WHERE D2_FILIAL = %xFilial:SD2%
		AND D2_EMISSAO >= %Exp:DtoS(mv_par01)% AND D2_EMISSAO <= %Exp:DtoS(mv_par02)%
		AND D2_COD >= %Exp:mv_par13% AND D2_COD <= %Exp:mv_par14%
		AND D2_ORIGLAN <> 'LF'
		AND SF2.F2_FILIAL    = %xFilial:SF2% 
		AND	SF2.F2_DOC       = SD2.D2_DOC
		AND	SF2.F2_SERIE     = SD2.D2_SERIE 
		AND	SF2.F2_CLIENTE   = SD2.D2_CLIENTE
    	AND	SF2.F2_LOJA      = SD2.D2_LOJA
		AND SD2.%NotDel%
		AND SF2.%NotDel%
		%Exp:cWhere%	
	ORDER BY %Exp:cOrder%
	EndSql 
	oReport:Section(3):EndQuery(/*Array com os parametros do tipo Range*/)
	dbGoTop()
		
#ELSE

	//������������������������������������������������������������������������Ŀ
	//� Filtra Itens de Venda da Nota Fiscal                                   �
	//��������������������������������������������������������������������������
	cAliasSD2 := "SD2"
	DbSelectArea(cAliasSD2)
	cCondicao:= ""
	cCondicao += "D2_FILIAL == '"+xFilial("SD2")+"'.And."
	cCondicao += "DTOS(D2_EMISSAO) >='"+DTOS(mv_par01)+"'.And.DTOS(D2_EMISSAO)<='"+DTOS(mv_par02)+"'"
	cCondicao += ".And. D2_COD>='"+MV_PAR13+"'.And. D2_COD<='"+MV_PAR14+"'"
	cCondicao += '.And. !('+IsRemito(2,'D2_TIPODOC')+')'		
	cCondicao += ".And.!(D2_ORIGLAN$'LF')"
	If mv_par04==3 .Or. mv_par11 == 2
		cCondicao += ".And.!(D2_TIPO$'BDI')"
	Else
		cCondicao += ".And.!(D2_TIPO$'BI')"
	EndIf		
	
	//��������������������������������������������������������������Ŀ
	//� Verifica se ha necessidade de Indexacao no SD2               �
	//����������������������������������������������������������������
	If oReport:Section(1):GetOrder() = 1 .Or. oReport:Section(1):GetOrder() = 6	// Por Tes
		oReport:Section(3):SetFilter(cCondicao,"D2_FILIAL+D2_TES+" + IIf(oReport:Section(1):GetOrder()==1,"D2_COD","D2_SERIE+D2_DOC"))	
	ElseIF oReport:Section(1):GetOrder() = 2				// Por Tipo
		SD2->(dbSetOrder(2))								// Tipo do Produto, Codigo do Produto
		oReport:Section(3):SetFilter(cCondicao,IndexKey())	
	ElseIF oReport:Section(1):GetOrder() = 3				// Por Grupo
		oReport:Section(3):SetFilter(cCondicao,"D2_FILIAL+D2_GRUPO+D2_COD")		
	ElseIF oReport:Section(1):GetOrder() = 4				// Por Conta Contabil
		oReport:Section(3):SetFilter(cCondicao,"D2_FILIAL+D2_CONTA+D2_COD")
	Else													// Por Produto
		oReport:Section(3):SetFilter(cCondicao,"D2_FILIAL+D2_COD+D2_LOCAL+D2_SERIE+D2_DOC")
	EndIF
	dbGoTop()

#ENDIF		


//������������������������������������������������������������������������Ŀ
//� Cria tabela temporaria                                                 �
//��������������������������������������������������������������������������
cIndice := CriaTrab("",.F.)
cIndTrab := SubStr(cIndice,1,7)+"A"
dbSelectArea("SD2")
aTam := TamSx3("D2_FILIAL")
Aadd(aCampos,{"D2_FILIAL","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_COD")
Aadd(aCampos,{"D2_COD","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_LOCAL")
Aadd(aCampos,{"D2_LOCAL","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_SERIE")
Aadd(aCampos,{"D2_SERIE","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_TES")
Aadd(aCampos,{"D2_TES","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_TP")
Aadd(aCampos,{"D2_TP","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_GRUPO")
Aadd(aCampos,{"D2_GRUPO","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_CONTA")
Aadd(aCampos,{"D2_CONTA","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_EMISSAO")
Aadd(aCampos,{"D2_EMISSAO","D",aTam[1],aTam[2]})
aTam := TamSx3("D2_TIPO")
Aadd(aCampos,{"D2_TIPO","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_DOC")
Aadd(aCampos,{"D2_DOC","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_QUANT")
Aadd(aCampos,{"D2_QUANT","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_TOTAL")
Aadd(aCampos,{"D2_TOTAL","N",aTam[1],aTam[2]})
If lValadi
	aTam := TamSx3("D2_VALADI")
	Aadd(aCampos,{"D2_VALADI","N",aTam[1],aTam[2]})
EndIf

If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
	aTam := TamSx3("D2_VALIMP1")
	Aadd(aCampos,{"D2_VALIMP1","N",aTam[1],aTam[2]})
else
	aTam := TamSx3("D2_VALIPI")
	Aadd(aCampos,{"D2_VALIPI","N",aTam[1],aTam[2]})
EndIf

aTam := TamSx3("D2_PRCVEN")
Aadd(aCampos,{"D2_PRCVEN","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_ITEM")
Aadd(aCampos,{"D2_ITEM","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_CLIENTE")
Aadd(aCampos,{"D2_CLIENTE","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_LOJA")
Aadd(aCampos,{"D2_LOJA","C",aTam[1],aTam[2]})

//Campos para guardar a moeda/taxa da nota para a conversao durante a impressao
aTam := TamSx3("F2_MOEDA")
Aadd(aCampos,{"D2_MOEDA","N",aTam[1],aTam[2]})
aTam := TamSx3("F2_TXMOEDA")
Aadd(aCampos,{"D2_TXMOEDA","N",aTam[1],aTam[2]})

cArqTrab := CriaTrab(aCampos)
Use &cArqTrab Alias TRB New Exclusive

If oReport:Section(1):GetOrder() = 1 .Or. oReport:Section(1):GetOrder() = 6							// Por Tes	
	cVaria := "D2_TES"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_TES+"+IIf(oReport:Section(1):GetOrder()==1,"D2_COD","D2_SERIE+D2_DOC"),,,STR0049)	// "Selecionando Registros..."
ElseIF oReport:Section(1):GetOrder() = 2																// Por Tipo
	cVaria := "D2_TP"
	IndRegua("TRB",cIndTrab,SD2->(IndexKey(2)),,,STR0049)   											// "Selecionando Registros..."
ElseIF oReport:Section(1):GetOrder() = 3																// Por Grupo
	cVaria := "D2_GRUPO"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_GRUPO+D2_COD",,,STR0049) 										// "Selecionando Registros..."
ElseIF oReport:Section(1):GetOrder() = 4																// Por Conta Contabil
	cVaria := "D2_CONTA"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_CONTA+D2_COD",,,STR0049) 										// "Selecionando Registros..."
Else																									// Por Produto
	cVaria := "D2_COD"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_COD+D2_LOCAL+D2_SERIE+D2_DOC",,,STR0049)     					// "Selecionando Registros..."
EndIF

//������������������������������������������������������������������������Ŀ
//� Gera Arqiuvo Temporario                                                �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//� Notas de Saida                                                         �
//��������������������������������������������������������������������������
// Busca filtro do usuario do SF2
If len(oReport:Section(3):GetAdvplExp("SF2")) > 0
	cFilSF2 := oReport:Section(3):GetAdvplExp("SF2")
EndIf
// Busca filtro do usuario do SD2
If len(oReport:Section(3):GetAdvplExp("SD2")) > 0
	cFilSD2 := oReport:Section(3):GetAdvplExp("SD2")
EndIf

dbSelectArea(cAliasSD2)
dbGoTop()
oReport:SetMeter(RecCount())
While !oReport:Cancel() .And. !(cAliasSD2)->(Eof()) .And. D2_FILIAL == xFilial("SD2")
		
		//��������������������������������������������������������������Ŀ
		//� Verifica vendedor no SF2                                     �
		//����������������������������������������������������������������
		
		// Verifica filtro do usuario
		If !Empty(cFilSF2) .And. !(&cFilSF2)
	   		dbSkip()
			Loop
		EndIf	

		dbselectarea(cAliasSF2)
		dbSeek(xFilial("SF2")+(cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA)
		dbSelectArea(cAliasSD2)
		
		
		For nCntFor := 1 To nVend
			cVendedor := (cAliasSF2)->(FieldGet((cAliasSF2)->(FieldPos("F2_VEND"+cVend))))
			If cVendedor >= mv_par09 .and. cVendedor <= mv_par10
				lVend := .T.
				Exit
			EndIf
			cVend := Soma1(cVend,1)
		Next nCntFor
		cVend := "1"
		
		If lVend
			dbSelectArea("TRB")
			Reclock("TRB",.T.)
			Replace TRB->D2_FILIAL  With (cAliasSD2)->D2_FILIAL
			Replace TRB->D2_COD     With (cAliasSD2)->D2_COD
			Replace TRB->D2_LOCAL   With (cAliasSD2)->D2_LOCAL
			Replace TRB->D2_SERIE   With (cAliasSD2)->D2_SERIE
			Replace TRB->D2_TES     With (cAliasSD2)->D2_TES
			Replace TRB->D2_TP      With (cAliasSD2)->D2_TP
			Replace TRB->D2_GRUPO   With (cAliasSD2)->D2_GRUPO
			Replace TRB->D2_CONTA   With (cAliasSD2)->D2_CONTA
			Replace TRB->D2_EMISSAO With (cAliasSD2)->D2_EMISSAO
			Replace TRB->D2_TIPO    With (cAliasSD2)->D2_TIPO
			Replace TRB->D2_DOC     With (cAliasSD2)->D2_DOC
			Replace TRB->D2_QUANT   With (cAliasSD2)->D2_QUANT
			
			if cPaisloc<>"BRA" // Localizado para imprimir o IVA 24/05/00
			    Replace TRB->D2_PRCVEN  With (cAliasSD2)->D2_PRCVEN
                Replace TRB->D2_TOTAL   With ((cAliasSD2)->D2_TOTAL - Iif(lValadi,(cAliasSD2)->D2_VALADI,0))
                If lValadi
                	Replace TRB->D2_VALADI  With ((cAliasSD2)->D2_VALADI)
                EndIf

				aImpostos:=TesImpInf((cAliasSD2)->D2_TES)
	
				For nY:=1 to Len(aImpostos)
					cCampImp:=(cAliasSD2) + "->" + (aImpostos[nY][2])
					If ( aImpostos[nY][3]=="1" )
						nImpInc     += &cCampImp
					EndIf
				Next
	
				Replace TRB->D2_VALImP1  With nImpInc
				nImpInc:=0
			else
			    If (cAliasSD2)->D2_TIPO <> "P" //Complemento de IPI
			       Replace TRB->D2_PRCVEN  With (cAliasSD2)->D2_PRCVEN
			       Replace TRB->D2_TOTAL   With (cAliasSD2)->D2_TOTAL
                Endif
				Replace TRB->D2_VALIPI  With (cAliasSD2)->D2_VALIPI
			endif
			
			Replace TRB->D2_ITEM    With (cAliasSD2)->D2_ITEM
			Replace TRB->D2_CLIENTE With (cAliasSD2)->D2_CLIENTE
			Replace TRB->D2_LOJA    With (cAliasSD2)->D2_LOJA
			
			//--------- Grava a moeda/taxa da nota para a conversao durante a impressao
			Replace TRB->D2_MOEDA   With (cAliasSF2)->F2_MOEDA
			Replace TRB->D2_TXMOEDA With (cAliasSF2)->F2_TXMOEDA
			
			MsUnlock()
			lVend := .F.
		EndIf
	dbSelectArea(cAliasSD2)
	dbSkip()
	oReport:IncMeter()
	
EndDo

//������������������������������������������������������������������������Ŀ
//� Nota de Devolucao                                                      �
//��������������������������������������������������������������������������
If mv_par04 == 2
	
	SF1->(dbsetorder(1))
	
	dbSelectArea(cAliasSD1)
	dbGoTop()
	oReport:SetMeter(RecCount())
	While !oReport:Cancel() .And. !(cAliasSD1)->(Eof()) .And. D1_FILIAL == xFilial("SD1")
			
			//��������������������������������������������������������������Ŀ
			//� Verifica nota fiscal de origem e vendedor no SF2             �
			//����������������������������������������������������������������
		    dbselectarea(cAliasSF2)
            If cPaisLoc == "BRA"
            	dbSeek(xFilial()+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI)
		    Else
		    	dbSeek(xFilial()+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA)
			EndIf
			
			// Verifica filtro do usuario
			If !Empty(cFilSF2) .And. !(&cFilSF2)
				dbSelectArea(cAliasSD1)
		   		dbSkip()
				Loop
			EndIf	
			
			// Verifica filtro do usuario no SD2     
			If !Empty(cFilSD2)
				dbSelectArea("SD2")
				dbSetOrder(3)
				If dbseek(xFilial()+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_ITEMORI)
					If !(&cFilSD2)
						dbSelectArea(cAliasSD1)
		   				dbSkip()
						Loop
					EndIf	
				EndIf	
			EndIf	
            //Somente busca o vendedor, se realmente foi encontrado a nota fiscal de origem
			If (cAliasSF2)->(Found())
				For nCntFor := 1 To nVend
					cVendedor := (cAliasSF2)->(FieldGet((cAliasSF2)->(FieldPos("F2_VEND"+cVend))))
					If cVendedor >= mv_par09 .and. cVendedor <= mv_par10
						lVend := .T.
						Exit
					EndIf
					cVend := Soma1(cVend,1)
				Next nCntFor
				cVend := "1"
            EndIf
            
			If lVend
				SF1->(dbseek((cAliasSD1)->D1_FILIAL+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA))
		        dbSelectArea("TRB")
				Reclock("TRB",.T.)
				Replace TRB->D2_FILIAL	With (cAliasSD1)->D1_FILIAL
				Replace TRB->D2_COD 	With (cAliasSD1)->D1_COD
				Replace TRB->D2_LOCAL 	With (cAliasSD1)->D1_LOCAL
				Replace TRB->D2_SERIE 	With If(mv_par12==1,(cAliasSD1)->D1_SERIORI,(cAliasSD1)->D1_SERIE)
				Replace TRB->D2_TES 	With (cAliasSD1)->D1_TES
				Replace TRB->D2_TP 		With (cAliasSD1)->D1_TP
				Replace TRB->D2_GRUPO 	With (cAliasSD1)->D1_GRUPO
				Replace TRB->D2_CONTA 	With (cAliasSD1)->D1_CONTA
				Replace TRB->D2_EMISSAO With (cAliasSD1)->D1_DTDIGIT
				Replace TRB->D2_TIPO 	With (cAliasSD1)->D1_TIPO
				Replace TRB->D2_DOC 	With If(mv_par12==1,(cAliasSD1)->D1_NFORI,(cAliasSD1)->D1_DOC)
				Replace TRB->D2_QUANT 	With -(cAliasSD1)->D1_QUANT
				Replace TRB->D2_TOTAL 	With -((cAliasSD1)->D1_TOTAL-(cAliasSD1)->D1_VALDESC)
				If lValadi
					Replace TRB->D2_VALADI 	With 0
				EndIf
				
				If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
					Replace TRB->D2_VALIMP1 With - (cAliasSD1)->D1_VALIMP1
				Else
					Replace TRB->D2_VALIPI With - (cAliasSD1)->D1_VALIPI
				Endif
				
				Replace TRB->D2_PRCVEN  With (cAliasSD1)->D1_VUNIT
				Replace TRB->D2_ITEM 	With (cAliasSD1)->D1_ITEM
				Replace TRB->D2_CLIENTE With (cAliasSD1)->D1_FORNECE
				Replace TRB->D2_LOJA 	With (cAliasSD1)->D1_LOJA
				
				//--------- Grava a moeda/taxa da nota para a conversao durante a impressao
				Replace TRB->D2_MOEDA   With SF1->F1_MOEDA
				Replace TRB->D2_TXMOEDA With SF1->F1_TXMOEDA
				
				MsUnlock()
				lVend := .F.
			EndIf
		dbSelectArea(cAliasSD1)
		dbSkip()
		oReport:IncMeter()
	EndDo
EndIf


dbSelectArea("TRB")
dbGoTop()
oReport:Section(1):Init()
oReport:SetMeter(RecCount())  														// Total de Elementos da regua
While !oReport:Cancel() .And. !TRB->(Eof()) .And. lImprime
	
	cColuna := TRB->D2_DOC + "/" + TRB->D2_SERIE
	cTexto	:= ""
	If oReport:Section(1):GetOrder() = 1 .Or. oReport:Section(1):GetOrder() = 6	// Por Tes
		dbSelectArea("SF4")
		dbSeek(xFilial()+TRB->D2_TES)
		dbSelectArea("TRB")
		If mv_par07 == 1															// Analitico
			cTexto  := "TES: " + TRB->D2_TES + " - " +  SF4->F4_TEXTO
		Else																		// Sintetico
			cColuna := TRB->D2_TES + " - " +  SF4->F4_TEXTO
		EndIf
		dbSelectArea("TRB")
		cCpo := TRB->D2_TES
	Elseif oReport:Section(1):GetOrder() = 2					   					// Por Tipo
		If mv_par07 == 1															// Analitico
			cTexto  := "TIPO DE PRODUTO: " + TRB->D2_TP
		Else																		// Sintetico
			cColuna := TRB->D2_TP
		EndIf
		cCpo := TRB->D2_TP		
	Elseif oReport:Section(1):GetOrder() = 3										// Por Grupo
		dbSelectArea("SBM")
		dbSeek(xFilial()+TRB->D2_GRUPO)
		dbSelectArea("TRB")
		If mv_par07 == 1															// Analitico
			cTexto  := "GRUPO: " + TRB->D2_GRUPO + " - " + SBM->BM_DESC 
		Else																		// Sintetico
			cColuna := TRB->D2_GRUPO + " - " + SBM->BM_DESC
		EndIf
		cCpo := TRB->D2_GRUPO		
	Elseif oReport:Section(1):GetOrder() = 4		  								// Por Conta Contabil
		dbSelectArea("SI1")
		dbSetOrder(1)
		dbSeek(xFilial()+TRB->D2_CONTA)
		dbSelectArea("TRB")		
		If mv_par07 == 1															// Analitico
			cTexto  := "CONTA: " + TRB->D2_CONTA + SI1->I1_DESC
		Else																		// Sintetico
			cColuna := TRB->D2_CONTA
		EndIf           
		cCpo := TRB->D2_CONTA
	Else																			// Por Produto
		If mv_par07 == 1															// Analitico
			cTexto  := "PRODUTO: " + TRB->D2_COD
		Else																		// Sintetico
			cColuna := TRB->D2_COD
		EndIf
		dbSelectArea("TRB")
		cCpo := TRB->D2_COD
	Endif
	cCampo 	:= "cCpo"
	nQuant	:=0;nTotal:=0;nValIpi:=0;nValadi:=0
	nQuant1	:=0;nTotal1:=0;nValIpi1:=0;
	
	If mv_par07 == 1			// Analitico
		oReport:PrintText(cTexto)
	EndIf
	
	dbSelectArea("TRB")
	While &cCampo = &cVaria .And. !Eof() .And. lImprime
		
		//�����������������������������Ŀ
		//� Trato a Devolu��o de Vendas �
		//�������������������������������
		nDevQtd	:=0;nDevVal:=0;nDevIPI:=0
		nDevQtd1:=0;nDevVal1:=0;
		
		If mv_par04 == 1  //Devolucao pela NF Original
			CalcDevR4(cDupli,cEstoq)
		EndIf
		
		dbSelectArea("TRB")
		If AvalTes(TRB->D2_TES,cEstoq,cDupli)
			oReport:Section(1):Cell("NQUANT"	):Show()
			oReport:Section(1):Cell("NTOTAL"	):Show()
			oReport:Section(1):Cell("NVALIPI"	):Show()
			
			If mv_par07 == 1		// Analitico
				oReport:Section(1):Cell("NPRCVEN"	):Show()
				oReport:Section(1):Cell("NQUANT1"	):Hide()
				oReport:Section(1):Cell("NPRCVEN1"	):Hide()
				oReport:Section(1):Cell("NTOTAL1"	):Hide()
				oReport:Section(1):Cell("NVALIPI1"	):Hide()
				
				cColuna := TRB->D2_DOC + "/" + TRB->D2_SERIE
				nQuant 	:= TRB->D2_QUANT - nDevQtd
				nTotal 	:= xMoeda(TRB->D2_TOTAL,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA)  - nDevVal
				nQuant1 := nPrcVen1 := nTotal1 := nValIPI1 := nValadi := 0 
			Else					// Sintetico
				oReport:Section(1):Cell("NPRCVEN"	):Hide()
				oReport:Section(1):Cell("NQUANT1"	):Show()
				oReport:Section(1):Cell("NPRCVEN1"	):Hide()
				oReport:Section(1):Cell("NTOTAL1"	):Show()
				oReport:Section(1):Cell("NVALIPI1"	):Show()
				
				nQuant 	+= (TRB->D2_QUANT - nDevQtd)
				nTotal 	+= (xMoeda(TRB->D2_TOTAL,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA)  - nDevVal)
			EndIf	
			
			nPrcVen := xMoeda(TRB->D2_PRCVEN,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA)
			If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
				nValIPI  += xMoeda(TRB->D2_VALIMP1,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA)  - nDevIpi
			Else
				nValIPI  += xMoeda(TRB->D2_VALIPI ,1,mv_par08,TRB->D2_EMISSAO) -  nDevIpi
			Endif
			
			If mv_par07 == 1				// Analitico
				If cPaisloc<>"BRA"			// Localizado para imprimir o IVA 24/05/00
					nValIPI := xMoeda(TRB->D2_VALIMP1 ,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA) - nDevIpi
				Else
					nValIPI :=  xMoeda(TRB->D2_VALIPI,1,mv_par08,TRB->D2_EMISSAO)- nDevIpi
				Endif
			EndIf
			
		Else
		
			If mv_par07 == 1		// Analitico
				oReport:Section(1):Cell("NQUANT"	):Hide()
				oReport:Section(1):Cell("NTOTAL"	):Hide()
				oReport:Section(1):Cell("NVALIPI"	):Hide()
				oReport:Section(1):Cell("NPRCVEN1"	):Show()				
				
				cColuna := TRB->D2_DOC + "/" + TRB->D2_SERIE
				nQuant1 := TRB->D2_QUANT - nDevQtd1
				nQuant := nPrcVen := nTotal := nValIPI := nValadi := 0
			Else	
				oReport:Section(1):Cell("NQUANT"	):Show()
				oReport:Section(1):Cell("NTOTAL"	):Show()
				oReport:Section(1):Cell("NVALIPI"	):Show()
				oReport:Section(1):Cell("NPRCVEN1"	):Hide()
				
				nQuant1 += (TRB->D2_QUANT - nDevQtd1)
			EndIf
			oReport:Section(1):Cell("NPRCVEN"	):Hide()
			oReport:Section(1):Cell("NQUANT1"	):Show()			
			oReport:Section(1):Cell("NTOTAL1"	):Show()
			oReport:Section(1):Cell("NVALIPI1"	):Show()
			
			If D2_TIPO <> "P" //Complemento de IPI
				nTotal1  += xMoeda(TRB->D2_TOTAL,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA) - nDevVal1
			EndIf
	
			If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
				nValIPI1 += xMoeda(TRB->D2_VALIMP1,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA) - nDevIpi				
			Else
				nValIPI1 += xMoeda(TRB->D2_VALIPI,1,mv_par08,TRB->D2_EMISSAO) - nDevIpi
			Endif
			
			If mv_par07 == 1				// Analitico
				If D2_TIPO <> "P" //Complemento de IPI
					nPrcVen1 := xMoeda(TRB->D2_PRCVEN,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA) 		
					nTotal1  := xMoeda(TRB->D2_TOTAL,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA)- nDevVal1
				Else
					nPrcVen1 := 0
					nTotal1  := 0
				EndIf
				
				If cPaisloc<>"BRA" // Localizado para imprimir o IVA 24/05/00
					nValIPI1 := xMoeda(TRB->D2_VALIMP1,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA) - nDevIpi 
				Else
					nValIPI1 := xMoeda(TRB->D2_VALIPI,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO) - nDevIpi 
				Endif
			EndIf
		EndIf
		
		If lValadi
			nValadi	+= xMoeda(TRB->D2_VALADI,TRB->D2_MOEDA,mv_par08,TRB->D2_EMISSAO,nDecs+1,TRB->D2_TXMOEDA)
		EndIf		
		
		If mv_par07 == 1		// Analitico
			oReport:Section(1):PrintLine()			
		EndIf			
		
		dbSelectArea("TRB")
		dbSkip()
		oReport:IncMeter()
		
	End	
	
	If mv_par07 == 1		// Analitico
		oReport:Section(1):SetTotalText(STR0051 + " " + AllTrim(RetTitle(cVaria)) + " " + &cCampo)		// "TOTAL"
		oReport:Section(1):Finish()
		oReport:Section(1):Init()
	Else
		oReport:Section(1):PrintLine()			
		oReport:ThinLine()
	EndIf	
		

	dbSelectArea("TRB")
End

oReport:Section(1):SetPageBreak()

#IFDEF TOP
	If mv_par04 # 3
		(cAliasSD1)->(dbCloseArea())
	EndIf
	(cAliasSF2)->(dbCloseArea())
	(cAliasSD2)->(dbCloseArea())
#ELSE
	dbSelectArea("SD1")
	dbClearFilter()
	dbSetOrder(1)
	dbSelectArea("SD2")
	dbClearFilter()
	dbSetOrder(1)
	dbSelectArea("SF2")
	dbClearFilter()
	dbSetOrder(1)
#ENDIF
TRB->(dbCloseArea())

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � CalcDevR4� Autor �     Marcos Simidu     � Data � 17.02.97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Calculo de Devolucoes                                      ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR660                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CalcDevR4(cDup,cEst)

dbSelectArea("SD1")
If dbSeek(xFilial()+TRB->D2_COD+TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM)

	//��������������������������Ŀ
	//� Soma Devolucoes          �
	//����������������������������
	If TRB->D2_CLIENTE+TRB->D2_LOJA == D1_FORNECE+D1_LOJA
		If !(D1_ORIGLAN == "LF")
			If AvalTes(D1_TES,cEst,cDup)
				If AvalTes(D1_TES,cEst) .And. (cEst == "S" .Or. cEst == "SN" )
					nDevQtd+= D1_QUANT
				Endif
				nDevVal +=xMoeda((D1_TOTAL-D1_VALDESC),TRB->D2_MOEDA,mv_par08,D1_DTDIGIT,nDecs+1,TRB->D2_TXMOEDA)
				If cPaisLoc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
					nDevipi += xMoeda(D1_VALIMP1,TRB->D2_MOEDA,mv_par08,D1_DTDIGIT,nDecs+1,TRB->D2_TXMOEDA)
				Else
					nDevipi += xMoeda(D1_VALIPI,1,mv_par08,D1_DTDIGIT)
				Endif
			Else
				If AvalTes(D1_TES,cEst) .And. (cEst == "S" .Or. cEst == "SN" )
					nDevQtd1+= D1_QUANT
				Endif
				nDevVal1 +=xMoeda((D1_TOTAL-D1_VALDESC),TRB->D2_MOEDA,mv_par08,D1_DTDIGIT,nDecs+1,TRB->D2_TXMOEDA)
			Endif
		Endif
	Endif
Endif
Return .T.


/*
�����������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    � MATR660R3� Autor � Wagner Xavier         � Data � 05.09.91  ���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Resumo de Vendas                                            ���
��������������������������������������������������������������������������Ĵ��
���Sintaxe e � MATR660(void)                                               ���
��������������������������������������������������������������������������Ĵ��
���Parametros� Verificar indexacao dentro de programa (provisoria)         ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                    ���
��������������������������������������������������������������������������Ĵ��
��� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                      ���
��������������������������������������������������������������������������Ĵ��
��� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                    ���
��������������������������������������������������������������������������Ĵ��
��� Paulo Augusto�24/05/00�Melhor� Alterado a impressao do IPI para Iva nas���
���              �        �      � Localizacoes                            ���
��� Marcello     �26/08/00�oooooo�Impressao de casas decimais de acordo    ���
���              �        �      �com a moeda selecionada.                 ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
Function Matr660R3()
//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
LOCAL CbTxt
LOCAL cString:= "SD2"
LOCAL CbCont,cabec1,cabec2,wnrel
LOCAL titulo := OemToAnsi(STR0001)	//"Resumo de Vendas"
LOCAL cDesc1 := OemToAnsi(STR0002)	//"Emissao do Relatorio de Resumo de Vendas, podendo o mesmo"
LOCAL cDesc2 := OemToAnsi(STR0003)	//"ser emitido por ordem de Tipo de Entrada/Saida, Grupo, Tipo"
LOCAL cDesc3 := OemToAnsi(STR0004)	//"de Material ou Conta Cont�bil."
LOCAL tamanho:= "M"
LOCAL limite := 132
LOCAL lImprime := .T.
cGrtxt := SPACE(11)
PRIVATE aReturn := { STR0005, 1,STR0006, 1, 2, 1, "",1 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog:="MATR660"
PRIVATE nLastKey := 0
PRIVATE cPerg   :="MTR660    "

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para Impressao do Cabecalho e Rodape    �
//����������������������������������������������������������������
cbtxt    := SPACE(10)
cbcont   := 00
li       := 80
m_pag    := 01
If cPaisloc == "MEX"
	tamanho:= "G"
EndIf
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
AjustaSX1()
pergunte("MTR660",.F.)
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01      A partir de                                    �
//� mv_par02      Ate a Data                                     �
//� mv_par03      Juros p/valor presente                         �
//� mv_par04      Considera Devolucao NF Orig/NF Devl/Nao Cons.  �
//� mv_par05      Tes Qto Estoque  Mov. X Nao Mov. X Ambas       �
//� mv_par06      Tes Qto Duplicata Gera X Nao Gera X Ambas      �
//� mv_par07      Tipo de Relatorio 1 Analitico 2 Sintetico      �
//� mv_par08      Qual Moeda                                     �
//� mv_par09      Vendedor de                                    �
//� mv_par10      Vendedor ate                                   �
//� mv_par11      Considera devolucao de compras                 �
//� mv_par12      Imprimir documento: original/devolucao         �
//����������������������������������������������������������������

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnrel:="MATR660"            //Nome Default do relatorio em Disco

aOrd :={STR0007,STR0008,STR0009,STR0010,STR0011,STR0036}		//"Por Tp/Saida+Produto"###"Por Tipo    "###"Por Grupo  "###"P/Ct.Contab."###"Por Produto " ### "Por Tp Saida + Serie + Nota "

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey==27
	dbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C660Imp(@lEnd,wnRel,cString)},Titulo)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � C660IMP  � Autor � Rosane Luciane Chene  � Data � 09.11.95 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relatorio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR660                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function C660Imp(lEnd,WnRel,cString)

LOCAL CbCont,cabec1,cabec2
LOCAL titulo := OemToAnsi(STR0001)	//"Resumo de Vendas"
LOCAL cDesc1 := OemToAnsi(STR0002)	//"Emissao do Relatorio de Resumo de Vendas, podendo o mesmo"
LOCAL cDesc2 := OemToAnsi(STR0003)	//"ser emitido por ordem de Tipo de Entrada/Saida, Grupo, Tipo"
LOCAL cDesc3 := OemToAnsi(STR0004)	//"de Material ou Conta Cont�bil."
LOCAL tamanho:= "M"
LOCAL limite := 132
LOCAL lImprime := .T.
LOCAL lContinua:=.T.
LOCAL nQuant1:=0,nValor1:=0,nValIpi:=0
LOCAL nTotQtd1:=0,nTotVal1:=0,nTotIpi:=0
LOCAL nQuant2:=0,nValor2:=0,nValIpi2:=0
LOCAL nTotQtd2:=0,nTotVal2:=0,nTotIpi2:=0,nIndex:=0
LOCAL lColGrup:=.T.
LOCAL lFirst:=.T.
Local cArqSD1,cKeySD1,cFilSD1,cFilSD2:=""
Local cEstoq := If( (MV_PAR05 == 1),"S",If( (MV_PAR05 == 2),"N","SN" ) )
Local cDupli := If( (MV_PAR06 == 1),"S",If( (MV_PAR06 == 2),"N","SN" ) )
Local cArqTrab, cIndTrab
Local aCampos := {}, aTam := {}
Local nVend:= fa440CntVen()
Local lVend:= .F.
Local cVend:= "1"
Local cVendedor := ""
Local nCntFor := 1
Local cIndice := ""
Local nImpInc:=0
Local nY:=0
Local cCampImp := ""
Local aImpostos:={}
Local aColuna  := Iif(cPaisloc <> "MEX",{18,19,31,44,61,74,131,18,74,76,88,101,119,131,42,99},{27,28,40,53,70,83,140,27,83,85,97,111,128,140,51,109})
Local lValadi  := cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico 
PRIVATE nDevQtd1:=0,nDevVal1:=0,nDevIPI :=0
PRIVATE nDevQtd2:=0,nDevVal2:=0

Private nDecs:=msdecimais(mv_par08)

nOrdem := aReturn[8]

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para Impressao do Cabecalho e Rodape    �
//����������������������������������������������������������������
cbtxt    := SPACE(10)
cbcont   := 00
li       := 80
m_pag    := 01
If cPaisloc == "MEX"
	tamanho:= "G"
EndIf

IF nOrdem = 1 .Or. nOrdem = 6 	// Tes
	cVaria := "D2_TES"
	If mv_par07 == 1			// Analitico
		cDescr1 := STR0012	//"    TIPO SAIDA   "
		cDescr2 := STR0013	//"NOTA FISCAL/SERIE"
	Else							// Sintetico
		cDescr1 := STR0014	//"      ORDEM      "
		cDescr2 := STR0015	//"    TIPO SAIDA   "
	EndIf
ElseIF nOrdem = 2	  			// Por Tipo
	cVaria := "D2_TP"
	If mv_par07 == 1        // Analitico
		cDescr1 := STR0016	//"   TIPO PRODUTO  "
		cDescr2 := STR0013	//"NOTA FISCAL/SERIE"
	Else							// Sintetico
		cDescr1 := STR0014	//"      ORDEM      "
		cDescr2 := STR0017	//"   TIPO PRODUTO  "
	EndIf
ElseIF nOrdem = 3				// Por Grupo
	cVaria := "D2_GRUPO"
	If mv_par07 == 1        // Analitico
		cDescr1 := STR0018	//"    G R U P O    "
		cDescr2 := STR0013	//"NOTA FISCAL/SERIE"
	Else                    // Analitico
		cDescr1 := STR0014	//"      ORDEM      "
		cDescr2 := STR0018	//"    G R U P O    "
	EndIf
ElseIF nOrdem = 4				// Por Conta Contabil
	cVaria := "D2_CONTA"
	If mv_par07 == 1        // Analitico
		cDescr1 := STR0019	//"    C O N T A    "
		cDescr2 := STR0013	//"NOTA FISCAL/SERIE"
	Else							// Sintetico
		cDescr1 := STR0014	//"      ORDEM      "
		cDescr2 := STR0019	//"    C O N T A    "
	EndIf
Else
	cVaria := "D2_COD"		// Ordem por produto
	If mv_par07 == 1        // Analitico
		cDescr1 := STR0020	//"  P R O D U T O  "
		cDescr2 := STR0013	//"NOTA FISCAL/SERIE"
	Else							// Sintetico
		cDescr1 := STR0014	//"      ORDEM      "
		cDescr2 := STR0020	//"  P R O D U T O  "
	EndIf
EndIF

If mv_par04 # 3
	dbSelectArea( "SD1" )
	cArqSD1 := CriaTrab( NIL,.F. )
	cKeySD1 := "D1_FILIAL+D1_COD+D1_SERIORI+D1_NFORI+D1_ITEMORI"
	cFilSD1 := 'D1_FILIAL=="'+xFilial("SD1")+'".And.D1_TIPO=="D"'
	cFilSD1 += ".And. D1_COD>='"+MV_PAR13+"'.And. D1_COD<='"+MV_PAR14+"'"
	cFilSD1 += '.And. !('+IsRemito(2,'D1_TIPODOC')+')'			
	If (MV_PAR04 == 2)
		cFilSD1 +=".And.DTOS(D1_DTDIGIT)>='"+DTOS(MV_PAR01)+"'.And.DTOS(D1_DTDIGIT)<='"+DTOS(MV_PAR02)+"'"
	EndIf	
	IndRegua("SD1",cArqSD1,cKeySD1,,cFilSD1,STR0021)		//"Selecionando Registros..."
	nIndex := RetIndex("SD1")
	#IFNDEF TOP
		dbSetIndex(cArqSD1+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
	SetRegua(RecCount())
	dbGotop()	
Endif

//������������������������������������������������������������������������Ŀ
//� Seleciona Indice da Nota Fiscal de Saida                               �
//��������������������������������������������������������������������������
dbSelectArea("SF2")
dbSetOrder(1)

dbSelectArea("SD2")
aTam := TamSx3("D2_FILIAL")
Aadd(aCampos,{"D2_FILIAL","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_COD")
Aadd(aCampos,{"D2_COD","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_LOCAL")
Aadd(aCampos,{"D2_LOCAL","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_SERIE")
Aadd(aCampos,{"D2_SERIE","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_TES")
Aadd(aCampos,{"D2_TES","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_TP")
Aadd(aCampos,{"D2_TP","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_GRUPO")
Aadd(aCampos,{"D2_GRUPO","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_CONTA")
Aadd(aCampos,{"D2_CONTA","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_EMISSAO")
Aadd(aCampos,{"D2_EMISSAO","D",aTam[1],aTam[2]})
aTam := TamSx3("D2_TIPO")
Aadd(aCampos,{"D2_TIPO","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_DOC")
Aadd(aCampos,{"D2_DOC","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_QUANT")
Aadd(aCampos,{"D2_QUANT","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_TOTAL")
Aadd(aCampos,{"D2_TOTAL","N",aTam[1],aTam[2]})

if cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
	aTam := TamSx3("D2_VALIMP1")
	Aadd(aCampos,{"D2_VALIMP1","N",aTam[1],aTam[2]})
else
	aTam := TamSx3("D2_VALIPI")
	Aadd(aCampos,{"D2_VALIPI","N",aTam[1],aTam[2]})
endif

aTam := TamSx3("D2_PRCVEN")
Aadd(aCampos,{"D2_PRCVEN","N",aTam[1],aTam[2]})
aTam := TamSx3("D2_ITEM")
Aadd(aCampos,{"D2_ITEM","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_CLIENTE")
Aadd(aCampos,{"D2_CLIENTE","C",aTam[1],aTam[2]})
aTam := TamSx3("D2_LOJA")
Aadd(aCampos,{"D2_LOJA","C",aTam[1],aTam[2]})

//Campos para guardar a moeda/taxa da nota para a conversao durante a impressao
aTam := TamSx3("F2_MOEDA")
Aadd(aCampos,{"D2_MOEDA","N",aTam[1],aTam[2]})
aTam := TamSx3("F2_TXMOEDA")
Aadd(aCampos,{"D2_TXMOEDA","N",aTam[1],aTam[2]})

cArqTrab := CriaTrab(aCampos)
Use &cArqTrab Alias TRB New Exclusive

DbSelectArea("SD2")
If !Empty(DbFilter())
	cFilSD2 :="("+DbFilter()+").And."
EndIf
cFilSD2 += "D2_FILIAL == '"+xFilial("SD2")+"'.And."
cFilSD2 += "DTOS(D2_EMISSAO) >='"+DTOS(mv_par01)+"'.And.DTOS(D2_EMISSAO)<='"+DTOS(mv_par02)+"'"
cFilSD2 += ".And. D2_COD>='"+MV_PAR13+"'.And. D2_COD<='"+MV_PAR14+"'"
cFilSD2 += '.And. !('+IsRemito(2,'D2_TIPODOC')+')'		
cFilSD2 += ".And.!(D2_ORIGLAN$'LF')"
If mv_par04==3 .Or. mv_par11 == 2
	cFilSD2 += ".And.!(D2_TIPO$'BDI')"
Else
	cFilSD2 += ".And.!(D2_TIPO$'BI')"
EndIf		

//��������������������������������������������������������������Ŀ
//� Verifica se ha necessidade de Indexacao no SD2               �
//����������������������������������������������������������������
cIndice := CriaTrab("",.F.)
If nOrdem = 1 .Or. nOrdem = 6	// Por Tes
	IndRegua("SD2",cIndice,"D2_FILIAL+D2_TES+"+IIf(nOrdem==1,"D2_COD","D2_SERIE+D2_DOC"),,cFilSD2,STR0021)	//"Selecionando Registros..."
	cIndTrab := SubStr(cIndice,1,7)+"A"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_TES+"+IIf(nOrdem==1,"D2_COD","D2_SERIE+D2_DOC"),,,STR0021)   //"Selecionando Registros..."
ElseIF nOrdem = 2			// Por Tipo
	dbSetOrder(2)
	cIndTrab := SubStr(cIndice,1,7)+"A"
	IndRegua("TRB",cIndTrab,SD2->(IndexKey()),,,STR0021)   //"Selecionando Registros..."
ElseIF nOrdem = 3			// Por Grupo
	IndRegua("SD2",cIndice,"D2_FILIAL+D2_GRUPO+D2_COD",,cFilSD2,STR0021)	//"Selecionando Registros..."
	cIndTrab := SubStr(cIndice,1,7)+"A"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_GRUPO+D2_COD",,,STR0021) //"Selecionando Registros..."
ElseIF nOrdem = 4			// Por Conta Contabil
	IndRegua("SD2",cIndice,"D2_FILIAL+D2_CONTA+D2_COD",,cFilSD2,STR0021)	//"Selecionando Registros..."
	cIndTrab := SubStr(cIndice,1,7)+"A"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_CONTA+D2_COD",,,STR0021) //"Selecionando Registros..."
Else							// Por Produto
	IndRegua("SD2",cIndice,"D2_FILIAL+D2_COD+D2_LOCAL+D2_SERIE+D2_DOC",,cFilSD2,STR0021)		//"Selecionando Registros..."
	cIndTrab := SubStr(cIndice,1,7)+"A"
	IndRegua("TRB",cIndTrab,"D2_FILIAL+D2_COD+D2_LOCAL+D2_SERIE+D2_DOC",,,STR0021)      //"Selecionando Registros..."
EndIF
nIndex := RetIndex("SD2")
If nOrdem <> 2
	#IFNDEF TOP
		dbSetIndex(cIndice+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
EndIf
SetRegua(RecCount())
dbGoTop()

While !Eof() .And. D2_FILIAL == xFilial("SD2")
		
		IF nOrdem = 2 .and. !(&cFILSD2)
			dbSkip()
			Loop
		EndIf

		//��������������������������������������������������������������Ŀ
		//� Verifica vendedor no SF2                                     �
		//����������������������������������������������������������������
		dbselectarea("SF2")
		dbSeek(xFilial()+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)

		For nCntFor := 1 To nVend
			cVendedor := SF2->(FieldGet(SF2->(FieldPos("F2_VEND"+cVend))))
			If cVendedor >= mv_par09 .and. cVendedor <= mv_par10
				lVend := .T.
				Exit
			EndIf
			cVend := Soma1(cVend,1)
		Next nCntFor
		cVend := "1"
		
		If lVend
			Reclock("TRB",.T.)
			Replace TRB->D2_FILIAL  With SD2->D2_FILIAL
			Replace TRB->D2_COD     With SD2->D2_COD
			Replace TRB->D2_LOCAL   With SD2->D2_LOCAL
			Replace TRB->D2_SERIE   With SD2->D2_SERIE
			Replace TRB->D2_TES     With SD2->D2_TES
			Replace TRB->D2_TP      With SD2->D2_TP
			Replace TRB->D2_GRUPO   With SD2->D2_GRUPO
			Replace TRB->D2_CONTA   With SD2->D2_CONTA
			Replace TRB->D2_EMISSAO With SD2->D2_EMISSAO
			Replace TRB->D2_TIPO    With SD2->D2_TIPO
			Replace TRB->D2_DOC     With SD2->D2_DOC
			Replace TRB->D2_QUANT   With SD2->D2_QUANT
			

			if cPaisloc<>"BRA" // Localizado para imprimir o IVA 24/05/00
			    Replace TRB->D2_PRCVEN  With SD2->D2_PRCVEN
                Replace TRB->D2_TOTAL   With SD2->D2_TOTAL-Iif(lValadi,SD2->D2_VALADI,0)

				aImpostos:=TesImpInf(SD2->D2_TES)
	
				For nY:=1 to Len(aImpostos)
					cCampImp:="SD2->"+(aImpostos[nY][2])
					If ( aImpostos[nY][3]=="1" )
						nImpInc     += &cCampImp
					EndIf
				Next
	
				Replace TRB->D2_VALImP1  With nImpInc
				nImpInc:=0
			else
			    If D2_TIPO <> "P" //Complemento de IPI
			       Replace TRB->D2_PRCVEN  With SD2->D2_PRCVEN
			       Replace TRB->D2_TOTAL   With SD2->D2_TOTAL
                Endif
				Replace TRB->D2_VALIPI  With SD2->D2_VALIPI
			endif
			
			Replace TRB->D2_ITEM    With SD2->D2_ITEM
			Replace TRB->D2_CLIENTE With SD2->D2_CLIENTE
			Replace TRB->D2_LOJA    With SD2->D2_LOJA
			
			//--------- Grava a moeda/taxa da nota para a conversao durante a impressao
			Replace TRB->D2_MOEDA   With SF2->F2_MOEDA
			Replace TRB->D2_TXMOEDA With SF2->F2_TXMOEDA
			
			MsUnlock()
			lVend := .F.
		EndIf
	dbSelectArea("SD2")
	dbSkip()
EndDo

If mv_par04 == 2
	// elimina filtro para pesquisar nota original (SD2) a partir da devolucao de venda (SD1)
	dbSelectArea("SD2")
	RetIndex("SD2")
	dbClearFilter()    
	
	// Busca filtro do usuario      
	cFilSD2 :=""
	If !Empty(DbFilter())
		cFilSD2 :="("+DbFilter()+")"
	EndIf
	SF1->(dbsetorder(1))
	dbSelectArea("SD1")
	dbGoTop()
	While !Eof() .And. D1_FILIAL == xFilial("SD1")

			// Verifica filtro do usuario no SD2
			If !Empty(cFilSD2)			
				dbSelectArea("SD2")
				dbSetOrder(3)
				If dbseek(xFilial("SD2")+SD1->D1_NFORI+SD1->D1_SERIORI+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_COD+SD1->D1_ITEMORI)
					If !(&cFILSD2)
						dbSelectArea("SD1")
		   				dbSkip()
						Loop
					EndIf	
				EndIf	
			EndIf			

			//��������������������������������������������������������������Ŀ
			//� Verifica nota fiscal de origem e vendedor no SF2             �
			//����������������������������������������������������������������
		    dbselectarea("SF2")
            If cPaisLoc == "BRA"
            	dbSeek(xFilial()+SD1->D1_NFORI+SD1->D1_SERIORI)
		    Else
		    	dbSeek(xFilial()+SD1->D1_NFORI+SD1->D1_SERIORI+SD1->D1_FORNECE+SD1->D1_LOJA)
			EndIf
			
            //Somente busca o vendedor, se realmente foi encontrado a nota fiscal de origem
			If SF2->(Found())
				For nCntFor := 1 To nVend
					cVendedor := SF2->(FieldGet(SF2->(FieldPos("F2_VEND"+cVend))))
					If cVendedor >= mv_par09 .and. cVendedor <= mv_par10
						lVend := .T.
						Exit
					EndIf
					cVend := Soma1(cVend,1)
				Next nCntFor
				cVend := "1"
			EndIf

	        dbSelectArea("SD1")

			If lVend
				SF1->(dbseek(SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA))
				Reclock("TRB",.T.)
				Replace TRB->D2_FILIAL  With SD1->D1_FILIAL
				Replace TRB->D2_COD     With SD1->D1_COD
				Replace TRB->D2_LOCAL   With SD1->D1_LOCAL
				Replace TRB->D2_SERIE   With If(mv_par12==1,SD1->D1_SERIORI,SD1->D1_SERIE)
				Replace TRB->D2_TES     With SD1->D1_TES
				Replace TRB->D2_TP      With SD1->D1_TP
				Replace TRB->D2_GRUPO   With SD1->D1_GRUPO
				Replace TRB->D2_CONTA   With SD1->D1_CONTA
				Replace TRB->D2_EMISSAO With SD1->D1_DTDIGIT
				Replace TRB->D2_TIPO    With SD1->D1_TIPO
				Replace TRB->D2_DOC     With If(mv_par12==1,SD1->D1_NFORI,SD1->D1_DOC)
				Replace TRB->D2_QUANT   With -SD1->D1_QUANT
				Replace TRB->D2_TOTAL   With -(SD1->D1_TOTAL-SD1->D1_VALDESC)
				
				If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
					Replace TRB->D2_VALIMP1 With - SD1->D1_VALIMP1
				Else
					Replace TRB->D2_VALIPI With -SD1->D1_VALIPI
				Endif
				
				Replace TRB->D2_PRCVEN  With SD1->D1_VUNIT
				Replace TRB->D2_ITEM With SD1->D1_ITEM
				Replace TRB->D2_CLIENTE With SD1->D1_FORNECE
				Replace TRB->D2_LOJA With SD1->D1_LOJA
				
				//--------- Grava a moeda/taxa da nota para a conversao durante a impressao
				Replace TRB->D2_MOEDA   With SF1->F1_MOEDA
				Replace TRB->D2_TXMOEDA With SF1->F1_TXMOEDA
				
				MsUnlock()
				lVend := .F.
			EndIf
		dbSelectArea("SD1")
		dbSkip()
	EndDo
EndIf
//��������������������������������������������������������������Ŀ
//� Definicao de Titulos e Cabecalhos de acordo com a opcao      �
//����������������������������������������������������������������
nTipo  := IIF(aReturn[4]==1,GetMV("MV_COMP"),GetMV("MV_NORM"))

titulo := STR0001 + " - " + GetMv("MV_MOEDA" + STR(mv_par08,1))
If cPaisLoc == "BRA"
	cabec1 := " " + cDescr1 + "|" + STR0022		//"                 F A T U R A M E N T O                    |            O U T R O S   V A L O R E S          |"
	cabec2 := " " + cDescr2 + "|" + STR0023		//"  QUANT.     VAL.  UNIT.    VAL.  MERCAD.       VALOR IPI |    QUANTIDADE   VALOR UNITARIO VALOR MERCADORIA |"
Else
	If cPaisLoc <> "MEX"
		cabec1 := " " + cDescr1 + "|" + STR0037		//"                 F A T U R A M E N T O                    |            O U T R O S   V A L O R E S          |"
		cabec2 := " " + cDescr2 + "|" + STR0038		//"  QUANT.     VAL.  UNIT.    VAL.  MERCAD.       VALOR IMP |    QUANTIDADE   VALOR UNITARIO VALOR MERCADORIA |"		
	Else 
		cabec1 := " " + cDescr1 + "         |" + STR0037		//"                 F A T U R A M E N T O                    |            O U T R O S   V A L O R E S          |"
		cabec2 := " " + cDescr2 + "         |" + STR0038		//"  QUANT.     VAL.  UNIT.    VAL.  MERCAD.       VALOR IMP |    QUANTIDADE   VALOR UNITARIO VALOR MERCADORIA |"
	EndIf
EndIf
dbSelectArea("TRB")
dbGoTop()

SetRegua(RecCount())		// Total de Elementos da regua

While !Eof() .And. lImprime
	
	IncRegua()
	
	IF lEnd
		@PROW()+1,001 PSay STR0024	//"CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	IF nOrdem = 1 .Or. nOrdem = 6		// Por Tes
		cTesalfa := D2_TES
		dbSelectArea("SF4")
		dbSeek(xFilial()+TRB->D2_TES)
		If mv_par07 == 1 					// Analitico
			cCfText := F4_TEXTO
		Else									// Sintetico
			cCfText := Subs(F4_TEXTO,1,13)
		EndIf
		dbSelectArea("TRB")
		cTesa := cTesalfa
		cCampo:= "cTesa"
	Elseif nOrdem = 2						// Por Tipo
		cTpProd := D2_TP
		cCampo  := "cTpProd"
	Elseif nOrdem = 3						// Por Grupo
		cSubtot := SubStr(D2_GRUPO,1,4)
		cTotal  := SubStr(D2_GRUPO,1,1)
		cGrupo  := D2_GRUPO
		cCampo  := "cGrupo"
		dbSelectArea("SBM")
		dbSeek(xFilial()+TRB->D2_GRUPO)
		If mv_par07 == 1  						// Analitico
			IF Found()
				cGrTxt := Substr(Trim(SBM->BM_DESC),1,16)
			Else
				cGrTxt := SPACE(11)
			Endif
		Else											// Sintetico
			IF Found()
				cGrTxt := Trim(SBM->BM_DESC)
			Else
				cGrTxt := SPACE(11)
			Endif
		EndIf
		dbSelectArea("TRB")
	Elseif nOrdem = 4								// Por Conta Contabil
		cSubtot := SubStr(D2_CONTA,1,4)
		cTotal  := SubStr(D2_CONTA,1,1)
		cConta  := D2_CONTA
		dbSelectArea("SI1")
		dbSetOrder(1)
		dbSeek(xFilial()+TRB->D2_CONTA)
		cCampo  := "cConta"
	Else
		cCodPro := D2_COD
		cCampo  := "cCodPro"
	Endif
	
	nQuant1:=0;nValor1:=0;nValIpi:=0
	nQuant2:=0;nValor2:=0;nValIpi2:=0
	lFirst:=.T.
	
	dbSelectArea("TRB")
	
	While &cCampo = &cVaria .And. !Eof() .And. lImprime
		
		IF lEnd
			@PROW()+1,001 PSay STR0024	//"CANCELADO PELO OPERADOR"
			lImprime := .F.
			Exit
		Endif
		
		IncRegua()
		
		If li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif
		
		//�����������������������������Ŀ
		//� Trato a Devolu��o de Vendas �
		//�������������������������������
		nDevQtd1:=0;nDevVal1:=0;nDevIPI:=0
		nDevQtd2:=0;nDevVal2:=0;
		
		If mv_par04 == 1  //Devolucao pela NF Original
			CalcDev(cDupli,cEstoq)
		EndIf
		
		dbSelectArea("TRB")
		
		nQuant1 -=nDevQtd1
		nQuant2 -=nDevQtd2
		If mv_par07 == 1 .And. lFirst    // Analitico
			lFirst:=.F.
			If nOrdem = 1 .Or. nOrdem = 6		// Por Tes
				@ li,000 PSay STR0025	//"TES: "
				@ li,005 PSay cTesa
				@ li,008 PSay "-"
				@ li,009 PSay AllTrim(cCftext)
			Elseif nOrdem = 3	 				// Por Grupo
				@ li,000 PSay STR0026	//"GRUPO: "
				@ li,007 PSay cGrupo
				@ li,012 PSay "-"
				@ li,013 PSay Substr(cGrTxt,1,12)
			ElseIf nOrdem = 4					// Por Conta Contabil
				@ li,000 PSay STR0027	//"CONTA: "
				@ li,008 PSay TRIM(cConta)
				@ li,030 PSay AllTrim(SI1->I1_DESC)
			Elseif nOrdem = 2					// Por Tipo de Produto
				@ li,000 PSay STR0028	//"TIPO DE PRODUTO: "
				@ li,017 PSay cTpprod
			Else					 			// Por Produto
				@ li,000 PSay STR0029	//"PRODUTO: "
				SB1->(dbSeek(xFilial("SB1")+cCodPro))
				@ li,011 PSay Trim(cCodPro) + " " + SB1->B1_DESC
			EndIf
		Endif
		
		If AvalTes(D2_TES,cEstoq,cDupli)
			lColGrup:=.T.
			If mv_par07 == 1				// Analitico
				li++
				@ li,000 PSay D2_DOC+" / "+D2_SERIE
				@ li,aColuna[1] PSay "|"
				@ li,aColuna[2] PSay (D2_QUANT - nDevQtd1)	Picture PesqPictQt("D2_QUANT",11)
			EndIf
			
			nQuant1  += D2_QUANT
			
			nValor1  += xMoeda(D2_TOTAL ,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA)- nDevVal1
			
			If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
				nValIPI  += xMoeda(D2_VALImp1,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA)  - nDevIpi
			Else
				nValIPI  += xMoeda(D2_VALIPI ,1,mv_par08,D2_EMISSAO) -  nDevIpi
			Endif
			
			If mv_par07 == 1				// Analitico

				@ li,aColuna[3] PSay xMoeda(D2_PRCVEN,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA) 		Picture PesqPict("SD2","D2_TOTAL",12,mv_par08)
				@ li,aColuna[4] PSay xMoeda(D2_TOTAL ,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA)  - nDevVal1 Picture PesqPict("SD2","D2_TOTAL",16,mv_par08)
	
				If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
					@ li,aColuna[5] PSay xMoeda(D2_VALIMP1 ,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA) - nDevIpi      PicTure PesqPict("SD2","D2_VALIMP1",12,mv_par08)
				Else
					@ li,aColuna[5] PSay xMoeda(D2_VALIPI,1,mv_par08,D2_EMISSAO)- nDevIpi 	PicTure PesqPict("SD2","D2_VALIPI",11)
				Endif
				
				@ li,aColuna[6] PSay "|"
				@ li,aColuna[7] PSay "|"
			EndIf
		Else
			lColGrup:=.F.
			If mv_par07 == 1 				// Analitico
				li++
				@ li,000 PSay D2_DOC+" / "+D2_SERIE
				@ li,aColuna[8] PSay "|"
				@ li,aColuna[9] PSay "|"
				@ li,aColuna[10] PSay (D2_QUANT - nDevQtd2)	Picture PesqPictQt("D2_QUANT",11)
			EndIf
			
			nQuant2  += D2_QUANT

			If D2_TIPO <> "P" //Complemento de IPI
				nValor2  += xMoeda(D2_TOTAL   ,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA) - nDevVal2
			EndIf
	
			If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
				nValIPI2 += xMoeda(D2_VALIMP1 ,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA) - nDevIpi
			Else
				nValIPI2 += xMoeda(D2_VALIPI,1,mv_par08,D2_EMISSAO) - nDevIpi
			Endif
			
			If mv_par07 == 1				// Analitico
				If D2_TIPO <> "P" //Complemento de IPI
					@ li,aColuna[11] PSay xMoeda(D2_PRCVEN,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA) 				Picture PesqPict("SD2","D2_TOTAL",12,mv_par08)
					@ li,aColuna[12] PSay xMoeda(D2_TOTAL ,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA)- nDevVal2 Picture PesqPict("SD2","D2_TOTAL",16,mv_par08)
				Else
					@ li,aColuna[3] PSay 0 Picture PesqPict("SD2","D2_TOTAL",12,mv_par08)
					@ li,aColuna[4] PSay 0 Picture PesqPict("SD2","D2_TOTAL",16,mv_par08)
				EndIf
				
				If cPaisloc<>"BRA" // Localizado para imprimir o IVA 24/05/00
					@ li,aColuna[13] PSay xMoeda(D2_VALIMP1,D2_MOEDA,mv_par08,D2_EMISSAO,nDecs+1,D2_TXMOEDA) - nDevIpi Picture PesqPict("SD2","D2_VALIMP1",12,mv_par08)
				Else
					@ li,aColuna[13] PSay xMoeda(D2_VALIPI ,D2_MOEDA,mv_par08,D2_EMISSAO) - nDevIpi 	Picture PesqPict("SD2","D2_VALIPI",11,mv_par08)
				Endif
				
				@ li,aColuna[14] PSay "|"
			EndIf
		EndIf
		dbSkip()
		If li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif
	End
	dbSelectArea("TRB")
	IF li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif
	
	If nQuant1 # 0 .Or. nQuant2 # 0 .Or. nValor1 # 0 .Or. nValor2 # 0 .Or. &cCampo <> &cVaria
		If !lFirst
			li++
		EndIf
		
		IF nOrdem = 1.Or. nOrdem = 6		// TES
			If mv_par07 == 1 				// ANALITICO
				@ li,000 PSay STR0030	//"TOTAL DA TES --->"
			Else								//SINTETICO
				@ li,000 PSay cTesa
				@ li,003 PSay "-"
				@ li,004 PSay AllTrim(cCftext)
			EndIf
		Elseif nOrdem = 3				  	// GRUPO
			If mv_par07 == 1				// ANALITICO
				@ li,000 PSay STR0031	//"TOTAL DO GRUPO ->"
			Else								//SINTETICO
				@ li,000 PSay cGrupo
				@ li,005 PSay "-"
				If nOrdem = 3				// GRUPO
					@ li,006 PSay Substr(cGrTxt,1,12)
				Endif
			EndIf
		ElseIf nOrdem = 4		 			// Por Conta Contabil
			If mv_par07 == 1           // Analitico
				@ li,000 PSay STR0032	//"TOTAL DA CONTA ->"
			Else								// Sintetico
				@ li,000 PSay cConta
			EndIf
		Elseif nOrdem = 2
			If mv_par07 == 1           // Analitico
				@ li,000 PSay STR0033	//"TOTAL DO TIPO -->"
			Else								// Sintetico
				@ li,009 PSay cTpprod
			EndIf
		Else
			If mv_par07 == 1           // Analitico
				@ li,000 PSay STR0034	//"TOTAL DO PRODUTO -->"
			Else								// Sintetico
				@ li,000 PSay cCodPro
			EndIf
		Endif
		If mv_par07 == 2 					// Sintetico
			@li,aColuna[1] PSay "|"
		EndIf
		If nOrdem = 1						// Por Tes
			If lColGrup
				If nQuant1 # 0
					@ li,aColuna[2] PSay nQuant1		Picture PesqPictQt("D2_QUANT",11)
				EndIf

				@ li,aColuna[15] PSay nValor1                   Picture PesqPict("SD2","D2_TOTAL",18,mv_par08)
				
				If cPaisLoc<>"BRA" // Localizado para imprimir o IVA 24/05/00
					@ li,aColuna[5] PSay nValIpi         PicTure PesqPict("SD2","D2_VALIMP1",12,mv_par08)
				Else
					@ li,aColuna[5] PSay nValIpi			PicTure PesqPict("SD2","D2_VALIPI",11)
				Endif
				@ li,aColuna[6] PSay "|"
			Else
				@ li,aColuna[6] PSay "|"
				If nQuant2 # 0
					@ li,aColuna[10] PSay nQuant2		Picture PesqPictQt("D2_QUANT",11)
				EndIf
				@ li,aColuna[16] PSay nValor2                   Picture PesqPict("SD2","D2_TOTAL",18,mv_par08)
				
				If cPaisloc<>"BRA" // Localizado para imprimir o IVA 24/05/00
					@ li,aColuna[13] PSay nValIpi2        PicTure PesqPict("SD2","D2_VALIMP1",12,mv_par08)
				Else
					@ li,aColuna[13] PSay nValIpi2     	PicTure PesqPict("SD2","D2_VALIPI",11)
				Endif
				
			EndIf
		Else
			If nQuant1 # 0
				@ li,aColuna[2] PSay nQuant1		Picture PesqPictQt("D2_QUANT",11)
			EndIf
			@ li,aColuna[15] PSay nValor1         Picture PesqPict("SD2","D2_TOTAL",18,mv_par08)
			
			If cPaisLoc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
				@ li,aColuna[5] PSay nValIpi      PicTure PesqPict("SD2","D2_VALIMP1",12,mv_par08)
			Else
				@ li,aColuna[5] PSay nValIpi		PicTure PesqPict("SD2","D2_VALIPI",11)
			Endif
			
			@ li,aColuna[6] PSay "|"
			If nQuant2 # 0
				@ li,aColuna[10] PSay nQuant2		Picture PesqPictQt("D2_QUANT",11)
			EndIf
			@ li,aColuna[16] PSay nValor2         Picture PesqPict("SD2","D2_TOTAL",18,mv_par08)
			
			If cpaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
				@ li,aColuna[13] PSay nValIpi2   	PicTure PesqPict("SD2","D2_VALIMP1",12,mv_par08)
			Else
				@ li,aColuna[13] PSay nValIpi2  	PicTure PesqPict("SD2","D2_VALIPI",11)
			Endif
			
		EndIf
		@ li,aColuna[14] PSay "|"
		li++
		@ li,000 PSay __PrtFatLine()
		li++
		nTotQtd1  += nQuant1
		nTotVal1  += nValor1
		nTotIpi   += nValIpi
		nTotQtd2  += nQuant2
		nTotVal2  += nValor2
		nTotIpi2  += nValIpi2
		
	Endif
	dbSelectArea("TRB")
End

If li != 80
	li++
	@ li,000 PSay STR0035 	//"T O T A L  -->"
	@ li,aColuna[1] PSay "|"
	@ li,aColuna[2] PSay nTotQtd1 Picture PesqPictQt("D2_QUANT",11)
	
	If cPaisloc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
		@ li,aColuna[15] PSay nTotVal1 Picture PesqPict("SD2","D2_TOTAL",18,mv_par08)
		@ li,aColuna[5] PSay nTotIpi  Picture PesqPict("SD2","D2_VALIMP1",12,mv_par08)
	Else
		@ li,aColuna[15] PSay nTotVal1 Picture PesqPict("SD2","D2_TOTAL",18)
		@ li,aColuna[5] PSay nTotIpi  Picture PesqPict("SD2","D2_VALIPI",12)
	Endif
	
	@ li,aColuna[9] PSay "|"
	@ li,aColuna[10] PSay nTotQtd2 Picture PesqPictQt("D2_QUANT",11)
	@ li,aColuna[16]  PSay nTotVal2 Picture PesqPict("SD2","D2_TOTAL",18,mv_par08)
	
	If cPaisLoc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
		@ li,aColuna[13] PSay nTotIpi2 Picture PesqPict("SD2","D2_VALIMP1",12,mv_par08)
	Else
		@ li,aColuna[13] PSay nTotIpi2 Picture PesqPict("SD2","D2_VALIPI",11)
	Endif
	
	@ li,aColuna[14] PSay "|"
	li++
	@ li,00 PSay __PrtFatLine()
	
	roda(cbcont,cbtxt,tamanho)
EndIF


IF nOrdem != 2	// Nao for por tipo
	RetIndex("SD2")
	dbClearFilter()
	IF File(cIndice+OrdBagExt())
		Ferase(cIndice+OrdBagExt())
	Endif
Endif

If mv_par04 <> 3
	dbSelectArea( "SD1" )
	RetIndex("SD1")
	dbClearFilter()
	IF File(cArqSD1+OrdBagExt())
		Ferase(cArqSD1+OrdBagExt())
	Endif
	dbSetOrder(1)
Endif

dbSelectArea("TRB")
cExt := OrdBagExt()
dbCloseArea()
If File(cArqTrab+GetDBExtension())
	FErase(cArqTrab+GetDBExtension())    //arquivo de trabalho
Endif
If File(cIndTrab + cExt)
	FErase(cIndTrab+cExt)	 //indice gerado
Endif

dbSelectArea("SD1")
dbClearFilter()
dbSetOrder(1)
dbSelectArea("SD2")
dbClearFilter()
dbSetOrder(1)

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � CalcDev  � Autor �     Marcos Simidu     � Data � 17.02.97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Calculo de Devolucoes                                      ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR660                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CalcDev(cDup,cEst)

dbSelectArea("SD1")
If dbSeek(xFilial()+TRB->D2_COD+TRB->D2_SERIE+TRB->D2_DOC+TRB->D2_ITEM)
	//��������������������������Ŀ
	//� Soma Devolucoes          �
	//����������������������������
	If TRB->D2_CLIENTE+TRB->D2_LOJA == D1_FORNECE+D1_LOJA
		If !(D1_ORIGLAN == "LF")
			If AvalTes(D1_TES,cEst,cDup)
				If AvalTes(D1_TES,cEst) .And. (cEst == "S" .Or. cEst == "SN" )
					nDevQtd1+= D1_QUANT
				Endif
				nDevVal1 +=xMoeda((D1_TOTAL-D1_VALDESC),TRB->D2_MOEDA,mv_par08,D1_DTDIGIT,nDecs+1,TRB->D2_TXMOEDA)
				If cPaisLoc<>"BRA"  // Localizado para imprimir o IVA 24/05/00
					nDevipi += xMoeda(D1_VALIMP1,TRB->D2_MOEDA,mv_par08,D1_DTDIGIT,nDecs+1,TRB->D2_TXMOEDA)
				Else
					nDevipi += xMoeda(D1_VALIPI,1,mv_par08,D1_DTDIGIT)
				Endif
				
			Else
				If AvalTes(D1_TES,cEst) .And. (cEst == "S" .Or. cEst == "SN" )
					nDevQtd2+= D1_QUANT
				Endif
				nDevVal2 +=xMoeda((D1_TOTAL-D1_VALDESC),TRB->D2_MOEDA,mv_par08,D1_DTDIGIT,nDecs+1,TRB->D2_TXMOEDA)
			Endif
		Endif
	Endif
Endif
Return .T.


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSX1 �Autor  �Leonardo Ruben      � Data �  06/07/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MATR660                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1()

aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}

Aadd( aHelpPor, "Informe se deve ser impresso o numero   " )
Aadd( aHelpPor, "da nota original (saida) ou o numero da " )
Aadd( aHelpPor, "nota de devolucao (entrada)             " )

Aadd( aHelpEng, "Enter whether the number of the         " )
Aadd( aHelpEng, "(outflow) original invoice must be      " )
Aadd( aHelpEng, "printed or the number of the (inflow)   " )
Aadd( aHelpEng, "invoice of return                       " )

Aadd( aHelpSpa, "Informe si debe ser impreso el numero   " )
Aadd( aHelpSpa, "de la factura original (salida) o el nu-" )
Aadd( aHelpSpa, "me de la factura de devolucion (entrada)" )

PutSx1( cPerg, "12","Imprime Documento      ?","�Imprime documento      ?","Print Document         ?","mv_chc","N",1,0,1,"C","","","","",;
	"mv_par12","Original","Original","Original","","Devolucao","Devolucion","Return","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
                                                            
aHelpPor :={}
aHelpEng :={}
aHelpSpa :={}
Aadd( aHelpPor, "Informar o codigo do produto inicial    " )
Aadd( aHelpPor, "para filtro.                            " )
Aadd( aHelpEng, "Enter the initial product code          " )
Aadd( aHelpEng, "for filter.                             " )
Aadd( aHelpSpa, "Informar el codigo del producto inicial " )
Aadd( aHelpSpa, "para filtro.                            " )

PutSx1(cPerg,"13","Produto De  ?","De Producto ?","From Product?","mv_chd","C",30,0,0,"G","","SB1","","S",;
	"mv_par13","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

aHelpPor :={} 
aHelpEng :={} 
aHelpSpa :={} 
Aadd( aHelpPor, "Informar o codigo do produto final para " )
Aadd( aHelpPor, "filtro.                                 " )
Aadd( aHelpEng, "Enter the final product code for        " )
Aadd( aHelpEng, "filter.                                 " )
Aadd( aHelpSpa, "Informar el codigo del producto final   " )
Aadd( aHelpSpa, "para filtro.                            " )

PutSx1(cPerg,"14","Produto Ate ?","A Producto  ?","To Product  ?","mv_che","C",30,0,0,"G","","SB1","","S",;
	"mv_par14","","","","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

If SX1->( dbSeek("MTR660    13")) .And. ( !("030" $ SX1->X1_GRPSXG) .OR. SX1->X1_TAMANHO <> TamSX3("B1_COD")[1] )
	RecLock('SX1',.F.)
	SX1->X1_GRPSXG := "030"
	SX1->X1_TAMANHO := TamSX3("B1_COD")[1]
	MsUnlock()
EndIf

If SX1->( dbSeek("MTR660    14")) .And. ( !("030" $ SX1->X1_GRPSXG) .OR. SX1->X1_TAMANHO <> TamSX3("B1_COD")[1] )
	RecLock('SX1',.F.)
	SX1->X1_GRPSXG := "030"
	SX1->X1_TAMANHO := TamSX3("B1_COD")[1]
	MsUnlock()
EndIf

Return Nil
