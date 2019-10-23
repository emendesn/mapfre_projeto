#include "rwmake.ch"        
#INCLUDE "TRM030.CH"
#include "report.ch"

/*��������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������Ŀ��
���Fun��o       � TRM030   � Autor � Eduardo Ju              � Data � 30.05.06 ���
������������������������������������������������������������������������������Ĵ��
���Descri��o    � Custo dos Treinamentos  		                               ���
������������������������������������������������������������������������������Ĵ��
���Uso          � TRM030                                                       ���
������������������������������������������������������������������������������Ĵ��
���Programador  � Data     � BOPS �  Motivo da Alteracao 		 	 	       ���
������������������������������������������������������������������������������Ĵ��
���Tania     	�20/09/2006�100265�Acertos para o Relatorio personalizavel, do ���
���          	�          �      �Release 4. Inclusao do Ajusta SX1.          ���
���Eduardo Ju  	�23/01/2007�120221�Correcao do Filtro do Periodo.              ���
���Eduardo Ju  	�05/04/2007�122629�Validacao do cAliasQry.                     ���
���Eduardo Ju  	�29/06/2007�113644�Totalizacao por Curso na Quebra por CC.     ���
���Eduardo Ju  	�13/07/2007�124525�Implementacao do Log de Inconsistencias.    ���
�������������������������������������������������������������������������������ٱ�
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������*/
User Function TRM030()

Local oReport
Local aArea := GetArea()

If FindFunction("TRepInUse") .And. TRepInUse()	//Verifica se relatorio personalizal esta disponivel
	//������������������������������������������Ŀ
	//� Ajusta SX1 para trabalhar com range.     �
	//��������������������������������������������
	AjustaTR030RSx1()
	Pergunte("TR030R",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()	
Else
	U_TRM030R3()	
EndIf  

RestArea( aArea )

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ReportDef() � Autor � Eduardo Ju          � Data � 30.05.06 ���
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
Local aOrdem    := {}
Local cAliasQry := "" 
Local lRet:= .T.     

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//��������������������������������������������������������������������������
oReport:=TReport():New("TRM030",STR0009,"TR030R",{|oReport| PrintReport(oReport,cAliasQry)},STR0002+" "+STR0003)	//"Custo de Treinamento"#"Ser� impresso de acordo com os parametros solicitados pelo usuario"
//oReport:SetLandscape()	//Imprimir Somente Paisagem
oReport:SetTotalInLine(.F.) //Totaliza em linha
Pergunte("TR030R",.F.)

Aadd( aOrdem, STR0004)	// "Matricula"
Aadd( aOrdem, STR0005)	// "Centro de Custo"
Aadd( aOrdem, STR0006)	// "Nome" 
Aadd( aOrdem, STR0016) 	// "Data"

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
//���������������������������Ŀ
//� Criacao da Primeira Secao:�
//����������������������������� 
oSection1 := TRSection():New(oReport,STR0041,{"RA4","RA1","RA2","RA9","RA0","RA7"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection1:SetTotalInLine(.F.) 

TRCell():New(oSection1,"RA4_CURSO","RA4",STR0031)		//Codigo do Curso    
TRCell():New(oSection1,"RA1_DESC","RA1","")			//Descricao do Curso
TRCell():New(oSection1,"RA4_SINONI","RA4",STR0032)		//Codigo do Sinonimo do Curso    
TRCell():New(oSection1,"RA9_DESCR","RA9","")			//Descricao do Sinonimo do Curso
TRCell():New(oSection1,"RA4_CALEND","RA4")				//Codigo do Calendario de Treinamento    
TRCell():New(oSection1,"RA2_DESC","RA2","")			//Descricao do Calendario de Treinamento    
TRCell():New(oSection1,"RA4_TURMA","RA4")				//Turma     
TRCell():New(oSection1,"RA4_DATAIN","RA4",STR0033)		//Periodo: Data Inicio do Curso
TRCell():New(oSection1,"RA4_DATAFI","RA4","",,,,,,,,.T.)		//Periodo: Data Final do Curso 
TRCell():New(oSection1,"RA4_ENTIDA","RA4",STR0034) 	//Codigo da Entidade do Curso 	
TRCell():New(oSection1,"RA0_DESC","RA0","")			//Descricao da Entidade do Curso 	
TRCell():New(oSection1,"RA2_INSTRU","RA2") 				//Codigo do Instrutor
TRCell():New(oSection1,"RA7_NOME","RA7")				//Nome do Instrutor
TRCell():New(oSection1,"RA4_HORAS","RA4")				//Horario
TRCell():New(oSection1,"RA2_DURACA","RA2")				//Duracao
TRCell():New(oSection1,"RA2_UNDURA","RA2","")			//Unidade de Duracao
TRCell():New(oSection1,"RA2_LOCAL","RA2")				//Local
oSection1:SetLineStyle()                                      

//���������������������������Ŀ
//� Criacao da Segunda Secao: �
//�����������������������������
oSection2 := TRSection():New(oSection1,STR0042,{"RA4","SRA"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)
oSection2:SetTotalInLine(.F.)

TRCell():New(oSection2,"RA4_MAT","RA4",STR0035)		//Matricula do Funcionario
TRCell():New(oSection2,"RA_NOME","SRA",STR0036)		//Nome do Funcionario
TRCell():New(oSection2,"RA4_VALOR","RA4",STR0037)		//Custo
TRCell():New(oSection2,"RA4_HORAS","RA4",STR0038)		//Horas 
TRCell():New(oSection2,"RA4_PRESEN","RA4",STR0039)		//Percentual de Presen�a
TRCell():New(oSection2,"RA4_NOTA","RA4",STR0040)		//Nota

TRFunction():New(oSection2:Cell("RA4_MAT"),/*cId*/,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oSection2:Cell("RA4_VALOR"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oSection2:Cell("RA4_HORAS" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)

oSection2:SetTotalText({|| Alltrim(STR0029)}) //Total 

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
Static Function PrintReport(oReport,cAliasQry)

Local cFil 		:= ""
Local cMat 		:= ""
Local cCc  		:= ""
Local cNom 		:= ""
Local cCur 		:= ""
Local cGru 		:= ""
Local cDep 		:= ""
Local cCar 		:= "" 
Local dPer		:= ""
Local cRel		:= ""
Local cSituacao := ""
Local nFerProg  := ""
Local cSitFol   := "" 
Local cOrder:= ""
Local nOrdem  	:= 	oReport:Section(1):GetOrder()

#IFNDEF TOP
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(1):Section(1)
	Local cArqDBF  	:= CriaTrab(NIL,.f.)
	Local aFields 	:= {}
	Local cAcessaRA4:= &("{ || " + ChkRH("TRM030","RA4","2") + "}")  
	Local cFiltro	:= ""
	Local cChave1	:= ""
	Local cChave2	:= ""                  
	Local cMainTitle:= ""
	Local cTitle1 	:= ""
	Local aLogCargo	:= {}    
	Local aLogTitle	:= {}
	Local lExcLogCargo:= .F.               
#ELSE
	Local lQuery    := .F. 
	Local i := 0
	Local cSitQuery := ""
#ENDIF	

#IFNDEF TOP
	//-- Transforma parametros Range em expressao (intervalo)
	MakeAdvplExpr("TR030R")	   
	cAliasQry := "SRA" 
#ELSE	
	//-- Transforma parametros Range em expressao SQL
	MakeSqlExpr("TR030R")
	cAliasQry := GetNextAlias()
#ENDIF

//+--------------------------------------------------------------+
//� Carregando variaveis mv_par?? para Variaveis do Sistema.     �
//+--------------------------------------------------------------+
cFil 		:= mv_par01
cMat 		:= mv_par02
cCc  		:= mv_par03
cNom 		:= mv_par04
cCur 		:= mv_par05
cGru 		:= mv_par06
cDep 		:= mv_par07
cCar 		:= mv_par08
dPer		:= mv_par09
cRel		:= mv_par10
cSituacao 	:= mv_par11
nFerProg  	:= mv_par12

#IFNDEF TOP
	//-- Transforma parametros Range em expressao (intervalo)
	If nOrdem == 1 		// Matricula 
		cOrder  := "TR_FILIAL + TR_CURSO + TR_CALEND + TR_TURMA + TR_MAT"
		cChave1 := "cFilRA4 + cCurso + cCalend + cTurma"
		cChave2 := "TR_FILIAL + TR_CURSO + TR_CALEND + TR_TURMA"
	ElseIf nOrdem == 2	// Centro de Custo + Matricula
		cOrder  := "TR_FILIAL + TR_CC + TR_CURSO + TR_CALEND + TR_TURMA + TR_MAT"
		cChave1 := "cFilRA4 + cCentro + cCurso + cCalend + cTurma"
		cChave2 := "TR_FILIAL + TR_CC + TR_CURSO + TR_CALEND + TR_TURMA"
	ElseIf nOrdem == 3	// Nome	
		cOrder  := "TR_FILIAL + TR_CURSO + TR_CALEND + TR_TURMA + TR_NOME"
		cChave1 := "cFilRA4 + cCurso + cCalend + cTurma"
		cChave2 := "TR_FILIAL + TR_CURSO + TR_CALEND + TR_TURMA"
	ElseIf nOrdem == 4	// Data
		cOrder  := "TR_FILIAL + DTOS(TR_DATAIN) + TR_CURSO + TR_CALEND + TR_TURMA + TR_MAT"	
		cChave1 := "cFilRA4 + cDatain + Curso + cCalend + cTurma"
		cChave2 := "TR_FILIAL + DTOS(TR_DATAIN) + TR_CURSO + TR_CALEND + TR_TURMA"
	EndIf	

	If !Empty(cFil)
		cFiltro:= cFil
	EndIf  
	
	If !Empty(cMat)
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cMat
	EndIf  
	       
	If !Empty(cCur)
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cCur
	EndIf  
	
	If !Empty(dPer)
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += dPer
	EndIf 
	
	//Define um filtro para a tabela principal da secao
	oSection2:SetFilter(cFiltro)
	
	If !Empty(cCc)		//SRA
		cFiltro := cCc
	EndIf  
	       
	If !Empty(cNom)		//SRA
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cNom
	EndIf  
	       
	//Define um filtro para a tabela principal da secao
	oSection2:SetFilter(cFiltro,,,"SRA")

	AADD(aFields,{"TR_FILIAL" ,"C",02,0})
	AADD(aFields,{"TR_CC"     ,"C",09,0})
	AADD(aFields,{"TR_MAT"    ,"C",06,0})
	AADD(aFields,{"TR_NOME"   ,"C",30,0})
	AADD(aFields,{"TR_CURSO"  ,"C",04,0})
	AADD(aFields,{"TR_DESCURS","C",30,0})
	AADD(aFields,{"TR_GRUPO"  ,"C",02,0})
	AADD(aFields,{"TR_DEPTO"  ,"C",03,0})
	AADD(aFields,{"TR_CARGO"  ,"C",05,0})
	AADD(aFields,{"TR_CUSTO"  ,"N",12,2})
	AADD(aFields,{"TR_PRESEN" ,"N",06,2})
	AADD(aFields,{"TR_NOTA"   ,"N",06,2})
	AADD(aFields,{"TR_HORAS"  ,"N",07,2})
	AADD(aFields,{"TR_DATAIN" ,"D",08,0})
	AADD(aFields,{"TR_DATAFI" ,"D",08,0})
	AADD(aFields,{"TR_CALEND" ,"C",04,0})
	AADD(aFields,{"TR_DESCCAL","C",20,0})
	AADD(aFields,{"TR_TURMA"  ,"C",03,0})
	AADD(aFields,{"TR_ENTIDA" ,"C",04,0})
	AADD(aFields,{"TR_DESCEN" ,"C",15,0})
	AADD(aFields,{"TR_HORARI" ,"C",15,0})
	AADD(aFields,{"TR_DURACA" ,"C",07,0})
	AADD(aFields,{"TR_UNDURA" ,"C",01,0})
	AADD(aFields,{"TR_INSTRU" ,"C",06,0})
	AADD(aFields,{"TR_NOMEIN" ,"C",15,0})
	AADD(aFields,{"TR_LOCAL"  ,"C",15,0})
	AADD(aFields,{"TR_SINON"  ,"C",04,0})
	AADD(aFields,{"TR_DESCSI" ,"C",30,0})
	
	dbCreate(cArqDbf,aFields)
	dbUseArea(.T.,,cArqDbf,"TRA",.F.)
	
	cArqNtx  := CriaTrab(NIL,.f.)
	IndRegua("TRA",cArqNtx,cOrder,,,STR0012) //"Selecionando Registros..."
	dbGoTop()
	
	//������������������������������������������Ŀ
	//� Arquivo Principal: Cursos do Funcionario �
	//��������������������������������������������
	dbSelectArea("RA4")	
	oReport:SetMeter(RecCount())
	
	While !Eof()
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
			 
		If !Eval(cAcessaRA4)
			dbSkip()
			Loop
		EndIf
	   
		//��������������������������������������������������������Ŀ
		//� 			Calendario de Treinamento    			   �
		//����������������������������������������������������������
		dbSelectArea("RA2")
		dbSeek(xFilial("RA2")+RA4->RA4_CALEND+RA4->RA4_CURSO+RA4->RA4_TURMA)
		
		dbSelectArea("SRA")
		dbSetOrder(1)
		
		If dbSeek(RA4->RA4_FILIAL+RA4->RA4_MAT)		
			//��������������������������Ŀ
			//� Situacao do Funcionario  �
			//����������������������������
			cSitFol := TrmSitFol()  
			cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)		
			
			//��������������������������������������������������Ŀ
			//� Alimenta array com os registros que n�o ha cargo �
			//���������������������������������������������������� 
			If Empty(cCargo)
				aAdd( aLogCargo,SRA->RA_FILIAL + Space(05) + SRA->RA_MAT + Space(04) + SRA->RA_NOME + Space(01) + RA4->RA4_CALEND + Space(07) + RA4->RA4_CURSO) 
			EndIf
				
			If	!Empty(cCc) 
				If &("!(SRA->" + cCc + ")")
					dbSelectArea("RA4")
					dbSkip()
					Loop
				EndIf
			EndIf			

			If	!Empty(cNom)
				If &("!(SRA->" + cNom + ")")
					dbSelectArea("RA4")
					dbSkip()
					Loop
				EndIf
			EndIf			

			If	(!(cSitfol $ cSituacao) .And. (cSitFol <> "P")) .Or.;
				(cSitfol == "P" .And. nFerProg == 2)
				dbSelectArea("RA4")
				dbSkip()
				Loop
			EndIf			
	
			//����������������������������������������Ŀ
			//�Cargo, Grupo e Departamento		 	   �
			//������������������������������������������  				
			dbSelectArea( "SQ3" )
			dbSetOrder(1)
			cFil := If(xFilial("SQ3") == Space(2),Space(2),SRA->RA_FILIAL)
			If dbSeek( cFil + cCargo + SRA->RA_CC ) .Or. dbSeek( cFil + cCargo ) 			
				If !Empty(cGru)
					If &("!" + cGru)
						dbSelectArea("RA4")
						dbSkip()
						Loop
					EndIf
				EndIf

				If !Empty(cDep)
					If &("!" + cDep)
						dbSelectArea("RA4")
						dbSkip()
						Loop
					EndIf
				EndIf

				If !Empty(cCar)
					If &("!" + cCar)
						dbSelectArea("RA4")
						dbSkip()
						Loop
					EndIf
				EndIf
			Else	
				dbSelectArea("RA4")
				dbSkip()
				Loop	
			EndIf
					
			RecLock("TRA",.T.)
			TRA->TR_FILIAL  	:= SRA->RA_FILIAL
			TRA->TR_CC      	:= SRA->RA_CC
			TRA->TR_MAT     	:= SRA->RA_MAT
			TRA->TR_NOME		:= SRA->RA_NOME
			TRA->TR_CURSO	 	:= RA4->RA4_CURSO
			TRA->TR_GRUPO   	:= SQ3->Q3_GRUPO
			TRA->TR_DEPTO   	:= SQ3->Q3_DEPTO
			TRA->TR_CARGO   	:= SQ3->Q3_CARGO
			TRA->TR_CUSTO	 	:= RA4->RA4_VALOR
			TRA->TR_PRESEN  	:= RA4->RA4_PRESEN
			TRA->TR_NOTA		:= RA4->RA4_NOTA
			TRA->TR_HORAS   	:= RA4->RA4_HORAS
			TRA->TR_DATAIN		:= RA4->RA4_DATAIN
			TRA->TR_DATAFI		:= RA4->RA4_DATAFI
			TRA->TR_CALEND		:= RA4->RA4_CALEND
			TRA->TR_TURMA		:= RA4->RA4_TURMA
			TRA->TR_ENTIDA		:= RA4->RA4_ENTIDA
			TRA->TR_HORARI		:= RA2->RA2_HORARI
			TRA->TR_DURACA		:= STR(RA2->RA2_DURACA,7,2)
			TRA->TR_UNDURA		:= RA2->RA2_UNDURA
			TRA->TR_INSTRU		:= RA2->RA2_INSTRU
			TRA->TR_LOCAL		:= RA2->RA2_LOCAL
			TRA->TR_SINON		:= RA4->RA4_SINONI
			MsUnlock()
		EndIf		
	
	   	dbSelectArea("RA4")
	   	dbSkip()
	EndDo
	
	dbSelectArea("TRA")
	dbGotop()	
	
	TRPosition():New(oSection1,"RA4",1,{|| RhFilial("RA4",TRA->TR_FILIAL) + TRA->TR_CALEND+TRA->TR_CURSO+TRA->TR_TURMA})
	TRPosition():New(oSection1,"RA4",3,{|| RhFilial("RA4",TRA->TR_FILIAL) + TRA->TR_CALEND+TRA->TR_CURSO+TRA->TR_TURMA}) 
	TRPosition():New(oSection1,"RA1",1,{||	RhFilial("RA1",TRA->TR_FILIAL) + TRA->TR_CURSO}) 
	TRPosition():New(oSection1,"RA2",1,{|| RhFilial("RA2",TRA->TR_FILIAL) + TRA->TR_CALEND+TRA->TR_CURSO+TRA->TR_TURMA})                            
	TRPosition():New(oSection1,"RA9",1,{|| RhFilial("RA9",TRA->TR_FILIAL) + TRA->TR_SINON}) 
	TRPosition():New(oSection1,"RA0",1,{|| RhFilial("RA0",TRA->TR_FILIAL) + TRA->TR_ENTIDA}) 
	TRPosition():New(oSection1,"RA7",1,{|| RhFilial("RA7",TRA->TR_FILIAL) + TRA->TR_INSTRU})
	
	TRPosition():New(oSection2,"RA4",3,{|| RhFilial("RA4",TRA->TR_FILIAL) + TRA->TR_CALEND+TRA->TR_CURSO+TRA->TR_TURMA+TRA->TR_MAT})
	TRPosition():New(oSection2,"SRA",1,{|| RhFilial("SRA",TRA->TR_FILIAL) + TRA->TR_MAT}) 
	
	If	cRel == 1	// Sintetico
	   	oSection2:Hide()
	   	oSection2:SetTotalInLine(.T.) 
	EndIf
	
	While TRA->( !Eof() ) 
	
		oReport:IncMeter()
	
		If oReport:Cancel()
			Exit
		EndIf
	   
		cFilRA4	:= TRA->TR_FILIAL	
		cCurso 	:= TRA->TR_CURSO 
	    cCalend := TRA->TR_CALEND
	    cTurma	:= TRA->TR_TURMA
	    cCentro := TRA->TR_CC
		cDataIn	:= dTos(TRA->TR_DATAIN)
		
		//������������������������������������Ŀ
		//� Impressao da Primeira Secao: Curso �
		//��������������������������������������
		oSection1:Init()
		oSection1:PrintLine()
				
		oSection2:Init()
		
		Do While ! Eof() .And. &cChave1 == &cChave2
			//������������������������������������������Ŀ
			//� Impressao da Segunda Secao: Funcionarios �
			//�������������������������������������������� 
			oSection2:PrintLine()  
			dbSelectArea("TRA")
			dbSkip()
		EndDo
	
		oSection2:Finish()
		oSection1:Finish()
	EndDo

	//��������������������������������������������������������������������Ŀ
	//� Gera Arquivo Log com as Inconsistencias no vinculo Funcao x Cargo  �
	//����������������������������������������������������������������������
	If ( lExcLogCargo := !Empty(aLogCargo) ) 
	
		cMainTitle 	:= STR0046			//"Inconsist�ncias na fun��o ou cargo"
		cTitle1		:= Upper(STR0047)	//"Filial Matricula Funcionario                    Calendario Curso"   
	   
	  	aAdd(aLogTitle,cTitle1)
	
		If ( lExcLogCargo := MsgNoYes(STR0048, STR0001 + " - " + cMainTitle ) )	//"Foram encontradas inconsist�ncias no v�nculo Fun��o x Cargo. Deseja gerar Log?"
			FMakeLog( { aLogCargo } , aLogTitle , , NIL , NIL , STR0001 + Space(01)+ "("+ cMainTitle+")","M","P",,.F. )			
		EndIf	                            
		
	EndIf
	
	//��������������������������������������������������������������Ŀ
	//� Termino do Relatorio                                         �
	//����������������������������������������������������������������
	dbSelectArea("TRA")
	dbCloseArea()
	fErase(cArqNtx + OrdBagExt())
	fErase(cArqDbf + GetDBExtension())

#ELSE	
	//-- Filtragem do relat�rio
	//-- Query do relat�rio da secao 1
	lQuery := .T.
	oReport:Section(1):BeginQuery()	
	
	If nOrdem == 1 		// Matricula 
		cOrder := "%RA4_FILIAL,RA4_CURSO,RA4_CALEND,RA4_TURMA,RA4_MAT%"
	ElseIf nOrdem == 2	// Centro de Custo + Matricula
		cOrder := "%RA4_FILIAL,RA_CC,RA4_CURSO,RA4_CALEND,RA4_TURMA,RA4_MAT%"
	ElseIf nOrdem == 3	// Nome	
		cOrder := "%RA4_FILIAL,RA4_CURSO,RA4_CALEND,RA4_TURMA,RA_NOME%"
	ElseIf nOrdem == 4	// Data
		cOrder := "%RA4_FILIAL,RA4_DATAIN,RA4_CURSO,RA4_CALEND,RA4_TURMA,RA4_MAT%"	
	EndIf
    
	//��������������������������������������������������������������Ŀ
	//� Tratamento da Filial para Ambiente Top                       �
	//����������������������������������������������������������������
	cFilRA1 := If ( RA1->(xFilial()) == "  " , "%AND RA1.RA1_FILIAL = '  '%","%AND RA1.RA1_FILIAL = RA4.RA4_FILIAL%")
	cFilRA2 := If ( RA2->(xFilial()) == "  " , "%AND RA2.RA2_FILIAL = '  '%","%AND RA2.RA2_FILIAL = RA4.RA4_FILIAL%")
	cFilRA9 := If ( RA9->(xFilial()) == "  " , "%AND RA9.RA9_FILIAL = '  '%","%AND RA9.RA9_FILIAL = RA4.RA4_FILIAL%")
	cFilRA0	:= If ( RA0->(xFilial()) == "  " , "%AND RA0.RA0_FILIAL = '  '%","%AND RA0.RA0_FILIAL = RA4.RA4_FILIAL%")
	cFilRA7	:= If ( RA7->(xFilial()) == "  " , "%AND RA7.RA7_FILIAL = '  '%","%AND RA7.RA7_FILIAL = RA2.RA2_FILIAL%")
	cFilSRA	:= If ( SRA->(xFilial()) == "  " , "%AND SRA.RA_FILIAL  = '  '%","%AND SRA.RA_FILIAL = RA4.RA4_FILIAL%")
	cFilSQ3	:= If ( SQ3->(xFilial()) == "  " , "%AND SQ3.Q3_FILIAL  = '  '%","%AND SQ3.Q3_FILIAL = SRA.RA_FILIAL%")

	BeginSql Alias cAliasQry
		SELECT 	RA4_CURSO,RA1_DESC,RA4_SINONI,RA9_DESCR,RA4_CALEND,RA2_DESC,RA4_TURMA,RA4_DATAIN,RA4_DATAFI,
				RA4_ENTIDA,RA0_DESC,RA2_INSTRU,RA7_NOME,RA4_HORAS,RA2_DURACA,RA2_UNDURA,RA2_LOCAL,RA4_VALOR,
				RA4_HORAS,RA4_PRESEN,RA4_NOTA,RA4_MAT,RA_NOME,Q3_GRUPO,Q3_DEPTO,Q3_CARGO,RA_SITFOLH, RA_FILIAL,
				RA_MAT, RA_ADMISSA, RA_DEMISSA				 
		FROM 	%table:RA4% RA4          
		LEFT JOIN %table:RA1% RA1
			ON RA1_CURSO = RA4_CURSO
			AND RA1.%NotDel%
			%exp:cFilRA1%
		LEFT JOIN %table:RA2% RA2
			ON 	RA2_CALEND = RA4_CALEND
			AND RA2_CURSO = RA4_CURSO
			AND RA2_TURMA = RA4_TURMA
			AND RA2.%NotDel%
			%exp:cFilRA2%
		LEFT JOIN %table:RA9% RA9
			ON RA9_SINONI   = RA4_SINONI
			AND RA9.%NotDel%
			%exp:cFilRA9%
		LEFT JOIN %table:RA0% RA0
			ON RA0_ENTIDA = RA4_ENTIDA
			AND RA0.%NotDel%  
			%exp:cFilRA0%		
		LEFT JOIN %table:RA7% RA7
			ON  RA7_INSTRU = RA2_INSTRU
			AND RA7.%NotDel%  
			%exp:cFilRA7%
		LEFT JOIN %table:SRA% SRA
			ON RA_MAT = RA4_MAT
			AND SRA.%NotDel%  
			%exp:cFilSRA%
		LEFT JOIN %table:SQ3% SQ3
			ON Q3_CARGO = RA_CARGO
			AND SQ3.%NotDel%			 								
			%exp:cFilSQ3%
		WHERE RA4.%NotDel%							
		ORDER BY %Exp:cOrder%                 		
	EndSql
	
	//������������������������������������������������������������������������Ŀ
	//�Metodo EndQuery ( Classe TRSection )                                    �
	//�Prepara o relat�rio para executar o Embedded SQL.                       �
	//�ExpA1 : Array com os parametros do tipo Range                           �
	//��������������������������������������������������������������������������
	oReport:Section(1):EndQuery({cFil,cMat,cCc,cNom,cCur,cGru,cDep,cCar,dPer})	//*Array com os parametros do tipo Range*
	
	//-- Inicio da impressao do fluxo do relat�rio
	oReport:SetMeter(RA4->(LastRec()))

	//-- Utiliza a query do Pai
	oReport:Section(1):Section(1):SetParentQuery()
	oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasQry)->RA4_CALEND + (cAliasQry)->RA4_CURSO + (cAliasQry)->RA4_TURMA  == cParam },{ || (cAliasQry)->RA4_CALEND + (cAliasQry)->RA4_CURSO + (cAliasQry)->RA4_TURMA })
		
	//�������������������������������������������������Ŀ
	//�Impressao do Relatorio Sintetico ou Analitico    �
	//���������������������������������������������������
	If	cRel == 1	// Sintetico
	   	oReport:Section(1):Section(1):Hide()
	   	oReport:Section(1):Section(1):SetTotalInLine(.T.)
	EndIf
	
	//�������������������������Ŀ
	//� Situacao do Funcionario �
	//���������������������������	
	For i:= 1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,i,1)+"'"
		If ( i+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		Endif
	Next i     
	If nFerProg = 1
		cSitQuery += ",'P'" 
	EndIf

	oReport:Section(1):Section(1):SetLineCondition({|| TrmSitFol() $ cSitQuery})
	oReport:Section(1):Print()	 	
#ENDIF	
	
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AjustaTR030RSx1� Autor � Tania Bronzeri   � Data �20/09/2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta SX1 para Trabalhar com Range                        ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � A partir do Release 4                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Function AjustaTR030RSx1()

Local aRegs		:= {}
Local aHelp		:= {}
Local aHelpE	:= {}
Local aHelpI	:= {}   
Local cHelp		:= ""

aHelp := {	"Informe intervalo de filiais que ",;
			"deseja considerar para impressao ",;
			"do relatorio." }
aHelpE:= {	"Informe intervalo de filiais que ",;
			"desea considerar para impresion ",;
			"del informe" }
aHelpI:= {	"Enter branch range to be considered ",;
			"to print report." }
cHelp := ".RHFILIAL."
PutSX1Help("P"+cHelp,aHelp,aHelpI,aHelpE)	 
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues   Pergunta Espanhol    Pergunta Ingles   Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01 DefSPA1  DefEng1 Cnt01        Var02  Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg  cPyme aHelpPor aHelpEng aHelpSpa cHelp   �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","01","Filial ?"           ,"�Sucursal ?"       ,"Branch ?"       ,"MV_CH1","C" ,99      ,0     ,0     ,"R"  ,""     ,"MV_PAR01",""    ,""      ,""    ,"RA4_FILIAL",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"XM0",""    ,"S"  ,""      ,""     ,""      ,cHelp}) 


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
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem  Pergunta Portugues  Pergunta Espanhol    Pergunta Ingles  Variavel  Tipo  Tamanho Decimal Presel GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02  Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05 XF3  GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp  �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","02","Matricula ?"       ,"�Matricula ?"     ,"Registration ?","MV_CH2" ,"C"  ,99     ,0      ,0     ,"R" ,""     ,"MV_PAR02",""    ,""      ,""     ,"RA4_MAT",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""  ,"SRA",""    ,"S"  ,""     ,""       ,""     ,cHelp})


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
/*
�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol   Pergunta Ingles  Variavel Tipo Tamanho  Decimal Presel GSC   Valid   Var01      Def01 DefSPA1  DefEng1  Cnt01   Var02  Def02  DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05 XF3  GrgSxg  cPyme aHelpPor aHelpEng aHelpSpa cHelp   �
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","03","Centro de Custo ?","�Centro de Costo ?","Cost Center ?" ,"MV_CH3","C" ,99      ,0      ,0     ,"R"  ,""     ,"MV_PAR03",""    ,""      ,""    ,"RA_CC",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"CTT","004"  ,"S"  ,""      ,""      ,""     ,cHelp})


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
/*
����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol  Pergunta Ingles  Variavel  Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1  Cnt01    Var02  Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3     GrgSxg  cPyme aHelpPor aHelpEng  aHelpSpa cHelp  �
������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","04" ,"Nome ?"           ,"�Nombre ?"       ,"Name ?"        ,"MV_CH4" ,"C"  ,99      ,0     ,0     ,"R"  ,""     ,"MV_PAR04",""    ,""      ,""     ,"RA_NOME",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""  ,"SRA01",""    ,"S"  ,""     ,""      ,""      ,cHelp})


aHelp := {	"Informe intervalo de Cursos que deseja ",;
			"considerar para impressao do relatorio. " }
aHelpE:= {	"Informe intervalo de Cursos que desea ",;
			"considerar para impresion del informe. " }
aHelpI:= {	"Enter range of Courses to be considered ",;
			"for printing the report." }
cHelp := ".TR030R05."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel  Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01       Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp   �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","05" ,"Curso ?"          ,"�Curso ?"       ,"Course ?"     ,"MV_CH5" ,"C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR05",""    ,""      ,""     ,"RA4_CURSO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"RA1",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Grupos que deseja ",;
			"considerar para impressao do relatorio. " }
aHelpE:= {	"Informe intervalo de Grupos que desea ",;
			"considerar para impresion del informe. " }
aHelpI:= {	"Enter range of Groups to be considered ",;
			"for printing the report." }
cHelp := ".TR030R06."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","06" ,"Grupo ?"          ,"�Grupo ?"       ,"Group ?"      ,"MV_CH6","C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR06",""    ,""      ,""     ,"Q3_GRUPO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"SQ0",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Departamentos ",;
			"que deseja considerar para impressao ",;
			"do relatorio. " }
aHelpE:= {	"Informe intervalo de Sectores que desea ",;
			"considerar para impresion del informe. " }
aHelpI:= {	"Enter range of Department to be ",;
			"considered for printing the report." }
cHelp := ".TR030R07."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","07" ,"Departamento ?"   ,"�Sector ?"      ,"Department ?" ,"MV_CH7","C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR07",""    ,""      ,""     ,"Q3_DEPTO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"SQB",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Cargos que ",;
			"deseja considerar para impressao ",;
			"do relatorio. " }
aHelpE:= {	"Informe intervalo de Funciones que ",;
			"desea considerar para impresion del ",;
			"informe. " }
aHelpI:= {	"Enter range of Jobs to be considered ",;
			"for printing the report." }
cHelp := ".TR030R08."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","08" ,"Cargo ?"          ,"�Funcion ?"      ,"Job ?"       ,"MV_CH8","C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR08",""    ,""      ,""     ,"Q3_CARGO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"SQ3",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Periodos que ",;
			"deseja considerar para impressao do ",;
			"relatorio. Exemplo: 01/04/06-31/08/06." }
aHelpE:= {	"Informe intervalo de periodos que ",;
			"desea considerar para impresion del ",;
			"informe. Ejemplo: 01/04/06-31/08/06." }
aHelpI:= {	"Enter range of Periods to be considered ",;
			"for printing the report. Example: ",;
			"01/04/06-31/08/06." }
cHelp := ".TR030R09."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem  Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC Valid        Var01      Def01       DefSPA1     DefEng1      Cnt01        Var02 Def02        DefSpa2     DefEng2    Cnt02 Var03 Def03  DefSpa3 DefEng3 Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04 Var05 Def05 DefSpa5 DefEng5 Cnt05  XF3 GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","09","Periodo ?"        ,"�Periodo ?"     ,"Period ?"     ,"MV_CH9","D" ,99     ,0      ,0     ,"R",""           ,"MV_PAR09",""         ,""         ,""          ,"RA4_DATAIN",""   ,""         ,""         ,""        ,""   ,""   ,""    ,""     ,""     ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,aHelp   ,aHelpI  ,aHelpE  ,cHelp      })
Aadd(aRegs,{"TR030R","10","Relatorio ?"      ,"�Informe ?"     ,"Report ?"     ,"MV_CHA","N" ,1      ,0      ,2     ,"C","NaoVazio()" ,"MV_PAR10","Sintetico","Sintetico","Summarized",""          ,""   ,"Analitico","Analitico","Detailed",""   ,""   ,""    ,""     ,""     ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,""      ,""      ,""      ,".RHTPREL."})
Aadd(aRegs,{"TR030R","11","Situacoes ?"      ,"�Situaciones ?" ,"Status ?"     ,"MV_CHB","C" ,5      ,0      ,0     ,"G","fSituacao()","MV_PAR11",""         ,""         ,""          ,""          ,""   ,""         ,""         ,""        ,""   ,""   ,""    ,""     ,""     ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,""      ,""      ,""      ,".RHSITUA."})


aHelp := {	"Informe se deseja considerar Ferias ",;
			"Programadas." }
aHelpE:= {	"Informe si desea considerar ",;
			"Vacaciones Programadas." }
aHelpI:= {	"Inform if you want to consider ",;
			"Scheduled Vacation. " }
cHelp := ".TR030R12."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues     Pergunta Espanhol           Pergunta Ingles        Variavel Tipo Tamanho Decimal Presel GSC Valid          Var01      Def01 DefSPA1 DefEng1 Cnt01 Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03 DefSpa3 DefEng3 Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04 Var05 Def05 DefSpa5 DefEng5 Cnt05  XF3 GrgSxg cPyme aHelpPor aHelpEng aHelpSpa cHelp         �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR030R","12" ,"Ferias Programadas ?","�Vacaciones Programadas ?","Scheduled Vacation?" ,"MV_CHC","N" ,1      ,0      ,1     ,"C","NaoVazio()" ,"MV_PAR12","Sim","Si"   ,"Yes"  ,""   ,""   ,"Nao","No"   ,"No"   ,""   ,""   ,""  ,""     ,""     ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,aHelp   ,aHelpI  ,aHelpE  ,cHelp})


ValidPerg(aRegs,"TR030R",.T.)
                    
/*
PROGRAMA FONTE ORIGINAL ABAIXO
*/

User Function TRM030R3()	

SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,AORD,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,LEND,COLUNAS")
SetPrvt("AT_PRG,WCABEC0,WCABEC1,CCABEC1,CONTFL,LI,NPAG")
SetPrvt("NTAMANHO,CTIT,AREGS,TITULO,WNREL,NORDEM")
SetPrvt("CARQDBF,AFIELDS,CINDCOND,CARQNTX,CINICIO,CFIM")
SetPrvt("CFIL,NTOTQT,NTOTVALOR,NTOTHORAS,NTOTGVL,NTOTGQT,NTOTGHR,NTOTFUNC,NTOTCURSO,NQTDECURSO")
SetPrvt("NCUSTO,NHORAS,NPRESENC,NNOTA,CAUXCURSO,CAUXTURMA,LRET")
SetPrvt("NTIPO,CCENTRO,CCURSO,CCALEND,CTURMA,CDESCCUR,CDescCal,CAUXDET,DET,LIMP")
SetPrvt("CENTIDA,CDESCEN,CHORARI,CDURACA,CUNDURA,CINSTRU,CNOMEIN,CLOCAL")
SetPrvt("cAcessaRA4,CSINON,CDESCSI,CCARGO,aLogCargo,aLogTitle,cMainTitle,cTitle1")

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � TRM030   � Autor � Cristina Ogura        � Data � 16.03.99 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Custo do Treinamentos                                      ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � TRM030                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RdMake                                                     ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���			   �		�	   �										  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
cDesc1  := STR0001 //"Custo Treinamento"
cDesc2  := STR0002 //"Ser� impresso de acordo com os parametros solicitados pelo"
cDesc3  := STR0003 //"usu�rio."
cString := "SRA"  			             	//-- alias do arquivo principal (Base)
aOrd    := { STR0004,STR0005,STR0006,STR0016 } 	//"Matricula"###"Centro de Custo"###"Nome"###"Data"

//��������������������������������������������������������������Ŀ
//� Define Variaveis (Basicas)                                   �
//����������������������������������������������������������������
aReturn  := { STR0007,1,STR0008,2,2,1,"",1 } //"Zebrado"###"Administra��o"
NomeProg := "TRM030"
aLinha   := {}
nLastKey := 0
cPerg    := "TRR050"
lEnd     := .F.

//��������������������������������������������������������������Ŀ
//� Define Variaveis (Programa)                                  �
//����������������������������������������������������������������
Colunas	:= 132
at_Prg  := "TRM030"
wCabec0 := 0
wCabec1 := ""
Contfl  := 1
Li      := 0
nPag    := 0
nTamanho:= "M"
cTit    := STR0009 //"Custo do Treinamento"
aRegs	:= {}

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
pergunte("TRR050",.F.)

Titulo   := STR0010 + DtoC(mv_par17) + STR0011 + DtoC(mv_par18)  //"Custo do Treinamento     Periodo:"###" a "

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
//� mv_par17        //  Periodo De                               �
//� mv_par18        //  Periodo Ate                              �
//� mv_par19        //  Relatorio 1-Sintetico 2-Analitico        �
//� mv_par20        //  Status Funcionario                       �
//� mv_par21        //  Ferias Programadas                       �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
WnRel := "TRM030"	//-- Nome Default do relatorio em Disco.
WnRel := SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd)
If nLastKey == 27
   Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
   Return
Endif
RptStatus({|lEnd| Relato()},cTit)// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==> RptStatus({|lEnd| Execute(Relato)},cTit)
Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � Relato   � Autor � Equipe R.H.	        � Data � 16.03.99 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Rotina Principal do Relatorio.							  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � Relato()	                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Rdmake	                                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function Relato()

nOrdem  	:= aReturn[8]
cArqDBF  	:= CriaTrab(NIL,.f.)
aFields 	:= {}
lImp		:= .F.
Titulo   	:= STR0010 + DtoC(mv_par17) + STR0011 + DtoC(mv_par18)  //"Custo do Treinamento     Periodo:"###" a "
cAcessaRA4	:= &("{ || " + ChkRH("TRM030","RA4","2") + "}")
cSituacao 	:= mv_par20
nFerProg  	:= mv_par21
cSitFol   	:= ""
aLogCargo	:= {}    
aLogTitle	:= {}
lExcLogCargo:= .F.
cMainTitle	:= ""
cTitle1 	:= ""

AADD(aFields,{"TR_FILIAL" ,"C",02,0})
AADD(aFields,{"TR_CC"     ,"C",09,0})
AADD(aFields,{"TR_MAT"    ,"C",06,0})
AADD(aFields,{"TR_NOME"   ,"C",30,0})
AADD(aFields,{"TR_CURSO"  ,"C",04,0})
AADD(aFields,{"TR_DESCURS","C",30,0})
AADD(aFields,{"TR_GRUPO"  ,"C",02,0})
AADD(aFields,{"TR_DEPTO"  ,"C",03,0})
AADD(aFields,{"TR_CARGO"  ,"C",06,0})
AADD(aFields,{"TR_CUSTO"  ,"N",12,2})
AADD(aFields,{"TR_PRESEN" ,"N",06,2})
AADD(aFields,{"TR_NOTA"   ,"N",06,2})
AADD(aFields,{"TR_HORAS"  ,"N",07,2})
AADD(aFields,{"TR_DATAIN" ,"D",08,0})
AADD(aFields,{"TR_DATAFI" ,"D",08,0})
AADD(aFields,{"TR_CALEND" ,"C",05,0})
AADD(aFields,{"TR_DESCCAL","C",20,0})
AADD(aFields,{"TR_TURMA"  ,"C",03,0})
AADD(aFields,{"TR_ENTIDA" ,"C",04,0})
AADD(aFields,{"TR_DESCEN" ,"C",15,0})
AADD(aFields,{"TR_HORARI" ,"C",15,0})
AADD(aFields,{"TR_DURACA" ,"C",07,0})
AADD(aFields,{"TR_UNDURA" ,"C",01,0})
AADD(aFields,{"TR_INSTRU" ,"C",06,0})
AADD(aFields,{"TR_NOMEIN" ,"C",15,0})
AADD(aFields,{"TR_LOCAL"  ,"C",15,0})
AADD(aFields,{"TR_SINON"  ,"C",04,0})
AADD(aFields,{"TR_DESCSI" ,"C",30,0})

dbCreate(cArqDbf,aFields)
dbUseArea(.T.,,cArqDbf,"TRA",.F.)

If nOrdem == 1 		// Matricula 
	cIndCond := "TR_FILIAL + TR_CURSO + TR_CALEND + TR_TURMA + TR_MAT"
ElseIf nOrdem == 2	// Centro de Custo + Matricula
	cIndCond := "TR_FILIAL + TR_CC + TR_CURSO + TR_CALEND + TR_TURMA + TR_MAT"
ElseIf nOrdem == 3	// Nome	
	cIndCond := "TR_FILIAL + TR_CURSO + TR_CALEND + TR_TURMA + TR_NOME"
ElseIf nOrdem == 4	// Data
	cIndCond := "TR_FILIAL + DTOS(TR_DATAIN) + TR_CURSO + TR_CALEND + TR_TURMA + TR_MAT"	
EndIf

cArqNtx  := CriaTrab(NIL,.f.)
IndRegua("TRA",cArqNtx,cIndCond,,,STR0012) //"Selecionando Registros..."
dbGoTop()

dbSelectArea("RA4")
dbSetOrder(1)
dbSeek(mv_par01+mv_par03+mv_par09,.T.) //Filial + Matricula+ Curso
cInicio	:= "RA4->RA4_FILIAL + RA4->RA4_MAT + RA4->RA4_CURSO" 
cFim	:= mv_par02 + mv_par04 + mv_par10

SetRegua(RecCount())

While !Eof() .And. &cInicio <= cFim

	If !Eval(cAcessaRA4)
		dbSkip()
		Loop
	EndIf

	If RA4->RA4_CURSO  < mv_par09 .Or. RA4->RA4_CURSO  > mv_par10 .Or.;
		RA4->RA4_DATAIN < mv_par17 .Or. RA4->RA4_DATAIN > mv_par18
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
		cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)		
		
		//��������������������������������������������������Ŀ
		//� Alimenta array com os registros que n�o ha cargo �
		//���������������������������������������������������� 
		If Empty(cCargo)
			aAdd( aLogCargo,SRA->RA_FILIAL + Space(05) + SRA->RA_MAT + Space(04) + SRA->RA_NOME + Space(01) + RA4->RA4_CALEND + Space(07) + RA4->RA4_CURSO) 
		EndIf
		
		If 	(SRA->RA_FILIAL	< mv_par01) .Or. (SRA->RA_FILIAL	> mv_par02) .Or.;
			(SRA->RA_MAT  	< mv_par03) .Or. (SRA->RA_MAT 		> mv_par04)	.Or.;
			(SRA->RA_CC   	< mv_par05) .Or. (SRA->RA_CC  		> mv_par06)	.Or.;
			(SRA->RA_NOME 	< mv_par07) .Or. (SRA->RA_NOME		> mv_par08)	.Or.;
			(cCargo 		< mv_par15) .Or. (cCargo		 	> mv_par16)	.Or.;
			(!(cSitfol $ cSituacao) 	.And.(cSitFol <> "P"))				.Or.;
			(cSitfol == "P" .And. nFerProg == 2)
			
			dbSelectArea("RA4")
			dbSkip()
			Loop
		EndIf
		
		dbSelectArea( "SQ3" )
		dbSetOrder(1)
		cFil := If(xFilial("SQ3") == Space(2),Space(2),SRA->RA_FILIAL)
		If dbSeek( cFil + cCargo + SRA->RA_CC ) .Or. dbSeek( cFil + cCargo ) 			
			If SQ3->Q3_GRUPO < mv_par11 .Or. SQ3->Q3_GRUPO > mv_par12 .Or.;
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
			                            
		dbSelectArea("RA0") 
		dbSetOrder(1)
		cFil := If(xFilial("RA0") == Space(2),Space(2),SRA->RA_FILIAL)
		dbSeek(cFil+RA4->RA4_ENTIDA)
		
		dbSelectArea("RA1")
		dbSetOrder(1)
		cFil := If(xFilial("RA1") == Space(2),Space(2),SRA->RA_FILIAL)
		dbSeek(cFil+RA4->RA4_CURSO)

		dbSelectArea("RA2")
		dbSetOrder(1)
		cFil := If(xFilial("RA2") == Space(2),Space(2),SRA->RA_FILIAL)
		dbSeek(cFil+RA4->RA4_CALEND+RA4->RA4_CURSO+RA4->RA4_TURMA)   

		dbSelectArea("RA7")
		dbSetOrder(1)
		cFil := If(xFilial("RA7") == Space(2),Space(2),SRA->RA_FILIAL)
		dbSeek(cFil+RA2->RA2_INSTRU)
				
		RecLock("TRA",.T.)
		TRA->TR_FILIAL  	:= SRA->RA_FILIAL
		TRA->TR_CC      	:= SRA->RA_CC
		TRA->TR_MAT     	:= SRA->RA_MAT
		TRA->TR_NOME    	:= SRA->RA_NOME
		TRA->TR_CURSO	 	:= RA4->RA4_CURSO
		TRA->TR_DESCURS 	:= RA1->RA1_DESC
		TRA->TR_GRUPO   	:= SQ3->Q3_GRUPO
		TRA->TR_DEPTO   	:= SQ3->Q3_DEPTO
		TRA->TR_CARGO   	:= SQ3->Q3_CARGO
		TRA->TR_CUSTO	 	:= RA4->RA4_VALOR
		TRA->TR_PRESEN  	:= RA4->RA4_PRESEN
		TRA->TR_NOTA		:= RA4->RA4_NOTA
		TRA->TR_HORAS   	:= RA4->RA4_HORAS
		TRA->TR_DATAIN		:= RA4->RA4_DATAIN
		TRA->TR_DATAFI		:= RA4->RA4_DATAFI
		TRA->TR_CALEND		:= RA4->RA4_CALEND
		TRA->TR_DESCCAL		:= RA2->RA2_DESC
		TRA->TR_TURMA		:= RA4->RA4_TURMA
		TRA->TR_ENTIDA		:= RA4->RA4_ENTIDA
		TRA->TR_DESCEN		:= RA0->RA0_DESC
		TRA->TR_HORARI		:= RA2->RA2_HORARI
		TRA->TR_DURACA		:= STR(RA2->RA2_DURACA,7,2)
		TRA->TR_UNDURA		:= RA2->RA2_UNDURA
		TRA->TR_INSTRU		:= RA2->RA2_INSTRU
		TRA->TR_NOMEIN		:= RA7->RA7_NOME
		TRA->TR_LOCAL		:= RA2->RA2_LOCAL
		TRA->TR_SINON		:= RA4->RA4_SINONI
		TRA->TR_DESCSI		:= TrmDesc("RA9",RA4->RA4_SINONI,"RA9->RA9_DESCR")
		MsUnlock()
	EndIf		

   	dbSelectArea("RA4")
   	dbSkip()
EndDo

dbSelectArea("TRA")
dbGotop()

// Variaveis dos totais do relatorio
nTotQt		:= 0
nTotValor	:= 0
nTotHoras	:= 0 
nTotGQt		:= 0
nTotGVl		:= 0
nTotGHr		:= 0

// Variaveis de totais da ordem selecionada
nTotFunc	:= 0
nCusto		:= 0
nTotCurso	:=0
nQtdeCurso	:=0
nHoras		:= 0
nPresenc	:= 0
nNota		:= 0
cAuxCurso	:= ""
cAuxTurma	:= ""
lRet		:= .T.
nTipo 		:= 1
cCentro 	:= TRA->TR_CC
cCurso		:= TRA->TR_CURSO
cDescCur 	:= TRA->TR_DESCURS                  
cCalend		:= TRA->TR_CALEND
cDescCal	:= TRA->TR_DESCCAL
cTurma		:= TRA->TR_TURMA
cEntida		:= TRA->TR_ENTIDA
cDescEn		:= TRA->TR_DESCEN
cHorari		:= TRA->TR_HORARI
cDuraca		:= TRA->TR_DURACA
cUnDura		:= TRA->TR_UNDURA
cInstru		:= TRA->TR_INSTRU
cNomeIn		:= TRA->TR_NOMEIN
cLocal		:= TRA->TR_LOCAL
cSinon		:= TRA->TR_SINON
cDescSi		:= TRA->TR_DESCSI
cDtIni      := dtoc(TRA->TR_DATAIN)
cDtFim		:= dtoc(TRA->TR_DATAFI)

While !Eof()
    
	If lRet
		If nOrdem == 2
			FImpCC()
		EndIf
		lRet:= .F.
	EndIf		

	If mv_par19	== 1			// Sintetico
		If nOrdem != 2 .And. cCurso+cCalend+cTurma+cDtIni+cDtFim != TRA->TR_CURSO+TRA->TR_CALEND+TRA->TR_TURMA+dtoc(TRA->TR_DATAIN)+dtoc(TRA->TR_DATAFI)
			nTipo 		:= 3	//Total
			FImpDet()
			FImpTot()				
			FZera()
			cCurso		:= TRA->TR_CURSO
			cDescCur 	:= TRA->TR_DESCURS
			cCalend		:= TRA->TR_CALEND
			cDescCal	:= TRA->TR_DESCCAL
			cTurma		:= TRA->TR_TURMA
			cEntida		:= TRA->TR_ENTIDA
			cDescEn		:= TRA->TR_DESCEN
			cHorari		:= TRA->TR_HORARI
			cDuraca		:= TRA->TR_DURACA
			cUnDura		:= TRA->TR_UNDURA
			cInstru		:= TRA->TR_INSTRU
			cNomeIn		:= TRA->TR_NOMEIN
			cLocal		:= TRA->TR_LOCAL
			cSinon		:= TRA->TR_SINON
			cDescSi		:= TRA->TR_DESCSI
			cDtIni      := dtoc(TRA->TR_DATAIN)
			cDtFim		:= dtoc(TRA->TR_DATAFI)
		EndIf
		If nOrdem == 2 .And. cCentro != TRA->TR_CC			// Centro de custo
			nTipo 		:= 2 //Total C.C.
			FImpDet()
			FImpTot()
			FImpCC()
			FZera() 
			cCentro  	:= TRA->TR_CC
			cCurso		:= TRA->TR_CURSO
			cDescCur 	:= TRA->TR_DESCURS
			cCalend		:= TRA->TR_CALEND
			cDescCal	:= TRA->TR_DESCCAL
			cTurma		:= TRA->TR_TURMA
			cEntida		:= TRA->TR_ENTIDA
			cDescEn		:= TRA->TR_DESCEN
			cHorari		:= TRA->TR_HORARI
			cDuraca		:= TRA->TR_DURACA
			cUnDura		:= TRA->TR_UNDURA
			cInstru		:= TRA->TR_INSTRU
			cNomeIn		:= TRA->TR_NOMEIN
			cLocal		:= TRA->TR_LOCAL
			cSinon		:= TRA->TR_SINON
			cDescSi		:= TRA->TR_DESCSI			
		EndIf
		
		// Totais por curso
		nTotFunc 	++
		nCusto		+= TRA->TR_CUSTO
		nPresenc 	+= TRA->TR_PRESEN
		nNota		+= TRA->TR_NOTA
		nHoras		+= TRA->TR_HORAS
		
	Else								// Analitico
		If nOrdem != 2 .And. cCurso+cCalend+cTurma+cDtIni+cDtFim <> TRA->TR_CURSO+TRA->TR_CALEND+TRA->TR_TURMA+dtoc(TRA->TR_DATAIN)+dtoc(TRA->TR_DATAFI)
			nTipo 		:= 3	//Total
			FImpTot()				
			cAuxCurso	:= ""
			cAuxTurma	:= ""
			cCurso   	:= TRA->TR_CURSO
			cDescCur 	:= TRA->TR_DESCURS
			cCalend		:= TRA->TR_CALEND
			cDescCal	:= TRA->TR_DESCCAL
			cTurma		:= TRA->TR_TURMA
			cEntida		:= TRA->TR_ENTIDA
			cDescEn		:= TRA->TR_DESCEN
			cHorari		:= TRA->TR_HORARI
			cDuraca		:= TRA->TR_DURACA
			cUnDura		:= TRA->TR_UNDURA
			cInstru		:= TRA->TR_INSTRU
			cNomeIn		:= TRA->TR_NOMEIN
			cLocal		:= TRA->TR_LOCAL
			cSinon		:= TRA->TR_SINON
			cDescSi		:= TRA->TR_DESCSI
			cDtIni      := dtoc(TRA->TR_DATAIN)
			cDtFim		:= dtoc(TRA->TR_DATAFI)
		EndIf
		nTotFunc	:= 1
		nCusto		:= TRA->TR_CUSTO
		nPresenc 	:= TRA->TR_PRESEN
		nNota		:= TRA->TR_NOTA
		nHoras		:= TRA->TR_HORAS
		If nOrdem == 2 .And. cCentro != TRA->TR_CC
			nTipo 		:= 2	//Tot. C.C.
			FImpTot()
			FImpCC()
			cAuxCurso 	:= ""
			cAuxTurma 	:= ""
			cCurso	 	:= TRA->TR_CURSO
			cDescCur	:= TRA->TR_DESCURS
			cCentro   	:= TRA->TR_CC  
			cCalend	 	:= TRA->TR_CALEND
			cDescCal	:= TRA->TR_DESCCAL
			cTurma	 	:= TRA->TR_TURMA
			cEntida		:= TRA->TR_ENTIDA
			cDescEn		:= TRA->TR_DESCEN
			cHorari		:= TRA->TR_HORARI
			cDuraca		:= TRA->TR_DURACA
			cUnDura		:= TRA->TR_UNDURA
			cInstru		:= TRA->TR_INSTRU
			cNomeIn		:= TRA->TR_NOMEIN
			cLocal		:= TRA->TR_LOCAL
			cSinon		:= TRA->TR_SINON
			cDescSi		:= TRA->TR_DESCSI			
			cDtIni      := dtoc(TRA->TR_DATAIN)
			cDtFim		:= dtoc(TRA->TR_DATAFI)
					
		EndIf
		FImpDet()		
	EndIf
	
	// Totais por centro de custo
	nTotQt		++
	nTotValor 	+= TRA->TR_CUSTO
	nTotHoras 	+= TRA->TR_HORAS
	
	// Totais do relatorio
	nTotGQt		++
	nTotGVl		+= TRA->TR_CUSTO
	nTotGHr 	+= TRA->TR_HORAS
	
	dbSelectArea("TRA")
	dbSkip()
EndDo

If !lRet
	If nOrdem == 2 
		nTipo := 2	//Tot. C.C. 
		If mv_par19 == 1
			FImpDet()
		EndIf
		FImpTot()
	
	ElseIf mv_par19 == 1 	//Sintetico
		nTipo := 3	//Total
		FImpDet()
		FImpTot()  
	
	ElseIf mv_par19 == 2	//Analitico
		nTipo := 3	//Total
		FImpTot()
	
	EndIf

	nTipo		:= 1	//Total Geral
	nTotQt		:= nTotGQt
	nTotValor 	:= nTotGVl
	nTotHoras 	:= nTotGHr
	
	FImpTot()
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

If lImp
	Impr("","F")
EndIf	

Set Device To Screen
If aReturn[5] == 1
	
	//�������������������������Ŀ
	//� Impressao do Relatorio  �
	//���������������������������
   Set Printer To
   Commit
   ourspool(wnrel)

	//��������������������������������������������������������������������Ŀ
	//� Gera Arquivo Log com as Inconsistencias no vinculo Funcao x Cargo  �
	//����������������������������������������������������������������������
	If ( lExcLogCargo := !Empty(aLogCargo) ) 
	
		cMainTitle 	:= STR0046			//"Inconsist�ncias na fun��o ou cargo"
		cTitle1		:= Upper(STR0047)	//"Filial Matricula Funcionario                    Calendario Curso"   
	   
	  	aAdd(aLogTitle,cTitle1)
	
		If ( lExcLogCargo := MsgNoYes(STR0048, STR0001 + " - " + cMainTitle ) )	//"Foram encontradas inconsist�ncias no v�nculo Fun��o x Cargo. Deseja gerar Log?"
			FMakeLog( { aLogCargo } , aLogTitle , , NIL , NIL , STR0001 + Space(01)+ "("+ cMainTitle+")","M","P",,.F. )			
		EndIf	                            
		
	EndIf  
      
Endif
MS_FLUSH()
Return Nil
      
//��������������������Ŀ
//� Function FImpCab() � // Imprime Cabecalho do relatorio
//����������������������
Static Function FImpCab()

If mv_par19 == 1	// Sintetico

	If nOrdem <> 2
		CCABEC1	:= STR0013	//"                                           QTDE.      CUSTO  HORAS %PRES MD NOTAS"
	Else
		CCABEC1	:= STR0045	//"                                                QTDE.         CUSTO      HORAS"
	EndIf

Else					// Analitico
	If nOrdem == 1 .Or. nOrdem == 4
		CCABEC1	:= STR0014	//"   FIL. MATR.  NOME                             QTDE.         CUSTO      HORAS   %PRES   NOTAS" 												
	ElseIf nOrdem == 2
		CCABEC1	:= STR0043	//"   FIL. MATR.  NOME                             QTDE.         CUSTO      HORAS   %PRES   NOTAS  CALEND CURSO TURMA PERIODO" 														
	ElseIf nOrdem == 3
		CCABEC1 := STR0015	//"   FIL. NOME                            MATR.   QTDE.         CUSTO      HORAS   %PRES   NOTAS"
	EndIf				
EndIf                               

Impr("","C")
Impr(CCABEC1, "C")
lImp := .T.
Return Nil


//��������������������Ŀ
//� Function FImpDet() � // Imprime as linhas de detalhe do relatorio
//����������������������
Static Function fImpDet()
cAuxDet := ""
DET 	:= "   "
nPresenc:= nPresenc / nTotFunc
nNota	:= nNota	/ nTotFunc

If mv_par19 == 1			// Sintetico	
	

	If nOrdem <> 2
		cAuxDet:= STR0020+cCalend+" - "+cDescCal + STR0017+cCurso+" - "+cDescCur +  STR0018+cTurma + STR0021+cDtIni+" - "+cDtFim // " CALENDARIO: " / " CURSO: " / "TURMA: " / " PERIODO: "
		IMPR(cAuxDet,"C")                                            			
	
		cAuxDET := STR0030 + cSinon + " - " + cDescSi + STR0025+cInstru+" - "+cNomeIn	//"SINONIMO DO CURSO: " / " INSTRUTOR: " 
		IMPR(cAuxDet,"C")		
		
		cAuxDET	:= STR0024+cEntida+" - "+cDescEn  + STR0028+cLocal + STR0026+cHorari + STR0027+Transform(cDuraca,"9999.99")+" "+cUnDura  //"ENTIDADE: " / " LOCAL: "/ " HORARIO: " / " DURACAO: "
		IMPR(cAuxDet,"C")   
	EndIf
		         		
	FImpCab()      
	DET 	:= Space(55)
	
Else							// Analitico
	If cAuxCurso+cAuxTurma == cCurso+cTurma
		cCurso  := Space(05)
		cAuxDet	:= ""
		cTurma	:= Space(03)
	Else
		cAuxCurso := cCurso
		cAuxTurma := cTurma
		
		If nOrdem <> 2
			cAuxDet:= STR0020+cCalend+" - "+cDescCal + STR0017+cCurso+" - "+cDescCur +  STR0018+cTurma + STR0021+Dtoc(TRA->TR_DATAIN)+" - "+Dtoc(TRA->TR_DATAFI) // " CALENDARIO: " / " CURSO: " / "TURMA: " / " PERIODO: "
			IMPR(cAuxDet,"C")                                            
	
			cAuxDET := STR0030 + cSinon + " - " + cDescSi + STR0025+cInstru+" - "+cNomeIn	//"SINONIMO DO CURSO: " / " INSTRUTOR: " 
			IMPR(cAuxDet,"C")		
			
			cAuxDET	:= STR0024+cEntida+" - "+cDescEn  + STR0028+cLocal + STR0026+cHorari + STR0027+Transform(cDuraca,"9999.99")+" "+cUnDura  //"ENTIDADE: " / " LOCAL: "/ " HORARIO: " / " DURACAO: "
			IMPR(cAuxDet,"C")            		
		EndIf
		
		FImpCab()		
	EndIf	
	If nOrdem != 3 
		DET := "   "
		DET += TRA->TR_FILIAL + Space(03) + TRA->TR_MAT + Space(01) + TRA->TR_NOME + Space(08)
 	Else
		DET := "   "
		DET += TRA->TR_FILIAL + Space(03) + TRA->TR_NOME + Space(01) + TRA->TR_MAT + Space(08)
	EndIf
	  
	//��������������������������������������������Ŀ
	//� Na Quebra por C.Custo - Totaliza por Curso �
	//����������������������������������������������
	If nOrdem == 2	//Totalizacao por curso somente ao "quebrar" por Centro de Custo
		If cAuxCurso <> TRA->TR_CURSO .And. mv_par19 <> 1 //Analitico
			cTotCurso := STR0044+Space(01) + cAuxCurso + Space(01) + Fdesc("RA1",cAuxCurso,"RA1_DESC",28)+  Space(01) + Transform(nQtdeCurso,"99999") + Space(01) + Transform(nTotCurso,"9999999,999.99")	//"TOTAL CURSO:"
			Impr("","C")
			IMPR(cTotCurso,"C")	  
			Impr("","C")
			nTotCurso := TRA->TR_CUSTO
			nQtdeCurso:= 0
			nQtdeCurso:= nQtdeCurso + 1
			cAuxCurso := TRA->TR_CURSO
		Else
			nTotCurso += TRA->TR_CUSTO
			nQtdeCurso := nQtdeCurso + 1
		EndIf 
	Endif	
	
	cCurso := cAuxCurso								
	cTurma := cAuxTurma
	DET += Space(2)
EndIf

If !(nOrdem == 2 .And. mv_par19 ==1)	//Sintetico e quebra por CC n�o imprime detalhe
	DET += Transform(nCusto,"99999,999.99") + Space(03)
	DET += Transform(nHoras,"99999.99") + Space(03)			
	DET += Transform(nPresenc,"999.9") + Space(02)
	DET += Transform(nNota,"999.99") + Space(02)  
EndIf	     
                 
//���������������������������������������������������Ŀ
//� Quebra por C.Custo acrescenta as colunas a seguir �
//�����������������������������������������������������
If nOrdem == 2 .And. mv_par19 <> 1 //Analitico
	DET += TRA->TR_CALEND + Space(02)       
	DET += TRA->TR_CURSO + Space(02)       
	DET += TRA->TR_TURMA + Space(03)       
	DET += DTOC(TRA->TR_DATAIN) + "-" +DTOC(TRA->TR_DATAFI)+Space(02)
EndIf	

IMPR(DET,"C")
Return Nil


//�������������������Ŀ
//� Function FImpCC() � // Imprime quebra do Centro de custo
//���������������������
Static Function FImpCC()  

IMPR("","C")  
DET := STR0019 + TRA->TR_CC + " - " + DescCC(TRA->TR_CC)		// "CENTRO DE CUSTO: "
IMPR(DET,"C")
IMPR("","C")   
Return Nil


//��������������������Ŀ
//� Function FImpTot() � // Imprime os totais do relatorio
//����������������������
Static Function FImpTot()
IMPR("","C")
DET := ""
If nTipo == 1
	DET := STR0022	//"TOTAL GERAL:           "
ElseIf nTipo == 2
	If mv_par19 <> 1 //Analitico
		cTotCurso:= STR0044+Space(01) + cAuxCurso + Space(01) + Fdesc("RA1",cAuxCurso,"RA1_DESC",28)+  Space(01) + Transform(nQtdeCurso,"99999") + Space(01) + Transform(nTotCurso,"9999999,999.99")	//"TOTAL CURSO:"
		IMPR(cTotCurso,"C")	  
		Impr("","C")
		nTotCurso	:=0
		nQtdeCurso	:=0		
	EndIf	
    DET := STR0023	//"TOTAL CENTRO DE CUSTO: "
ElseIf nTipo == 3
    DET := UPPER(STR0029)+ ":                 "	// "TOTAL:                 "
EndIf

DET += Space(24)
DET += Transform(nTotQt		,"99999") + Space(01)
DET += Transform(nTotValor	,"9999999,999.99") + Space(01) 
DET += Transform(nTotHoras	,"9999999.99") 
IMPR(DET,"C")
Impr(Repl('-', colunas), "C")

nTotQt		:= 0
nTotValor	:= 0
nTotHoras	:= 0

Return Nil

//������������������Ŀ
//� Function FZera() � // Zera as variaveis do relatorio
//��������������������
Static Function FZera()
nTotFunc 	:= 0
nCusto		:= 0
nPresenc	:= 0
nNota		:= 0
nHoras		:= 0
Return Nil			
