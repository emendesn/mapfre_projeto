#INCLUDE "Protheus.ch"
#INCLUDE "rwmake.ch"        
#INCLUDE "TRM040.CH"

/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Funcao       � TRM040   � Autor � Eduardo Ju            � Data � 09.06.06 ���
����������������������������������������������������������������������������Ĵ��
���Descricao    � Custo do Treinamento Anual                                 ���
����������������������������������������������������������������������������Ĵ��
���Uso          � TRM030                                                     ���
����������������������������������������������������������������������������Ĵ��
���Programador  � Data	 � BOPS �  Motivo da Alteracao 					     ���
����������������������������������������������������������������������������Ĵ��
���Eduardo Ju  	�13/07/07�124525�Implementacao do Log de Inconsistencias.    ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
User Function TRM040()

Local oReport
Local aArea := GetArea()
Private aValor 	:= Array(12)
Private aHoras 	:= Array(12)

If FindFunction("TRepInUse") .And. TRepInUse()	//Verifica se relatorio personalizal esta disponivel 
	TR040RSX1()	//Criacao do Pergunte (SX1)
	Pergunte("TR040R",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()	
Else
	U_TRM040R3()	
EndIf  

RestArea( aArea )

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ReportDef() � Autor � Eduardo Ju          � Data � 23.08.06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Definicao do Componente de Impressao do Relatorio           ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function ReportDef()

Local oReport
Local oSection1	
Local oSection2
Local oSection3	 
Local oBreakCC  
Local aOrdem    := {}
Local nTotal	:= 0 

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�������������������������������������������������������������������������� 
oReport:=TReport():New("TRM040",STR0001,"TR040R",{|oReport| PrintReport(oReport)},STR0002+" "+STR0003)	//"Custo de Treinamento Anual"#"Ser� impresso de acordo com os parametros solicitados pelo usuario"
oReport:SetTotalInLine(.F.) //Totaliza em linha 
oReport:SetLandscape()		//Imprimir Somente Paisagem
Pergunte("TR040R",.F.)  

Aadd( aOrdem, STR0004)	// "Curso"
Aadd( aOrdem, STR0005)	// "Centro de Custo"

//******************* Relatorio por Curso **********************
//��������������������������������������������Ŀ
//� Criacao da Primeira Secao: "Curso" - Valor �
//���������������������������������������������� 
oSection1 := TRSection():New(oReport,STR0035 + " -" + STR0011,{"RA4","RA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)	//"Custo por Curso - Valor"
oSection1 :SetTotalInLine(.F.)   
oSection1:SetHeaderBreak(.T.) 

TRCell():New(oSection1,"RA4_CURSO","RA4",CRLF + STR0004,,,,{|| cCurso })		//Codigo do Curso
TRCell():New(oSection1,"RA1_DESC","RA1","")									//Descricao do Curso  
TRCell():New(oSection1,"JANEIRO"	,"   ",	STR0020 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[1] })
TRCell():New(oSection1,"FEVEREIRO"	,"   ", STR0021 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[2] })
TRCell():New(oSection1,"MARCO"		,"   ", STR0022 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[3] })
TRCell():New(oSection1,"ABRIL"		,"   ", STR0023 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[4] })
TRCell():New(oSection1,"MAIO"		,"   ", STR0024 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[5] })
TRCell():New(oSection1,"JUNHO"		,"   ", STR0025 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[6] })
TRCell():New(oSection1,"JULHO"		,"   ", STR0026 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[7] })
TRCell():New(oSection1,"AGOSTO"		,"   ", STR0027 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[8] })
TRCell():New(oSection1,"SETEMBRO"	,"   ", STR0028 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[9] })
TRCell():New(oSection1,"OUTUBRO"	,"   ", STR0029 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[10]})
TRCell():New(oSection1,"NOVEMBRO"	,"   ", STR0030 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[11]})
TRCell():New(oSection1,"DEZEMBRO"	,"   ", STR0031 + CRLF + STR0033 ,"@R 9999,999.99",12,, {|| aValor[12]})
TRCell():New(oSection1,"TOTAL"		,"   ", STR0032 ,"@R 9999,999.99",12,, {|| nTotal:= 0, aEval(aValor,{ |X| nTotal += X }), nTotal})	 	

TRPosition():New(oSection1,"RA1",1,{|| RhFilial("RA1",RA4->RA4_FILIAL)+ cCurso })

//��������������������������������������������Ŀ
//� Criacao da Primeira Secao: "Curso" - Horas �
//���������������������������������������������� 
oSection2 := TRSection():New(oReport,STR0035 + " -" + STR0012,{"RA4","RA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)	//"Custo por Curso - Horas"
oSection2 :SetTotalInLine(.F.)   
oSection2:SetHeaderBreak(.T.)

TRCell():New(oSection2,"RA4_CURSO","RA4",CRLF + STR0004,,,,{|| cCurso })	//Codigo do Curso
TRCell():New(oSection2,"RA1_DESC","RA1","")									//Descricao do Curso  
TRCell():New(oSection2,"JANEIRO"	,"   ",	STR0020 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[1] })
TRCell():New(oSection2,"FEVEREIRO"	,"   ", STR0021 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[2] })
TRCell():New(oSection2,"MARCO"		,"   ", STR0022 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[3] })
TRCell():New(oSection2,"ABRIL"		,"   ", STR0023 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[4] })
TRCell():New(oSection2,"MAIO"		,"   ", STR0024 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[5] })
TRCell():New(oSection2,"JUNHO"		,"   ", STR0025 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[6] })
TRCell():New(oSection2,"JULHO"		,"   ", STR0026 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[7] })
TRCell():New(oSection2,"AGOSTO"		,"   ", STR0027 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[8] })
TRCell():New(oSection2,"SETEMBRO"	,"   ", STR0028 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[9] })
TRCell():New(oSection2,"OUTUBRO"	,"   ", STR0029 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[10]})
TRCell():New(oSection2,"NOVEMBRO"	,"   ", STR0030 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[11]})
TRCell():New(oSection2,"DEZEMBRO"	,"   ", STR0031 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[12]})
TRCell():New(oSection2,"TOTAL"		,"   ", STR0032,"@R 999,999",6,, {|| nTotal:= 0, aEval(aHoras,{ |X| nTotal += X }), nTotal})	 	
 
TRPosition():New(oSection2,"RA1",1,{|| RhFilial("RA1",RA4->RA4_FILIAL)+ cCurso })

//******************* Relatorio por CC **********************
//��������������������������������������Ŀ
//� Criacao da Terceira Secao: "C.Custo" �
//���������������������������������������� 
oSection3 := TRSection():New(oReport, STR0001 ,{"RA4","SRA"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)	//"Custo de Treinamento Anual"
oSection3 :SetTotalInLine(.F.)   
oSection3:SetHeaderBreak(.T.)  

TRCell():New(oSection3,"RA_CC","SRA",,,,,{|| TRA->TR_CC })	//Centro de Custo
TRCell():New(oSection3,"CTT_DESC01","CTT","")				//Descricao do Centro de Custo

TRPosition():New(oSection3,"SRA",1,{|| RhFilial("SRA",TRA->TR_FILIAL)+ TRA->TR_MAT })
TRPosition():New(oSection3,"CTT",1,{|| RhFilial("CTT",TRA->TR_FILIAL)+ TRA->TR_CC })

//���������������������������������������������Ŀ
//� Criacao da Quarta Secao: C.Custo por Valor  �
//�����������������������������������������������
oSection4 := TRSection():New(oSection3,STR0037 + " -" + STR0011,{"RA4","RA1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)		//"Custo por C.Custo - Valor"
oSection4:SetTotalInLine(.F.)  
oSection4:SetHeaderBreak(.T.)  

TRCell():New(oSection4,"RA4_CURSO","RA4",CRLF + STR0004,,,,{|| cCurso })	//Codigo do Curso
TRCell():New(oSection4,"RA1_DESC","RA1","")									//Descricao do Curso  
TRCell():New(oSection4,"JANEIRO"	,"   ",	STR0020 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[1] })
TRCell():New(oSection4,"FEVEREIRO"	,"   ", STR0021 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[2] })
TRCell():New(oSection4,"MARCO"		,"   ", STR0022 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[3] })
TRCell():New(oSection4,"ABRIL"		,"   ", STR0023 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[4] })
TRCell():New(oSection4,"MAIO"		,"   ", STR0024 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[5] })
TRCell():New(oSection4,"JUNHO"		,"   ", STR0025 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[6] })
TRCell():New(oSection4,"JULHO"		,"   ", STR0026 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[7] })
TRCell():New(oSection4,"AGOSTO"		,"   ", STR0027 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[8] })
TRCell():New(oSection4,"SETEMBRO"	,"   ", STR0028 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[9] })
TRCell():New(oSection4,"OUTUBRO"	,"   ", STR0029 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[10]})
TRCell():New(oSection4,"NOVEMBRO"	,"   ", STR0030 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[11]})
TRCell():New(oSection4,"DEZEMBRO"	,"   ", STR0031 + CRLF + STR0033,"@R 9999,999.99",12,, {|| aValor[12]})
TRCell():New(oSection4,"TOTAL"		,"   ",STR0032,"@R 9999,999.99",12,, {|| nTotal:= 0, aEval(aValor,{ |X| nTotal += X }), nTotal})	 	

TRPosition():New(oSection4,"RA1",1,{|| RhFilial("RA1",TRA->TR_FILIAL)+ cCurso })

//��������������������������������������������Ŀ
//� Criacao da Quinta Secao: C.Custo por Horas �
//���������������������������������������������� 
oSection5 := TRSection():New(oSection3,STR0037 + " -" + STR0012,{"RA4","RA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)	//"Custo do Treinamento Anual por Curso"
oSection5 :SetTotalInLine(.F.)   
oSection5:SetHeaderBreak(.T.) 

TRCell():New(oSection5,"RA4_CURSO","RA4",CRLF + "Curso",,,,{|| cCurso })	//Codigo do Curso
TRCell():New(oSection5,"RA1_DESC","RA1","")									//Descricao do Curso  
TRCell():New(oSection5,"JANEIRO"	,"   ",	STR0020 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[1] })
TRCell():New(oSection5,"FEVEREIRO"	,"   ", STR0021 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[2] })
TRCell():New(oSection5,"MARCO"		,"   ", STR0022 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[3] })
TRCell():New(oSection5,"ABRIL"		,"   ", STR0023 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[4] })
TRCell():New(oSection5,"MAIO"		,"   ", STR0024 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[5] })
TRCell():New(oSection5,"JUNHO"		,"   ", STR0025 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[6] })
TRCell():New(oSection5,"JULHO"		,"   ", STR0026 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[7] })
TRCell():New(oSection5,"AGOSTO"		,"   ", STR0027 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[8] })
TRCell():New(oSection5,"SETEMBRO"	,"   ", STR0028 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[9] })
TRCell():New(oSection5,"OUTUBRO"	,"   ", STR0029 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[10]})
TRCell():New(oSection5,"NOVEMBRO"	,"   ", STR0030 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[11]})
TRCell():New(oSection5,"DEZEMBRO"	,"   ", STR0031 + CRLF + STR0034,"@R 999,999",6,, {|| aHoras[12]})
TRCell():New(oSection5,"TOTAL"		,"   ",STR0032,"@R 999,999",6,, {|| nTotal:= 0, aEval(aHoras,{ |X| nTotal += X }), nTotal})	 	

TRPosition():New(oSection5,"RA1",1,{|| RhFilial("RA1",TRA->TR_FILIAL)+ cCurso })

Return oReport

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ReportDef() � Autor � Eduardo Ju          � Data � 30.05.06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Impressao do Relatorio (Custo do Treinamento)               ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function PrintReport(oReport) 

Local nOrdem  	:= oReport:Section(1):GetOrder() 
Local oSection1 
Local oSection2 
Local cFiltroRA4:= ""
Local cFiltroSRA:= ""
Local cFiltroSQ3:= ""
Local cArqDBF  	:= ""
Local aFields 	:= {}
Local cAcessaRA4:= 	 &("{ || " + ChkRH("TRM040","RA4","2") + "}")
Local cSituacao := ""
Local nFerProg  := 0
Local cSitFol   := "" 
Local cTit		:= ""
Local aLogCargo	:= {}    
Local aLogTitle	:= {}
Local lExcLogCargo:= .F.  
Local cMainTitle:= ""
Local cTitle1	:= ""

//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
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
//��������������������������������������������������������������������������            
//������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                   �
//� mv_par01        //  Filial?                                            �
//� mv_par02        //  Matricula ?                                        �
//� mv_par03        //  Centro de Custo?                                   �
//� mv_par04        //  Nome?                                              �
//� mv_par05        //  Curso?                                             �
//� mv_par06        //  Grupo?                                             �
//� mv_par07        //  Depto?                                             �
//� mv_par08        //  Cargo?                                             �
//� mv_par09        //  Ano?                                               �
//� mv_par10        //  Totais Em? 1- Valor; 2- Horas                      �
//� mv_par11        //  Situacoes?                                         � 
//� mv_par12        //  Ferias Programadas?                                �
//�������������������������������������������������������������������������� 
//������������������������������������������������������Ŀ
//� Transforma parametros Range em expressao (intervalo) �
//��������������������������������������������������������
MakeAdvplExpr("TR040R")	    

cSituacao 	:= mv_par11
nFerProg  	:= mv_par12
//cSitFol   := ""
               
If nOrdem = 1	//Relatorio por Curso

	oSection1 := If(mv_par10 = 1, oReport:Section(1), oReport:Section(2))	//Por Valor # Por Horas
	
	TRFunction():New(oSection1:Cell("JANEIRO")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("FEVEREIRO"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("MARCO")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("ABRIL")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("MAIO")     ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("JUNHO")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("JULHO")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("AGOSTO")   ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("SETEMBRO") ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("OUTUBRO")  ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("NOVEMBRO") ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("DEZEMBRO") ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection1:Cell("TOTAL")    ,/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
		
Else			//Relatorio por C.Custo 

	oSection1 := oReport:Section(3)	
	oSection2 := If(mv_par10 = 1, oSection1:Section(1), oSection1:Section(2))

	oBreakCC := TRBreak():New(oReport,oSection1:Cell("RA_CC"),STR0036) // "Total por C.Custo"
	
	TRFunction():New(oSection2:Cell("JANEIRO")  ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("FEVEREIRO"),/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("MARCO")    ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("ABRIL")    ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("MAIO")     ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("JUNHO")    ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("JULHO")    ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("AGOSTO")   ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("SETEMBRO") ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("OUTUBRO")  ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("NOVEMBRO") ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("DEZEMBRO") ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oSection2:Cell("TOTAL")    ,/*cId*/,"SUM",oBreakCC,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.,/*lEndReport*/,/*lEndPage*/) 

Endif

//��������������Ŀ
//� Filtra RA4   �
//����������������
If !Empty(mv_par01)	//RA4_FILIAL
	cFiltroRA4 := mv_par01
EndIf 

If !Empty(mv_par02)	//RA4_MAT 
	cFiltroRA4 += IIF(!Empty(cFiltroRA4)," .And. ","")
	cFiltroRA4 += mv_par02 
EndIf

If !Empty(mv_par05)	//RA4_CURSO  
	cFiltroRA4 += IIF(!Empty(cFiltroRA4)," .And. ","")
	cFiltroRA4 += mv_par05
EndIf                                 

If !Empty(cFiltroRA4) 
	cFiltroRA4 += ' .And. Year(RA4_DATAIN) = ' + AllTrim(Str(mv_par09)) 	//Apenas Filtrar Registros do Ano definido no parametro.		
Else
	cFiltroRA4 += ' Year(RA4_DATAIN) = ' + AllTrim(Str(mv_par09)) 	//Apenas Filtrar Registros do Ano definido no parametro.		
EndIf

//��������������Ŀ
//� Filtra SRA   �
//����������������
If !Empty(mv_par03)	//RA_CC
	cFiltroSRA := mv_par03 
EndIf

If !Empty(mv_par04)	//RA_NOME  
	cFiltroSRA += IIF(!Empty(cFiltroSRA)," .And. ","")
	cFiltroSRA += mv_par04
EndIf        

//��������������Ŀ
//� Filtra SQ3   �
//����������������
If !Empty(mv_par06)	//Q3_GRUPO
	cFiltroSQ3 := mv_par06
EndIf  

If !Empty(mv_par07)	//Q3_DEPTO 
	cFiltroSQ3 += IIF(!Empty(cFiltroSQ3)," .And. ","")
	cFiltroSQ3 += mv_par07 
EndIf

If !Empty(mv_par08)	//Q3_CARGO
	cFiltroSQ3 += IIF(!Empty(cFiltroSQ3)," .And. ","")
	cFiltroSQ3 += mv_par08 
EndIf        

//����������������������������������������������������������Ŀ
//� Definicao do filtro para a Tabela Principal e Secundaria �
//������������������������������������������������������������ 
oSection1:SetFilter(cFiltroRA4,,,"RA4")	
oSection1:SetFilter(cFiltroSRA,,,"SRA")		
oSection1:SetFilter(cFiltroSQ3,,,"SQ3") 
   
//������������������������������������������Ŀ
//� Arquivo Principal: Cursos do Funcionario �
//��������������������������������������������
dbSelectArea("RA4")	
dbSetOrder(2)	
RA4->( DbGoTop() )
oReport:SetMeter(RecCount()) 

//Inicializa
aFill(aHoras,0)	
aFill(aValor,0)

If nOrdem = 1   //Por Curso
    //����������������������������������������Ŀ
	//� Centralizacao das Celulas do Relatorio �
	//������������������������������������������ 
	oSection1:Cell("JANEIRO"):SetHeaderAlign("CENTER")
	oSection1:Cell("FEVEREIRO"):SetHeaderAlign("CENTER")
	oSection1:Cell("MARCO"):SetHeaderAlign("CENTER")
	oSection1:Cell("ABRIL"):SetHeaderAlign("CENTER")
	oSection1:Cell("MAIO"):SetHeaderAlign("CENTER")
	oSection1:Cell("JUNHO"):SetHeaderAlign("CENTER")
	oSection1:Cell("JULHO"):SetHeaderAlign("CENTER")
	oSection1:Cell("AGOSTO"):SetHeaderAlign("CENTER")
	oSection1:Cell("SETEMBRO"):SetHeaderAlign("CENTER")
	oSection1:Cell("OUTUBRO"):SetHeaderAlign("CENTER")
	oSection1:Cell("NOVEMBRO"):SetHeaderAlign("CENTER")
	oSection1:Cell("DEZEMBRO"):SetHeaderAlign("CENTER")
	oSection1:Cell("TOTAL"):SetHeaderAlign("CENTER")

	oSection1:Init() 

	While !RA4->(Eof())

		cCurso 	:= RA4->RA4_CURSO 
			
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		While !RA4->(Eof()) .And. cCurso == RA4->RA4_CURSO
			Begin Sequence
				If !Eval(cAcessaRA4)
				    break
				EndIf
				dbSelectArea("SRA")
				dbSetOrder(1)
				
				If dbSeek(RA4->RA4_FILIAL+RA4->RA4_MAT)
					//��������������������������Ŀ
					//� Situacao do Funcionario  �
					//����������������������������
					cSitFol := TrmSitFol()
					cCargo 	:= fGetCargo(SRA->RA_MAT)
					
					//��������������������������������������������������Ŀ
					//� Alimenta array com os registros que n�o ha cargo �
					//���������������������������������������������������� 
					If Empty(cCargo)
						aAdd( aLogCargo,SRA->RA_FILIAL + Space(05) + SRA->RA_MAT + Space(04) + SRA->RA_NOME + Space(01) + RA4->RA4_CALEND + Space(07) + RA4->RA4_CURSO) 
					EndIf
						
					If	(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P")) .Or.;
						(cSitfol == "P" .And. nFerProg == 2)
					    Break
					EndIf    
					nMes := Month(RA4->RA4_DATAIN)
					aHoras[nMes] := aHoras[nMes]  + RA4->RA4_HORAS
					aValor[nMes] := aValor[nMes]  + RA4->RA4_VALOR
				EndIf    
			End Sequence
			dbSelectArea("RA4")
			dbSkip()
		EndDo  
		oSection1:PrintLine() 
		aFill(aHoras,0)	
		aFill(aValor,0)
	EndDo 
	oSection1:Finish() 
Else  //Relatorio do Centro de custo

	//����������������������������������������Ŀ
	//� Centralizacao das Celulas do Relatorio �
	//������������������������������������������ 
	oSection2:Cell("JANEIRO"):SetHeaderAlign("CENTER")
	oSection2:Cell("FEVEREIRO"):SetHeaderAlign("CENTER")
	oSection2:Cell("MARCO"):SetHeaderAlign("CENTER")
	oSection2:Cell("ABRIL"):SetHeaderAlign("CENTER")
	oSection2:Cell("MAIO"):SetHeaderAlign("CENTER")
	oSection2:Cell("JUNHO"):SetHeaderAlign("CENTER")
	oSection2:Cell("JULHO"):SetHeaderAlign("CENTER")
	oSection2:Cell("AGOSTO"):SetHeaderAlign("CENTER")
	oSection2:Cell("SETEMBRO"):SetHeaderAlign("CENTER")
	oSection2:Cell("OUTUBRO"):SetHeaderAlign("CENTER")
	oSection2:Cell("NOVEMBRO"):SetHeaderAlign("CENTER")
	oSection2:Cell("DEZEMBRO"):SetHeaderAlign("CENTER")
	oSection2:Cell("TOTAL"):SetHeaderAlign("CENTER")
	
	cArqDBF  	:= CriaTrab(NIL,.f.)
    
	AADD(aFields,{"TR_FILIAL"	,"C",02,0})
	AADD(aFields,{"TR_MAT"		,"C",06,0})
	AADD(aFields,{"TR_CC"		,"C",09,0})
	AADD(aFields,{"TR_CURSO"	,"C",04,0})
	AADD(aFields,{"TR_CUSTO"	,"N",12,2})
	AADD(aFields,{"TR_HORAS"	,"N",06,2})
	AADD(aFields,{"TR_DATA"		,"D",08,0})

	dbCreate(cArqDbf,aFields)
	dbUseArea(.T.,,cArqDbf,"TRA",.F.)
	cIndCond := "TR_CC + TR_CURSO"	// Centro de Custo + Curso  

	cArqNtx  := CriaTrab(NIL,.f.)
	oSection2:SetFilter(".T.",cIndCond,,"TRA")
	dbGoTop()

	dbSelectArea("RA4")
	dbSetOrder(1)
	dbGoTop()

	While !RA4->(Eof())	    
		
		If !Eval(cAcessaRA4)
			dbSkip()
			Loop
		EndIf
		
		dbSelectArea("SRA")
		dbSetOrder(1)
	
		If dbSeek(RA4->RA4_FILIAL+RA4->RA4_MAT)
			
			//��������������������������Ŀ
			//� Situacao do Funcionario  �
			//����������������������������
			cSitFol := TrmSitFol()
			cCargo 	:= fGetCargo(SRA->RA_MAT)
			
			//��������������������������������������������������Ŀ
			//� Alimenta array com os registros que n�o ha cargo �
			//���������������������������������������������������� 
			If Empty(cCargo)
				aAdd( aLogCargo,SRA->RA_FILIAL + Space(05) + SRA->RA_MAT + Space(04) + SRA->RA_NOME + Space(01) + RA4->RA4_CALEND + Space(07) + RA4->RA4_CURSO) 
			EndIf
			
			If	(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P")) .Or.;
				(cSitfol == "P" .And. nFerProg == 2)
				
				dbSelectArea("RA4")
				dbSkip()
				Loop
			EndIf
							
			RecLock("TRA",.T.)
				TRA->TR_FILIAL	:= RA4->RA4_FILIAL 
				TRA->TR_MAT		:= SRA->RA_MAT
				TRA->TR_CC		:= SRA->RA_CC
				TRA->TR_CURSO	:= RA4->RA4_CURSO
				TRA->TR_CUSTO	:= RA4->RA4_VALOR
				TRA->TR_HORAS	:= RA4->RA4_HORAS
				TRA->TR_DATA 	:= RA4->RA4_DATAIN
			MsUnlock()
			dbSelectArea("RA4")
		  	dbSkip()
        Else
			dbSelectArea("RA4")
		  	dbSkip()
		EndIf		
		
	EndDo
		
	aHoras := Array(12)
	aValor := Array(12)
		
	aFill(aHoras,0)
	aFill(aValor,0)
	
	dbSelectArea("TRA")
	dbGotop()
		
	While !Eof() 
				
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf    
		
		cCC 	:= TRA->TR_CC 
		
		//������������������������Ŀ
		//� Impressao da Secao Pai �
		//��������������������������
	   	oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()  
		
		While !TRA->(Eof()) .And. cCC == TRA->TR_CC 
		 
			cCurso	:= TRA->TR_CURSO
						
			//While !Eof() .And. cCurso == TRA->TR_CURSO
			While !TRA->(Eof()) .And. cCc + cCurso == TRA->TR_CC + TRA->TR_CURSO
				 	
				nMes := Month(TRA->TR_DATA)
								
				aHoras[nMes] := aHoras[nMes]  + TRA->TR_HORAS
				aValor[nMes] := aValor[nMes]  + TRA->TR_CUSTO
				
			   	TRA->( dbSkip() )
			EndDo 
			
			//��������������������������Ŀ
			//� Impressao da Secao Filha �
			//����������������������������
			oSection2:Init()
			oSection2:PrintLine()
			
			aFill(aHoras,0)	
			aFill(aValor,0)
		EndDo
		
		oSection2:Finish()
		
	EndDo    
	
	dbSelectArea("TRA")
	dbCloseArea()
	fErase(cArqNtx + OrdBagExt())
	fErase(cArqDbf + GetDBExtension()) 
	
EndIf

//��������������������������������������������������������������������Ŀ
//� Gera Arquivo Log com as Inconsistencias no vinculo Funcao x Cargo  �
//����������������������������������������������������������������������
If ( lExcLogCargo := !Empty(aLogCargo) ) 

	cMainTitle 	:= STR0038			//"Inconsist�ncias na fun��o ou cargo"
	cTitle1		:= Upper(STR0039)	//"Filial Matricula Funcionario                    Calendario Curso"   
   
  	aAdd(aLogTitle,cTitle1)

	If ( lExcLogCargo := MsgNoYes(STR0040, STR0001 + " - " + cMainTitle ) )	//"Foram encontradas inconsist�ncias no v�nculo Fun��o x Cargo. Deseja gerar Log?"
		FMakeLog( { aLogCargo } , aLogTitle , , NIL , NIL , STR0001 + Space(01)+ "("+ cMainTitle+")","M","P",,.F. )			
	EndIf	                            
	
EndIf

Return Nil

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �TR040RSX1 � Autor � Eduardo Ju            � Data � 24.08.06 ���
�������������������������������������������������������������������������Ĵ��
���Descricao �Criacao do Pergunte TR040R no Dicionario SX1                ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Uso       �CSR50RSX1                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/ 
Static Function TR040RSX1()             

Local aRegs		:= {} 
Local cPerg		:= "TR040R"  
Local aHelp		:= {}
Local aHelpE	:= {}
Local aHelpI	:= {}   
Local cHelp		:= ""

aHelp := {	"Informe intervalo de filiais que ",;
			"deseja considerar para impressao ",;
			"do relatorio." }
aHelpE:= {	"Informe intervalo de sucursales que ",;
			"desea considerar para impresion del ",;
			"informe" }
aHelpI:= {	"Enter branch range to be considered ",;
			"to print report." }
cHelp := ".RHFILIAL."
PutSX1Help("P"+cHelp,aHelp,aHelpI,aHelpE)	 
/*
�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo    Ordem   Pergunta Portugues      Pergunta Espanhol           Pergunta Ingles             Variavel    Tipo    Tamanho     Decimal Presel  GSC     Valid           Var01       Def01               DefSPA1             DefEng1             Cnt01               Var02   Def02               DefSpa2             DefEng2         Cnt02       Var03   Def03               DefSpa3             DefEng3         Cnt03   Var04   Def04       DefSpa4     DefEng4     Cnt04   Var05   Def05       DefSpa5     DefEng5     Cnt05   XF3   GrgSxg cPyme  aHelpPor    aHelpEng    aHelpSpa    cHelp  �
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{cPerg	,"01"	,"Filial ?"	   		,"�Sucursal?"  			,"Branch?"				,"mv_ch1"  	,"C"	,99			,0		,0		,"R"	,""		    ,"mv_par01"	,""					,""					,""					,"RA4_FILIAL"		,""		,""					,""					,""				,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,"XM0",""  ,"S"	,{}			,{}			,{}			,cHelp})


/*
�����������������������������������������������������������Ŀ
� Matricula       														�
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de matriculas que ",;
			"deseja considerar para impressao do ",;
			"relatorio." }
aHelpE:= {	"Informe intervalo de matriculas que ",;
			"desea considerar para impresion del ",;
			"informe." }
aHelpI:= {	"Enter registration range to be ",;
			"considered for printing the report." }
cHelp := ".RHMATRIC."
PutSX1Help("P"+cHelp,aHelp,aHelpI,aHelpE)	 
Aadd(aRegs,{cPerg,"02","Matricula ?","�Matricula ?","Registration ?","mv_ch2","C",99,0,0,"R","","mv_par02"	,"","","","RA4_MAT"	,"","","","","","","","","","","","","",""	,"","","","",""	,"","SRA","","S",{}	  ,{}	,{}	,cHelp})
/*
�����������������������������������������������������������Ŀ
� Centro de Custo											�
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de Centros de Custo ",;
			"que deseja considerar para impressao ",;
			"do relatorio." }
aHelpE:= {	"Informe intervalo de centros de costo ",;
			"que desea considerar para impresion ",;
			"del informe." }
aHelpI:= {	"Enter the cost center range to be ",;
			"considered for printing the report." }
cHelp := ".RHCCUSTO."
PutSX1Help("P"+cHelp,aHelp,aHelpI,aHelpE)
Aadd(aRegs,{cPerg	,"03","Centro de Custo ?"	,"�Centro de Costo ?"    ,"Cost Center ?"	       ,"mv_ch3","C",99		,0		,0	,"R"	,""	,"mv_par03"	,""	,""		,""		,"RA_CC"		,""	,""		,""		,""		,""						,""		,""		,""		,""		,""		,""	,""		,""		,""		,""		,"" ,""		,""		,""		,""		,"CTT",""   ,"S"	,{}			,{}			,{}			,cHelp})              

/*
�����������������������������������������������������������Ŀ
� Nome            											�
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de nomes de funcio-",;
			"narios que deseja considerar para im-",;
			"pressao do relatorio." }
aHelpE:= {	"Informe intervalo de nombres de empleados ",;
			"que desea considerar para impresion del ",;
			"informe." }
aHelpI:= {	"Enter range of employee names to be ",;
			"considered for printing the report." }
cHelp := ".RHNOME."
PutSX1Help("P"+cHelp,aHelp,aHelpI,aHelpE)	 
Aadd(aRegs,{cPerg,"04","Nome ?"	,"�Nombre?","Name ?","mv_ch4","C",99,0	,0,"R","","mv_par04",""	,"","","RA_NOME","","","","","","","","","","","","","","","",""     ,""			,""			,""			,""		,""	,"","S"	,{}			,{}			,{}			,cHelp})              
/*
�����������������������������������������������������������Ŀ
� Curso            											�
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de curso que deseja",;
			" considerar para impressao do relatorio." }

aHelpE:= {	"Informe intervalo de curso que desea",;
			" considerar para impresion del informe." }
			
aHelpI:= {	"Enter range of course code  to be ",;
			"considered for printing the report." }

cHelp := ".TR040R05."
Aadd(aRegs,{cPerg,"05"	,"Curso ?"	,"�Curso ?","Course ?","mv_ch5"  	,"C",99,0,0,"R","","mv_par05"	,""	,"","","RA4_CURSO","","","","","","","","","","","",""	,"","","","","","","","","RA1"    ,"","S"	,aHelp		,aHelpI		,aHelpE			,cHelp})

/*
�����������������������������������������������������������Ŀ
� Grupo                                                     �
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de grupo que deseja",;
			" considerar para impressao do relatorio." }

aHelpE:= {	"Informe intervalo de grupo que desea",;
			" considerar para impresion del informe." }
			
aHelpI:= {	"Enter range of group  to be ",;
			"considered for printing the report." }

cHelp := ".TR040R06."
Aadd(aRegs,{cPerg	,"06"	,"Grupo ?"	   		,"�Grupo ?"     		,"Group ?"				,"mv_ch6"  	,"C"	,99			,0		,0		,"R"	,""			,"mv_par06"	,""					,""					,""					,"Q3_GRUPO"			,""		,""					,""					,""				,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,"SQ0"		,"","S"	,aHelp		,aHelpI		,aHelpE			,cHelp})

/*
�����������������������������������������������������������Ŀ
� Departamento                                              �
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de departamento que deseja",;
			" considerar para impressao do relatorio." }

aHelpE:= {	"Informe intervalo de sector que desea",;
			" considerar para impresion del informe." }
			
aHelpI:= {	"Enter range of department to be ",;
			"considered for printing the report." }

cHelp := ".TR040R07."
Aadd(aRegs,{cPerg	,"07"	,"Departamento ?"	,"�Sector ?"     		,"Department ?"			,"mv_ch7"  	,"C"	,99			,0		,0		,"R"	,""			,"mv_par07"	,""					,""					,""					,"Q3_DEPTO"			,""		,""					,""					,""				,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,"SQB"	,"","S"	,aHelp		,aHelpI		,aHelpE			,cHelp})

/*
�����������������������������������������������������������Ŀ
� Cargo                                                     �
�������������������������������������������������������������*/
aHelp := {	"Informe intervalo de cargo que deseja",;
			" considerar para impressao do relatorio." }

aHelpE:= {	"Informe intervalo de funcion que desea",;
			" considerar para impresion del informe." }
			
aHelpI:= {	"Enter range of job to be ",;
			"considered for printing the report." }

cHelp := ".TR040R08."
Aadd(aRegs,{cPerg	,"08"	,"Cargo ?"			,"�Funcion ?"     		,"Job ?"				,"mv_ch8"  	,"C"	,99			,0		,0		,"R"	,""			,"mv_par08"	,""					,""					,""					,"Q3_CARGO"			,""		,""					,""					,""				,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,""		,"","S"	,aHelp		,aHelpI		,aHelpE			,cHelp})
/*
/*
�����������������������������������������������������������Ŀ
� Usando o Help do R3                                       �
�������������������������������������������������������������*/
Aadd(aRegs,{cPerg	,"09"	,"Ano(AAAA) ?"		,"�A�o(AAAA) ?"     	,"Year (YYYY) ?"		,"mv_ch9"  	,"N"	,4			,0		,0		,"G"	,""			,"mv_par09"	,""					,""					,""					,""			  		,""		,""					,""					,""				,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,""		,"","S"	,{}			,{}			,{}			,'.TRR06017.'}) 
Aadd(aRegs,{cPerg	,"10"	,"Totais em ?"		,"�Totales en ?"    	,"Totals in ?"			,"mv_cha"  	,"N"	,1			,0		,1		,"C"	,""			,"mv_par10"	,"Valor"			,"Valor"			,"Value"			,""	   				,""		,"Horas"			,"Horas"			,"Hours"		,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,""		,"","S"	,{}			,{}			,{}			,'.TRR06018.'})              
Aadd(aRegs,{cPerg	,"11"	,"Situacoes ?"		,"�Situaciones ?"    	,"Status ?"		   		,"mv_chb"  	,"C"	,5			,0		,0		,"G"	,"fSituacao","mv_par11"	,""		   			,""					,""					,""	   				,""		,""					,""					,""				,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,""		,"","S"	,{}			,{}			,{}			,'.RHSITUA.'})              
Aadd(aRegs,{cPerg	,"12"	,"Ferias Programadas ?"	,"�Vacaciones Programadas ?","Scheduled Vacation ?"	,"mv_chc"  	,"N"	,1	,0		,1		,"C"	,""			,"mv_par12"	,"Sim"	   			,"Si"				,"Yes"				,""	   				,""		,"Nao"				,"No"				,"No"   		,""			,""		,""					,""					,""				,""		,""		,""			,""			,""			,""		,""     ,""			,""			,""			,""		,""		,"","S"	,{}			,{}			,{}			,'.TRR06020.'})  

ValidPerg(aRegs,cPerg)

Return Nil

/*
PROGRAMA FONTE ORIGINAL ABAIXO
*/

User Function TRM040R3()

SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,AORD,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,LEND,COLUNAS")
SetPrvt("AT_PRG,CONTFL,LI,NPAG,NTAMANHO,ADRIVER")
SetPrvt("CTIT,TITULO,WNREL,NORDEM,CARQDBF")
SetPrvt("AFIELDS,CINDCOND,CARQNTX,CINICIO,CFIM,CFIL")
SetPrvt("LRET,AHORAS,AVALOR,ACHORAS,ACVALOR,ATHORAS")
SetPrvt("ATVALOR,CCURSO,CNOME,CCC,NMES,WCABEC0")
SetPrvt("WCABEC1,WCABEC2,NTOTAL,DET,NX,CAUX,LIMP")
SetPrvt("cAcessaRA4,nChar,cCargo,aLogCargo,aLogTitle,lExcLogCargo,cMainTitle,cTitle1") 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � TRM040   � Autor � Desenvolvimento R.H.  � Data � 16.03.99 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Custo do Treinamentos - Mensal                             ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � TRM040                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RdMake                                                     ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �  /  /  �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
cDesc1  := STR0001 //"Custo Treinamento Mensal"
cDesc2  := STR0002 //"Ser� impresso de acordo com os parametros solicitados pelo"
cDesc3  := STR0003 //"usu�rio."
cString := "SRA"  			         //-- alias do arquivo principal (Base)
aOrd    := { STR0004,STR0005 } 		//"Curso"###"Centro de Custo"

//��������������������������������������������������������������Ŀ
//� Define Variaveis (Basicas)                                   �
//����������������������������������������������������������������
aReturn  := { STR0006,1,STR0007,2,2,1,"",1 } //"Zebrado"###"Administra��o"
NomeProg := "TRM040"
aLinha   := {}
nLastKey := 0
cPerg    := "TRR060"
lEnd     := .F.

//��������������������������������������������������������������Ŀ
//� Define Variaveis (Programa)                                  �
//����������������������������������������������������������������
COLUNAS  := 220
at_Prg   := "TRM040"
Contfl   := 1
Li       := 0
nPag     := 0
nTamanho := "G"
aDriver	 := ReadDriver()
nChar	 := 15
aLogCargo:= {}    
aLogTitle:= {}
lExcLogCargo:= .F.  
cMainTitle:= ""
cTitle1	:= ""

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
pergunte("TRR060",.F.)

cTit   := STR0009 + Str(mv_par17,4) + STR0010 + IIf(mv_par18=1,STR0011,STR0012) //"Investimento em Treinamento no Ano de "###" em: "###" Valor"###" Horas"
Titulo := cTit
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01        //  Filial  De                               �
//� mv_par02        //  Filial  Ate                              �
//� mv_par03        //  Matricula De                             �
//� mv_par04        //  Matricula Ate                            �
//� mv_par05        //  Centro de Custo                          �
//� mv_par06        //  Centro de Custo                          �
//� mv_par07        //  Nome De                                  �
//� mv_par08        //  Nome Ate                                 �
//� mv_par09        //  Curso De                                 �
//� mv_par10        //  Curso Ate                                �
//� mv_par11        //  Grupo De                                 �
//� mv_par12        //  Grupo Ate                                �
//� mv_par13        //  Departamento De                          �
//� mv_par14        //  Departamento Ate                         �
//� mv_par15        //  Cargo De                                 �
//� mv_par16        //  Cargo Ate                                �
//� mv_par17        //  Ano (AAAA)                               �
//� mv_par18        //  Treinamento em 1-Valor      2-Horas      �
//� mv_par19        //  Status Funcionario                       �
//� mv_par20        //  Ferias Programadas                       �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
WnRel :="TRM040"	//-- Nome Default do relatorio em Disco.
WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,nTamanho)

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

RptStatus({|lEnd| Relato()},cTit)

Return

Static Function Relato()

nOrdem  	:= aReturn[8]
cArqDBF  	:= CriaTrab(NIL,.f.)
aFields 	:= {}
lImp		:= .F.
cTit   		:= STR0009 + Str(mv_par17,4) + STR0010 + IIf(mv_par18=1,STR0011,STR0012) //"Investimento em Treinamento no Ano de "###" em: "###" Valor"###" Horas"
Titulo 		:= cTit
cAcessaRA4	:= &("{ || " + ChkRH("TRM040","RA4","2") + "}")
cSituacao 	:= mv_par19
nFerProg  	:= mv_par20
cSitFol   	:= ""

AADD(aFields,{"TR_CC"		,"C",09,0})
AADD(aFields,{"TR_CURSO"	,"C",04,0})
AADD(aFields,{"TR_DESCUR"	,"C",30,0})
AADD(aFields,{"TR_CUSTO"	,"N",12,2})
AADD(aFields,{"TR_HORAS"	,"N",06,2})
AADD(aFields,{"TR_DATA"		,"D",08,0})

dbCreate(cArqDbf,aFields)
dbUseArea(.T.,,cArqDbf,"TRA",.F.)

If nOrdem == 1 		// Curso     
	cIndCond := "TR_CURSO"
Else                 // Centro de Custo + Curso    
	cIndCond := "TR_CC + TR_CURSO"
EndIf

cArqNtx  := CriaTrab(NIL,.f.)
IndRegua("TRA",cArqNtx,cIndCond,,,STR0013) //"Selecionando Registros..."
dbGoTop()

dbSelectArea("RA4")
dbSetOrder(1) 
RA4->( DbGoTop() )
dbSeek(mv_par01+mv_par03+mv_par09,.T.)
cInicio	:= "RA4->RA4_FILIAL + RA4->RA4_MAT + RA4->RA4_CURSO" 
cFim	:= mv_par02 + mv_par04 + mv_par10

SetRegua(RecCount())

While !Eof() .And. &cInicio <= cFim

	If !Eval(cAcessaRA4)
		dbSkip()
		Loop
	EndIf

	If RA4->RA4_CURSO  < mv_par09 .Or. RA4->RA4_CURSO  > mv_par10 .Or.;
		Year(RA4->RA4_DATAIN) # mv_par17
		dbSkip()
		Loop
	EndIf
	
	dbSelectArea("RA2")
	dbSeek(xFilial("RA2")+RA4->RA4_CALEND+RA4->RA4_CURSO+RA4->RA4_TURMA)
	
	dbSelectArea("SRA")
	dbSetOrder(1)
	
	If dbSeek(RA4->RA4_FILIAL+RA4->RA4_MAT)
		
		//��������������������������Ŀ
		//� Situacao do Funcionario  �
		//����������������������������
		cSitFol := TrmSitFol()
		cCargo 	:= fGetCargo(SRA->RA_MAT)
		
		//��������������������������������������������������Ŀ
		//� Alimenta array com os registros que n�o ha cargo �
		//���������������������������������������������������� 
		If Empty(cCargo)
			aAdd( aLogCargo,SRA->RA_FILIAL + Space(05) + SRA->RA_MAT + Space(04) + SRA->RA_NOME + Space(01) + RA4->RA4_CALEND + Space(07) + RA4->RA4_CURSO) 
		EndIf
		
		If 	(SRA->RA_MAT  	< mv_par03) .Or.	(SRA->RA_MAT 	> mv_par04)	.Or.;
			(SRA->RA_CC   	< mv_par05) .Or.	(SRA->RA_CC  	> mv_par06)	.Or.;
			(SRA->RA_NOME 	< mv_par07) .Or.	(SRA->RA_NOME 	> mv_par08)	.Or.;
			(cCargo 		< mv_par15)	.Or.	(cCargo		 	> mv_par16)	.Or.;
			(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P"))   		.Or.;
			(cSitfol == "P" .And. nFerProg == 2)
			
			dbSelectArea("RA4")
			dbSkip()
			Loop
		EndIf
		
		dbSelectArea( "SQ3" )
		dbSetOrder(1)
		cFil := If(xFilial("SQ3") == Space(2),Space(2),RA4->RA4_FILIAL)
		If dbSeek( cFil + cCargo + SRA->RA_CC ) .Or. dbSeek( cFil + cCargo )
			If 	SQ3->Q3_GRUPO < mv_par11 .Or. SQ3->Q3_GRUPO > mv_par12 .Or.;
				SQ3->Q3_DEPTO < mv_par13 .Or. SQ3->Q3_DEPTO > mv_par14
				dbSelectArea("RA4")
				dbSkip()
				Loop
			EndIf
		Else 
			dbSelectArea("RA4")
			dbSkip()
			Loop	
		EndIf
				
		dbSelectArea("RA1")
		dbSetOrder(1)
		cFil := If(xFilial("RA1") == Space(2),Space(2),RA4->RA4_FILIAL)
		dbSeek(cFil+RA4->RA4_CURSO)

		RecLock("TRA",.T.)
			TRA->TR_CC		:= SRA->RA_CC
			TRA->TR_CURSO	:= RA4->RA4_CURSO
			TRA->TR_DESCUR	:= RA1->RA1_DESC
			TRA->TR_CUSTO	:= RA4->RA4_VALOR
			TRA->TR_HORAS	:= RA4->RA4_HORAS
			TRA->TR_DATA 	:= RA4->RA4_DATAIN
		MsUnlock()
		
	EndIf		
	
	dbSelectArea("RA4")
  	dbSkip()
EndDo

lRet := .T.

aHoras := Array(12)
aValor := Array(12)
aCHoras:= Array(12)
aCValor:= Array(12)
aTHoras:= Array(12)
aTValor:= Array(12)

aFill(aHoras,0)
aFill(aValor,0)
aFill(aCHoras,0)
aFill(aCValor,0)
aFill(aTHoras,0)
aFill(aTValor,0)

dbSelectArea("TRA")
dbGotop()

// Seta a impressao para comprimido
//@ 0,0 PSAY &(aDriver[5])

cCurso 	:= TRA->TR_CURSO
cNome	:= TRA->TR_DESCUR
cCC 	:= TRA->TR_CC

While !Eof()

	FImpCab()
	If lRet
		If nOrdem == 2
			FImpCC()
		EndIf
		lRet:= .F.
	EndIf	
	
	nMes := Month(TRA->TR_DATA)
		
	If cCurso # TRA->TR_CURSO
		FImpDet() 
		cCurso 	:= TRA->TR_CURSO
		cNome	:= TRA->TR_DESCUR
	EndIf
	
	If nOrdem == 2 .And. cCC # TRA->TR_CC
		FImpDet()
		FTotCC()
		cCC 	:= TRA->TR_CC
		cCurso:= TRA->TR_CURSO
		cNome	:= TRA->TR_DESCUR
		FImpCC()
	EndIf
		
	aHoras[nMes] := aHoras[nMes]  + TRA->TR_HORAS
	aValor[nMes] := aValor[nMes]  + TRA->TR_CUSTO
	aCHoras[nMes]:= aCHoras[nMes] + TRA->TR_HORAS
	aCValor[nMes]:= aCValor[nMes] + TRA->TR_CUSTO
	aTHoras[nMes]:= aTHoras[nMes] + TRA->TR_HORAS
	aTValor[nMes]:= aTValor[nMes] + TRA->TR_CUSTO
	
	dbSkip()
EndDo

If !lRet
	FImpDet()
	If nOrdem == 2		
		FTotCC()
	EndIf
	FTotGeral()
EndIf	

//��������������������������������������������������������������Ŀ
//� Termino do Relatorio                                         �
//����������������������������������������������������������������
dbSelectArea("TRA")
dbCloseArea()
fErase(cArqNtx + OrdBagExt())
fErase(cArqDbf + GetDBExtension())

dbSelectArea("SRA")
dbSetOrder(1)

dbSelectArea("RA4")
dbSetOrder(1)

dbSelectArea("SQ3") 
dbSetOrder(1)

dbSelectArea("RA1")
dbSetOrder(1)

Set Device To Screen

If lImp
	Impr("","F")
EndIf	

If aReturn[5] == 1
   Set Printer To
   Commit
   ourspool(wnrel)
Endif

MS_FLUSH()

//��������������������������������������������������������������������Ŀ
//� Gera Arquivo Log com as Inconsistencias no vinculo Funcao x Cargo  �
//����������������������������������������������������������������������
If ( lExcLogCargo := !Empty(aLogCargo) ) 

	wCabec1 := ""
	wCabec2 := ""

	cMainTitle 	:= STR0038			//"Inconsist�ncias na fun��o ou cargo"
	cTitle1		:= Upper(STR0039)	//"Filial Matricula Funcionario                    Calendario Curso"   
   
  	aAdd(aLogTitle,cTitle1)

	If ( lExcLogCargo := MsgNoYes(STR0040, STR0001 + " - " + cMainTitle ) )	//"Foram encontradas inconsist�ncias no v�nculo Fun��o x Cargo. Deseja gerar Log?"
		FMakeLog( { aLogCargo } , aLogTitle , , NIL , NIL , STR0001 + Space(01)+ "("+ cMainTitle+")","M","P",,.F. )			
	EndIf	                            
	
EndIf


Return Nil

// Imprime Cabecalho do relatorio
Static Function FImpCab()
wCabec0	:= 2
wCabec1	:= STR0017	//"                                           JAN         FEV         MAR         ABR         MAI         JUN         JUL         AGO         SET         OUT         NOV         DEZ "

If mv_par18 == 1		// Valor
	wCabec2  := STR0018	//"CURSO                                     VALOR       VALOR       VALOR       VALOR       VALOR       VALOR       VALOR       VALOR       VALOR       VALOR       VALOR       VALOR           TOTAL"
Else	
	wCabec2  := STR0019	//"CURSO                                     HORAS       HORAS       HORAS       HORAS       HORAS       HORAS       HORAS       HORAS       HORAS       HORAS       HORAS       HORAS           TOTAL"
EndIf	
Return Nil

// Imprime as linhas de detalhe do relatorio
Static Function FImpDet()

Local nx := 0

If LI > 60
	FImpCab()
EndIf

nTotal:= 0
DET 	:= ""
DET 	:= cCurso + SPACE(01) + cNome
DET 	:= DET + IIF(mv_par18==1,Space(01),Space(05))
For nx:= 1 To 12
	If mv_par18 == 1
		cAux 	:= Transform(aValor[nx],"@R 9999,999.99")
		nTotal	:= nTotal + aValor[nx]
	Else
		cAux 	:= Transform(aHoras[nx],"@R 999,999")
		nTotal	:= nTotal + aHoras[nx]
	EndIf	
	DET 	:= DET + cAux
	DET 	:= DET + IIF(mv_par18==1,Space(01),Space(05))
	cAux 	:= ""
Next nx 

DET := DET + IIF(mv_par18==1,Transform(nTotal,"@R 99999999,999.99"),Transform(nTotal,"999,999,999"))
IMPR(DET,"C")

aFill(aHoras,0)
aFill(aValor,0)
lImp := .T.
Return Nil

// Imprime o cabecalho da quebra por Centro de Custo
Static Function FImpCC()

If LI > 60
	FImpCab()
EndIf	

DET:=""
DET:= STR0014 + cCC + " - " + DescCC(cCC) //"CENTRO DE CUSTO: "
IMPR(DET,"C")

Return Nil

// Imprime os totais por Centro de custo
Static Function FTotCC()

Local nx := 0

If LI > 60
	FImpCab()
	FimpCC()
EndIf	

IMPR(Repl("-",COLUNAS),"C")

nTotal:=0
DET := ""
DET := STR0015 + IIF(mv_par18==1,Space(12),Space(16)) //"TOTAL DO CENTRO DE CUSTO"

For nx:=1 To 12
	If mv_par18 == 1
		cAux 	:= Transform(aCValor[nx],"@R 9999,999.99")
		nTotal:= nTotal + aCValor[nx]
	Else
		cAux 	:= Transform(aCHoras[nx],"999,999")
		nTotal:= nTotal + aCHoras[nx]
	EndIf	
	DET := DET + cAux
	DET := DET + IIF(mv_par18==1,Space(01),Space(05))
	cAux := ""
Next nx

DET := DET + IIF(mv_par18==1,Transform(nTotal,"@R 99999999,999.99"),Transform(nTotal,"999,999,999"))
IMPR(DET,"C")
IMPR("","C")

aFill(aCHoras,0)
aFill(aCValor,0)

Return Nil

// Imprime total geral dos meses
Static Function FTotGeral()

Local nx := 0

If LI > 60
	FImpCab()
EndIf	

nTotal:=0
DET := ""
DET := STR0016 + IIF(mv_par18==1,Space(12),Space(16)) //"TOTAL GERAL:            "

For nx:=1 To 12
	If mv_par18 == 1
		cAux 	:= Transform(aTValor[nx],"@R 9999,999.99")
		nTotal:= nTotal + aTValor[nx]
	Else
		cAux 	:= Transform(aTHoras[nx],"999,999")
		nTotal:= nTotal + aTHoras[nx]
	EndIf	
	DET := DET + cAux
	DET := DET + IIF(mv_par18==1,Space(01),Space(05))
	cAux := ""
Next nx

DET := DET + IIF(mv_par18==1,Transform(nTotal,"@R 99999999,999.99"),Transform(nTotal,"999,999,999"))
IMPR("","C")
IMPR(DET,"C")
IMPR("","C")

aFill(aTHoras,0)
aFill(aTValor,0)

Return Nil
