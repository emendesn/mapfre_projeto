#include "rwmake.ch"  
#INCLUDE "TRM020.CH"
#include "protheus.ch"       
#include "report.ch"

/*��������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������Ŀ��
���Fun��o       � TRM020   � Autor � Eduardo Ju              � Data � 24.05.06 ���
������������������������������������������������������������������������������Ĵ��
���Descri��o    � Relatorio de Treinamentos (Solicitacao)   	               ���
������������������������������������������������������������������������������Ĵ��
���Uso          � TRM020                                                       ���
������������������������������������������������������������������������������Ĵ��
���Programador  � Data 	   � BOPS �  Motivo da Alteracao 				       ���
������������������������������������������������������������������������������Ĵ��
���Tania     	�18/09/2006�100265�Acertos para o Relatorio personalizavel, do ���
���          	�          �      �Release 4. Inclusao do Ajusta SX1.          ���
���Eduardo Ju 	�06/01/2007�105658�Correcao: filtro da Situacao do Funcionario ��� 
���          	�          �      �e da Query.                                 ���  
���Eduardo Ju 	�10/10/2007�129103�Alteracao da Query R4.                      ��� 
�������������������������������������������������������������������������������ٱ�
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������*/
User Function TRM020()

Local oReport
Local aArea := GetArea()

If FindFunction("TRepInUse") .And. TRepInUse()	//Verifica se relatorio personalizal esta disponivel
	//������������������������������������������Ŀ
	//� Ajusta SX1 para trabalhar com range.     �
	//��������������������������������������������
	AjustaTR020RSx1()
	Pergunte("TR020R",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()	
Else
	U_TRM020R3()	
EndIf  

RestArea( aArea )

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ReportDef() � Autor � Eduardo Ju          � Data � 16.05.06 ���
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
Local cAliasQry := GetNextAlias()

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//��������������������������������������������������������������������������
oReport := TReport():New("TRM020",STR0009,"TR020R",{|oReport| PrintReport(oReport,cAliasQry)},STR0017)	//"Solicita��o de Treinamento"#"Este programa tem como objetivo imprimir a Solicita��o de Treinamento conforme par�metros selecionados"
oReport:SetTotalInLine(.F.) 
oReport:SetLandscape()	//Imprimir Somente Paisagem
Pergunte("TR020R",.F.)

Aadd( aOrdem, STR0004)	// "Matricula"
Aadd( aOrdem, STR0005)	// "Centro de Custo"
Aadd( aOrdem, STR0006)	// "Nome" 

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
oSection1 := TRSection():New(oReport,STR0018,{"RA3","RA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)	//"Curso"

#IFNDEF TOP
	TRCell():New(oSection1,"RA3_CURSO","RA3",STR0018,,,,{|| TRA->TR_CURSO })	//Codigo do Curso  
	TRPosition():New(oSection1,"RA1",1,{|| xFilial("RA1") + RA3->RA3_CURSO})   	
#ELSE                                                                                                          
	TRCell():New(oSection1,"RA3_CURSO","RA3",STR0018)	//Codigo do Curso    
#ENDIF

TRCell():New(oSection1,"RA1_DESC","RA1","")		//Descricao do Curso    

//���������������������������Ŀ
//� Criacao da Segunda Secao: �
//�����������������������������

//                 1                  2                  3                           4                5                6             7             8
//TRCell():New(<oParent>	, <cName>			, [ <cAlias> ]			, [ <cTitle> ]		,[ <cPicture> ] , [ <nSize> ]	 , [ <.lPixel.> ], [ <bBlock> ],; 
//             9                    10                  11                          12               13              14             15             16
//		[ <"cAlign"> ]		, [ <.lLineBreak.> ], [ <"cHeaderAlign"> ]	, [ <.lCellBreak.> ],[ <nColSpace> ], [<.lAutoSize.>], [ <nClrBack> ], [ <nClrFore> ])

oSection2 := TRSection():New(oSection1,STR0001,{"RA3","SRA","SQ3","SQ0","SQB"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	//"Treinamento"	
TRCell():New(oSection2,"RA3_FILIAL","RA3",STR0019)			//Filial
TRCell():New(oSection2,"RA3_MAT","RA3",STR0020,,7) 			//Matricula do Funcionario
TRCell():New(oSection2,"RA_NOME","SRA",STR0021)				//Nome do Funcionario
TRCell():New(oSection2,"Q3_GRUPO","SQ3")					//Codigo do Grupo **SUPRIMIR CAMPO
TRCell():New(oSection2,"Q0_DESCRIC","SQ0",STR0022)			//Descricao do Grupo 
TRCell():New(oSection2,"Q3_DEPTO","SQ3","")					//Codigo do Depto **SUPRIMIR CAMPO
TRCell():New(oSection2,"QB_DESCRIC","SQB",STR0023,,10)		//Descricao do Depto 
TRCell():New(oSection2,"Q3_CARGO","SQ3")					//Cargo:= fGetCargo(SRA->RA_MAT) **SUPRIMIR CAMPO
TRCell():New(oSection2,"Q3_DESCSUM","SQ3",STR0024,,,,,,,,,,.F.)		//Descricao do Cargo  
TRCell():New(oSection2,"RA3_RESERV","RA3",STR0025)			//Status da Reserva (Reservado)
TRCell():New(oSection2,"RA3_DATA","RA3",STR0026,,12)		//Data da Solicitacao
TRCell():New(oSection2,"RA3_CALEND","RA3",STR0027)			//Calendario de Treinamento
TRCell():New(oSection2,"RA2_DESC","RA2","")					//Descricado do Calendario
TRCell():New(oSection2,"RA2_DATAIN","RA2",STR0028,,12)		//Periodo: Data Inicio do Curso
TRCell():New(oSection2,"RA2_DATAFI","RA2",,,12)				//Periodo: Data Final do Curso 
TRCell():New(oSection2,"RA3_TURMA","RA3")					//Turma     
TRCell():New(oSection2,"RA_CC","SRA")						//Centro de Custo
#IFNDEF TOP	
	TRPosition():New(oSection2,"RA2",1,{|| xFilial("RA2") + RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA}) 
	TRPosition():New(oSection2,"SRA",1,{|| xFilial("SRA") + RA3->RA3_MAT})
	TRPosition():New(oSection2,"SQ0",1,{|| xFilial("SQ0") + SQ3->Q3_GRUPO})
	TRPosition():New(oSection2,"SQB",1,{|| xFilial("SQB") + SQ3->Q3_DEPTO})
	TRPosition():New(oSection2,"SI3",1,{|| xFilial("SI3") + SRA->RA_CC})     
	TRCell():New(oSection2,"I3_DESC","SI3","",,,,{|| RhDescCC(TRA->TR_CC)},,,,,,.F.)	//Descricao do Centro de Custo 
#ELSE                                                                                                          
	TRCell():New(oSection2,"I3_DESC","SI3","",,,,{|| RhDescCC(RA_CC)},,,,,,.F.)	//Descricao do Centro de Custo 
#ENDIF

TRFunction():New(oSection2:Cell("RA3_MAT" ),/*cId*/,"COUNT",/*oBreak*/,/*cTitle*/,"9999"/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
oSection2:SetTotalText({|| STR0029 })
oSection2:SetTotalInLine(.F.) 
oSection2:SetAutoSize()

Return oReport

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ReportDef() � Autor � Eduardo Ju          � Data � 19.05.06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Impressao do Relatorio (Lista de Presenca)                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function PrintReport(oReport,cAliasQry)

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)  
Local cFil 		:= ""
Local cMat 		:= ""
Local cCc  		:= ""
Local cNom 		:= ""
Local cCur 		:= ""
Local cGru 		:= ""
Local cDep 		:= ""
Local cCar 		:= ""
Local nNecess	:= ""
Local nFerProg  := ""
Local cSitFol   := "" 
Local nOrdem  	:= osection1:GetOrder()

#IFNDEF TOP
	Local cAcessaRA3:= &("{ || " + ChkRH("TRM020","RA3","2") + "}")
	Local cFiltro	:= ""
	Local aFields 	:= {}
	Local cArqDBF	:= ""
#ELSE
	Local lQuery    := .F. 
	Local cExpressao:= ""
	Local cOrder	:= ""
	Local i 		:= 0
#ENDIF

Private cSituacao	:= "" 

#IFNDEF TOP
	//-- Transforma parametros Range em expressao (intervalo)
	MakeAdvplExpr("TR020R")	
#ELSE	
	//-- Transforma parametros Range em expressao SQL
	MakeSqlExpr("TR020R")
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
nNecess		:= If(!Empty(mv_par09),nNecess:=mv_par09,nNecess:=3)
cSituacao 	:= mv_par10
nFerProg  	:= mv_par11

#IFNDEF TOP	
	If !Empty(cFil)		//RA3
		cFiltro:= cFil 
	EndIf  
	
	If !Empty(cMat)		//RA3
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cMat
	EndIf  
	       
	If !Empty(cCur)		//RA3
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cCur 
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

	If !Empty(cGru)		//SQ3
		cFiltro := cGru 
	EndIf  
	
	If !Empty(cDep)		//SQ3
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cDep 
	EndIf  
	
	If !Empty(cCar)		//SQ3
		cFiltro += Iif(!Empty(cFiltro)," .AND. ","")
		cFiltro += cCar 
	EndIf  
	
	//Define um filtro para a tabela principal da secao
	oSection2:SetFilter(cFiltro,,,"SQ3")
	
	cArqDBF  := CriaTrab(NIL,.f.)
	
	AADD(aFields,{"TR_FILIAL" 	,"C",02,0})
	AADD(aFields,{"TR_CC"     	,"C",09,0})
	AADD(aFields,{"TR_MAT"    	,"C",06,0})
	AADD(aFields,{"TR_NOME"   	,"C",30,0})
	AADD(aFields,{"TR_CURSO"  	,"C",04,0})
	AADD(aFields,{"TR_DESCUR"	,"C",30,0})
	AADD(aFields,{"TR_GRUPO"  	,"C",02,0})
	AADD(aFields,{"TR_DEPTO"  	,"C",03,0})
	AADD(aFields,{"TR_CARGO"  	,"C",05,0})
	AADD(aFields,{"TR_RESERV" 	,"C",01,0})
	AADD(aFields,{"TR_DATA" 	,"D",08,0})
	AADD(aFields,{"TR_CALEND"	,"C",04,0})
	AADD(aFields,{"TR_TURMA"	,"C",03,0})
	AADD(aFields,{"TR_DTINI"	,"D",08,0})
	AADD(aFields,{"TR_DTFIM"	,"D",08,0})
	
	dbCreate(cArqDbf,aFields)
	dbUseArea(.T.,,cArqDbf,"TRA",.F.)
	
	If nOrdem == 1		// Matricula 
		cIndCond := "TR_FILIAL + TR_CURSO + TR_MAT"
	ElseIf nOrdem == 2	// Centro de Custo + Matricula
		cIndCond := "TR_FILIAL + TR_CURSO + TR_CC + TR_MAT"
	Else				// Nome	
		cIndCond := "TR_FILIAL + TR_CURSO + TR_NOME"
	EndIf
	
	cArqNtx  := CriaTrab(NIL,.f.)
	IndRegua("TRA",cArqNtx,cIndCond,,,STR0015) //"Selecionando Registros..."
	
	dbSelectArea("RA3")
	dbGoTop()
	
	oReport:SetMeter(RecCount())
	
	While !Eof()
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
				 
		If !Eval(cAcessaRA3)
			dbSkip()
			Loop
		EndIf
	
		dbSelectArea("RA2")
		dbSeek(xFilial("RA2")+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
			
		//��������������������������������������������������������Ŀ
		//� 			Buscar Nome e Centro de Custo  			   �
		//����������������������������������������������������������
		dbSelectArea("SRA")
		dbSetOrder(1)	
		dbSeek(RA3->RA3_FILIAL+RA3->RA3_MAT)
				
		//��������������������������Ŀ
		//� Situacao do Funcionario  �
		//����������������������������
		cSitFol := TrmSitFol( If(Empty(RA2->RA2_DATAIN),RA3->RA3_DATA,RA2->RA2_DATAIN))
		cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)
		
		If	!Empty(cCc) 
			If &("!(SRA->" + cCc + ")")
				dbSelectArea("RA3")
				dbSkip()
				Loop
			EndIf
		EndIf			

		If	!Empty(cNom)
			If &("!(SRA->" + cNom + ")")
				dbSelectArea("RA3")
				dbSkip()
				Loop
			EndIf
		EndIf			

		If	(!(cSitfol $ cSituacao) .And. (cSitFol <> "P")) .Or.;
			(cSitfol == "P" .And. nFerProg == 2)
			dbSelectArea("RA3")
			dbSkip()
			Loop
		EndIf			
				
		//����������������������������������������Ŀ
		//�Cargo, Grupo e Departamento		 	   �
		//������������������������������������������  
	 	dbSelectArea( "SQ3" )
		dbSetOrder(1)
		cFil := If(xFilial("SQ3") == Space(2),Space(2),SRA->RA_FILIAL)
		If (dbSeek( cFil + cCargo + SRA->RA_CC ) .Or. dbSeek( cFil + cCargo ) )

			If !Empty(cGru)
				If &("!" + cGru)
					dbSelectArea("RA3")
					dbSkip()
					Loop
				EndIf
			EndIf 

			If !Empty( cDep)
				If &("!" + cDep)
					dbSelectArea("RA3")
					dbSkip()
					Loop
				EndIf
			EndIf 

			If !Empty(cCar)
				If &("!" + cCar)
					dbSelectArea("RA3")
					dbSkip()
					Loop
				EndIf
			EndIf 
		Else
			dbSelectArea("RA3")
			dbSkip()
			Loop			
		EndIf
	
		//��������������������������������������������������������Ŀ
		//�               Grava arquivo Temporario 		           �
		//����������������������������������������������������������
		dbSelectArea("TRA")
		RecLock("TRA",.T.)
		
		TRA->TR_FILIAL	:= RA3->RA3_FILIAL
		TRA->TR_MAT		:= RA3->RA3_MAT
		TRA->TR_CURSO	:= RA3->RA3_CURSO
		TRA->TR_RESERV	:= RA3->RA3_RESERV 
		TRA->TR_DATA	:= RA3->RA3_DATA
		TRA->TR_NOME	:= SRA->RA_NOME
		TRA->TR_CC		:= SRA->RA_CC
		TRA->TR_DESCUR	:= RA1->RA1_DESC
		TRA->TR_CARGO  	:= SQ3->Q3_CARGO
		TRA->TR_GRUPO	:= SQ3->Q3_GRUPO
		TRA->TR_DEPTO  	:= SQ3->Q3_DEPTO
		TRA->TR_CALEND 	:= RA3->RA3_CALEND
		TRA->TR_TURMA	:= RA3->RA3_TURMA
		
		dbSelectArea("RA2")
		dbSetOrder(1)                                                 
		cFil := If(xFilial("RA2") == Space(2),Space(2),RA3->RA3_FILIAL)
		dbSeek(cFil+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
		
		dbSelectArea("TRA")
		TRA->TR_DTINI	:= RA2->RA2_DATAIN
		TRA->TR_DTFIM	:= RA2->RA2_DATAFI
		
		MsUnlock()
			
		DbSelectArea("RA3")
		DbSkip()
	EndDo 
	
	dbSelectArea("TRA")
	dbGotop()
	          	
	TRPosition():New(oSection1,"RA1",1,{|| RhFilial("RA1",TRA->TR_FILIAL) + TRA->TR_CURSO})
	TRPosition():New(oSection1,"RA3",1,{|| RhFilial("RA3",TRA->TR_FILIAL) + TRA->TR_MAT})
	TRPosition():New(oSection2,"RA3",1,{|| RhFilial("RA3",TRA->TR_FILIAL) + TRA->TR_MAT}) 
	TRPosition():New(oSection2,"RA2",1,{|| RhFilial("RA2",TRA->TR_FILIAL) + TRA->TR_CALEND+TRA->TR_CURSO+TRA->TR_TURMA})
	TRPosition():New(oSection2,"SRA",1,{|| RhFilial("SRA",TRA->TR_FILIAL) + TRA->TR_MAT})
	TRPosition():New(oSection2,"SQ0",1,{|| RhFilial("SQ0",TRA->TR_FILIAL) + TRA->TR_GRUPO})
	TRPosition():New(oSection2,"SQ3",2,{|| RhFilial("SQ3",TRA->TR_FILIAL) + TRA->TR_GRUPO + TRA->TR_DEPTO + TRA->TR_CARGO})
	TRPosition():New(oSection2,"SI3",1,{|| RhFilial("SI3",TRA->TR_FILIAL) + TRA->TR_CC})
	   
	Do While ! Eof()
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
	
		cCurso := TRA->TR_CURSO 
	    
		lFirst := .T.
		
		oSection1:Init()
		oSection1:SetTotalText( {|| STR0029 } )
		oSection1:PrintLine()
		
		oSection2:Init()	
		
		Do While !Eof() .And. cCurso == TRA->TR_CURSO    
			oSection2:SetTotalText( {|| STR0029 } )
		       
			//��������������������������������������������������������Ŀ
			//�            Verifica necessidade do Cargo 	           �
			//����������������������������������������������������������  
			dbSelectArea("RA5")
			dbSetOrder(2)
			cFil := If(xFilial("RA5") == Space(2),Space(2),TRA->TR_FILIAL)
			
			lAchou 	:= 	(dbSeek( cFil + TRA->TR_CARGO + TRA->TR_CC + TRA->TR_CURSO )) .Or.;
						(dbSeek( cFil + TRA->TR_CARGO + TRA->TR_CURSO ))		
			
			If nNecess == 1 	//Necessidade do Cargo
	
				If lAchou 
					//������������������������������������������������������Ŀ
					//� Impressao da Segunda Secao: Funcionarios			 �
					//��������������������������������������������������������
					oSection2:Cell("Q3_GRUPO"):Disable()
					oSection2:Cell("Q3_DEPTO"):Disable()
					oSection2:Cell("Q3_CARGO"):Disable()
					oSection2:PrintLine()
					lFirst := .F.
	        	EndIf
	        
			Else  			//Solicitacao (S/ necessidade do cargo)     
				If !lAchou .Or. nNecess == 3
					//������������������������������������������������������Ŀ
					//� Impressao da Segunda Secao: Funcionarios			 �
					//��������������������������������������������������������
					oSection2:Cell("Q3_GRUPO"):Disable()
					oSection2:Cell("Q3_DEPTO"):Disable()
					oSection2:Cell("Q3_CARGO"):Disable()
					oSection2:PrintLine()
					lFirst := .F.
				EndIf
			EndIf 
			
			dbSelectArea("TRA")
			dbSkip()
	
		EndDo 
	
		oSection2:Finish()
		oSection1:Finish()
		
	EndDo 
	
	dbSelectArea("TRA")
	dbCloseArea()
	fErase( cArqNtx + OrdBagExt() )
	fErase( cArqDBF )
	
#ELSE

	//-- Filtragem do relat�rio
	//-- Query do relat�rio da secao 1
	lQuery := .T.          

	If nOrdem == 1		// Matricula 
		cOrder := "%RA3_CURSO,RA3_FILIAL,RA3_MAT%"	//"TR_FILIAL + TR_CURSO + TR_MAT"
	ElseIf nOrdem == 2	// Centro de Custo + Matricula
		cOrder := "%RA3_CURSO,RA3_FILIAL,RA_CC,RA3_MAT%"
	Else				// Nome	
		cOrder := "%RA3_CURSO,RA3_FILIAL,RA_NOME%"
	EndIf

	oReport:Section(1):BeginQuery()	
	
	cFilRA1 := If ( RA1->(xFilial()) == "  ", "%AND RA1.RA1_FILIAL = '  '%","%AND RA1.RA1_FILIAL = RA3.RA3_FILIAL%")
	cFilRA2 := If ( RA2->(xFilial()) == "  ", "%AND RA2.RA2_FILIAL = '  '%","%AND RA2.RA2_FILIAL = RA3.RA3_FILIAL%")
	cFilSRA := If ( SRA->(xFilial()) == "  ", "%AND SRA.RA_FILIAL = '  '%","%AND SRA.RA_FILIAL = RA3.RA3_FILIAL%")
	cFilSQ3 := If ( SQ3->(xFilial()) == "  ", "%AND SQ3.Q3_FILIAL = '  '%","%AND SQ3.Q3_FILIAL = SRA.RA_FILIAL%")
	cFilSQ0 := If ( SQ0->(xFilial()) == "  ", "%AND SQ0.Q0_FILIAL = '  '%","%AND SQ0.Q0_FILIAL = SQ3.Q3_FILIAL%")
	cFilSRJ := If ( SRJ->(xFilial()) == "  ", "%AND SRJ.RJ_FILIAL = '  '%","%AND SRJ.RJ_FILIAL = SRA.RA_FILIAL%")			 		   				
   
	If !Empty(mv_par01)	
   		cExpressao:= mv_par01
	EndIf  
	If !Empty(mv_par02)		
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par02
	EndIf         
	If !Empty(mv_par03)	
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par03 
	EndIf  
	If !Empty(mv_par04)	
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par04
	EndIf  
	If !Empty(mv_par05)	
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par05
	EndIf  
	If !Empty(mv_par06)	
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par06
	EndIf  
	If !Empty(mv_par07)	
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par07
	EndIf           
	If !Empty(mv_par08)	
		cExpressao += Iif(!Empty(cExpressao)," AND ","")
		cExpressao += mv_par08
	EndIf
	
	If nNecess == 1 //Necessidade do Cargo
		cExpressao += Iif(!Empty(cExpressao)," AND ","") + "EXISTS ( SELECT 1 FROM " + RetSqlName("RA5") + " RA5 WHERE RA5_CARGO = Q3_CARGO AND RA5_CC = RA_CC AND RA5_CURSO = RA3_CURSO )"
	ElseIf nNecess == 2	//Solicitacao	
		cExpressao += Iif(!Empty(cExpressao)," AND ","") + "NOT EXISTS ( SELECT 1 FROM " + RetSqlName("RA5")  + " RA5 WHERE RA5_CARGO = Q3_CARGO AND RA5_CC = RA_CC AND RA5_CURSO = RA3_CURSO )" 
	EndIf	
		
	If !Empty(cExpressao)
		cExpressao += " AND "
	EndIf
	
	cExpressao := "%"+cExpressao+"%"
	
	BeginSql Alias cAliasQry
	
		SELECT DISTINCT	RA3_FILIAL,RA3_CURSO,RA1_DESC,RA3_MAT,RA3_DATA,RA_NOME,Q3_GRUPO,Q0_DESCRIC,Q3_DEPTO,
				QB_DESCRIC,Q3_CARGO,Q3_DESCSUM,RA3_RESERV,RA3_CALEND,RA2_DESC,
				RA2_DATAIN,RA2_DATAFI,RA3_TURMA,RA_CC/*,I3_DESC*/
		FROM 	%table:RA3% RA3		  
		INNER JOIN %table:RA1% RA1
			ON RA1_CURSO = RA3_CURSO
			AND RA1.%NotDel% 
			%exp:cFilRA1%
		LEFT JOIN %table:RA2% RA2
			ON RA2_CALEND = RA3_CALEND
			AND RA2_CURSO = RA3_CURSO
			AND RA2_TURMA = RA3_TURMA
			AND RA2.%NotDel% 
			%exp:cFilRA2%  	  
		INNER JOIN %table:SRA% SRA
			ON RA_MAT = RA3_MAT
			AND SRA.%NotDel% 
			%exp:cFilSRA%  
		INNER JOIN %table:SQ3% SQ3
			ON Q3_CARGO = RA_CARGO
			AND SQ3.%NotDel%			 								
			%exp:cFilSQ3% 
		INNER JOIN %table:SQ0% SQ0
			ON Q0_GRUPO = Q3_GRUPO
			AND SQ0.%NotDel%
			%exp:cFilSQ0% 
		LEFT JOIN %table:SQB% SQB
			ON QB_FILIAL = %xFilial:SQB%
			AND QB_DEPTO = Q3_DEPTO
			AND SQB.%NotDel%					
		WHERE 	%exp:cExpressao%
				RA3.%NotDel%  //Se remover essa expressao podera ocorrer erro na compilacao

	   	UNION 

		SELECT DISTINCT RA3_FILIAL,RA3_CURSO,RA1_DESC,RA3_MAT,RA3_DATA,RA_NOME,Q3_GRUPO,Q0_DESCRIC,Q3_DEPTO,
				QB_DESCRIC,Q3_CARGO,Q3_DESCSUM,RA3_RESERV,RA3_CALEND,RA2_DESC,
				RA2_DATAIN,RA2_DATAFI,RA3_TURMA,RA_CC
		FROM 	%table:RA3% RA3		 
		 
		INNER JOIN %table:RA1% RA1
			ON RA1_CURSO = RA3_CURSO
			AND RA1.%NotDel% 
			%exp:cFilRA1%
		LEFT JOIN %table:RA2% RA2
			ON RA2_CALEND = RA3_CALEND
			AND RA2_CURSO = RA3_CURSO
			AND RA2_TURMA = RA3_TURMA
			AND RA2.%NotDel%
			%exp:cFilRA2%  
		INNER JOIN %table:SRA% SRA
			ON RA_MAT = RA3_MAT
			AND SRA.%NotDel% 
			%exp:cFilSRA%  
		INNER JOIN %table:SRJ% SRJ
			ON RJ_FUNCAO = RA_CODFUNC
			AND SRJ.%NotDel%
			%exp:cFilSRJ% 
		INNER JOIN %table:SQ3% SQ3
			ON Q3_CARGO = RJ_CARGO
			AND SQ3.%NotDel%
			%exp:cFilSQ3% 
		INNER JOIN %table:SQ0% SQ0
			ON Q0_GRUPO = Q3_GRUPO
			AND SQ0.%NotDel%
			%exp:cFilSQ0% 
		LEFT JOIN %table:SQB% SQB
			ON QB_FILIAL = %xFilial:SQB%
			AND QB_DEPTO = Q3_DEPTO
			AND SQB.%NotDel%					 	
		WHERE RA_CARGO = '     ' AND
			%exp:cExpressao%
			RA3.%NotDel% //Se remover essa expressao podera ocorrer erro na compilacao
		  										
		ORDER BY %Exp:cOrder%                 		
	EndSql
	
	//������������������������������������������������������������������������Ŀ
	//�Metodo EndQuery ( Classe TRSection )                                    �
	//�Prepara o relat�rio para executar o Embedded SQL.                       �
	//�ExpA1 : Array com os parametros do tipo Range                           �
	//��������������������������������������������������������������������������
	oReport:Section(1):EndQuery()
		
	//-- Inicio da impressao do fluxo do relat�rio
	oReport:SetMeter(RA3->(LastRec()))

	//-- Utiliza a query do Pai
	oSection2:SetParentQuery()
	oSection2:SetParentFilter( { |cParam| (cAliasQry)->RA3_CURSO == cParam },{ || (cAliasQry)->RA3_CURSO })
	
	//Valida Situacao do Funcionario 
	oSection2:SetLineCondition({|| fChkSit(cAliasQry)})

	oSection2:Cell("Q3_GRUPO"):Disable()
	oSection2:Cell("Q3_DEPTO"):Disable()
	oSection2:Cell("Q3_CARGO"):Disable()
	oSection1:Print()	 //Imprimir

#ENDIF
	
Return Nil

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �fChkSit     � Autor � Eduardo Ju          � Data � 10.10.07 ���
�������������������������������������������������������������������������Ĵ��
���Descricao �Checa a Situacao do Funcionario                             ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � TRM020                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Function fChkSit(cAliasQry)   

Local aSaveArea	:= GetArea()
Local lChkSit	:= .F.  

SRA->(dbSeek( (cAliasQry)->RA3_FILIAL+(cAliasQry)->RA3_MAT ))
lChkSit := TrmSitFol( If(Empty((cAliasQry)->RA2_DATAIN),(cAliasQry)->RA3_DATA,(cAliasQry)->RA2_DATAIN)) $ cSituacao
       
RestArea(aSaveArea)

Return(lChkSit)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AjustaTR020RSx1� Autor � Tania Bronzeri   � Data �18/09/2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta SX1 para Trabalhar com Range                        ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � A partir do Release 4                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Function AjustaTR020RSx1()

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
Aadd(aRegs,{"TR020R","01","Filial ?"           ,"�Sucursal ?"       ,"Branch ?"       ,"MV_CH1","C" ,99      ,0     ,0     ,"R"  ,""     ,"MV_PAR01",""    ,""      ,""    ,"RA3_FILIAL",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"XM0",""    ,"S"  ,""      ,""     ,""      ,cHelp})


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
����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol    Pergunta Ingles  Variavel  Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1  Cnt01     Var02  Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05 XF3   GrgSxg  cPyme aHelpPor aHelpEng  aHelpSpa cHelp  �
������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","02","Matricula ?"       ,"�Matricula ?"     ,"Registration ?"  ,"MV_CH2" ,"C"  ,99      ,0     ,0     ,"R"  ,""     ,"MV_PAR02",""    ,""      ,""     ,"RA3_MAT",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""  ,"SRA",""    ,"S"  ,""     ,""       ,""     ,cHelp})


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
Aadd(aRegs,{"TR020R","03","Centro de Custo ?","�Centro de Costo ?","Cost Center ?" ,"MV_CH3","C" ,99      ,0      ,0     ,"R"  ,""     ,"MV_PAR03",""    ,""      ,""    ,"RA_CC",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"CTT","004"  ,"S"  ,""      ,""      ,""     ,cHelp})


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
����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������x��������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","04" ,"Nome  ?"           ,"�Nombre  ?"       ,"Name   ? "      ,"MV_CH4" ,"C"  ,99      ,0     ,0     ,"R"  ,""     ,"MV_PAR04",""    ,""      ,""     ,"RA_NOME",""    ,""   ,""     ,""     ,""  ,""   ,""    ,""      ,""      ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""  ,"",""    ,"S"  ,""     ,""      ,""      ,cHelp}) //SRA01


aHelp := {	"Informe intervalo de Cursos que deseja ",;
			"considerar para impressao do relatorio. " }
aHelpE:= {	"Informe intervalo de Cursos que desea ",;
			"considerar para impresion del informe. " }
aHelpI:= {	"Enter range of Courses to be considered ",;
			"for printing the report." }
cHelp := ".TR020R05."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel  Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01       Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp   �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","05" ,"Curso ?"          ,"�Curso ?"       ,"Course ?"     ,"MV_CH5" ,"C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR05",""    ,""      ,""     ,"RA3_CURSO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"RA1",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Grupos que deseja ",;
			"considerar para impressao do relatorio. " }
aHelpE:= {	"Informe intervalo de Grupos que desea ",;
			"considerar para impresion del informe. " }
aHelpI:= {	"Enter range of Groups to be considered ",;
			"for printing the report." }
cHelp := ".TR020R06."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","06" ,"Grupo ?"          ,"�Grupo ?"       ,"Group ?"      ,"MV_CH6","C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR06",""    ,""      ,""     ,"Q3_GRUPO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"SQ0",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Departamentos ",;
			"que deseja considerar para impressao ",;
			"do relatorio. " }
aHelpE:= {	"Informe intervalo de Sectores que desea ",;
			"considerar para impresion del informe. " }
aHelpI:= {	"Enter range of Department to be ",;
			"considered for printing the report." }
cHelp := ".TR020R07."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","07" ,"Departamento ?"   ,"�Sector ?"      ,"Department ?" ,"MV_CH7","C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR07",""    ,""      ,""     ,"Q3_DEPTO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"SQB",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe intervalo de Cargos que ",;
			"deseja considerar para impressao ",;
			"do relatorio. " }
aHelpE:= {	"Informe intervalo de Funciones que ",;
			"desea considerar para impresion del ",;
			"informe. " }
aHelpI:= {	"Enter range of Jobs to be considered ",;
			"for printing the report." }
cHelp := ".TR020R08."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol Pergunta Ingles Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01  DefSPA1  DefEng1 Cnt01      Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03  DefSpa3  DefEng3  Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04  Var05  Def05  DefSpa5 DefEng5 Cnt05  XF3   GrgSxg cPyme aHelpPor aHelpEng  aHelpSpa cHelp     �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","08" ,"Cargo ?"          ,"�Funcion ?"      ,"Job ?"       ,"MV_CH8","C" ,99     ,0      ,0     ,"R"  ,""     ,"MV_PAR08",""    ,""      ,""     ,"Q3_CARGO",""   ,""    ,""     ,""     ,""  ,""   ,""    ,""      ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,"SQ3",""    ,"S"  ,aHelp   ,aHelpI   ,aHelpE  ,cHelp})


aHelp := {	"Informe se deseja gerar o Relatorio ",;
			"de Rreinamento por: Necessidade de ",;
			"Treinamento, Solicitacao de Treina-",;
			"mento ou Ambos. " }
aHelpE:= {	"Especifique si desea generar el ",;
			"informe de entrenamiento por: ",;
			"necesidad de entrenamiento, ",;
			"solicitud de entrenamiento o ambos. " }
aHelpI:= {	"Inform if you want to generate the ",;
			"Training Report by: Training Need, ",;
			"Training Requisition or Both. " }
cHelp := ".TR020R09."
/*
������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues  Pergunta Espanhol      Pergunta Ingles Variavel Tipo Tamanho Decimal Presel GSC Valid          Var01      Def01         DefSPA1     DefEng1     Cnt01 Var02 Def02         DefSpa2      DefEng2       Cnt02 Var03 Def03   DefSpa3  DefEng3 Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04 Var05 Def05 DefSpa5 DefEng5 Cnt05  XF3 GrgSxg cPyme aHelpPor aHelpEng aHelpSpa cHelp         �
��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","09" ,"Treinamento por ?","�Entrenamiento por ?","Training by ?","MV_CH9","N" ,1      ,0      ,3     ,"C","NaoVazio()" ,"MV_PAR09","Necessidade","Necesidad","Necessity",""   ,""   ,"Solicitacao","Solicitud","Requisition",""   ,""   ,"Ambos","Ambos","Both"  ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,aHelp   ,aHelpI  ,aHelpE  ,cHelp})
Aadd(aRegs,{"TR020R","10","Situacoes ?"       ,"�Situaciones ?"      ,"Status ?"     ,"MV_CHA","C" ,5      ,0      ,0     ,"G","fSituacao()","MV_PAR10",""           ,""         ,""         ,""   ,""   ,""           ,""         ,""           ,""   ,""   ,""     ,""     ,""      ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,""      ,""      ,""      ,".RHSITUA."})


aHelp := {	"Informe se deseja considerar Ferias ",;
			"Programadas." }
aHelpE:= {	"Informe si desea considerar ",;
			"Vacaciones Programadas." }
aHelpI:= {	"Inform if you want to consider ",;
			"Scheduled Vacation. " }
cHelp := ".TR020R11."
/*
�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues     Pergunta Espanhol           Pergunta Ingles        Variavel Tipo Tamanho Decimal Presel GSC Valid          Var01      Def01 DefSPA1 DefEng1 Cnt01 Var02 Def02 DefSpa2 DefEng2 Cnt02 Var03 Def03 DefSpa3 DefEng3 Cnt03 Var04 Def04 DefSpa4 DefEng4 Cnt04 Var05 Def05 DefSpa5 DefEng5 Cnt05  XF3 GrgSxg cPyme aHelpPor aHelpEng aHelpSpa cHelp         �
���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{"TR020R","11" ,"Ferias Programadas ?","�Vacaciones Programadas ?","Scheduled Vacation?" ,"MV_CHB","N" ,1      ,0      ,1     ,"C","NaoVazio()" ,"MV_PAR11","Sim","Si"   ,"Yes"  ,""   ,""   ,"Nao","NO"   ,"No"   ,""   ,""   ,""  ,""     ,""     ,""  ,""   ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,"S"  ,aHelp   ,aHelpI  ,aHelpE  ,cHelp})


ValidPerg(aRegs,"TR020R",.T.)

                








//======>>>>>>>> Daqui para baixo, trata-se do release 3 ou anterior.
/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � TRM020   � Autor � Equipe R.H.           � Data � 16/03/99 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Relatorio de Treinamentos (Solicitacao)                    ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � TRM020                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RdMake                                                     ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���			   �		�      � 										  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
User Function TRM020R3()

SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,AORD,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,LEND,COLUNAS")
SetPrvt("TITULO,AT_PRG,WCABEC0,WCABEC1,CONTFL,LI")
SetPrvt("NPAG,NTAMANHO,CTIT")
SetPrvt("WNREL,NORDEM,CFILDE,CFILATE,CMATDE,CMATATE")
SetPrvt("CCCDE,CCCATE,CNOMDE,CNOMATE,CCURDE,CCURATE")
SetPrvt("CGRUDE,CGRUATE,CDEPDE,CDEPATE,CCARDE,CCARATE")
SetPrvt("NNECESS,CFIL,CINICIO,CFIM,LIMPDET")
SetPrvt("CRESERVA,DET,DETCURSO,LFIRST") 
SetPrvt("CARQDBF,AFIELDS,CACESSARA3,NCHAR,CORDEM") 

cDesc1  := STR0001 //"Treinamento"
cDesc2  := STR0002 //"Ser� impresso de acordo com os parametros solicitados pelo"
cDesc3  := STR0003 //"usu�rio."
cString := "RA1"   //-- alias do arquivo principal (Base)
aOrd    := { STR0004,STR0005,STR0006 } //"Matricula"###"Centro de Custo"###"Nome"

//+--------------------------------------------------------------+
//� Define Variaveis (Basicas)                                   �
//+--------------------------------------------------------------+
aReturn  := { STR0007,1,STR0008,2,2,1,"",1 } //"Zebrado"###"Administra��o"
NomeProg := "TRM020"
aLinha   := {}
nLastKey := 0
cPerg    := "TRR040"
lEnd     := .F.

//+--------------------------------------------------------------+
//� Define Variaveis (Programa)                                  �
//+--------------------------------------------------------------+
Colunas  	:= 220
Titulo   	:= STR0009 //"SOLICITACAO/RESERVA DE TREINAMENTO"
AT_PRG   	:= "TRM020"
wCabec0  	:= 1
wCabec1  	:= STR0011 //"FIL. MATR.  NOME                           GRUPO           DEPARTAMENTO         CARGO                        SITUACAO     DT.SOLIC.  CALENDARIO                        PERIODO         TURMA C.CUSTO"
Contfl   	:= 1
Li       	:= 0
nPag     	:= 0
nTamanho 	:= "G"
nChar		:= 15
cTit     	:= STR0009 //"SOLICITACAO/RESERVA DE TREINAMENTO"

//+--------------------------------------------------------------+
//� Verifica as perguntas selecionadas                           �
//+--------------------------------------------------------------+
pergunte("TRR040",.F.)

//+--------------------------------------------------------------+
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
//� mv_par17        //  Treinamento por:Necessidade/Solic./Ambos �
//� mv_par18        //  Status Funcionario                       �
//� mv_par19        //  Ferias Programadas                       �
//+--------------------------------------------------------------+

//+--------------------------------------------------------------+
//� Envia controle para a funcao SETPRINT                        �
//+--------------------------------------------------------------+
WnRel :="TRM020"  //-- Nome Default do relatorio em Disco.
WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F., nTamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| Relato()},cTit)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � Relato   � Autor � Equipe R.H.		    � Data � 19/03/99 ���
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

Local lAchou 	:= .F.
Local cCargo	:= "" 

nOrdem  	:= aReturn[8]
cAcessaRA3	:= &("{ || " + ChkRH("TRM020","RA3","2") + "}")

If nOrdem == 1
	cOrdem := STR0004 		// "Matricula"
ElseIf nOrdem == 2
	cOrdem := STR0005 		// "Centro de Custo"
Else
	cOrdem := STR0006 		// "Nome"
EndIf
cOrdem := " ("+STR0016+cOrdem+")"	// "Ordem de "

cTit   := STR0009 + cOrdem 	// "SOLICITACAO/RESERVA DE TREINAMENTO"
Titulo := cTit

//+--------------------------------------------------------------+
//� Carregando variaveis mv_par?? para Variaveis do Sistema.     �
//+--------------------------------------------------------------+
If(!Empty(mv_par01),cFilDe :=mv_par01,cFilDe :="  ")
If(!Empty(mv_par02),cFilAte:=mv_par02,cFilAte:="99")
If(!Empty(mv_par03),cMatDe :=mv_par03,cMatDe :="      ")
If(!Empty(mv_par04),cMatAte:=mv_par04,cMatAte:="999999")
If(!Empty(mv_par05),cCcDe  :=mv_par05,cCcDe  :="         ")
If(!Empty(mv_par06),cCcAte :=mv_par06,cCcAte :="999999999")
If(!Empty(mv_par07),cNomDe :=mv_par07,cNomDe :="                              ")
If(!Empty(mv_par08),cNomAte:=mv_par08,cNomAte:="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ")
If(!Empty(mv_par09),cCurDe :=mv_par09,cCurDe :="    ")
If(!Empty(mv_par10),cCurAte:=mv_par10,cCurAte:="9999")
If(!Empty(mv_par11),cGruDe :=mv_par11,cGruDe :="  ")
If(!Empty(mv_par12),cGruAte:=mv_par12,cGruAte:="99")
If(!Empty(mv_par13),cDepDe :=mv_par13,cDepDe :="   ")
If(!Empty(mv_par14),cDepAte:=mv_par14,cDepAte:="999")
If(!Empty(mv_par15),cCarDe :=mv_par15,cCarDe :="     ")
If(!Empty(mv_par16),cCarAte:=mv_par16,cCarAte:="99999")
If(!Empty(mv_par17),nNecess:=mv_par17,nNecess:=3)
cSituacao := mv_par18
nFerProg  := mv_par19
cSitFol   := ""

cArqDBF  := CriaTrab(NIL,.f.)
aFields 	:= {}

AADD(aFields,{"TR_FILIAL" 	,"C",02,0})
AADD(aFields,{"TR_CC"     	,"C",09,0})
AADD(aFields,{"TR_MAT"    	,"C",06,0})
AADD(aFields,{"TR_NOME"   	,"C",30,0})
AADD(aFields,{"TR_CURSO"  	,"C",04,0})
AADD(aFields,{"TR_DESCUR"	,"C",30,0})
AADD(aFields,{"TR_GRUPO"  	,"C",02,0})
AADD(aFields,{"TR_DEPTO"  	,"C",03,0})
AADD(aFields,{"TR_CARGO"  	,"C",05,0})
AADD(aFields,{"TR_RESERV" 	,"C",01,0})
AADD(aFields,{"TR_DATA" 	,"D",08,0})
AADD(aFields,{"TR_CALEND"	,"C",04,0})
AADD(aFields,{"TR_TURMA"	,"C",03,0})
AADD(aFields,{"TR_DTINI"	,"D",08,0})
AADD(aFields,{"TR_DTFIM"	,"D",08,0})

dbCreate(cArqDbf,aFields)
dbUseArea(.T.,,cArqDbf,"TRA",.F.)

If nOrdem == 1		// Matricula 
	cIndCond := "TR_FILIAL + TR_CURSO + TR_MAT"
ElseIf nOrdem == 2	// Centro de Custo + Matricula
	cIndCond := "TR_FILIAL + TR_CURSO + TR_CC + TR_MAT"
Else				// Nome	
	cIndCond := "TR_FILIAL + TR_CURSO + TR_NOME"
EndIf

cArqNtx  := CriaTrab(NIL,.f.)
IndRegua("TRA",cArqNtx,cIndCond,,,STR0015) //"Selecionando Registros..."
dbGoTop()

dbSelectArea("RA3")
dbSetOrder(1)
dbSeek(cFilDe+cMatDe+cCurDe,.T.)
cInicio	:= "RA3->RA3_FILIAL + RA3->RA3_MAT + RA3->RA3_CURSO" 
cFim	:= cFilAte + cMatAte + cCurAte

lImpDet  := .F.

SetRegua(RecCount())

While !Eof() .And. &cInicio <= cFim

	//+--------------------------------------------------------------+
	//� Incrementa Regua de Processamento.                           �
	//+--------------------------------------------------------------+
	IncRegua()
		
	If RA3->RA3_CURSO  < cCurDe .Or. RA3->RA3_CURSO  > cCurAte .Or.!Eval(cAcessaRA3)
		dbSkip()
		Loop
	EndIf

	dbSelectArea("RA2")
	dbSeek(xFilial("RA2")+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
	   
	//��������������������������������������������������������Ŀ
	//� 			Buscar Nome e Centro de Custo  			   �
	//����������������������������������������������������������
	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(RA3->RA3_FILIAL+RA3->RA3_MAT)
	
	//��������������������������Ŀ
	//� Situacao do Funcionario  �
	//����������������������������
	cSitFol := TrmSitFol( If(Empty(RA2->RA2_DATAIN),RA3->RA3_DATA,RA2->RA2_DATAIN))
	cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)
	
	If 	(SRA->RA_MAT  	< cMatDe)	.Or. (SRA->RA_MAT 	> cMatAte) .Or.;
		(SRA->RA_CC   	< cCcDe) 	.Or. (SRA->RA_CC  	> cCcAte)  .Or.;
		(SRA->RA_NOME 	< cNomDe) 	.Or. (SRA->RA_NOME > cNomAte) .Or.;
		(cCargo			< cCarDe) 	.Or. (cCargo		> cCarAte) .Or.;
		(!(cSitfol $ cSituacao) .And. (cSitFol <> "P")) .Or.;
		(cSitfol == "P" .And. nFerProg == 2)
		dbSelectArea("RA3")
		dbSkip()
		Loop
	EndIf			

	//��������������������������������������������������������Ŀ
	//�            Buscar o Grupo e Departamento		 	   �
	//����������������������������������������������������������
	dbSelectArea( "SQ3" )
	dbSetOrder(1)
	cFil := If(xFilial("SQ3") == Space(2),Space(2),SRA->RA_FILIAL)
	If dbSeek( cFil + cCargo + SRA->RA_CC ) .Or. dbSeek( cFil + cCargo ) 
		If 	SQ3->Q3_GRUPO < cGruDe .Or. SQ3->Q3_GRUPO > cGruAte .Or.;
			SQ3->Q3_DEPTO < cDepDe .Or. SQ3->Q3_DEPTO > cDepAte
			dbSelectArea("RA3")
			dbSkip()
			Loop
		EndIf 
	Else
		dbSelectArea("RA3")
		dbSkip()
		Loop			
	EndIf                  
	
	//��������������������������������������������������������Ŀ
	//�                  Descricao do Curso                    �
	//����������������������������������������������������������
	dbSelectArea("RA1")
	dbSetOrder(1)
	cFil := If(xFilial("RA1") == Space(2),Space(2),RA3->RA3_FILIAL)
	dbSeek(cFil+RA3->RA3_CURSO)

	//��������������������������������������������������������Ŀ
	//�               Grava arquivo Temporario 		           �
	//����������������������������������������������������������
	dbSelectArea("TRA")
	RecLock("TRA",.T.)
	
		TRA->TR_FILIAL	:= RA3->RA3_FILIAL
		TRA->TR_MAT		:= RA3->RA3_MAT
		TRA->TR_CURSO	:= RA3->RA3_CURSO
		TRA->TR_RESERV	:= RA3->RA3_RESERV 
		TRA->TR_DATA	:= RA3->RA3_DATA
		TRA->TR_NOME	:= SRA->RA_NOME
		TRA->TR_CC		:= SRA->RA_CC
		TRA->TR_DESCUR	:= RA1->RA1_DESC
		TRA->TR_CARGO  	:= SQ3->Q3_CARGO
		TRA->TR_GRUPO	:= SQ3->Q3_GRUPO
		TRA->TR_DEPTO  	:= SQ3->Q3_DEPTO
		TRA->TR_CALEND 	:= RA3->RA3_CALEND
		TRA->TR_TURMA	:= RA3->RA3_TURMA
		
		dbSelectArea("RA2")
		dbSetOrder(1)                                                 
		cFil := If(xFilial("RA2") == Space(2),Space(2),RA3->RA3_FILIAL)
		dbSeek(cFil+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
		
		dbSelectArea("TRA")
		TRA->TR_DTINI	:= RA2->RA2_DATAIN
		TRA->TR_DTFIM	:= RA2->RA2_DATAFI
		
	MsUnlock()

    dbSelectArea("RA3")
	dbSkip()
EndDo

dbSelectArea("TRA")
dbGotop()

SetRegua(RecCount())
   
Do While ! Eof()
    cCurso := TRA->TR_CURSO 

	lFirst := .T.
    DETCURSO := STR0010 + PadR(TRA->TR_CURSO,4) + " - " + PadR(TRA->TR_DESCUR,30) //"CURSO: "
	
	Do While ! Eof() .And. cCurso == TRA->TR_CURSO    
	
	    IncRegua()
	    
		//��������������������������������������������������������Ŀ
		//�            Verifica necessidade do Cargo 	           �
		//���������������������������������������������������������� 
		 
		dbSelectArea("RA5")
		dbSetOrder(2)
		cFil := If(xFilial("RA5") == Space(2),Space(2),TRA->TR_FILIAL)
		
		lAchou := (dbSeek( cFil + TRA->TR_CARGO + TRA->TR_CC + TRA->TR_CURSO )) .Or.;
		(dbSeek( cFil + TRA->TR_CARGO + TRA->TR_CURSO ))		
		
		If nNecess == 1 	//Necessidade do Cargo

			If lAchou 
				If lFirst
					IMPR(DETCURSO,"C")
					IMPR("","C")
					lFirst := .F.
				EndIf
			
				lImpDet := .T.
				fImpDet()
        	EndIf
        
		Else  			//Solicitacao (S/ necessidade do cargo)     
			If !lAchou .Or. nNecess == 3
				If lFirst
					IMPR(DETCURSO,"C")
					IMPR("","C")
					lFirst := .F.
				EndIf

				lImpDet := .T.
				fImpDet()
			EndIf
		EndIf
	
		dbSelectArea("TRA")
		dbSkip()
	EndDo
	
	If lImpDet .And. ! Eof()
		IMPR("","P")
	EndIf
EndDo
    
If lImpDet
	IMPR("","F")
EndIf	

//��������������������������������������������������������������Ŀ
//� Termino do Relatorio                                         �
//����������������������������������������������������������������
dbSelectArea("TRA")
dbCloseArea()
fErase(cArqNtx + OrdBagExt())
fErase(cArqDbf + GetDBExtension())

dbSelectArea("RA3")
dbSetOrder(1)

Set Device To Screen

If aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � fImpDet  � Autor � Equipe R.H.		    � Data � 19/03/99 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprime Detalhe											  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � fImpDet()                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function fImpDet()

If TRA->TR_RESERV == "R"
	cReserva := STR0012 //"RESERVADO"
ElseIf TRA->TR_RESERV == "L"
	cReserva := STR0013 //"LISTA ESPERA"
ElseIf TRA->TR_RESERV == "S"
	cReserva := STR0014 //"SOLICITACAO"
Else
	cReserva := ""
EndIf

DET := TRA->TR_FILIAL + "   " + TRA->TR_MAT + " " + TRA->TR_NOME + " "
DET += PadR(TrmDesc("SQ0",TRA->TR_GRUPO,"SQ0->Q0_DESCRIC"),15)+ " "
DET += PadR(TrmDesc("SQB",TRA->TR_DEPTO,"SQB->QB_DESCRIC"),20) + " "
DET += PadR(TrmDesc("SQ3",TRA->TR_CARGO,"SQ3->Q3_DESCSUM"),28) + " "
DET += PadR(cReserva,12)+ " "
DET += If(__SetCentury(),Dtoc(TRA->TR_DATA),Dtoc(TRA->TR_DATA)+Space(2)) + " "
DET += TRA->TR_CALEND +"-"+PadR(TrmDesc("RA2",TRA->TR_CALEND,"RA2->RA2_DESC"),20) + " "
DET += If(__SetCentury(),Dtoc(TRA->TR_DTINI),Dtoc(TRA->TR_DTINI)+Space(2)) + " - "
DET += If(__SetCentury(),Dtoc(TRA->TR_DTFIM),Dtoc(TRA->TR_DTFIM)+Space(2)) + " "
DET += TRA->TR_TURMA + Space(3)
DET += TRA->TR_CC +" - "+PadR(TrmDesc("SI3",TRA->TR_CC,"SI3->I3_DESC"),20)

IMPR(DET,"C")

Return Nil

