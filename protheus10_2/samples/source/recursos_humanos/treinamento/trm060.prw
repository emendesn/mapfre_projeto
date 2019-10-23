#include "rwmake.ch" 
#INCLUDE "TRM060.CH"
#Include "Report.ch"

/*
�����������������������������������������������������������������������������������
�����������������������������������������������������������������������������������
�������������������������������������������������������������������������������Ŀ��
���Fun��o       � TRM060   � Autor � Eduardo Ju              � Data � 02.06.06  ���
�������������������������������������������������������������������������������Ĵ��
���Descri��o    � Treinamentos Solicitados ou Baixados                          ���
�������������������������������������������������������������������������������Ĵ��
���Uso          � TRM060                                                        ���
�������������������������������������������������������������������������������Ĵ��
���Programador  � Data     � BOPS �  Motivo da Alteracao			 	        ���
�������������������������������������������������������������������������������Ĵ��
���Tania     	�30/09/2006�100282�Re-conversao do relatorio para o formato per-���
���          	�          �      �sonalizavel, do release 4 e criacao dos per- ���
���          	�          �      �guntes com range.                            ���
���Eduardo Ju   �13/06/2007�110259�Acerto no processa// de acordo com a Filial. ��� 
���Eduardo Ju	�19/11/2007�135423�Validacao da TrmSitFol().                    ���
��������������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������������
�����������������������������������������������������������������������������������*/
User Function TRM060() 
Local oReport                   
Local aArea 	:= GetArea()
Private cPerg   := "TRR60A"
Private cTitulo	:=	OemToAnsi(STR0010)  //-- Treinamentos Solicitados ou Baixados     Periodo:

If FindFunction("TRepInUse") .And. TRepInUse()	//Verifica se relatorio personalizal esta disponivel
	//��������������������������������������������������������������Ŀ
	//� Ajusta SX1 para trabalhar com range.                         �
	//����������������������������������������������������������������
	AcertSX1() 
	
	Pergunte(cPerg,.F.)			//-- Usara o mesmo grupo de perguntas 
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	TRM060R3()
EndIf  

RestArea( aArea )

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  �Microsiga           � Data �  10/25/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()
Local aOrdem    := {}
Local cAliasQry := GetNextAlias()
Local lRet		:= .T.
Local cIndCond	:= ""
Private oReport
Private oSection1
Private oSection2
Private oSection3

Aadd( aOrdem, OemToAnsi(STR0004))	// "Matricula"
Aadd( aOrdem, OemToAnsi(STR0005))	// "Centro de Custo"
Aadd( aOrdem, OemToAnsi(STR0006))	// "Nome" 
Aadd( aOrdem, OemToAnsi(STR0016)) 	// "Data"

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//��������������������������������������������������������������������������
DEFINE REPORT oReport NAME "TRM060" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| TRM060Imp(oReport)} DESCRIPTION OemToAnsi(STR0039)   //-- "Este relatorio efetua a impressao  dos treinamentos que foram solicitados ou Baixados"
oReport:SetTotalInLine(.F.) //Totaliza em linha

DEFINE SECTION oSection1 OF oReport TITLE  oemtoAnsi(STR0040) TABLES "TRA","RA2","RA3","SRA","RA4","SQ0","SQ3","SQB" ORDERS aOrdem   //-- Treinamento

	DEFINE CELL NAME "CURSO" 	OF oSection1 TITLE OemToAnsi(STR0027)	SIZE 06 BLOCK{||cCurso}		//Curso
	DEFINE CELL NAME "DESCCUR"	OF oSection1 TITLE "-"					SIZE 20 BLOCK{||cDescCur}	//Descricao do Curso
	DEFINE CELL NAME "SINON" 	OF oSection1 TITLE OemToAnsi(STR0028)	SIZE 06 BLOCK{||cSinon}		//Sinonimo do Curso
	DEFINE CELL NAME "DESCSIN"	OF oSection1 TITLE "-"	                SIZE 20 BLOCK{||cDescSi}	//Descr. Sinonimo
	DEFINE CELL NAME "CALEND" 	OF oSection1 TITLE OemToAnsi(STR0032)	SIZE 06 BLOCK{||cCalend}	//Calendario do Curso
	DEFINE CELL NAME "DESCCAL"	OF oSection1 TITLE "-"					SIZE 20 BLOCK{||cDescCal} CELL BREAK	//Descr. Calendario
	DEFINE CELL NAME "TURMA" 	OF oSection1 TITLE OemToAnsi(STR0033)	SIZE 06 BLOCK{||cTurma}		//Turma
	DEFINE CELL NAME "DATAIN"	OF oSection1 TITLE OemToAnsi(STR0029)	SIZE 10 BLOCK{||Dtoc(TRA->TR_DATAIN)}//Periodo: Data Inicio do Curso
	DEFINE CELL NAME "DATAFI" 	OF oSection1 TITLE "-"					SIZE 10 BLOCK{||Dtoc(TRA->TR_DATAFI)}//Periodo: Data Final do Curso

oSection1:SetLineStyle()
oSection1:SetCharSeparator("")


DEFINE SECTION oSection2 OF oSection1 TITLE oemtoAnsi(STR0038)  TABLES "TRA","RA2"												//-- Participantes 

	DEFINE CELL NAME "FIL" 			OF oSection2 TITLE OemToAnsi(STR0041) 	BLOCK{||TR_FILIAL}									//Filial do Funcionario
	DEFINE CELL NAME "MATR" 		OF oSection2 TITLE OemToAnsi(STR0004)	BLOCK{||TRA->TR_MAT}								//Matricula do Funcionario
	DEFINE CELL NAME "NOME"	 		OF oSection2 TITLE OemToAnsi(STR0006)	SIZE 35 BLOCK{||TRA->TR_NOME}						//Nome do Funcionario 
	DEFINE CELL NAME "GRUPO"		OF oSection2 TITLE OemToAnsi(STR0034)	SIZE 15 BLOCK{||PadR(TrmDesc("SQ0",TRA->TR_GRUPO,"SQ0->Q0_DESCRIC"),15)}	//Descricao do Grupo
	DEFINE CELL NAME "DEPTO"		OF oSection2 TITLE OemToAnsi(STR0035)	SIZE 20 BLOCK{||PadR(TrmDesc("SQB",TRA->TR_DEPTO,"SQB->QB_DESCRIC"),20)}	//Descricao do Depto
	DEFINE CELL NAME "CARGO"		OF oSection2 TITLE OemToAnsi(STR0036)	SIZE 30 BLOCK{||PadR(TrmDesc("SQ3",TRA->TR_CARGO,"SQ3->Q3_DESCSUM"),30)}	//Descricao do Cargo
	DEFINE CELL NAME "SITUACAO"		OF oSection2 TITLE OemToAnsi(STR0037)	SIZE 12 BLOCK{||TRA->TR_SITUAC}						//Status da Reserva (Reservado)

oSection2:SetLeftMargin(07)

DEFINE SECTION oSection3 OF oReport TITLE oemtoAnsi(STR0005) TABLES "CTT", "TRA" 	//--Centro Custo 

	DEFINE CELL NAME "CENTROCUSTO"	OF oSection3 TITLE OemToAnsi(STR0005)	SIZE TamSx3("CTT_CUSTO")[1] BLOCK{||TRA->TR_CC}		//Centro de Custo
	DEFINE CELL NAME "DESCCCUSTO"	OF oSection3 TITLE "-"					SIZE 30 BLOCK{||Fdesc("CTT",TRA->TR_CC,"CTT_DESC01")}	//Descr. Centro de Custo

oSection3:SetLineStyle()
oSection3:SetCharSeparator("")

Return(oReport)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  �Microsiga           � Data �  10/25/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function TRM060Imp(oReport)

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
//� mv_par19        //  Treinamento 1-Aberto 2-Baixado 3-Ambos   �
//� mv_par20        //  Status Funcionario                       �
//� mv_par21        //  Ferias Programadas                       �
//����������������������������������������������������������������

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)  
Local oSection3	:= oReport:Section(2)
Private nOrdem	:= oSection1:GetOrder()

cArqDBF 	:= CriaTrab(NIL,.f.)
aFields 	:= {}
cAcessaRA3	:= &("{ || " + ChkRH("TRM060","RA3","2") + "}")
cAcessaRA4	:= &("{ || " + ChkRH("TRM060","RA4","2") + "}")
cSituacao 	:= mv_par20
nFerProg  	:= mv_par21
cSitFol   	:= ""

//��������������������������������������������������������������Ŀ
//� Altera Titulo do relatorio                                   �
//����������������������������������������������������������������
cTitulo 	:= If(AllTrim(oReport:Title())==AllTrim(cTitulo),cTitulo,oReport:Title()  )  + " "   //-- //-- Treinamentos Solicitados ou Baixados     Periodo:
cTitulo     += DtoC(mv_par17) + STR0011 + DtoC(mv_par18) 
oReport:SetTitle(cTitulo)

oSection1:Init()
oSection2:Init()                     
oSection3:Init()

AADD(aFields,{"TR_FILIAL" ,"C",02,0})
AADD(aFields,{"TR_CC"     ,"C",TamSx3("CTT_CUSTO")[1],0})
AADD(aFields,{"TR_MAT"    ,"C",06,0})
AADD(aFields,{"TR_NOME"   ,"C",30,0})
AADD(aFields,{"TR_CURSO"  ,"C",04,0})
AADD(aFields,{"TR_DESCURS","C",30,0})
AADD(aFields,{"TR_GRUPO"  ,"C",02,0})
AADD(aFields,{"TR_DEPTO"  ,"C",03,0})
AADD(aFields,{"TR_CARGO"  ,"C",05,0})
AADD(aFields,{"TR_DATAIN"	,"D",08,0})
AADD(aFields,{"TR_DATAFI"	,"D",08,0})
AADD(aFields,{"TR_CALEND"	,"C",05,0})
AADD(aFields,{"TR_DESCCAL"	,"C",20,0})
AADD(aFields,{"TR_TURMA"	,"C",03,0})
AADD(aFields,{"TR_SITUAC"	,"C",13,0})
AADD(aFields,{"TR_SINON"	,"C",04,0})
AADD(aFields,{"TR_DESCSI"	,"C",30,0})

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
IndRegua("TRA",cArqNtx,cIndCond,,,OemToAnsi(STR0012)) //"Selecionando Registros..."
dbGoTop()
oReport:SetMeter( 100 )  

//��������������������������������Ŀ
//� Treinamentos Baixados ou Ambos �
//����������������������������������
If mv_par19 == 2 .or. mv_par19 == 3 

	dbSelectArea("RA4")
	dbSetOrder(1)
	dbSeek(mv_par01+mv_par03+mv_par09,.T.)
	cInicio	:= "RA4->RA4_FILIAL + RA4->RA4_MAT + RA4->RA4_CURSO" 
	cFim	:= mv_par02 + mv_par04 + mv_par10

	While !Eof() .And. &cInicio <= cFim

		oReport:IncMeter( 1 )  

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
			cSitFol := TrmSitFol(RA4->RA4_DATAIN) 			
			cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)
			
			If 	(SRA->RA_MAT  	< mv_par03)	.Or. (SRA->RA_MAT 	> mv_par04)	.Or.;
				(SRA->RA_CC   	< mv_par05)	.Or. (SRA->RA_CC  	> mv_par06)	.Or.;
				(SRA->RA_NOME 	< mv_par07)	.Or. (SRA->RA_NOME 	> mv_par08)	.Or.;
				(cCargo 		< mv_par15) .Or. (cCargo 		> mv_par16)	.Or.;
				(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P"))  		.Or.;
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
			EndIf
		
			dbSelectArea("RA1")
			dbSetOrder(1)
			cFil := If(xFilial("RA1") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA4->RA4_CURSO)

			dbSelectArea("RA2")
			dbSetOrder(1)
			cFil := If(xFilial("RA2") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA4->RA4_CALEND+RA4->RA4_CURSO+RA4->RA4_TURMA)
				
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
				TRA->TR_DATAIN		:= RA4->RA4_DATAIN
				TRA->TR_DATAFI		:= RA4->RA4_DATAFI
				TRA->TR_CALEND		:= RA4->RA4_CALEND
				TRA->TR_DESCCAL		:= RA2->RA2_DESC
				TRA->TR_TURMA		:= RA4->RA4_TURMA
				TRA->TR_SITUAC		:= STR0025 	//"CONCLUIDO"
				TRA->TR_SINON		:= RA2->RA2_SINON
				TRA->TR_DESCSI		:= TrmDesc("RA9",RA2->RA2_SINON,"RA9->RA9_DESCR")
			MsUnlock()
		EndIf		
		
		dbSelectArea("RA4")
		dbSkip()
	EndDo
EndIf

//��������������������������������Ŀ
//�Treinamentos em aberto ou Ambos �
//����������������������������������
If mv_par19 == 1 .or. mv_par19 == 3 

	dbSelectArea("RA3")
	dbSetOrder(1)
	dbSeek(mv_par01+mv_par03+mv_par09,.T.)
	cInicio	:= "RA3->RA3_FILIAL + RA3->RA3_MAT + RA3->RA3_CURSO" 
	cFim	:= mv_par02 + mv_par04 + mv_par10

	While !Eof() .And. &cInicio <= cFim
            
		oReport:IncMeter(1)
		
		If !Eval(cAcessaRA3)
			dbSkip()
			Loop
		EndIf

		If RA3->RA3_CURSO  < mv_par09 .Or. RA3->RA3_CURSO  > mv_par10 .Or.;
			RA3->RA3_DATA < mv_par17 .Or. RA3->RA3_DATA > mv_par18
			dbSkip()
			Loop
		EndIf
	
	 	dbSelectArea("RA2")
		dbSeek(xFilial("RA2")+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
	
		dbSelectArea("SRA")
		dbSetOrder(1)
	
		If dbSeek(RA3->RA3_FILIAL+RA3->RA3_MAT)
			
			//��������������������������Ŀ
			//� Situacao do Funcionario  �
			//����������������������������			
			cSitFol := TrmSitFol(RA3->RA3_DATA)
			cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)

			If 	(SRA->RA_MAT  	< mv_par03)	.Or. 	(SRA->RA_MAT 	> mv_par04)	.Or.;
				(SRA->RA_CC   	< mv_par05)	.Or. 	(SRA->RA_CC  	> mv_par06)	.Or.;
				(SRA->RA_NOME 	< mv_par07)	.Or. 	(SRA->RA_NOME 	> mv_par08)	.Or.;
				(cCargo			< mv_par15) .Or.	(cCargo 		> mv_par16)	.Or.;
				(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P"))   		.Or.;
				(cSitfol == "P" .And. nFerProg == 2)
				
				dbSelectArea("RA3")
				dbSkip()
				Loop
			EndIf
				
			dbSelectArea( "SQ3" )
			dbSetOrder(1)
			cFil := If(xFilial("SQ3") == Space(2),Space(2),SRA->RA_FILIAL)
			If dbSeek( cFil + cCargo + SRA->RA_CC ) .OR. dbSeek( cFil + cCargo )
				If SQ3->Q3_GRUPO < mv_par11 .Or. SQ3->Q3_GRUPO > mv_par12 .Or.;
					SQ3->Q3_DEPTO < mv_par13 .Or. SQ3->Q3_DEPTO > mv_par14
					
					dbSelectArea("RA3")
					dbSkip()
					Loop
				EndIf
			Else
				dbSelectArea("RA3")
				dbSkip()
				Loop	
			EndIf
		
			dbSelectArea("RA1")
			dbSetOrder(1)
			cFil := If(xFilial("RA1") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA3->RA3_CURSO)

			dbSelectArea("RA2")
			dbSetOrder(1)
			cFil := If(xFilial("RA2") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
				
			RecLock("TRA",.T.)
				TRA->TR_FILIAL  	:= SRA->RA_FILIAL
				TRA->TR_CC      	:= SRA->RA_CC
				TRA->TR_MAT     	:= SRA->RA_MAT
				TRA->TR_NOME    	:= SRA->RA_NOME
				TRA->TR_CURSO	 	:= RA3->RA3_CURSO
				TRA->TR_DESCURS 	:= RA1->RA1_DESC
				TRA->TR_GRUPO   	:= SQ3->Q3_GRUPO
				TRA->TR_DEPTO   	:= SQ3->Q3_DEPTO
				TRA->TR_CARGO   	:= SQ3->Q3_CARGO
				TRA->TR_DATAIN		:= RA3->RA3_DATA
				TRA->TR_DATAFI		:= RA3->RA3_DATA
				TRA->TR_CALEND		:= RA3->RA3_CALEND
				TRA->TR_DESCCAL		:= RA2->RA2_DESC
				TRA->TR_TURMA		:= RA3->RA3_TURMA  
				TRA->TR_SINON		:= RA2->RA2_SINON
				TRA->TR_DESCSI		:= TrmDesc("RA9",RA2->RA2_SINON,"RA9->RA9_DESCR")
				
				cSituac := " "
				If RA3->RA3_RESERVA == "S"
				   cSituac := STR0022	//"Solicitacao"
				ElseIf RA3->RA3_RESERVA == "R"
				   cSituac := STR0023	//"Reserva"
				Else 
					cSituac := STR0024	//"Lista Espera" 
				EndIf
				TRA->TR_SITUAC		:= cSituac
			MsUnlock()
		EndIf		
		
		dbSelectArea("RA3")
		dbSkip()
	EndDo
EndIf

dbSelectArea("TRA")
dbGotop()

// Variaveis de totais da ordem selecionada
cAuxCurso	:= ""
cAuxTurma	:= ""
lRet		:= .T.
lOk			:= .F.
cCentro 	:= TRA->TR_CC
cCurso		:= TRA->TR_CURSO
cDescCur 	:= TRA->TR_DESCURS                  
cCalend		:= TRA->TR_CALEND
cDescCal	:= TRA->TR_DESCCAL
cTurma		:= TRA->TR_TURMA
cSinon 		:= TRA->TR_SINON
cDescSi		:= TRA->TR_DESCSI

While !Eof()

	oReport:IncMeter(1)
	
	If lRet
		If nOrdem == 2
			oReport:ThinLine()
			oReport:SkipLine()
			oSection3:PrintLine()
		EndIf
		lRet:= .F.
	EndIf		

	If cCurso+cCalend+cTurma # TRA->TR_CURSO+TRA->TR_CALEND+TRA->TR_TURMA
		cAuxCurso	:= ""
		cAuxTurma	:= ""
		cCurso   	:= TRA->TR_CURSO
		cDescCur 	:= TRA->TR_DESCURS
		cCalend		:= TRA->TR_CALEND
		cDescCal	:= TRA->TR_DESCCAL
		cTurma		:= TRA->TR_TURMA
		cSinon 		:= TRA->TR_SINON
		cDescSi		:= TRA->TR_DESCSI
	EndIf
	If nOrdem == 2 .And. cCentro #TRA->TR_CC
		oReport:ThinLine()       
		oReport:SkipLine()
		oSection3:PrintLine()
		cAuxCurso	:= ""
		cAuxTurma 	:= ""
		cCurso	 	:= TRA->TR_CURSO
		cDescCur	:= TRA->TR_DESCURS
		cCentro   	:= TRA->TR_CC  
		cCalend	 	:= TRA->TR_CALEND
		cDescCal	:= TRA->TR_DESCCAL
		cTurma	 	:= TRA->TR_TURMA
		cSinon 		:= TRA->TR_SINON
		cDescSi		:= TRA->TR_DESCSI
	EndIf
	FImpDet(oReport,oSection1,oSection2)		

	dbSelectArea("TRA")
	dbSkip()
EndDo

If !lRet
	If nOrdem == 2
		FImpDet(oReport,oSection1,oSection2)
	EndIf	
	lOk := .T.
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

dbSelectArea("RA3")
dbSetOrder(1)

dbSelectArea("RA4")
dbSetOrder(1)

dbSelectArea("SQ3") 
dbSetOrder(1)

dbSelectArea("RA1")
dbSetOrder(1)

Set Device To Screen

oSection1:Finish()
oSection2:Finish()                     
oSection3:Finish()

Return Nil

//���������������������������������������������
//� Imprime as linhas de detalhe do relatorio �
//���������������������������������������������
Static Function fImpDet(oReport,oSection1,oSection2)

cAuxDet := ""
DET :="   "

If cAuxCurso+cAuxTurma == cCurso+cTurma
	cCurso   := Space(05)
	cAuxDet 	:= ""
	cTurma	:= Space(03)
Else
	cAuxCurso := cCurso
	cAuxTurma := cTurma        
	oReport:ThinLine()
	oReport:SkipLine()    
	
	oSection2:Finish()                     
	
	oSection1:PrintLine()

	oSection2:Init()                     
		
EndIf	

cCurso := cAuxCurso								
cTurma := cAuxTurma

oSection2:PrintLine()

Return Nil



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �trm060R3()     � Autor � RH               � Data �27/07/2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � A partir do Release 4                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
//===>Daqui para baixo, trata-se do release 3 ou anterior
Function trm060R3()       

SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,AORD,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,LEND,COLUNAS")
SetPrvt("AT_PRG,WCABEC0,WCABEC1,CCABEC1,CONTFL,LI,NPAG")
SetPrvt("NTAMANHO,CTIT,TITULO,WNREL,NORDEM")
SetPrvt("CARQDBF,AFIELDS,CINDCOND,CARQNTX,CINICIO,CFIM")
SetPrvt("CFIL,NTOTGVL,NTOTGHR")
SetPrvt("CAUXCURSO,CAUXTURMA,LRET")
SetPrvt("LOK,CCENTRO,CCURSO,CCALEND,CTURMA,CDESCCUR,CDescCal,CAUXDET,DET,LIMP")
SetPrvt("cAcessaRA3,cAcessaRA4,CSINON,CDESCSI,cCargo")

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � TRM060   � Autor �  Equipe RH		    � Data � 20.10.00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Treinamentos Solicitados ou Baixados                       ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � TRM060                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RdMake                                                     ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���			   �		�	   � 					                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
cDesc1  := STR0001 //"Treinamentos Solicitados ou Baixados"
cDesc2  := STR0002 //"Ser� impresso de acordo com os parametros solicitados pelo"
cDesc3  := STR0003 //"usu�rio."
cString := "SRA"   //-- alias do arquivo principal (Base)
aOrd    := { STR0004,STR0005,STR0006,STR0016 } 	//"Matricula"###"Centro de Custo"###"Nome"###"Data"

//��������������������������������������������������������������Ŀ
//� Define Variaveis (Basicas)                                   �
//����������������������������������������������������������������
aReturn  := { STR0007,1,STR0008,2,2,1,"",1 } //"Zebrado"###"Administra��o"
NomeProg := "TRM060"
aLinha   := {}
nLastKey := 0
cPerg    := "TRR60A"
lEnd     := .F.
lImp	 := .F.

//��������������������������������������������������������������Ŀ
//� Define Variaveis (Programa)                                  �
//����������������������������������������������������������������
Colunas  := 132
at_Prg   := "TRM060"
wCabec0  := 0
wCabec1  := ""
Contfl   := 1
Li       := 0
nPag     := 0
nTamanho := "M"
cTit     := STR0009 //"Treinamentos Solicitados ou Baixados"

//��������������������������������������������������������������Ŀ
//� Correcao nas perguntas - Retirar nas novas versoes           �
//����������������������������������������������������������������
AcertSX1()

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
pergunte("TRR60A",.F.)

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
//� mv_par19        //  Treinamento 1-Aberto 2-Baixado 3-Ambos   �
//� mv_par20        //  Status Funcionario                       �
//� mv_par21        //  Ferias Programadas                       �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
WnRel :="TRM060"	//-- Nome Default do relatorio em Disco.
WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd)

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

RptStatus({|lEnd| Relato()},cTit)
Return


//�����������������
//� Funcao Relato �
//�����������������
Static Function Relato()

nOrdem  	:= aReturn[8]
cArqDBF 	:= CriaTrab(NIL,.f.)
aFields 	:= {}
Titulo   	:= STR0010 + DtoC(mv_par17) + STR0011 + DtoC(mv_par18)  //"Custo do Treinamento     Periodo:"###" a "
cAcessaRA3	:= &("{ || " + ChkRH("TRM060","RA3","2") + "}")
cAcessaRA4	:= &("{ || " + ChkRH("TRM060","RA4","2") + "}")
cSituacao 	:= mv_par20
nFerProg  	:= mv_par21
cSitFol   	:= ""

AADD(aFields,{"TR_FILIAL" ,"C",02,0})
AADD(aFields,{"TR_CC"     ,"C",TamSx3("CTT_CUSTO")[1],0})
AADD(aFields,{"TR_MAT"    ,"C",06,0})
AADD(aFields,{"TR_NOME"   ,"C",30,0})
AADD(aFields,{"TR_CURSO"  ,"C",04,0})
AADD(aFields,{"TR_DESCURS","C",30,0})
AADD(aFields,{"TR_GRUPO"  ,"C",02,0})
AADD(aFields,{"TR_DEPTO"  ,"C",03,0})
AADD(aFields,{"TR_CARGO"  ,"C",05,0})
AADD(aFields,{"TR_DATAIN"	,"D",08,0})
AADD(aFields,{"TR_DATAFI"	,"D",08,0})
AADD(aFields,{"TR_CALEND"	,"C",05,0})
AADD(aFields,{"TR_DESCCAL"	,"C",20,0})
AADD(aFields,{"TR_TURMA"	,"C",03,0})
AADD(aFields,{"TR_SITUAC"	,"C",13,0})
AADD(aFields,{"TR_SINON"	,"C",04,0})
AADD(aFields,{"TR_DESCSI"	,"C",30,0})

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

//��������������������������������Ŀ
//� Treinamentos Baixados ou Ambos �
//����������������������������������
If mv_par19 == 2 .or. mv_par19 == 3 

	dbSelectArea("RA4")
	dbSetOrder(1)
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
			cSitFol := TrmSitFol(RA4->RA4_DATAIN) 
			cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)
			
			If 	(SRA->RA_MAT  	< mv_par03)	.Or. (SRA->RA_MAT 	> mv_par04)	.Or.;
				(SRA->RA_CC   	< mv_par05)	.Or. (SRA->RA_CC  	> mv_par06)	.Or.;
				(SRA->RA_NOME 	< mv_par07)	.Or. (SRA->RA_NOME 	> mv_par08)	.Or.;
				(cCargo 		< mv_par15) .Or. (cCargo 		> mv_par16)	.Or.;
				(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P"))  		.Or.;
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
			EndIf
		
			dbSelectArea("RA1")
			dbSetOrder(1)
			cFil := If(xFilial("RA1") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA4->RA4_CURSO)

			dbSelectArea("RA2")
			dbSetOrder(1)
			cFil := If(xFilial("RA2") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA4->RA4_CALEND+RA4->RA4_CURSO+RA4->RA4_TURMA)
				
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
				TRA->TR_DATAIN		:= RA4->RA4_DATAIN
				TRA->TR_DATAFI		:= RA4->RA4_DATAFI
				TRA->TR_CALEND		:= RA4->RA4_CALEND
				TRA->TR_DESCCAL		:= RA2->RA2_DESC
				TRA->TR_TURMA		:= RA4->RA4_TURMA
				TRA->TR_SITUAC		:= STR0025 	//"CONCLUIDO"
				TRA->TR_SINON		:= RA2->RA2_SINON
				TRA->TR_DESCSI		:= TrmDesc("RA9",RA2->RA2_SINON,"RA9->RA9_DESCR")
			MsUnlock()
		EndIf		
		
		dbSelectArea("RA4")
		dbSkip()
	EndDo
EndIf

//��������������������������������Ŀ
//�Treinamentos em aberto ou Ambos �
//����������������������������������
If mv_par19 == 1 .or. mv_par19 == 3 

	dbSelectArea("RA3")
	dbSetOrder(1)
	dbSeek(mv_par01+mv_par03+mv_par09,.T.)
	cInicio	:= "RA3->RA3_FILIAL + RA3->RA3_MAT + RA3->RA3_CURSO" 
	cFim	:= mv_par02 + mv_par04 + mv_par10

	SetRegua(RecCount())

	While !Eof() .And. &cInicio <= cFim
            
		If !Eval(cAcessaRA3)
			dbSkip()
			Loop
		EndIf

		If RA3->RA3_CURSO  < mv_par09 .Or. RA3->RA3_CURSO  > mv_par10 .Or.;
			RA3->RA3_DATA < mv_par17 .Or. RA3->RA3_DATA > mv_par18
			dbSkip()
			Loop
		EndIf
	
	 	dbSelectArea("RA2")
		dbSeek(xFilial("RA2")+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
	
		dbSelectArea("SRA")
		dbSetOrder(1)
	
		If dbSeek(RA3->RA3_FILIAL+RA3->RA3_MAT)
			
			//��������������������������Ŀ
			//� Situacao do Funcionario  �
			//����������������������������			
			cSitFol := TrmSitFol(RA3->RA3_DATA)
			cCargo 	:= fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)

			If 	(SRA->RA_MAT  	< mv_par03)	.Or. 	(SRA->RA_MAT 	> mv_par04)	.Or.;
				(SRA->RA_CC   	< mv_par05)	.Or. 	(SRA->RA_CC  	> mv_par06)	.Or.;
				(SRA->RA_NOME 	< mv_par07)	.Or. 	(SRA->RA_NOME 	> mv_par08)	.Or.;
				(cCargo			< mv_par15) .Or.	(cCargo 		> mv_par16)	.Or.;
				(!(cSitfol $ cSituacao) 	.And.	(cSitFol <> "P"))   		.Or.;
				(cSitfol == "P" .And. nFerProg == 2)
				
				dbSelectArea("RA3")
				dbSkip()
				Loop
			EndIf
				
			dbSelectArea( "SQ3" )
			dbSetOrder(1)
			cFil := If(xFilial("SQ3") == Space(2),Space(2),SRA->RA_FILIAL)
			If dbSeek( cFil + cCargo + SRA->RA_CC ) .OR. dbSeek( cFil + cCargo )
				If SQ3->Q3_GRUPO < mv_par11 .Or. SQ3->Q3_GRUPO > mv_par12 .Or.;
					SQ3->Q3_DEPTO < mv_par13 .Or. SQ3->Q3_DEPTO > mv_par14
					
					dbSelectArea("RA3")
					dbSkip()
					Loop
				EndIf
			Else
				dbSelectArea("RA3")
				dbSkip()
				Loop	
			EndIf
		
			dbSelectArea("RA1")
			dbSetOrder(1)
			cFil := If(xFilial("RA1") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA3->RA3_CURSO)

			dbSelectArea("RA2")
			dbSetOrder(1)
			cFil := If(xFilial("RA2") == Space(2),Space(2),SRA->RA_FILIAL)
			dbSeek(cFil+RA3->RA3_CALEND+RA3->RA3_CURSO+RA3->RA3_TURMA)
				
			RecLock("TRA",.T.)
				TRA->TR_FILIAL  	:= SRA->RA_FILIAL
				TRA->TR_CC      	:= SRA->RA_CC
				TRA->TR_MAT     	:= SRA->RA_MAT
				TRA->TR_NOME    	:= SRA->RA_NOME
				TRA->TR_CURSO	 	:= RA3->RA3_CURSO
				TRA->TR_DESCURS 	:= RA1->RA1_DESC
				TRA->TR_GRUPO   	:= SQ3->Q3_GRUPO
				TRA->TR_DEPTO   	:= SQ3->Q3_DEPTO
				TRA->TR_CARGO   	:= SQ3->Q3_CARGO
				TRA->TR_DATAIN		:= RA3->RA3_DATA
				TRA->TR_DATAFI		:= RA3->RA3_DATA
				TRA->TR_CALEND		:= RA3->RA3_CALEND
				TRA->TR_DESCCAL		:= RA2->RA2_DESC
				TRA->TR_TURMA		:= RA3->RA3_TURMA  
				TRA->TR_SINON		:= RA2->RA2_SINON
				TRA->TR_DESCSI		:= TrmDesc("RA9",RA2->RA2_SINON,"RA9->RA9_DESCR")
				
				cSituac := " "
				If RA3->RA3_RESERVA == "S"
				   cSituac := STR0022	//"Solicitacao"
				ElseIf RA3->RA3_RESERVA == "R"
				   cSituac := STR0023	//"Reserva"
				Else 
					cSituac := STR0024	//"Lista Espera" 
				EndIf
				TRA->TR_SITUAC		:= cSituac
			MsUnlock()
		EndIf		
		
		dbSelectArea("RA3")
		dbSkip()
	EndDo
EndIf

dbSelectArea("TRA")
dbGotop()

// Variaveis de totais da ordem selecionada
cAuxCurso	:= ""
cAuxTurma	:= ""
lRet		:= .T.
lOk			:= .F.
cCentro 	:= TRA->TR_CC
cCurso		:= TRA->TR_CURSO
cDescCur 	:= TRA->TR_DESCURS                  
cCalend		:= TRA->TR_CALEND
cDescCal	:= TRA->TR_DESCCAL
cTurma		:= TRA->TR_TURMA
cSinon 		:= TRA->TR_SINON
cDescSi		:= TRA->TR_DESCSI

While !Eof()
	If lRet
		If nOrdem == 2
			FImpCC()
		EndIf
		lRet:= .F.
	EndIf		

	If cCurso+cCalend+cTurma # TRA->TR_CURSO+TRA->TR_CALEND+TRA->TR_TURMA
		cAuxCurso	:= ""
		cAuxTurma	:= ""
		cCurso   	:= TRA->TR_CURSO
		cDescCur 	:= TRA->TR_DESCURS
		cCalend		:= TRA->TR_CALEND
		cDescCal	:= TRA->TR_DESCCAL
		cTurma		:= TRA->TR_TURMA
		cSinon 		:= TRA->TR_SINON
		cDescSi		:= TRA->TR_DESCSI
	EndIf
	If nOrdem == 2 .And. cCentro #TRA->TR_CC
		FImpCC()
		cAuxCurso	:= ""
		cAuxTurma 	:= ""
		cCurso	 	:= TRA->TR_CURSO
		cDescCur	:= TRA->TR_DESCURS
		cCentro   	:= TRA->TR_CC  
		cCalend	 	:= TRA->TR_CALEND
		cDescCal	:= TRA->TR_DESCCAL
		cTurma	 	:= TRA->TR_TURMA
		cSinon 		:= TRA->TR_SINON
		cDescSi		:= TRA->TR_DESCSI
	EndIf
	R3FImpDet()		

	dbSelectArea("TRA")
	dbSkip()
EndDo

If !lRet
	If nOrdem == 2
		R3FImpDet()
	EndIf	
	lOk := .T.
EndIf	

If lImp
	Impr("","F")
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

dbSelectArea("RA3")
dbSetOrder(1)

dbSelectArea("RA4")
dbSetOrder(1)

dbSelectArea("SQ3") 
dbSetOrder(1)

dbSelectArea("RA1")
dbSetOrder(1)

Set Device To Screen

If aReturn[5] == 1
   Set Printer To
   Commit
   ourspool(wnrel)
Endif

MS_FLUSH()

Return Nil

//����������������������������������
//� Imprime Cabecalho do relatorio �
//����������������������������������
Static Function fImpCab()

If nOrdem #3 
	cCabec1	:= STR0014	//"FIL. MATR.  NOME 									GRUPO 			 DEPARTAMENTO 			 CARGO 					 SITUACAO"                           
Else
	cCabec1 := STR0015	//"NOME                             FIL. MATR. GRUPO 			 DEPARTAMENTO 			 CARGO 					 SITUACAO"                           
EndIf						  
Impr("","C")
Impr(CCABEC1, "C")
lImp := .T.
Return Nil

//���������������������������������������������
//� Imprime as linhas de detalhe do relatorio �
//���������������������������������������������
Static Function R3fImpDet()

cAuxDet := ""
DET :="   "

If cAuxCurso+cAuxTurma == cCurso+cTurma
	cCurso   := Space(05)
	cAuxDet 	:= ""
	cTurma	:= Space(03)
Else
	cAuxCurso := cCurso
	cAuxTurma := cTurma        
	If nOrdem == 2 
		Impr("","C")
	ElseIf lImp
		Impr(Repl('-', colunas), "C")
	EndIf
	cAuxDet	:= STR0017+cCurso+" - "+cDescCur + STR0020+cCalend+" - "+cDescCal + STR0018+cTurma + STR0021+Dtoc(TRA->TR_DATAIN)+" - "+Dtoc(TRA->TR_DATAFI) //"CURSO: " / " CALENDARIO: " / " TURMA: " / " PERIODO: "
	IMPR(cAuxDet,"C")
	
	cAuxDet	:= STR0026+cSinon+" - "+cDescSi //"SINONIMO DE CURSO: "
	IMPR(cAuxDet,"C")
	
	FimpCab()
EndIf	

If nOrdem #3 
	DET := "   "
	DET := DET + Space(02) + TRA->TR_FILIAL + Space(01) + TRA->TR_MAT + Space(01) + TRA->TR_NOME + Space(02)
Else
	DET := "   "
	DET := DET + TRA->TR_NOME + Space(03) + TRA->TR_FILIAL + Space(01) + TRA->TR_MAT + Space(02)
EndIf
	
cCurso := cAuxCurso								
cTurma := cAuxTurma

DET := DET + PadR(TrmDesc("SQ0",TRA->TR_GRUPO,"SQ0->Q0_DESCRIC"),15)+ " " 
DET := DET + PadR(TrmDesc("SQB",TRA->TR_DEPTO,"SQB->QB_DESCRIC"),20) + " " 
DET := DET + PadR(TrmDesc("SQ3",TRA->TR_CARGO,"SQ3->Q3_DESCSUM"),30) + " "
DET := DET + TRA->TR_SITUAC

IMPR(DET,"C")
Return Nil


//�����������������������������������Ŀ
//� Imprime quebra do Centro de custo �
//�������������������������������������
Static Function FImpCC()

If lImp
	Impr(Repl('-', colunas), "C")
	IMPR("","C")
EndIf
DET := STR0019 + TRA->TR_CC + " - " + DescCC(TRA->TR_CC)		// "CENTRO DE CUSTO: "
IMPR(DET,"C")   

Return (Nil)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AcertSX1	 � Autor � Desenvolvimento RH   � Data � 22/07/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Inclusao de consulta (F3) nas perguntas Grupo/Depto/Cargo.  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �TRM060	                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function AcertSX1()

Local aSaveArea := GetArea()
Local aPerg		:= {}
Local aRegs		:= {} 
Local nx		:= 0
Local aHelp		:= {}
Local aHelpE	:= {}
Local aHelpI	:= {}
Local cHelp		:= ""

aHelp:= {"Informe se deseja que sejam ",;
         "consideradas as ferias programadas ",;
         "na emissao do relatorio."}
aHelpE	:= {"Informe si desea que se consideren",;
            "las vacaciones programadas cuando ",;
            "se emita el informe.   "    }
aHelpI	:= {"Inform whether you want to consider ",;
            "the programmed vacation during printing ",;
            "the report. "}

PutSX1Help("P"+cHelp,aHelp,aHelpI,aHelpE)

/*
������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
�           Grupo   Ordem   Pergunta Portugues   Pergunta Espanhol                 Pergunta Ingles          Variavel Tipo Tamanho Decimal Presel  GSC   Valid   Var01      Def01             DefSPA1        DefEng1    Cnt01       Var02  Def02     DefSpa2   DefEng2  Cnt02 Var03 Def03   DefSpa3   DefEng3    Cnt03 Var04 Def04  DefSpa4 DefEng4 Cnt04  Var05  Def05 DefSpa5 DefEng5 Cnt05  XF3   GrgSxg  cPyme aHelpPor aHelpEng aHelpSpa      cHelp                                                                                                                                          �
��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������*/
Aadd(aRegs,{cPerg ,"21","Ferias Programadas  ?"  ,"�Vacaciones Programadas  ?"   ,"Scheduled Vacation ?"  ,"MV_CHL","N" ,01      ,0     ,1     ,"C"  ,""     ,"MV_PAR22","Sim  "         ,"Si"            ,"Yes"    ,""          ,""   ,"Nao"   ,"No"     ,"No"     ,""  ,""   ,""    ,""       ,""         ,""   ,""   ,""   ,""     ,""     ,""   ,""    ,""    ,""     ,""     ,""   ,""    ,""    ,"S"  ,aHelp   ,aHelpI  ,aHelpE       ,      })

ValidPerg(aRegs,cPerg,.T.)

Aadd( aPerg, {"11", "SQ0"} )	//Grupo
Aadd( aPerg, {"12", "SQ0"} )	
Aadd( aPerg, {"13", "SQB"} )	//Depto
Aadd( aPerg, {"14", "SQB"} )		
Aadd( aPerg, {"15", "SQ3"} ) 	//Cargo
Aadd( aPerg, {"16", "SQ3"} )		

For nx := 1 To Len(aPerg)

	dbSelectArea("SX1")   
	dbSetOrder(1)
	If dbSeek("TRR60A"+aPerg[nx][1]) .And. Empty(SX1->X1_F3)	
		RecLock("SX1",.F.)
	    	SX1->X1_F3	:= aPerg[nx][2]
		MsUnlock()
	EndIf	
Next nx


RestArea(aSaveArea)

Return Nil
