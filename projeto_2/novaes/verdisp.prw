#include "Protheus.ch"

//Defines de posi��o do array de filiais
Static lFWCodFil := FindFunction("FWCodFil")
Static aFilProc := {}
Static nRetAviso := 0

User Function VERDISP(lWizard)

Local lOpenedEmp := .T.

cArqEmp		:= "SigaMat.Emp"
nModulo		:= 02
__cInterNet	:= Nil

PRIVATE cMessage
PRIVATE aArqUpd	 := {}
PRIVATE aREOPEN	 := {}

lWizard	:= .F.

Set Dele On

lOpenedEmp := MsOpenDbf(.T.,__LocalDriver,"SIGAMAT.EMP", "SM0",.T.,.F.)
IF ( lOpenedEmp )
	MsOpenIdx("SIGAMAT.IND",'M0_CODIGO+M0_CODFIL',.T.,,,"SIGAMAT.IND")
	DbSetIndex("SIGAMAT.IND")
ELSE
	MsgAlert("N�o foi poss�vel abrir o Microsiga","ESCALONAR")
ENDIF

DbGoTop()

	lEmpenho	:= .F.
	lAtuMnu		:= .F.

	DEFINE WINDOW oMainWnd FROM 0,0 TO 01,1 TITLE OEMTOANSI("Verifica��o de Ambiente")

	ACTIVATE WINDOW oMainWnd ICONIZED;
	ON INIT Processa({|lEnd| cTexto := VERProc(@lEnd)},OEMTOANSI("Processando..."),OEMTOANSI("Aguarde"),.F.)

	DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
	DEFINE MSDIALOG oDlg TITLE STR0028 From 3,0 to 340,417 PIXEL //"Atualizacao concluida."
	@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
	oMemo:bRClicked := {||AllwaysTrue()}
	oMemo:oFont:=oFont

	DEFINE SBUTTON  FROM 153,175 TYPE  1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga

	ACTIVATE MSDIALOG oDlg CENTER

Return


Static Function VERProc(lEnd)

Local cTexto   := ''
Local cFile    := ""
Local cMask    := STR0009 //"Arquivos Texto (*.TXT) |*.txt|"
Local nRecno   := 0
Local nX       := 0
Local nRecAtu
Local aAreaSM0
Local lAbriu
Local nCFil		:= 0
Local aSM0		:= {}

Private cPaisLoc := ""
Private cMvConsold := ""

ProcRegua(1)
IncProc(STR0010) //"Verificando integridade dos dicionarios...."

OpenSm0Excl()
aSM0 := AdmAbreSM0()

For nCFil := 1 to Len(aSM0)
	
	RpcSetType(3)
	RpcSetEnv(aSM0[nCFil][SM0_GRPEMP], aSM0[nCFil][SM0_CODFIL] )
	
	RpcClearEnv()
	OpenSm0Excl()
	
Next nCFil

For nCFil := 1 to Len(aSM0)
	
	aArqUpd  := {}
	
	RpcSetType(3)
	RpcSetEnv(aSM0[nCFil][SM0_GRPEMP], aSM0[nCFil][SM0_CODFIL] )
	
	cPaisLoc := GETMV("MV_PAISLOC",.F.,"BRA")
	cMvConsold := Alltrim(Getmv("MV_CONSOLD"))
	
	cTexto += Replicate("-",128)+CRLF
	cTexto += STR0011+aSM0[nCFil][SM0_GRPEMP]+STR0012+aSM0[nCFil][SM0_CODFIL]+"-"+aSM0[nCFil][SM0_NOME]+CRLF //"Empresa : "###" Filial : "
	ProcRegua(8)
	
	//������������������������������������Ŀ
	//�Atualiza as perguntas de relatorios.�
	//��������������������������������������
	IncProc(STR0013) // //"Analisando Perguntas de Relatorios..."
	cTexto += CTBAtuSX1()
	
	//����������������������������������Ŀ
	//�Atualiza o dicionario de arquivos.�
	//������������������������������������
	IncProc(STR0014) // //"Analisando Dicionario de Arquivos..."
	cTexto += CTBAtuSX2()
	
	//�����������������������������������������Ŀ
	//�Atualiza os grupos de campos. 			�
	//�Proceder nesta atualizacao antes do SX3  �
	//�������������������������������������������
	IncProc(STR0052) // //"Analisando Grupos de Campos..."
	cTexto += CTBAtuSXG()
	
	//�������������������������������Ŀ
	//�Atualiza o dicionario de dados.�
	//���������������������������������
	IncProc(STR0015) // //"Analisando Dicionario de Dados..."
	cTexto += CTBAtuSX3()
	
	//�������������������������������Ŀ
	//�Atualiza o dicionario de dados.�
	//���������������������������������
	IncProc("Atualizando helps de campos...") // //"Atualizando helps de campos..."
	cTexto += CTBAtuHlp()
	
	//�����������������������Ŀ
	//�Atualiza os parametros.�
	//�������������������������
	IncProc(STR0016) // // //"Analisando Tabelas..."
	cTexto += CTBAtuSX5()
	
	//�����������������������Ŀ
	//�Atualiza os parametros.�
	//�������������������������
	IncProc(STR0017) // //"Analisando Parametros..."
	cTexto += CTBAtuSX6()
	
	//���������������������Ŀ
	//�Atualiza os gatilhos.�
	//�����������������������
	IncProc(STR0018) // //"Analisando Gatilhos..."
	cTexto += CTBAtuSX7()
	
	//���������������������������������Ŀ
	//�Atualiza os folder's de cadastro.�
	//�����������������������������������
	IncProc(STR0019) //"Analisando Folder de Cadastro..."
	cTexto += CTBAtuSXA()
	
	//������������������������������Ŀ
	//�Atualiza as consultas padroes.�
	//��������������������������������
	IncProc(STR0020) // //"Analisando Consultas Padroes..."
	cTexto += CTBAtuSXB()
	
	//������������������������������Ŀ
	//|Atualiza os indices.          |
	//��������������������������������
	ProcRegua(2)
	IncProc(STR0021) // //"Analisando Indices..."
	cTexto += CTBAtuSIX()
	
	__SetX31Mode(.F.)
	For nX := 1 To Len(aArqUpd)
		lAbriu := .F.
		IncProc(STR0022+aArqUpd[nx]+"]") //"Atualizando estruturas. Aguarde... ["
		If Select(aArqUpd[nx])>0
			lAbriu := .T.
			dbSelecTArea(aArqUpd[nx])
			dbCloseArea()
		EndIf
		X31UpdTable(aArqUpd[nx])
		If __GetX31Error()
			Alert(__GetX31Trace())
			Aviso(STR0001,STR0023+ aArqUpd[nx] + STR0024,{STR0025},2) //"Atencao!"###"Ocorreu um erro desconhecido durante a atualizacao da tabela : "###". Verifique a integridade do dicionario e da tabela."###"Continuar"
			cTexto += STR0026+aArqUpd[nx] +CRLF //"Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "
		ElseIf ! lAbriu
			dbSelectArea(aArqUpd[nx])
			dbCloseArea()
		EndIf
	Next nX
	
	//�����������������������������������Ŀ
	//|Atualiza a tabela de processos CVG |
	//�������������������������������������
	ProcRegua(2)
	IncProc(STR0055) // "Atualizando Processos..."
	cTexto += CTBAtuCVG( xFilial( "CVG", aSM0[nCFil][SM0_CODFIL] ) )
	
	//�����������������������������������Ŀ
	//|Atualiza a tabela de processos CVJ |
	//�������������������������������������
	ProcRegua(2)
	IncProc(STR0053) // "Atualizando Processos..."
	cTexto += CTBAtuCVJ( xFilial( "CVJ",aSM0[nCFil][SM0_CODFIL] ) )
	
	//������������������������������������������������������������������������Ŀ
	//|Atualiza a tabela CT0 incluindo as entidades padroes (CT1,CTT,CTD e CTH)|
	//|caso o pais seja PERU ou COLOMBIA inclui a entidade 05                  |
	//��������������������������������������������������������������������������
	If AliasInDic("CT0") .And. FindFunction("CtbIncCT0")
		CtbIncCT0() // Fonte CTB0005
	ENdIf
	
	If Empty(cMvConsold)  // ajustar conteudo do campo filial de origem da tabela CT2_FILORI
		// somente nas empresas que nao sao consolidadoras
		CtbFilOri( cEmpAnt, cFilAnt )
	EndIf
	
	//�����������������������������������Ŀ
	//|Atualiza a Pyme                    |
	//�������������������������������������
	ProcRegua(2)
	IncProc(STR0058) // "Atualizando Pyme dos Campos"
	cTexto += CTBAtuPyme()
	
	
	RpcClearEnv()
	OpenSm0Excl()
	
Next nCFil

RpcSetEnv(aSM0[1][SM0_GRPEMP],aSM0[1][SM0_CODFIL],,,,, { "AE1" }) 

cTexto := STR0031+CRLF+cTexto //"Log da atualizacao "

Return cTexto