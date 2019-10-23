#IFNDEF WINDOWS
#DEFINE PSAY SAY
#ENDIF

#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"
#Include "MSOLE.CH"

Static cCodIns

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � SECR002	� Autor �Regiane & LeandroSD    � Data � 03/06/02 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Emite o historico escolar						       	  ���
�������������������������������������������������������������������������Ĵ��
���Uso		 � Especifico Academico 							          ���
�������������������������������������������������������������������������Ĵ��
���Analista  � Data/Bops/Ver �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���PESeiding.�12/02/07�107253�Inser��o dos campos de Portaria, Data/Port.,���
���          �        �      �Data Publica��o da Portaria de Reconhecim.  ���
���          �        �      �do curso e ENADE.                           ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function SECR002()
Local oDlgPrint,oBtnImp,oBtnSair,oBtnPar,oMemo,oGroup
Local cPerg     := "SEC002"
Local cObjetivo := ""
Local lOpc      := .f.
Local cFiltro   := ""

//Funcoes requeridas para as funcoes de impressao
Private nLastKey  := 0
Private cArqTRBC  := ""
Private cArqTRBI  := ""
Private cOrder    := ""

Private cPRO := Space(6)
Private cSEC := Space(6) 
Private cJahGrupo


if cCodIns == nil
	cCodIns := GetMV("MV_ACCODIN")
endif

cObjetivo := "Este programa tem como objetivo, imprimir o Historico "
cObjetivo += "Escolar de acordo com os par�metros informados pelo usu�rio."

Pergunte(cPerg,.F.)

//�����������������������������������������������������������������Ŀ
//�Definicao da tela												�
//�������������������������������������������������������������������

oDlgPrint := MSDialog():New( 10,10,250,350,"Impress�o de Historico Escolar",,,,,,,,,.T. )

oGroup    := TGroup():New( 3,4,115,166,"",,,,.T.,.T.)

//�����������������������������������������������������������������Ŀ
//�Definicao dos Botoes											    �
//�������������������������������������������������������������������

oBtnImp   := SButton():New( 15, 125, 1, {|| oDlgPrint:End(),lOpc := .T.},,.T. )
oBtnSair  := SButton():New( 35, 125, 2, {|| oDlgPrint:End()},,.T. )
oBtnPar   := SButton():New( 55, 125, 5, {|| Pergunte(cPerg,.T.)},,.T. )

oBtnImp :cToolTip  := "Imprimir..."
oBtnSair:cToolTip  := "Sair..."
oBtnPar :cToolTip  := "Par�metros..."

//�����������������������������������������������������������������Ŀ
//�Definicao do campo Memo                                          �
//�������������������������������������������������������������������

oMemo:= tMultiget():New(10,10,{|u|if(Pcount()>0,cObjetivo:=u,cObjetivo)},oDlgPrint,100,100,,,,,,.T.,,,{||.F.})

oDlgPrint:Activate(,,,.T.,,,)

If lOpc
	
	cFiltro := "SELECT DISTINCT "
	cFiltro += "	JBE.JBE_NUMRA NUMRA, "
	cFiltro += "	JBE.JBE_CODCUR CODCUR, "
	cFiltro += "	JAF.JAF_DESMEC DESCCUR, "
	cFiltro += "	JAF.JAF_COD ccURLO, "
	cFiltro += "	JAH.JAH_GRUPO "
	cFiltro += "FROM "
	cFiltro += "	" + RetSQLName("JBE") + " JBE, "
	cFiltro += "	" + RetSQLName("JAH") + " JAH, "
	cFiltro += "	" + RetSQLName("JAF") + " JAF "
	cFiltro += "WHERE "
	cFiltro += " JBE.JBE_FILIAL = '" + xFilial( "JBE" ) 	+ "' "
	cFiltro += "	AND JAF.JAF_FILIAL = '"	+ xFilial( "JAF" ) 	+ "' "
	cFiltro += "	AND JAH.JAH_FILIAL = '"	+ xFilial( "JAH" ) 	+ "' "
	cFiltro += "	AND JBE.JBE_NUMRA  Between '" + mv_par01 + "' And '"+mv_par02	+"' "
	cFiltro += "	AND JBE.JBE_CODCUR Between '" + mv_par05 + "' And '"+mv_par06	+"' "
	cFiltro += "	AND JBE.JBE_TURMA  Between '" + mv_par07 + "' And '"+mv_par08	+"' "
	cFiltro += "	AND JAH.JAH_UNIDAD Between '" + mv_par09 + "' And '"+mv_par10	+ "' "
	cFiltro += "	AND JAH.JAH_CODIGO = JBE.JBE_CODCUR "
	cFiltro += "	AND JAF.JAF_COD    = JAH.JAH_CURSO "
	cFiltro += "	AND JAF.JAF_VERSAO = JAH.JAH_VERSAO "
	cFiltro += "	AND JAF.JAF_AREA   Between '" + mv_par03 + "' And '"+ mv_par04 	+ "' "
	cFiltro += "	AND JAH.D_E_L_E_T_<>'*' "
	cFiltro += "	AND JAF.D_E_L_E_T_<>'*' "
	cFiltro += "	AND JBE.D_E_L_E_T_<>'*'	"
	cFiltro += "ORDER BY "
	cFiltro += "	NUMRA, CODCUR "
	cFiltro := ChangeQuery(cFiltro)
	
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cFiltro),"TMP", .F., .T.)
	TMP->( dbGotop() )

	//�������������������������������������������������Ŀ
	//� Chamada da rotina de escolha de assinaturas.... �
	//���������������������������������������������������
	If TMP->(!Eof())                
		cJahGrupo := TMP->JAH_GRUPO
		If cJahGrupo $ '004/008'
			cVar := SPACE (500)
			Processa({||U_sASIN() })
		ELSE
			Processa({||U_ASSREQ() })
		ENDIF
	EndIf	

	while TMP->( !eof() ) 

		cARcUR	:=	TMP->ccURLO
		Processa( { || ACATRB0002(.T.,TMP->NUMRA,TMP->CODCUR,TMP->DESCCUR, mv_par11 == 2,cARcUR) } )
		TMP->( dbSkip() )

	end
	TMP->( dbCloseArea() )
	
EndIf
Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � SEC0002	� Autor �Regiane & LeandroSD    � Data � 03/06/02 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Emite o historico escolar						       	  ���
�������������������������������������������������������������������������Ĵ��
���Uso		 � Especifico Academico 							          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function SEC0002()
Local nLastKey	:= 0

Private cPRO						:= Space(6)
Private cSEC						:= Space(6)

//Chamada da rotina de escolha de assinaturas....
Processa({||U_ASSREQ() })

If nLastKey == 27
	Set Filter To
	Return
EndIf

// Chamada da rotina de armazenamento de dados...
Processa({||ACATRB0002() })

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 �ACATRB0002� Autor �Regiane & LeandroSD    � Data � 03/06/02 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Armazenamento e Tratamento dos dados 					  ���
�������������������������������������������������������������������������Ĵ��
��� Uso 	 � Especifico Academico              				          ���
�������������������������������������������������������������������������Ĵ��
��� Revis�o  �								            � Data �  		  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
STATIC FUNCTION ACATRB0002(lViaMenu,cRa,cCodCur,cDescCur,lPrint,cARcUR)
Local aArea			:= GetArea()
Local aCamposC		:= {}
Local aCamposD		:= {}
Local aCamposI		:= {}
Local cQuery		:= ""
Local aTamRA		:= TamSX3("JA2_NUMRA")
Local aDispGrade	:= {}
Local aRet			:= {}
Local lOracle		:= "ORACLE" $ TcGetDb()
Local lDisPai		:= .F.	// Indica se eh uma disciplina pai
Local lAchou
Local cArqTRBC  	:= ""
Local cArqTRBI  	:= ""
Local cIndTRBI1  	:= ""
Local cIndTRBI2  	:= ""
Local aPerLets		:= {}
Local aDisOpt		:= {}
Local nLenOpt		:= 0
Local nInd			:= 0
Local nInd2			:= 0
Local aDisPai       := {}
Local aAreaJC7
Local cDisOri
Local nMedia
Local nPesos 		:= 0
Local cDisPai       := ""
Local nPosDisPai    := 0	//Posicao da Disciplina Pai
Local cPerLetPai    := ""	//Periodo letivo do pai       
Local cSeq			:= ""

lViaMenu := if( lViaMenu == NIL, .F., lViaMenu )
lPrint   := if( lPrint == NIL, .F., lPrint )

ProcRegua( 4 )

JDK->(DBSetOrder(1))  
JCL->(DBSetOrder(1))  
dbselectarea("JAH")                  


If !lViaMenu
	cRA 		:= Left(JBH_CODIDE,aTamRA[1])
	cNumReq 	:= JBH->JBH_NUM
	aRet 		:= ACScriptReq( cNumReq )
	IF ALLTRIM(Posicione("JAH",1,xFilial("JAH")+aRet[1],"JAH_GRUPO")) $ '004/008'
		U_ACATRBLE2D(.F.,cRa,cCodCur,cDescCur,lPrint,cARcUR,cVar)
		RETURN
	ENDIF
Else
	aRet 		:= {cCodCur,cDescCur}
	If cJahGrupo $ '004/008'
		U_ACATRBLE2D(.T.,cRa,cCodCur,cDescCur,lPrint,cARcUR,cVar)
		RETURN
	ENDIF
EndIf


//��������������������������������������������������������������Ŀ
//� Cria Arquivos de Trabalho			       				     �
//����������������������������������������������������������������
Aadd(aCamposC,{"NUMRA"			,"C",TamSX3("JA2_NUMRA")[1],0})
Aadd(aCamposC,{"UNIDADE"		,"C",TamSX3("JA3_DESLOC")[1],0})
Aadd(aCamposC,{"CEP"      		,"C",008,0})
Aadd(aCamposC,{"ENDERECO" 		,"C",TamSX3("JA3_END")[1],0})
Aadd(aCamposC,{"NUMEND"   		,"C",TamSX3("JA3_NUMEND")[1],0})
Aadd(aCamposC,{"COMPLE"   		,"C",TamSX3("JA3_COMPLE")[1],0})
Aadd(aCamposC,{"BAIRRO"   		,"C",TamSX3("JA3_BAIRRO")[1],0})
Aadd(aCamposC,{"CIDADE"   		,"C",TamSX3("JA3_CIDADE")[1],0})
Aadd(aCamposC,{"ESTADO"   		,"C",002,0})
Aadd(aCamposC,{"FONE"     		,"C",TamSX3("JA3_FONE")[1],0})
Aadd(aCamposC,{"CODCUR"   		,"C",TamSX3("JAH_CODIGO")[1],0})
Aadd(aCamposC,{"HABILI"			,"C",TamSX3("JDK_CODIGO")[1],0})
Aadd(aCamposC,{"CURSO"			,"C",TamSX3("JAF_DESMEC")[1],0})
Aadd(aCamposC,{"DECRET"			,"C",TamSX3("JCF_MEMO3")[1],0})
Aadd(aCamposC,{"NOME"			,"C",TamSX3("JA2_NOME")[1],0})
Aadd(aCamposC,{"NACION"			,"C",030,0})
Aadd(aCamposC,{"NATURA"			,"C",030,0})
Aadd(aCamposC,{"DTNASC"			,"D",008,0})
Aadd(aCamposC,{"RG"				,"C",TamSX3("JA2_RG")[1],0})
Aadd(aCamposC,{"ESTRG"			,"C",002,0})
Aadd(aCamposC,{"TITULO"			,"C",TamSX3("JA2_TITULO")[1],0})
Aadd(aCamposC,{"ENTIDA"			,"C",TamSX3("JCL_NOME")[1],0})
Aadd(aCamposC,{"ENTCID"			,"C",TamSX3("JCL_CIDADE")[1],0})
Aadd(aCamposC,{"ENTEST"			,"C",002,0})
Aadd(aCamposC,{"CONCLU"			,"C",004,0})
Aadd(aCamposC,{"INSTIT"			,"C",006,0})
Aadd(aCamposC,{"DATAPR"			,"C",TamSX3("JA2_DATAPR")[1],0})
Aadd(aCamposC,{"CLASSF"			,"C",006,0})
Aadd(aCamposC,{"PONTUA"			,"N",008,2})
Aadd(aCamposC,{"CHCURSO"		,"N",TamSX3("JAF_CARGA")[1],0})
Aadd(aCamposC,{"INICIO"			,"D",008,0})
Aadd(aCamposC,{"FIM"			,"D",008,0})
Aadd(aCamposC,{"LOCAL"			,"C",006,0})
Aadd(aCamposC,{"DISPRO"			,"C",006,0})
Aadd(aCamposC,{"FORING"			,"C",001,0})
Aadd(aCamposC,{"CMILIT"			,"C",014,0})
Aadd(aCamposC,{"SEXO"			,"C",001,0})
Aadd(aCamposC,{"QTDOPT"			,"N",002,0})
Aadd(aCamposC,{"CURPAD"			,"C",TamSX3("JAF_COD")[1],0})
Aadd(aCamposC,{"VERSAO"			,"C",TamSX3("JAF_VERSAO")[1],0})
Aadd(aCamposC,{"DESCHABILI"		,"C",TamSX3("JDK_DESC")[1],0})
Aadd(aCamposC,{"NOMEINSTIT"		,"C",TamSX3("JCL_NOME")[1],0})

cArqTRBC := CriaTrab(aCamposC,.T.)
dbUseArea( .T.,, cArqTRBC, "TRBC", .F., .F. )
IndRegua( "TRBC",cArqTRBC,"NUMRA+CURSO",,,"Selecionando Registros...")

Aadd(aCamposI,{"CODCUR"			,"C",006,0})
Aadd(aCamposI,{"ANO"			,"C",004,0})
Aadd(aCamposI,{"PERIOD"			,"C",002,0})
Aadd(aCamposI,{"CODDIS"			,"C",TamSX3("JAE_CODIGO")[1],0})
Aadd(aCamposI,{"DISCIP"			,"C",TamSX3("JAE_DESC")[1],0})
Aadd(aCamposI,{"MEDIA"			,"N",TamSX3("JC7_MEDFIM")[1],TamSX3("JC7_MEDFIM")[2]})
Aadd(aCamposI,{"MEDCON"			,"C",TamSX3("JC7_MEDCON")[1],0})
Aadd(aCamposI,{"DESMCO"			,"C",TamSX3("JC7_DESMCO")[1],0})
Aadd(aCamposI,{"CH"				,"N",004,0})
Aadd(aCamposI,{"SITUAC"			,"C",001,0})
Aadd(aCamposI,{"INSTIT"			,"C",006,0})
Aadd(aCamposI,{"ANOINS"			,"C",TamSX3("JCO_ANOINS")[1],0})
Aadd(aCamposI,{"AE"				,"C",001,0})
Aadd(aCamposI,{"SEMESTRE"		,"C",002,0})
Aadd(aCamposI,{"HABILI"  		,"C",TamSX3("JC7_HABILI")[1],TamSX3("JC7_HABILI")[2]})
Aadd(aCamposI,{"CODPROF"		,"C",006,0})
Aadd(aCamposI,{"NOMEPROF"		,"C",TamSX3("RA_NOME")[1],0})
Aadd(aCamposI,{"CARGOPRF"		,"C",030,0})
Aadd(aCamposI,{"FALTAS"			,"N",004,0})
Aadd(aCamposI,{"TIPODIS"		,"C",003,0})
Aadd(aCamposI,{"OPTATIVA"		,"C",001,0})
Aadd(aCamposI,{"ORDEM"			,"C",001,0})
Aadd(aCamposI,{"TOTCHARG"		,"N",004,0})

cArqTRBI := CriaTrab(aCamposI,.T.)
dbUseArea( .T.,, cArqTRBI, "TRBI", .F., .F. )
cIndTRBI1 := CriaTrab(,.F.)
cIndTRBI2 := CriaTrab(,.F.)
IndRegua( "TRBI",cIndTRBI1,"CODCUR+ORDEM+SEMESTRE+HABILI+CODDIS",,,"Selecionando Registros...")
IndRegua( "TRBI",cIndTRBI2,"CODCUR+CODDIS",,,"Selecionando Registros...")

TRBI->( dbClearIndex() )
TRBI->( dbSetIndex( cIndTRBI1 ) )
TRBI->( dbSetIndex( cIndTRBI2 ) )

//�����������������������������������������������������������������������Ŀ
//� Query do cabecalho   				   	                              �
//�������������������������������������������������������������������������
cQuery := "SELECT "
cQuery += "	JAH.JAH_CODIGO CODCUR , "
cQuery += "	JAH.JAH_CURSO CURPAD , "
cQuery += "	JAH.JAH_VERSAO VERSAO , "
cQuery += "	JA2.JA2_NUMRA NUMRA , "
cQuery += "	JA2.JA2_NOME NOME , "
cQuery += "	JA2.JA2_NACION NACION , "
cQuery += "	JA2.JA2_NATURA NATURA , "
cQuery += "	JA2.JA2_DTNASC DTNASC , "
cQuery += "	JA2.JA2_RG RG , "
cQuery += "	JA2.JA2_ESTRG ESTRG , "
cQuery += "	JA2.JA2_TITULO TITULO , "
cQuery += "	JCL.JCL_NOME ENTIDA , "
cQuery += "	JCL.JCL_CIDADE ENTCID , "
cQuery += "	JCL.JCL_ESTADO ENTEST , "
cQuery += " JA2.JA2_CONCLU CONCLU , "
cQuery += "	JA2.JA2_INSTIT INSTIT , "
cQuery += "	JA2.JA2_DATAPR DATAPR , "
cQuery += "	JA2.JA2_CLASSF CLASSF , "
cQuery += "	JA2.JA2_PONTUA PONTUA , "
cQuery += "	JA3.JA3_CODLOC LOCAL1 , "
cQuery += "	JA3.JA3_DESLOC UNIDADE , "
cQuery += "	JA3.JA3_CEP    CEP , "
cQuery += "	JA3.JA3_END    ENDERECO , "
cQuery += "	JA3.JA3_NUMEND NUMEND , "
cQuery += "	JA3.JA3_COMPLE COMPLE , "
cQuery += "	JA3.JA3_BAIRRO BAIRRO , "
cQuery += "	JA3.JA3_CIDADE CIDADE , "
cQuery += "	JA3.JA3_EST    ESTADO , "
cQuery += "	JA3.JA3_FONE   FONE , "
cQuery += "	JAF.JAF_CARGA  CHCURSO, "
cQuery += "	JA2.JA2_MEMO2  DISPRO, "
cQuery += "	JA2.JA2_FORING FORING, "
cQuery += "	JA2.JA2_CMILIT CMILIT, "
cQuery += "	JA2.JA2_SEXO   SEXO, "
cQuery += " SUM(JAW.JAW_QTDOPT) QTDOPT, "
cQuery += "	MIN(JAR.JAR_DATA1) INICIO, "
cQuery += "	MAX(JAR.JAR_DATA2) FIM, "
cQuery += " MAX(JAR.JAR_HABILI) HABILI "

cQuery += "FROM "
cQuery += " " + RetSQLName("JA2")+ " JA2 LEFT OUTER JOIN " + RetSQLName("JCL")+ " JCL "
cQuery += "ON JCL.JCL_FILIAL  = '" + xFilial("JCL") +"'"+" AND JA2.JA2_ENTIDA = JCL.JCL_CODIGO AND JCL.D_E_L_E_T_ <> '*' "+" , "
cQuery += " " + RetSQLName("JAW")+ " JAW INNER JOIN (" + RetSQLName("JAR")+ " JAR INNER JOIN (" + RetSQLName("JA3")+ " JA3 "
cQuery += "INNER JOIN (" + RetSQLName("JAF")+ " JAF INNER JOIN " + RetSQLName("JAH")+ " JAH "
cQuery += " ON  (JAF.JAF_VERSAO  = JAH.JAH_VERSAO) "
cQuery += " AND (JAF.JAF_COD     = JAH.JAH_CURSO)) " 
cQuery += " ON   JA3.JA3_CODLOC  = JAH.JAH_UNIDAD) "
cQuery += " ON   JAR.JAR_CODCUR  = JAH.JAH_CODIGO) "
cQuery += " ON  (JAW.JAW_HABILI  = JAR.JAR_HABILI) "
cQuery += " AND (JAW.JAW_PERLET  = JAR.JAR_PERLET) "
cQuery += " AND (JAW.JAW_VERSAO  = JAF.JAF_VERSAO) "
cQuery += " AND (JAW.JAW_CURSO   = JAF.JAF_COD) "


cQuery += "WHERE "
cQuery += "       JA2.JA2_FILIAL  = '" + xFilial("JA2")	+"' "
cQuery += "   and JA3.JA3_FILIAL  = '" + xFilial("JA3")	+"' "
cQuery += "   and JAH.JAH_FILIAL  = '" + xFilial("JAH")	+"' "
cQuery += "   and JAF.JAF_FILIAL  = '" + xFilial("JAF")	+"' "
cQuery += "   and JAW.JAW_FILIAL  = '" + xFilial("JAW")	+"' "
cQuery += "   and JA2.JA2_NUMRA  = '" + cRA + "' "
cQuery += "   and JAH.JAH_CODIGO = '" + aRet[1] + "' "

cQuery += "   and JA2.D_E_L_E_T_ <> '*' "
cQuery += "   and JA3.D_E_L_E_T_ <> '*' "
cQuery += "   and JAH.D_E_L_E_T_ <> '*' "
cQuery += "   and JAF.D_E_L_E_T_ <> '*' "
cQuery += "   and JAW.D_E_L_E_T_ <> '*' "
cQuery += "   and JAR.D_E_L_E_T_ <> '*' "

cQuery += "GROUP BY "

cQuery += "	JAH.JAH_CODIGO  , "
cQuery += "	JAH.JAH_CURSO  , "
cQuery += "	JAH.JAH_VERSAO, "
cQuery += "	JA2.JA2_NUMRA  , "
cQuery += "	JA2.JA2_NOME  , "
cQuery += "	JA2.JA2_NACION  , "
cQuery += "	JA2.JA2_NATURA  , "
cQuery += "	JA2.JA2_DTNASC  , "
cQuery += "	JA2.JA2_RG  , "
cQuery += "	JA2.JA2_ESTRG  , "
cQuery += "	JA2.JA2_TITULO  , "
cQuery += "	JCL.JCL_NOME  , "
cQuery += "	JCL.JCL_CIDADE  , "
cQuery += "	JCL.JCL_ESTADO  , "
cQuery += " JA2.JA2_CONCLU  , "
cQuery += "	JA2.JA2_INSTIT  , "
cQuery += "	JA2.JA2_DATAPR  , "
cQuery += "	JA2.JA2_CLASSF  , "
cQuery += "	JA2.JA2_PONTUA  , "
cQuery += "	JA3.JA3_CODLOC  , "
cQuery += "	JA3.JA3_DESLOC  , "
cQuery += "	JA3.JA3_CEP     , "
cQuery += "	JA3.JA3_END     , "
cQuery += "	JA3.JA3_NUMEND  , "
cQuery += "	JA3.JA3_COMPLE  , "
cQuery += "	JA3.JA3_BAIRRO  , "
cQuery += "	JA3.JA3_CIDADE  , "
cQuery += "	JA3.JA3_EST     , "
cQuery += "	JA3.JA3_FONE    , "
cQuery += "	JAF.JAF_CARGA   , "
cQuery += "	JA2.JA2_MEMO2   , "
cQuery += "	JA2.JA2_FORING  , "
cQuery += "	JA2.JA2_CMILIT  , "
cQuery += "	JA2.JA2_SEXO "

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"SQJC", .F., .T.)
TcSetField("SQJC","INICIO","D",8,0)
TcSetField("SQJC","FIM"   ,"D",8,0)
TcSetField("SQJC","DTNASC","D",8,0)
TcSetField("SQJC","DATAPR","C",TamSX3("JA2_DATAPR")[1],0)
TcSetField("SQJC","PONTUA","N",8,2)
TcSetField("SQJC","QTDOPT","N",2,0)

//�����������������������������������������������������������������������Ŀ
//� Gerando o arquivo de trabalho do cabecalho                            �
//�������������������������������������������������������������������������
DbSelectArea ("SQJC")
If Eof()
	MsgStop("N�o foram encontrados os dados necess�rios para a emiss�o deste hist�rico.")
Else

	While SQJC->(!Eof())
        
		DbSelectArea( "TRBC" )
		RecLock( "TRBC",.T. )
		
		TRBC->NUMRA 		:= SQJC->NUMRA
		TRBC->UNIDADE 		:= SQJC->UNIDADE
		TRBC->ENDERECO		:= SQJC->ENDERECO
		TRBC->NUMEND		:= SQJC->NUMEND
		TRBC->COMPLE		:= SQJC->COMPLE
		TRBC->CEP			:= SQJC->CEP
		TRBC->BAIRRO		:= SQJC->BAIRRO
		TRBC->CIDADE		:= SQJC->CIDADE
		TRBC->ESTADO		:= SQJC->ESTADO
		TRBC->FONE			:= SQJC->FONE
		TRBC->CODCUR		:= SQJC->CODCUR
		TRBC->LOCAL	 		:= SQJC->LOCAL1
		TRBC->CURSO   		:= aRet[2]
		TRBC->HABILI		:= SQJC->HABILI
		TRBC->DECRET  		:= AcDecret(SQJC->CURPAD,,SQJC->LOCAL1)
		TRBC->NOME    		:= SQJC->NOME
		TRBC->NACION  		:= SQJC->NACION
		TRBC->NATURA  		:= TABELA("12", ALLTRIM(SQJC->NATURA), .F.)
		TRBC->DTNASC  		:= SQJC->DTNASC
		TRBC->RG      		:= SQJC->RG
		TRBC->ESTRG   		:= SQJC->ESTRG
		TRBC->TITULO  		:= SQJC->TITULO
		TRBC->ENTIDA  		:= SQJC->ENTIDA
		TRBC->ENTCID  		:= SQJC->ENTCID
		TRBC->ENTEST  		:= SQJC->ENTEST
		TRBC->CONCLU  		:= SQJC->CONCLU
		TRBC->INSTIT  		:= SQJC->INSTIT
		TRBC->DATAPR  		:= SQJC->DATAPR
		TRBC->CLASSF  		:= SQJC->CLASSF
		TRBC->PONTUA  		:= SQJC->PONTUA
		TRBC->CHCURSO 		:= SQJC->CHCURSO
		TRBC->INICIO      	:= SQJC->INICIO
		TRBC->FIM		  	:= SQJC->FIM
		TRBC->DISPRO 		:= SQJC->DISPRO
		TRBC->FORING 		:= SQJC->FORING
		TRBC->CMILIT		:= SQJC->CMILIT
		TRBC->SEXO			:= SQJC->SEXO
		TRBC->QTDOPT		:= SQJC->QTDOPT
		TRBC->CURPAD		:= SQJC->CURPAD
		TRBC->VERSAO		:= SQJC->VERSAO
		If !empty(SQJC->HABILI)	
			JDK->(DBSeek(xFilial("JDK")+SQJC->HABILI))
			TRBC->DESCHABILI	:= JDK->JDK_DESC
		Else
			TRBC->DESCHABILI	:= ""
		EndIf        
		
		If !empty(SQJC->INSTIT)
			JCL->(DBSeek(xFilial("JCL") + SQJC->INSTIT))
			TRBC->NOMEINSTIT := JCL->JCL_NOME 	
		EndIf
		SQJC->(MsUnlock())
		SQJC->(Dbskip())

	Enddo

	IncProc()
	
	//�����������������������������������������������������������������������Ŀ
	//� Query dos itens 	   				   	                              �
	//�������������������������������������������������������������������������
	TRBC->( dbGoTop() )

	JCO->( dbSetOrder(1) )
	JCH->( dbSetOrder(2) )
	JAS->( dbSetOrder(2) )
	JAR->( dbSetOrder(1) )
	JAE->( dbSetOrder(1) )
	JC7->( dbSetOrder(4) )    
	JBE->( dbSetOrder(1) )
	TRBI->( dbSetOrder(2) )
	JAY->( DbSetOrder(1) ) //JAY_FILIAL, JAY_CURSO, JAY_VERSAO, JAY_PERLET, JAY_HABILI, JAY_CODDIS, R_E_C_N_O_, D_E_L_E_T_

	
	While TRBC->( !eof() )
		
		aPerLets := {}
		
		JAS->( dbSeek(xFilial("JAS")+TRBC->CODCUR) )
		while JAS->( !eof() ) .and. JAS->JAS_FILIAL+JAS->JAS_CODCUR+JAS->JAS_HABILI == xFilial("JAS")+TRBC->CODCUR+TRBC->HABILI
			
			JAR->( dbSeek(xFilial("JAR")+JAS->JAS_CODCUR+JAS->JAS_PERLET+JAS->JAS_HABILI) )
			JAE->( dbSeek(xFilial("JAE")+JAS->JAS_CODDIS) )
			JAY->( DbSeek(XFILIAL("JAY") + TRBC->CURPAD + TRBC->VERSAO + JAS->JAS_PERLET+JAS->JAS_HABILI+JAS->JAS_CODDIS))			
			
			// Se possui disciplina pai, atualiza array de controle das disciplinas filhas para
			// calculo da media.
			if !empty( JAE->JAE_DISPAI )
				if aScan( aDisPai, {|x| x[1] == JAE->JAE_DISPAI} ) == 0
					aAdd( aDisPai, { JAE->JAE_DISPAI, {} })
				endif
				
				// Deixa a disciplina pai posicionada, para atualizacao do TRBI
				JAE->( dbSeek(xFilial("JAE")+JAE->JAE_DISPAI) )
			endif
			
			// Procura por dispensa na JCO e adiciona registro de dispensa na TRBI.
			if JCO->( dbSeek( xFilial("JCO")+TRBC->NUMRA+JAS->JAS_CODCUR+JAS->JAS_PERLET+JAS->JAS_HABILI+JAE->JAE_CODIGO ) ) .and. !SEC002AE( JCO->JCO_CODINS, JCO->JCO_NUMRA, JCO->JCO_DISCIP, TRBC->CODCUR )
				
				RecLock( "TRBI", TRBI->( !dbSeek(JAS->JAS_CODCUR+JAE->JAE_CODIGO) ) )
				TRBI->CODCUR      	:= JAS->JAS_CODCUR
				TRBI->ANO       	:= if( JAR->JAR_PERIOD == "00", StrZero( Val( JAR->JAR_ANOLET ) - 1, 4 ), JAR->JAR_ANOLET )
				TRBI->PERIOD		:= if( JAR->JAR_PERIOD$"08/09/10/11/12/00", "02", if( JAR->JAR_PERIOD$"03/04/05/06/07", "01", JAR->JAR_PERIOD ))
				TRBI->CODDIS		:= JAE->JAE_CODIGO
				TRBI->DISCIP    	:= JAE->JAE_DESC
				TRBI->TIPODIS    	:= JAE->JAE_TIPO
				TRBI->CH        	:= JAE->JAE_CARGA
				TRBI->TOTCHARG		:= JAE->JAE_CARGA //soma as cargas das disciplina
				TRBI->SEMESTRE   	:= JAS->JAS_PERLET
				TRBI->HABILI     	:= JAS->JAS_HABILI
				TRBI->SITUAC    	:= '8'
				TRBI->INSTIT    	:= JCO->JCO_CODINS
				TRBI->ANOINS    	:= JCO->JCO_ANOINS
				TRBI->MEDIA     	:= JCO->JCO_MEDFIM
				TRBI->MEDCON    	:= JCO->JCO_MEDCON
				TRBI->DESMCO		:= JCO->JCO_DESMCO
				TRBI->CODPROF   	:= ' '
				TRBI->NOMEPROF		:= ' '
				TRBI->CARGOPRF		:= ' '
				TRBI->FALTAS		:= 0
				TRBI->AE			:= 'S'
				TRBI->OPTATIVA		:= JAS->JAS_TIPO
				TRBI->ORDEM			:= '1'
				TRBI->( MsUnlock() )
			ElseIF JAY->JAY_STATUS == '1'
				RecLock( "TRBI", TRBI->( !dbSeek(JAS->JAS_CODCUR+JAE->JAE_CODIGO) ) )
				TRBI->CODCUR      	:= JAS->JAS_CODCUR
				TRBI->ANO       	:= if( JAR->JAR_PERIOD == "00", StrZero( Val( JAR->JAR_ANOLET ) - 1, 4 ), JAR->JAR_ANOLET )
				TRBI->PERIOD		:= if( JAR->JAR_PERIOD$"08/09/10/11/12/00", "02", if( JAR->JAR_PERIOD$"03/04/05/06/07", "01", JAR->JAR_PERIOD ))
				TRBI->CODDIS		:= JAE->JAE_CODIGO
				TRBI->DISCIP    	:= JAE->JAE_DESC
				TRBI->TIPODIS    	:= JAE->JAE_TIPO
				TRBI->CH        	:= JAE->JAE_CARGA
				TRBI->TOTCHARG		:= JAE->JAE_CARGA //soma as cargas das disciplina
				TRBI->SEMESTRE   	:= JAS->JAS_PERLET
				TRBI->HABILI     	:= JAS->JAS_HABILI
				If JC7->( FieldPos("JC7_SEQ") ) > 0 
					JC7->( dbSeek( xFilial("JC7")+TRBC->NUMRA+TRBC->CODCUR+TRBI->CODDIS+TRBI->SEMESTRE+TRBI->HABILI ) )
					while JC7->( !eof() ) .and. JC7->JC7_FILIAL+JC7->JC7_NUMRA+JC7->JC7_CODCUR + JC7->JC7_DISCIP + JC7->JC7_PERLET + JC7->JC7_HABILI == xFilial("JC7")+TRBC->NUMRA+TRBC->CODCUR+TRBI->CODDIS+TRBI->SEMESTRE+TRBI->HABILI
						cSeq := ACSequence(JC7->JC7_NUMRA, JC7->JC7_CODCUR, JC7->JC7_PERLET, JC7->JC7_TURMA, JC7->JC7_HABILI, .F.)
						If JC7->JC7_SEQ <> cSeq 
							JC7->(DBSkip())
							Loop
						EndIf
						TRBI->SITUAC    	:= JC7->JC7_SITUAC
						JC7->(DBSkip())
					Enddo		
				Else	
					TRBI->SITUAC    	:= Posicione('JC7',4,xFilial('JC7')+TRBC->NUMRA+TRBC->CODCUR+TRBI->CODDIS+TRBI->SEMESTRE+TRBI->HABILI,'JC7_SITUAC')
				EndIf		
				TRBI->INSTIT    	:= ' '
				TRBI->ANOINS    	:= ' '
				TRBI->MEDIA     	:= 0
				TRBI->MEDCON    	:= ' '
				TRBI->DESMCO		:= Space(30)
				TRBI->CODPROF   	:= ' '
				TRBI->NOMEPROF		:= ' '
				TRBI->CARGOPRF		:= ' '
				TRBI->FALTAS		:= 0
				TRBI->AE			:= 'N'
				TRBI->OPTATIVA		:= JAS->JAS_TIPO
				TRBI->ORDEM			:= '1'
				TRBI->( MsUnlock() )
				
			endif
	
			aAdd( aPerLets, {JAS->JAS_CODCUR, JAS->JAS_PERLET, JAS->JAS_HABILI, JAS->JAS_CODDIS} )
	
			// Guarda disciplina se for Opcional
			If JAY->JAY_STATUS == '2'
				AAdd( aDisOpt, JAS->( JAS_CODCUR + "1" + JAS_PERLET + JAS_HABILI + JAS_CODDIS ) )
			endif
	
			JAS->( dbSkip() )
		end

		// Verifica as disciplinas j� cursadas
		JC7->( dbSeek( xFilial("JC7")+TRBC->NUMRA+TRBC->CODCUR ) )
		while JC7->( !eof() ) .and. JC7->JC7_FILIAL+JC7->JC7_NUMRA+JC7->JC7_CODCUR == xFilial("JC7")+TRBC->NUMRA+TRBC->CODCUR
			If JC7->( FieldPos("JC7_SEQ") ) > 0 
				cSeq := ACSequence(TRBC->NUMRA, TRBC->CODCUR, JC7->JC7_PERLET, JC7->JC7_TURMA, JC7->JC7_HABILI, .F.)
				If JC7->JC7_SEQ <> cSeq 
					JC7->(DBSkip())
					Loop
				EndIf	
			EndIf		
			
		if !(JC7->JC7_SITUAC $ "7/8/9")
			//������������������������������������������������������������������������������������������������������������������Ŀ
			//� Executa o encerramento de notas para o aluno na disciplina e atualiza sua media final e situacao caso necessario �
			//��������������������������������������������������������������������������������������������������������������������
			ACEncNota( JC7->JC7_NUMRA, JC7->JC7_CODCUR, JC7->JC7_PERLET, JC7->JC7_TURMA, JC7->JC7_DISCIP )
		
			JAS->( dbSeek( xFilial( "JAS" ) + JC7->( JC7_CODCUR + JC7_PERLET + JC7_HABILI + JC7_DISCIP ) ) )
			JAE->( dbSeek(xFilial("JAE")+JAS->JAS_CODDIS) )
			
			// Se possui disciplina pai, atualiza array de controle das disciplinas filhas para
			// calculo da media.
			if !Empty( JAE->JAE_DISPAI )
				If aScan( aDisPai, {|x| x[1] == JAE->JAE_DISPAI} ) == 0
					aAdd( aDisPai, { JAE->JAE_DISPAI, {} })
				Endif
				cDisPai    := JAE->JAE_DISPAI
				cPerLetPai := JC7->JC7_PERLET
				
				// Deixa a disciplina pai posicionada, para atualizacao do TRBI
				JAE->( dbSeek(xFilial("JAE")+cDisPai) )
			Else
				cDisPai      := ""          
				cPerLetPai   := ""
			EndIf
			
			aAreaJC7	:= JC7->( GetArea() )
			cDisOri		:= JAE->JAE_CODIGO
			
			// Se o aluno cursou uma equivalente dessa disciplina, posiciona no registro em que foi cursada
			SEC002EQ( JC7->JC7_NUMRA, JC7->JC7_DISCIP, TRBC->CODCUR )
			
			JBE->( dbSeek( xFilial( "JBE" ) + JC7->( JC7_NUMRA  + JC7_CODCUR + JC7_PERLET + JC7_HABILI + JC7_TURMA ) ) )
			
			if !empty( JC7->JC7_OUTCUR )
				JAR->( dbSeek( xFilial("JAR")+JC7->JC7_OUTCUR+JC7->JC7_OUTPER + JC7->JC7_OUTHAB ) )
			else
				JAR->( dbSeek( xFilial("JAR")+JC7->JC7_CODCUR+JC7->JC7_PERLET + JC7->JC7_HABILI ) )
			endif
			
			// Guarda disciplina se for Opcional
			if JAS->JAS_TIPO == "2" .And. aScan( aDisOpt, JAS->( JAS_CODCUR + "1" + JAS_PERLET + JAS_HABILI + JAS_CODDIS ) ) == 0
				AAdd( aDisOpt, JAS->( JAS_CODCUR + "1" + JAS_PERLET + JAS_HABILI + JAS_CODDIS ) )
			endif
			              
			If Empty(cPerLetPai)
				nPerLet	:= aScan( aPerLets, {|x| x[1]+x[4] == JC7->JC7_CODCUR+cDisOri} )
				If nPerLet > 0
					cPerLetPai := aPerLets[nPerLet,2]
				Else
					cPerLetPai := JC7->JC7_PERLET
				EndIf
			EndIf
	
			lAchou	:= TRBI->( dbSeek(JC7->JC7_CODCUR+cDisOri) )
			                                          
			nPosDisPai := aScan( aDisPai, {|x| x[1] == cDisPai} )
			lDisPai := ( nPosDisPai > 0  )
			
			if !lAchou .or. (Empty(TRBI->SITUAC) .Or. lDisPai ) .or. JAR->( JAR_ANOLET+JAR_PERIOD ) > TRBI->ANO+TRBI->PERIOD
				
				RecLock( "TRBI", !lAchou )
				
				TRBI->CODCUR      	:= JC7->JC7_CODCUR
				
				if JC7->JC7_SITDIS == "001"	// Adaptacao
					TRBI->ANO       	:= if( JAR->JAR_PERIOD$"08/09/10/11/12", StrZero( Val( JAR->JAR_ANOLET ) + 1, 4 ), JAR->JAR_ANOLET )
					TRBI->PERIOD		:= if( JAR->JAR_PERIOD$"08/09/10/11/12/00", "01", if( JAR->JAR_PERIOD$"03/04/05/06/07", "02", JAR->JAR_PERIOD ))
				else
					TRBI->ANO       	:= if( JAR->JAR_PERIOD == "00", StrZero( Val( JAR->JAR_ANOLET ) - 1, 4 ), JAR->JAR_ANOLET )
					TRBI->PERIOD		:= if( JAR->JAR_PERIOD$"08/09/10/11/12/00", "02", if( JAR->JAR_PERIOD$"03/04/05/06/07", "01", JAR->JAR_PERIOD ))
				endif
				
				TRBI->CODDIS		:= cDisOri
				TRBI->DISCIP    	:= JAE->JAE_DESC
				TRBI->TIPODIS    	:= JAE->JAE_TIPO
				TRBI->CH        	:= JAE->JAE_CARGA
				TRBI->TOTCHARG		:= JAE->JAE_CARGA
				if SEC002AE( JC7->JC7_CODINS, JC7->JC7_NUMRA, JC7->JC7_DISCIP, TRBC->CODCUR )
					TRBI->SITUAC	:= if( JC7->JC7_SITUAC == '8', '8', '2' )
					TRBI->AE		:= if( JC7->JC7_SITUAC == '8', 'S', 'N' )
				else
					TRBI->SITUAC    := if( JBE->JBE_SITUAC == '1', ' ', JC7->JC7_SITUAC )
					TRBI->AE		:= if( JCO->(DbSeek(xFilial("JCO")+JC7->( JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_DISCIP ))), 'S', 'N' )
				endif
				
				TRBI->INSTIT		:= JC7->JC7_CODINS
				TRBI->ANOINS		:= JC7->JC7_ANOINS
				TRBI->DESMCO		:= JC7->JC7_DESMCO
				TRBI->SEMESTRE   	:= cPerLetPai
				TRBI->HABILI     	:= JC7->JC7_HABILI
				TRBI->MEDIA     	:= JC7->JC7_MEDFIM
				TRBI->MEDCON    	:= JC7->JC7_MEDCON
				TRBI->CODPROF   	:= JC7->JC7_CODPRF
				TRBI->NOMEPROF		:= ACNomeProf(JC7->JC7_CODPRF)
				TRBI->CARGOPRF		:= if( Empty(ACNomeProf(JC7->JC7_CODPRF, "RA_CODTIT")), " ", Tabela("FF", ACNomeProf(JC7->JC7_CODPRF, "RA_CODTIT"), .F.) )
				TRBI->FALTAS		:= 0
				TRBI->OPTATIVA 		:= JAS->JAS_TIPO
				TRBI->ORDEM			:= '1'
				if Empty(JC7->JC7_OUTCUR)
				If JCH->( dbSeek( xFilial("JCH")+JC7->JC7_NUMRA+JC7->JC7_CODCUR+JC7->JC7_PERLET+JC7->JC7_HABILI+JC7->JC7_TURMA+JC7->JC7_DISCIP ) )
					while JCH->( !eof() ) .and. JCH->(JCH_FILIAL+JCH_NUMRA+JCH_CODCUR+JCH_PERLET+JCH_HABILI+JCH_TURMA+JCH_DISCIP) == xFilial("JCH")+JC7->JC7_NUMRA+JC7->JC7_CODCUR+JC7->JC7_PERLET+JC7->JC7_HABILI+JC7->JC7_TURMA+JC7->JC7_DISCIP
						TRBI->FALTAS	+= JCH->JCH_QTD
						JCH->( dbSkip() )
					end
					EndIf
				else
					If JCH->( dbSeek( xFilial("JCH")+JC7->JC7_NUMRA+JC7->JC7_OUTCUR+JC7->JC7_OUTPER+JC7->JC7_OUTHAB+JC7->JC7_OUTTUR+JC7->JC7_DISCIP ) )
						while JCH->( !eof() ) .and. JCH->(JCH_FILIAL+JCH_NUMRA+JCH_CODCUR+JCH_PERLET+JCH_HABILI+JCH_TURMA+JCH_DISCIP) == xFilial("JCH")+JC7->JC7_NUMRA+JC7->JC7_OUTCUR+JC7->JC7_OUTPER+JC7->JC7_OUTHAB+JC7->JC7_OUTTUR+JC7->JC7_DISCIP
							TRBI->FALTAS	+= JCH->JCH_QTD
							JCH->( dbSkip() )
						end
					EndIf
				endif
				
				TRBI->( MsUnlock() )
				
				nInd := aScan( aDisPai, {|x| x[1] == JAE->JAE_CODIGO} )
				if nInd > 0
					if JAS->(FieldPos("JAS_PESO")) > 0 .and. JAS->JAS_PESO <> 0 //Verifica se possui peso por disciplina
						aAdd( aDisPai[nInd,2], { JAS->JAS_CODDIS, TRBI->MEDIA, TRBI->SITUAC, JAS->JAS_PESO } )
					else
						aAdd( aDisPai[nInd,2], { JAS->JAS_CODDIS, TRBI->MEDIA, TRBI->SITUAC, 1 } )
					endif
					// Atualiza a media final das disciplinas pais.
					nMedia := 0
					nPesos := 0
					
					for nInd2 := 1 to len( aDisPai[nInd,2] )
						nMedia += aDisPai[nInd,2,nInd2,2] * aDisPai[nInd,2,nInd2,4]
						nPesos += aDisPai[nInd,2,nInd2,4]
					next nInd2
					
					//Media da Disciplina Pai
					nMedia := nMedia / nPesos
					
					
					// Calcular a situacao final da disciplina pai
					// Priorizar:
					// 4N - Reprovado por falta
					// 3 - Reprovado por nota
					// 5 - Reprovado no exame
					// 1 - Cursando
					// A - A cursar
					// 2S - Aprovado
					// 8 - Dispensado
					cSituac := TRBI->SITUAC
					for nInd2 := 1 to len( aDisPai[nInd,2] )
						if cSituac $ "8" .and. aDisPai[nInd,2,nInd2,3] $ "4N3516A2S"
							cSituac := aDisPai[nInd,2,nInd2,3]
						elseif cSituac $ "2S" .and. aDisPai[nInd,2,nInd2,3] $ "4N3516A"
							cSituac := aDisPai[nInd,2,nInd2,3]
						elseif cSituac $ "A" .and. aDisPai[nInd,2,nInd2,3] $ "4N3516"
							cSituac := aDisPai[nInd,2,nInd2,3]
						elseif cSituac $ "16" .and. aDisPai[nInd,2,nInd2,3] $ "4N35"
							cSituac := aDisPai[nInd,2,nInd2,3]
						elseif cSituac $ "5" .and. aDisPai[nInd,2,nInd2,3] $ "4N3"
							cSituac := aDisPai[nInd,2,nInd2,3]
						elseif cSituac $ "3" .and. aDisPai[nInd,2,nInd2,3] $ "4N"
							cSituac := aDisPai[nInd,2,nInd2,3]
						endif
					next nInd2
					
					RecLock("TRBI",.F.)
					TRBI->MEDIA  := nMedia
					TRBI->SITUAC := cSituac
					TRBI->( msUnlock() )
				endif
				
			endif
			
			JC7->( RestArea( aAreaJC7 ) )
			
		endif
			JC7->( dbSkip() )
		end

		//������������������������������������������������������������������������������������������������������������������������Ŀ
		//� Percorre as disciplinas que ultrapassam o total de optativas do curso, atualizando sua ordem de impressao no historico �
		//��������������������������������������������������������������������������������������������������������������������������
		nLenOpt := Len( aDisOpt )
		
		For nInd := 1 To nLenOpt
			
			if nInd > TRBC->QTDOPT
				
				// Altera ordem para impressao no final do historico
				If TRBI->( dbSeek( TRBC->CODCUR+aDisOpt[ nInd ] ) )
					Reclock( "TRBI", .F. )
					TRBI->ORDEM := '2'
					TRBI->( MsUnlock() )
				Endif
				
			endif
			
		Next nInd
		
		TRBC->( dbSkip() )
	end
	
	IncProc()
	
  	If ExistBlock ("ACSEC0002")  // Substitui o PREL0002, imprimindo o numero do protocolo
  		U_ACSEC0002(@lPrint,@cARcUR)
  	else
	// Chamada da rotina de impressao do relat�rio...
	Processa({|| PREL0002( lPrint,cARcUR ) })
  	endif
EndIf

//��������������������������������������������������������������Ŀ
//� Apaga arquivos tempor�rios		                             �
//����������������������������������������������������������������

DbSelectArea("SQJC")
DbCloseArea()

DbSelectarea("TRBC")
DbCloseArea()

DbSelectarea("TRBI")
DbCloseArea()

if File( cArqTRBC+GetDbExtension() )
	FErase( cArqTRBC+GetDbExtension() )
endif
if File( cArqTRBC+OrdBagExt() )
	FErase( cArqTRBC+GetDbExtension() )
endif
if File( cArqTRBI+GetDbExtension() )
	FErase( cArqTRBC+GetDbExtension() )
endif
if File( cIndTRBI1+OrdBagExt() )
	FErase( cIndTRBI1+OrdBagExt() )
endif
if File( cIndTRBI2+OrdBagExt() )
	FErase( cIndTRBI2+OrdBagExt() )
endif

RestArea(aArea)

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 � PREL0002 � Autor �Regiane & LeandroSD    � Data � 03/06/02 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do WORD                       			    	  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Especifico Academico              				          ���
�������������������������������������������������������������������������Ĵ��
��� Revis�o  �		                                    � Data �  		  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function PREL0002( lImprime, cARcUR )

Local aAss		:= {}
Local aDiscip	:= {}
Local cPerLet	:= ""
Local cEqvCon	:= ""
Local cSituac	:= ""
Local cSemestg	:= ""
Local cArqDot	:= ""
Local cPathDot	:= ""
Local cMemo		:= ""
Local cDecret	:= ""
Local cEnder	:= ""
Local cNextSem	:= "" //Proximo Semestre
Local cConceito	:= ""
Local cObs		:= ""
Local aObs      := {}
Local aLeg      := {}
Local cPeriodo	:= ""
Local nMemCount	:= 0
Local nLoop		:= 0
Local nCntFor	:= 0
Local nCntFo1	:= 0
Local nPos		:= 0
Local hWord		:= 0
Local nx		:= 0
Local cDisPro	:= ""
Local cForIng	:= ""
Local cLegenda	:= ""
Local cMonog	:= SPACE(2)
Local cCargaHor   := ""
Local cCredDiscip := ""
Local aCLeng    := 0
Local nVolt     := 0
Local nT        := 0
Local nPerLet   := 0
Local cPorMec	:= 	space(20)
Local cDataPMec	:=  "  /  /    "
Local cDataPubl	:=  "  /  /    "


Private aTRBI       := {}

Private cPathEst:= Alltrim(GetMv("MV_DIREST")) // PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHO

//������������������Ŀ
//� Incrementa regua �
//��������������������
ProcRegua( TRBI->( LastRec() ) )

hWord := OLE_CreateLink()
OLE_SetProperty ( hWord, oleWdVisible, .F.)
                      
JAR->( dbSetOrder( 1 ) )
dbSelectArea("TRBC")
dbGoTop()

cArqDot  := "SEC0002.DOT"
cPathDot := Alltrim(GetMv("MV_DIRACA")) + cArqDot // PATH DO ARQUIVO MODELO WORD

MontaDir(cPathEst)

If !File(cPathDot) // Verifica a existencia do DOT no ROOTPATH Protheus / Servidor
	MsgStop("Atencao... " +cPathDot+"  nao encontrado no Servidor")
	
Elseif hWord == "-1"
	MsgStop("Imposs�vel estabelecer comunica��o com o Microsoft Word.")
	
Else
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	
	CpyS2T(cPathDot,cPathEst,.T.)
Endif
nVALCH := 0
while TRBC->( !eof() )
	
	IncProc('Montando hist�rico do aluno '+TRBC->NUMRA)
	//�����������������������������������������������������������������������Ŀ
	//� Gerando novo documento do Word na estacao                             �
	//�������������������������������������������������������������������������
	OLE_NewFile( hWord, cPathEst + cArqDot)
	
	OLE_SetProperty( hWord, oleWdVisible, .F. )
	OLE_SetProperty( hWord, oleWdPrintBack, .F. )
	
	//	OLE_ExecuteMacro(hWord,"DesProteger")
	
	cEnder		:=	TRBC->( RTrim(ENDERECO) + ", " + RTrim(NUMEND) + " - " + RTrim(CIDADE) + " - " +RTrim(ESTADO) + " - CEP " + RTrim(CEP) + " - Tel.: " + RTrim(FONE) )
	cDecret		:= ""
	cMemo		:= MSMM(TRBC->DECRET)
	nMemCount	:= MlCount( cMemo ,60 )
	
	If !Empty( nMemCount )
		For nLoop := 1 To nMemCount
			cDecret += MemoLine( cMemo, 60, nLoop )
		Next nLoop
	Else
		cDecret   := cMemo
	EndIf
	
	cDecret   := if( Empty(cDecret), " ", cDecret )
	
	cDisPro := MSMM( TRBC->DISPRO )
	cDisPro := Alltrim( StrTran( cDisPro, Chr(13)+Chr(10), ", " ) )
	if Right( cDisPro, 1 ) == ","
		cDisPro := Left( cDisPro, Len( cDisPro ) - 1 )
	endif
	
	cForIng := if( TRBC->FORING == "4", "CONCURSO VESTIBULAR", "PROCESSO SELETIVO" )
	OLE_SetDocumentVar(hWord, "cUnidade"  , 'UNIDADE '+ALLTRIM(TRBC->UNIDADE))

	OLE_SetDocumentVar(hWord, "cEndereco" , cEnder)
	
	OLE_SetDocumentVar(hWord, "cCurso"    , TRBC->CURSO)
	OLE_SetDocumentVar(hWord, "cHabil"    , Iif(Empty(TRBC->HABILI), " ", TRBC->DESCHABILI ))
	OLE_SetDocumentVar(hWord, "MDECRET"   , cDecret)
	OLE_SetDocumentVar(hWord, "cOBSERV2"  , ' ')
	JBE->( dbSetOrder(3) )
	JBE->(DBSEEK(XFILIAL("JBE")+'5'+TRBC->NUMRA))

	if !empty(dtoS(JBE->JBE_DTENC))
		OLE_SetDocumentVar(hWord, "cDTINC"    , IIF(TRBC->SEXO == "1",'O ','A ')+'referid'+IIF(TRBC->SEXO == "1",'o ','a ')+'alun'+IIF(TRBC->SEXO == "1",'o ','a ')+'participou do Exame Nacional de Cursos, realizado em '+DTOC(JBE->JBE_DTENC)+'. ')
	ELSE
		OLE_SetDocumentVar(hWord, "cDTINC"    , ' ')
	ENDIF                                           

	If JCF->(FieldPos("JCF_PORMEC")) > 0

		JCF->(dbSetOrder(1))
		JCF->( dbGotop() )

		while !(JCF->( eof()))
			if ((JAH->JAH_FILIAL + JAH->JAH_CURSO + JAH->JAH_UNIDAD) == (JCF->JCF_FILIAL + JCF->JCF_CURSO + JCF->JCF_UNIDAD))
				exit
			else
				JCF->( dbSkip() )
			endif
		enddo

		if ((JAH->JAH_FILIAL + JAH->JAH_CURSO + JAH->JAH_UNIDAD) == (JCF->JCF_FILIAL + JCF->JCF_CURSO + JCF->JCF_UNIDAD))
			cPorMec		:= 	JCF->JCF_PORMEC
			cDataPMec	:=  DtoC(JCF->JCF_DTPMEC)
		    cDataPubl	:=  DtoC(JCF->JCF_DTPUBL)
		endif
    endif
    
	OLE_SetDocumentVar(hWord, "cPorMec"		, cPorMec)
	OLE_SetDocumentVar(hWord, "cDataPMec"	, cDataPMec)
	OLE_SetDocumentVar(hWord, "cDataPubl"	, cDataPubl)

	OLE_SetDocumentVar(hWord, "cNome"     , TRBC->NOME)
	OLE_SetDocumentVar(hWord, "cNacion"   , substr(Tabela( "34", TRBC->NACION, .F. ),1,1)+lower(substr(ALLTRIM(Tabela( "34", TRBC->NACION, .F. )),2,(len(ALLTRIM(Tabela( "34", TRBC->NACION, .F. ))))-2)+if( TRBC->SEXO == "1", "o", "a" )) )
	OLE_SetDocumentVar(hWord, "cNatura"   , TRBC->NATURA)
	OLE_SetDocumentVar(hWord, "dDtNasc"   , TRBC->DTNASC)
	IF ALLTRIM(TRBC->NACION) == '10' .OR. ALLTRIM(TRBC->NACION) == '20'
		OLE_SetDocumentVar(hWord, "cRG"       , ' R.G. N� '+TRBC->RG)
	ELSE
		OLE_SetDocumentVar(hWord, "cRG"       , ' R.N.E.: '+TRBC->RG)
	ENDIF
	OLE_SetDocumentVar(hWord, "cEstRG"    , TRBC->ESTRG)
	OLE_SetDocumentVar(hWord, "cEstRA"    , MV_PAR01)
	OLE_SetDocumentVar(hWord, "cTitulo"   , TRBC->TITULO)
	OLE_SetDocumentVar(hWord, "cEntida"   , TRBC->ENTIDA)
	OLE_SetDocumentVar(hWord, "cEntCid"   , TRBC->ENTCID)
	OLE_SetDocumentVar(hWord, "cEntEst"   , TRBC->ENTEST)
	OLE_SetDocumentVar(hWord, "cConclu"   , Alltrim(TRBC->CONCLU))
	OLE_SetDocumentVar(hWord, "cInstit"   , TRBC->NOMEINSTIT )
	OLE_SetDocumentVar(hWord, "dDataPr"   , TRBC->DATAPR)
	OLE_SetDocumentVar(hWord, "cClassf"   , Iif(Empty(TRBC->CLASSF), " ",Alltrim(Str(Val(TRBC->CLASSF),4,0))+"�"))
	OLE_SetDocumentVar(hWord, "nPontua"   , Iif(Empty(TRBC->PONTUA), " ", TRBC->PONTUA))
	OLE_SetDocumentVar(hWord, "dData1"    , TRBC->Inicio)
	OLE_SetDocumentVar(hWord, "dData2"    , TRBC->Fim)
	OLE_SetDocumentVar(hWord, "cDisPro"   , Iif( Empty(cDisPro), " ", cDisPro) )
	OLE_SetDocumentVar(hWord, "cForIng"   , cForIng)
	OLE_SetDocumentVar(hWord, "cSexo"     , if( TRBC->SEXO == "1", "M", "F" ) )
	if  TRBC->SEXO == "1"
		OLE_SetDocumentVar(hWord, "cCMilit"   , 'Reservista: '+TRBC->CMILIT)
	else
		OLE_SetDocumentVar(hWord, "cCMilit"   , ' ')
	endif
	OLE_SetDocumentVar(hWord, "cteso"   , 'DATA DE COLA��O DE GRAU:')
	OLE_SetDocumentVar(hWord, "cteso1"   , ' DATA DE EXPEDI��O DO DIPLOMA:')
	OLE_SetDocumentVar(hWord, "cColacao"  , IIF(!EMPTY(DTOS(JBE->JBE_DCOLAC)),DTOC(JBE->JBE_DCOLAC),'XXXXXX'))
	OLE_SetDocumentVar(hWord, "cDiploma"  , IIF(!EMPTY(DTOS(JBE->JBE_DATADI)),DTOC(JBE->JBE_DATADI),'XXXXXX'))
	If JBE->(FieldPos("JBE_ENADE")) > 0
		OLE_SetDocumentVar(hWord, "cENADE" , A240SEnade(TRBC->NUMRA, TRBC->CODCUR))
	Endif
	//�����������������������������������������������������������������������Ŀ
	//� Gerando variaveis para os itens  	                	              �
	//�������������������������������������������������������������������������
	
	DbSelectArea("TRBI")
	dbSetOrder(1)
	dbSeek( TRBC->CODCUR )
	
	aObs    	:= {}
	aLeg    	:= {}
	nCntFor 	:= 0
	cSemestg	:= TRBI->SEMESTRE
	
	JAR->( dbSetOrder( 1 ) )
	JAR->( dbSeek( xFilial( "JAR" ) + TRBC->CODCUR + cSemestg ) )

	cConceito   := JAR->JAR_CRIAVA

	While TRBI->( !Eof() ) .and. TRBI->CODCUR = TRBC->CODCUR                         
			
		While TRBI->( !Eof() ) .AND. TRBI->SEMESTRE == cSemestg .and. TRBI->CODCUR = TRBC->CODCUR
			if !Empty(TRBI->CODDIS) 			    			 
				//��������������������������������������������������������������Ŀ
				//�Array com valores inclusos no TRBI - Disciplina/Semestre/Notas�
				//����������������������������������������������������������������
				aAdd( aTRBI, { 	TRBI->CODCUR,;   // Codigo do Curso                   1
				TRBI->ANO,;      // Ano letivo                                        2
				TRBI->PERIOD,;   // Periodo letivo                                    3
				TRBI->CODDIS,;   // Codigo disciplina                                 4
				TRBI->DISCIP,;   // Decricao Disciplina                               5
				TRBI->TIPODIS,;  // Tipo disciplina                                   6
				TRBI->CH,;       // Carga Horaria                                     7
				TRBI->TOTCHARG,; // Total da Carga Horaria                            8
				TRBI->SITUAC,;   // Situa��o da disciplina  - SX5 - F3 - jc7_situac   9
				TRBI->AE,;       //                                                   10
				TRBI->INSTIT,;   // Institui��o                                       11
				TRBI->ANOINS,;   // Ano                                               12
				TRBI->DESMCO,;   // Descria��o do MEC                                 13
				TRBI->SEMESTRE,; // Semestre                                          14
				TRBI->MEDIA,;    // Media                                             15
				TRBI->MEDCON,;   // Media Conselho                                    16
				TRBI->CODPROF,;  // Matricula do Professor                            17
				TRBI->NOMEPROF,; // Nome do Professor                                 18
				TRBI->CARGOPRF,; // Cargo do Professor                                19
				TRBI->FALTAS,;   // N�mero de faltas                                  20
				TRBI->OPTATIVA,; // Disciplina � ou n�o optativa                      21
				TRBI->ORDEM,;    // Ordem                                             22
				TRBI->FALTAS,;   // Faltas                                            23
				TRBI->MEDIA  } ) // Media 
                                       
			endif
			DbSkip()
			
		Enddo


		    cSemestg	:= TRBI->SEMESTRE

			JAR->( dbSeek( xFilial( "JAR" ) + TRBC->CODCUR + cSemestg ) )
	
			cConceito	:= JAR->JAR_CRIAVA			

	Enddo	

	aTRBI := aSort( aTRBI,,, {|x,y| x[14]+x[4] < y[14]+y[4]} )  // Ordena o Array

	for nVolt := 1 to Len(aTRBI)
			
		IncProc('Montando hist�rico do aluno '+TRBC->NUMRA)
		
		//�����������������������������������������������������������������������Ŀ
		//� Gerando variaveis do documento                                        �
		//�������������������������������������������������������������������������
		nCntFor += 1
		nCntFo1 := 1
		cObs    := " "
		nVALCH += aTRBI[nVolt,8]
		OLE_SetDocumentVar(hWord, "cSemest"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), if( aTRBI[nVolt,9]$"789A", "-",  aTRBI[nVolt,14]))
		nCntFo1 += 1
		
		OLE_SetDocumentVar(hWord, "cAno"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), if( aTRBI[nVolt,9]$"789A", "-",  aTRBI[nVolt,2]))
		nCntFo1 += 1
		
		OLE_SetDocumentVar(hWord, "cDiscip"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(aTRBI[nVolt,5]))
		nCntFo1 += 1
		
		if aTRBI[nVolt,6] == "003"
			if aTRBI[nVolt,9] $ "28"
				OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), "Cumpriu")
			elseif aTRBI[nVolt,9]$" 1679A"
				OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), "-")
			else
				OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), "N�o Cumpriu")
			endif
		else
			if aTRBI[nVolt,9]$" 1679A"
				OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), "-")
			else
				if aTRBI[nVolt,9] == "8"
					if !Empty( TRBI->MEDCON )
						OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(aTRBI[nVolt,16]) )
					else
						OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(Str(aTRBI[nVolt,24],5,2)) )
					endif
				elseIf cConceito == "2"
					if Empty( aTRBI[nVolt,16] )
						cEqvCon := Posicione("JAR",1,xFilial("JAR")+TRBC->CODCUR+cSemestg,"JAR_EQVCON")
						JDF->( dbSetOrder( 1 ) )
						JDF->( dbSeek(xFilial("JDF")+cEqvCon) )
						While JDF->( ! EoF() .and. JDF_FILIAL+JDF_CODIGO == xFilial("JDF")+cEqvCon )
							If JDF->( (aTRBI[nVolt,24] >= JDF_NOTINI) .and. (aTRBI[nVolt,24] <= JDF_NOTFIN) )
								Exit
							EndIf
							JDF->(dbSkip())
						Enddo
						OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(JDF->JDF_CONCEI) )
					else
						OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(aTRBI[nVolt,16]) )
					endif
				Else
					OLE_SetDocumentVar(hWord, "nMedia"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(Str(aTRBI[nVolt,24],5,2)) )
				EndIf
			endif
		endif
		nCntFo1 += 1
		
		OLE_SetDocumentVar(hWord, "nCH"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Str(aTRBI[nVolt,7],3,0))
		nCntFo1 += 1
		aCleng := 0
		If aTRBI[nVolt,9] $ "79A " // Trancado / Desistente
			cSituac := "AC"
		ElseIf Empty(aTRBI[nVolt,9]) .or. aTRBI[nVolt,9] $ "16"	// Cursando / Exame
			cSituac := "C"
		ElseIf	aTRBI[nVolt,9] == "2" // Aprovado
			cSituac := "A"
		ElseIf	aTRBI[nVolt,9] == "3" // Reprovado por Nota
			cSituac := "RN"
		ElseIf	aTRBI[nVolt,9] $ "4" // Reprovado por Falta 
			cSituac := "RF"                                                                 			
		ElseIf	aTRBI[nVolt,9] $ "5" //  Reprovado por exame (exibe com reprovado por nota pois dot nao possui legenda RE)  
			cSituac := "RN"                                                                 
		ElseIf	aTRBI[nVolt,9] == "8" // Dispensado
			cSituac := If(aTRBI[nVolt,10] <> "S", "D", "AE")
			
			nPos := Ascan(aObs,{|x| x[1] = aTRBI[nVolt,11]})
			If nPos == 0
				cObs := REPLICATE("*",Len(aObs)+1)
				Aadd(aObs,{aTRBI[nVolt,11],cObs})
			Else
				cObs := aObs[nPos,2]
			EndIf
			If Ascan(aLeg,{|x| x[1] + x[2] == aTRBI[nVolt,11]+Alltrim(aTRBI[nVolt,16])+' '}) == 0
				nPos := Ascan( aObs, { |x| x[1] == aTRBI[nVolt,11] } )
				If !empty(alltrim(aTRBI[nVolt,11]))
					Aadd(aLeg,{aTRBI[nVolt,11],Alltrim(aTRBI[nVolt,16])+' ',aObs[nPos][2],Alltrim(aTRBI[nVolt,13])+' '})
					if !empty(alltrim(aTRBI[nVolt,11]+''+Alltrim(aTRBI[nVolt,16])+''+Alltrim(aTRBI[nVolt,13])))
						aCleng += 1
					endif
				endif
			EndIf
		EndIf
		
		OLE_SetDocumentVar(hWord,"cSituac"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)),cSituac)
		nCntFo1 += 1
		
		OLE_SetDocumentVar(hWord,"cObs"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)),cObs)
		nCntFo1 += 1
		
		OLE_SetDocumentVar(hWord, "nFaltas"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Str(aTRBI[nVolt,20],4,0))
		nCntFo1 += 1
		
		if len(aTRBI) >= (nVolt+1)
			cNextSem := aTRBI[nVolt+1,14]
		endif
		
		OLE_SetDocumentVar(hWord, "cNome"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(aTRBI[nVolt,18])+' ')
		OLE_SetDocumentVar(hWord, "cCargo"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), Alltrim(aTRBI[nVolt,19])+' ')
		
		nCntFo1 += 1
		
		OLE_SetDocumentVar(hWord, "cConclu"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), if( !Empty(aTRBI[nVolt,12]), Alltrim(aTRBI[nVolt,12])+" ", " " ) )
		nCntFo1 += 1
		
		cCargaHor   := AllTrim(Str(aTRBI[nVolt,7]))+' '
		cCredDiscip := Tabela("FY", cCargaHor, .F.)
		
		OLE_SetDocumentVar(hWord, "cCred"+AllTrim(Str(nCntFor))+AllTrim(Str(nCntFo1)), cCredDiscip)
		nCntFo1 += 1
		
		//����������������������������������������������������������������Ŀ
		//� Indica se a disciplina deve ser impressa no final do historico �
		//������������������������������������������������������������������
		OLE_SetDocumentVar(hWord,'cOrdem'+AllTrim(Str(nCntFor)), aTRBI[nVolt,22] )
		
		if len(aTRBI) >= (nVolt+1)
			If cNextSem <> aTRBI[nVolt,14]
				OLE_SetDocumentVar(hWord,'Adv_CriaLinha' + Alltrim(Str(nCntFor)) ,"S")
				cNextSem := cSemestg
			Else
				OLE_SetDocumentVar(hWord,'Adv_CriaLinha' + Alltrim(Str(nCntFor)) ,"N")
			EndIf
		else
			OLE_SetDocumentVar(hWord,'Adv_CriaLinha' + Alltrim(Str(nCntFor)) ,"N")
		endif
		
		cSemestg	:= aTRBI[nVolt,14]
		
		JAR->( dbSetOrder( 1 ) )
		JAR->( dbSeek( xFilial( "JAR" ) + TRBC->CODCUR + cSemestg ) )
		
		cConceito	:= JAR->JAR_CRIAVA
		
	next nVolt

	//�����������������������������������������������������������������������Ŀ
	//� Nr. de linhas da Tabela a ser utilizada na matriz do Word             �
	//�������������������������������������������������������������������������
	OLE_SetDocumentVar(hWord,'Adv_SEMESTRE',Str(nCntFor))
	OLE_SetDocumentVar(hWord, "cCHCurso"  , ALLTRIM(STR(nVALCH)))
	OLE_SetDocumentVar(hWord, "dDtHoje" , SubStr(DtoC(dDataBase),1,2) + " de " + MesExtenso(Val(SubStr(DtoC(dDataBase),4,2))) + " de " + AllTrim(Str(Year(dDataBase))))
	
	//�����������������������������������������������������������������������Ŀ
	//� Gerando variaveis para observacao 	                	              �
	//�������������������������������������������������������������������������
	cObserv := " "
	
	For nx := 1 to Len(aObs)
		cObserv += aObs[nx,2]
		cObserv += " Disciplina cursada na "+Alltrim(Posicione("JCL",1,xFilial("JCL") + aObs[nx,1],"JCL_NOME")) + " "
	Next
	
	OLE_SetDocumentVar( hWord, "cObserv", cObserv )
	
	//�������������������������������������������������������������������Ŀ
	//� Gerando variavel para legenda de conceitos de outras instituicoes �
	//���������������������������������������������������������������������
	cLegenda := ""
	
	OLE_SetDocumentVar( hWord, "nNumLeg", str(aCleng) )
	
	For nx := 1 to Len(aLeg)
		cLegenda += aLeg[nx,3] + aLeg[nx,2] + " " + aLeg[nx,4] + "; "
		OLE_SetDocumentVar( hWord, "cCodLeg"+Alltrim(Str(nx,2)), aLeg[nx,3] )
		OLE_SetDocumentVar( hWord, "cLeg"+Alltrim(Str(nx,2)), aLeg[nx,2] + " " + aLeg[nx,4] )
	Next
	
	OLE_SetDocumentVar( hWord, "cLegenda", cLegenda )
	OLE_SetDocumentVar(hWord, "CdasTA"			, "S�o Paulo, " + SubStr(DtoC(dDataBase),1,2) + " de " + MesExtenso(Val(SubStr(DtoC(dDataBase),4,2))) + " de " + AllTrim(Str(Year(dDataBase)))+'.')
	
	//�����������������������������������������������������������������������Ŀ
	//� Gerando variaveis para assinaturas 	                	              �
	//�������������������������������������������������������������������������
	aAss := U_ACRetAss( cPRO )
	
	OLE_SetDocumentVar( hWord, "cAss1"  , aAss[1] )
	OLE_SetDocumentVar( hWord, "cCargo1", aAss[2] )
	
	aAss := U_ACRetAss( cSEC )
	
	OLE_SetDocumentVar( hWord, "cAss2"  , aAss[1] )
	OLE_SetDocumentVar( hWord, "cCargo2", aAss[2] )
	
	//�����������������������������������������������������������������������Ŀ
	//� Executa macro do Word                                                 �
	//�������������������������������������������������������������������������

// macro com problema de execussao

	OLE_ExecuteMacro(hWord,"SEMESTRE")
//
	
	//�����������������������������������������������������������������������Ŀ
	//� Atualizando variaveis do documento                                    �
	//�������������������������������������������������������������������������
	OLE_UpdateFields( hWord )
	
	//�����������������������������������������������������������������������Ŀ
	//� Maximizo o Documento Word e Ativo o Visible do Word                   �
	//�������������������������������������������������������������������������
	//	OLE_ExecuteMacro( hWord, "Proteger" )
	
	if lImprime
		OLE_PrintFile( hWord )
		Sleep(2000)	// Espera 2 segundos pra imprimir.
		OLE_CloseFile( hWord )  
	endif
	
	TRBC->( dbSkip() )
End

if !lImprime
	OLE_SetProperty( hWord, oleWdVisible, .T. )
	OLE_SetProperty( hWord, oleWdWindowState, "MAX" )
endif

//������������������������������������������������Ŀ
//�Efetuar o fechamento do Link sem encerrar o Word�
//��������������������������������������������������
OLE_CloseLink( hWord, lImprime )

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC002AE  �Autor  �Rafael Rodrigues    � Data �  14/Mai/03  ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se o aluno cursou esta disciplina na mesma institu-���
���          �icao e se foi no mesmo curso padrao do curso no JCO.        ���
�������������������������������������������������������������������������͹��
���Uso       �SEC0002                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SEC002AE( cIns, cNumRA, cDiscip, cCodCur )
Local lRet	:= Alltrim(cIns) == Alltrim(cCodIns)
Local aArea	:= JC7->( GetArea() )

if lRet
	lRet := .F.
	JC7->( dbSetOrder(3) )
	JC7->( dbSeek( xFilial("JC7")+cNumRA+cDiscip ) )
	while JC7->( JC7_FILIAL+JC7_NUMRA+JC7_DISCIP ) == xFilial("JC7")+cNumRA+cDiscip .and. JC7->( !eof() )
		if JC7->JC7_SITUAC $ "28" .and. AcaCurPad(JC7->JC7_CODCUR) == AcaCurPad(cCodCur)
			lRet := .T.
			exit
		endif
		JC7->( dbSkip() )
	end
	
	JC7->( RestArea(aArea) )
	
endif

Return lRet
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC002EQ  �Autor  �Rafael Rodrigues    � Data �  09/09/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se o aluno cursou alguma equivalencia da disciplina���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SEC002EQ( cNumRA, cCodDis, cCodCur )
Local lRet		:= .F.
Local cQuery	:= ""
Local aDiscip   := { cCodDis }
Local aDisOri	:= { cCodDis }
Local aArea		:= GetArea()
Local cDiscip	:= "'"+cCodDis+"'"
Local cDisOri	:= "'"+cCodDis+"'"
Local i

while !lRet .and. !Empty( aDisOri )
	cQuery := "Select Distinct JC7_PERLET, JC7_HABILI, JC7_TURMA, JC7_DISCIP, JC7_SITUAC "
	cQuery += "From "
	cQuery += RetSQLName("JC7")+" JC7 "
	cQuery += "Where "
	cQuery += "    JC7_FILIAL = '"+xFilial("JC7")+"' and JC7.D_E_L_E_T_ <> '*' "
	cQuery += "and JC7_NUMRA  = '"+cNumRA+"' "
	cQuery += "and JC7_CODCUR = '"+cCodCur+"' "
	cQuery += "and JC7_DISORI in ("+cDisOri+") "
//	cQuery += "and JC7_DISCIP not in ("+cDiscip+") "
	
	cQuery := ChangeQuery( cQuery )
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TRBEQV", .F., .F.)
	
	TRBEQV->( dbGoTop() )
	aDisOri := {}
	while !lRet .and. TRBEQV->( !eof() )
		if TRBEQV->JC7_SITUAC $ "1268"		// Cursando/Aprovado/Exame/Dispensado
			lRet := .T.
			JC7->( dbSetOrder(1) )
			JC7->( dbSeek( xFilial("JC7")+cNumRA+cCodCur+TRBEQV->JC7_PERLET+TRBEQV->JC7_HABILI+TRBEQV->JC7_TURMA+TRBEQV->JC7_DISCIP ) )
		endif
		
		aAdd( aDisOri, TRBEQV->JC7_DISCIP )
		if aScan( aDiscip, TRBEQV->JC7_DISCIP ) == 0
			aAdd( aDiscip, TRBEQV->JC7_DISCIP )
		endif
		TRBEQV->( dbSkip() )
	end
	
	TRBEQV->( dbCloseArea() )
	
	cDisOri := ""
	for i := 1 to len( aDisOri )
		cDisOri += "'"+aDisOri[i]+"', "
	next i
	cDisOri := Left( cDisOri,len(cDisOri)-2 )
	
	cDiscip := ""
	for i := 1 to len( aDiscip )
		cDiscip += "'"+aDiscip[i]+"', "
	next i
	cDiscip := Left( cDiscip,len(cDiscip)-2 )
end

RestArea(aArea)   

Return lRet
