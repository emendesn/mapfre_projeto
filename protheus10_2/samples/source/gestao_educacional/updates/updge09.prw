#INCLUDE "Protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �UpdGE09    �Autor  � Rafael Rodrigues     � Data � 20/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualizacao do dicionario de dados para contemplacao da	  ���
���          � rotinas de melhorias do projeto ANHEMBI                    ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function UpdGE09()
Local cMsg := ""

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

Private cMessage
Private aArqUpd	 := {}
Private aREOPEN	 := {}
Private oMainWnd

Set Dele On

cMsg += "Este programa tem como objetivo ajustar os dicion�rios e base de dados "
cMsg += "para a implementa��o a melhoria de controle de matricula apos final do curso."+Chr(13)+Chr(10)
cMsg += "Esta rotina deve ser processada em modo exclusivo! "
cMsg += "Fa�a um backup dos dicion�rios e base de dados antes do processamento!"

oMainWnd := MSDIALOG():Create()
oMainWnd:cName := "oMainWnd"
oMainWnd:cCaption := "Implementando ..."
oMainWnd:nLeft := 0
oMainWnd:nTop := 0
oMainWnd:nWidth := 640
oMainWnd:nHeight := 460
oMainWnd:lShowHint := .F.
oMainWnd:lCentered := .T.
oMainWnd:bInit := {|| if( Aviso( "Atualizador de Base", cMsg, {"Cancelar", "Prosseguir"}, 2 ) == 2 , ( Processa({|lEnd| GEProc(@lEnd)} , "Atualizador de Base" ) , oMainWnd:End() ), ( MsgAlert( "Opera�ao cancelada!" ), oMainWnd:End() ) ) }

oMainWnd:Activate()
	
Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEProc    � Autor �Rafael Rodrigues      � Data � 20/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao dos arquivos           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEProc(lEnd)
Local cTexto    := '' 				//Exibira o log ao final do processo
Local cFile     :="" 				//Nome do arquivo, caso o usuario deseje salvar o log das operacoes
Local cMask     := "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    := 0
Local nI        := 0                //Contador para laco
Local nX        := 0	            //Contador para laco
Local aRecnoSM0 := {}
Local lOpen     := .F. 				//Retorna se conseguiu acesso exclusivo a base de dados
Local nModulo	:= 49 				//SIGAGE - GESTAO EDUCACIONAL

/********************************************************************************************
Inicia o processamento.
********************************************************************************************/
IncProc("Verificando integridade dos dicion�rios....")

If ( lOpen := MyOpenSm0Ex() )

	dbSelectArea("SM0")
	dbGotop()
	While !Eof() 
  		If ( nI := Ascan( aRecnoSM0, {|x| x[2] == M0_CODIGO} ) ) == 0 //--So adiciona no aRecnoSM0 se a empresa for diferente
			aAdd(aRecnoSM0,{Recno(),M0_CODIGO,{}})
			nI := Len(aRecnoSM0)
		EndIf
		
		aAdd( aRecnoSM0[nI,3], SM0->M0_CODFIL )
		
		dbSkip()
	EndDo	
		
	If lOpen
		For nI := 1 To Len(aRecnoSM0)
			
			SM0->(dbGoto(aRecnoSM0[nI,1]))
			RpcSetType(2) 
			RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)
			lMsFinalAuto := .F.

			cTexto += Replicate("-",128)+CHR(13)+CHR(10)
			cTexto += "Empresa : "+SM0->M0_CODIGO+SM0->M0_NOME+CHR(13)+CHR(10)

			ProcRegua( nI)
			IncProc("Empresa : "+SM0->M0_CODIGO+SM0->M0_NOME)			
			
			//���������������������������������������Ŀ
			//�Elimina do SX o que deve ser eliminado.�
			//�����������������������������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Limpando Dicion�rios")
			cTexto += "Limpando Dicion�rios..."+CHR(13)+CHR(10)
			GELimpaSX()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Limpando Dicion�rios")						
			
			//����������������������������������Ŀ
			//�Atualiza o dicionario de arquivos.�
			//������������������������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Dicionario de Arquivos")			
			cTexto += "Analisando Dicionario de Arquivos..."+CHR(13)+CHR(10)
			GEAtuSX2()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Dicionario de Arquivos")

			//�������������������������������Ŀ
			//�Atualiza o dicionario de dados.�
			//���������������������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Dicionario de Dados")			
			cTexto += "Analisando Dicionario de Dados..."+CHR(13)+CHR(10)
			GEAtuSX3()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Dicionario de Dados")              

			//�������������������������������Ŀ
			//�Atualiza os parametros.        �
			//���������������������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Parametros")			
			cTexto += "Analisando Parametros..."+CHR(13)+CHR(10)
			GEAtuSX6()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Parametros")


			//�������������������������������Ŀ
			//�Atualiza os gatilhos.          �
			//���������������������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Gatilhos")			
			cTexto += "Analisando Gatilhos..."+CHR(13)+CHR(10)
			GEAtuSX7()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Gatilhos")

			//��������������������Ŀ
			//�Atualiza os indices.�
			//����������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Indices")
			cTexto += "Analisando arquivos de �ndices. "+CHR(13)+CHR(10)
			GEAtuSIX()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Indices")
			
			//��������������������Ŀ
			//�Atualiza Consultas  �
			//����������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Consultas Padroes")
			cTexto += "Analisando consultas padroes..."+CHR(13)+CHR(10) 
			GEAtuSxB( SM0->M0_CODIGO )
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Consultas Padroes")

			__SetX31Mode(.F.)
			For nX := 1 To Len(aArqUpd)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx])
				cTexto += "Atualizando estruturas. Aguarde... ["+aArqUpd[nx]+"]"+CHR(13)+CHR(10)
				If Select(aArqUpd[nx])>0
					dbSelecTArea(aArqUpd[nx])
					dbCloseArea()
				EndIf
				X31UpdTable(aArqUpd[nx])
				If __GetX31Error()
					Alert(__GetX31Trace())
					Aviso("Atencao!","Ocorreu um erro desconhecido durante a atualizacao da tabela : "+ aArqUpd[nx] + ". Verifique a integridade do dicionario e da tabela.",{"Continuar"},2)
					cTexto += "Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "+aArqUpd[nx] +CHR(13)+CHR(10)
				EndIf
				IncProc( dtoc( Date() )+" "+Time()+" "+"Fim Atualizando Estruturas "+aArqUpd[nx])
			Next nX

			//Utiliza o Select Area para forcar a criacao das tabelas
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Retirando registros deletados dos dicionarios...")
			SIX->( Pack() )
			SX2->( Pack() )
			SX3->( Pack() )
			SX6->( Pack() )
			SX7->( Pack() )
			SXB->( Pack() )
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Retirando registros deletados dos dicionarios...")

			//Utiliza o Select Area para forcar a criacao das tabelas
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Abrindo Tabelas")

			dbSelectArea("JBE")

			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Abrindo Tabelas")
			
			// Atualiza a base de dados da empresa para cada filial
			For nX := 1 To Len(aRecnoSM0[nI,3])

				RpcSetType(2)
				RpcSetEnv(aRecnoSM0[nI,2], aRecnoSM0[nI,3,nX])
				lMsFinalAuto := .F.

				IncProc( dtoc( Date() )+" "+Time()+" "+"Criando sequencial para a Filial: "+aRecnoSM0[nI,3,nX] )

				cSQL := "update "+RetSQLName("JBE")+" set jbe_seq = '001'"
				cSQL += " where jbe_seq = ' ' and d_e_l_e_t_ = ' '"
				
				TCSQLExec( cSQL )
				TCSQLExec( "commit" )
				
				cSQL := "update "+RetSQLName("JC7")+" set jc7_seq = '001'"
				cSQL += " where jc7_seq = ' ' and d_e_l_e_t_ = ' '"
				
				TCSQLExec( cSQL )
				TCSQLExec( "commit" )
			  
				cTexto += "Criando sequencial para a Filial: "+aRecnoSM0[nI,3,nX]+CHR(13)+CHR(10)

				ProcRegua(nX)
				IncProc("Criando sequencial para a Filial: "+aRecnoSM0[nI,3,nX])

				RpcClearEnv()
			Next nX
			
			If !( lOpen := MyOpenSm0Ex() )
				Exit 
			EndIf 
			
		Next nI 
		   
		If lOpen

			IncProc( dtoc( Date() )+" "+Time()+" "+"Atualiza��o Conclu�da." )
			
			cTexto := "Log da Atualiza��o "+CHR(13)+CHR(10)+cTexto
			__cFileLog := MemoWrite(Criatrab(,.f.)+".LOG",cTexto)
			DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
			DEFINE MSDIALOG oDlg TITLE "Atualizacao Conclu�da." From 3,0 to 340,417 PIXEL
			@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
			oMemo:bRClicked := {||AllwaysTrue()}
			oMemo:oFont:=oFont
			DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
			DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."
			ACTIVATE MSDIALOG oDlg CENTER
			
		EndIf
		
	EndIf
		
EndIf 	

Return(.T.)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSX2  � Autor �Rafael Rodrigues      � Data � 20/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SX2 - Arquivos      ��� 
���          � Adiciona as tabelas para regra de visibilidade             ��� 
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSX2()
Local aSX2   := {}							//Array que contem as informacoes das tabelas
Local aEstrut:= {}							//Array que contem a estrutura da tabela SX2
Local i      := 0							//Contador para laco
Local j      := 0							//Contador para laco
Local cAlias := ''     						//Nome da tabela
Local cPath									//String para caminho do arquivo 
Local cNome									//String para nome da empresa e filial
Local cModo

aEstrut:= {"X2_CHAVE","X2_PATH","X2_ARQUIVO","X2_NOME","X2_NOMESPA","X2_NOMEENG","X2_DELET","X2_MODO","X2_TTS","X2_ROTINA","X2_UNICO","X2_PYME"}

ProcRegua(Len(aSX2))

dbSelectArea("SX2")
SX2->(DbSetOrder(1))	
MsSeek("JAH") //Seleciona a tabela que eh padrao do sistema para pegar algumas informacoes
cPath := SX2->X2_PATH
cNome := Substr(SX2->X2_ARQUIVO,4,5)
cModo := SX2->X2_MODO

/******************************************************************************************
* Adiciona as informacoes das tabelas num array, para trabalho posterior
*******************************************************************************************/
/*
aAdd(aSX2,{	"JC7",; 								//Chave
			cPath,;									//Path
			"JC7"+cNome,;							//Nome do Arquivo
			"Itens Alocacao do Aluno",;				//Nome Port
			"Itens Alocacao do Aluno",;				//Nome Port
			"Itens Alocacao do Aluno",;				//Nome Port
			0,;										//Delete
			cModo,;									//Modo - (C)Compartilhado ou (E)Exclusivo
			"",;									//TTS
			"",;									//Rotina
			"JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SEQ",;				//Unico
			"S"})									//Pyme
*/			
/*******************************************************************************************
Realiza a inclusao das tabelas
*******************************************/
For i:= 1 To Len(aSX2)
	If !Empty(aSX2[i][1])

		If SX2->( !dbSeek(aSX2[i,1]) )
			RecLock("SX2",.T.) //Adiciona registro		
		Else
			RecLock("SX2",.F.) //Altera Registro
		EndIf
		
		If !(aSX2[i,1]$cAlias)
			cAlias += aSX2[i,1]+"/"
		EndIf

		For j:=1 To Len(aSX2[i])
			If FieldPos(aEstrut[j]) > 0
				FieldPut(FieldPos(aEstrut[j]),aSX2[i,j])
			EndIf
		Next j
		SX2->X2_PATH := cPath
		SX2->X2_ARQUIVO := aSX2[i,1]+cNome
		MsUnLock()
		IncProc("Atualizando Dicionario de Arquivos...")
	EndIf
Next i

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSX3  � Autor �Rafael Rodrigues      � Data � 20/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SX3 - Campos        ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
����������������������������������������������������������������������������*/
Static Function GEAtuSX3()
Local aSX3			:= {}				//Array com os campos das tabelas
Local aEstrut		:= {}              //Array com a estrutura da tabela SX3
Local i				:= 0				//Laco para contador
Local j				:= 0				//Laco para contador
Local lSX3			:= .F.             //Indica se houve atualizacao
Local cAlias		:= ''				//String para utilizacao do noem da tabela
Local cUsadoKey		:= ''				//String que servira para cadastrar um campo como "USADO" em campos chave
Local cReservKey	:= ''				//String que servira para cadastrar um campo como "Reservado" em campos chave
Local cUsadoObr		:= ''				//String que servira para cadastrar um campo como "USADO" em campos obrigatorios
Local cReservObr	:= ''				//String que servira para cadastrar um campo como "Reservado" em campos obrigatorios
Local cUsadoOpc		:= ''				//String que servira para cadastrar um campo como "USADO" em campos opcionais
Local cReservOpc	:= ''				//String que servira para cadastrar um campo como "Reservado" em campos opcionais
Local cUsadoNao		:= ''				//String que servira para cadastrar um campo como "USADO" em campos fora de uso
Local cReservNao	:= ''				//String que servira para cadastrar um campo como "Reservado" em campos fora de uso
Local cOrdem		:= ''

/*******************************************************************************************
Define a estrutura do array
*******************************************/
aEstrut:= { "X3_ARQUIVO","X3_ORDEM"  ,"X3_CAMPO"  ,"X3_TIPO"   ,"X3_TAMANHO","X3_DECIMAL","X3_TITULO" ,"X3_TITSPA" ,"X3_TITENG" ,;
			"X3_DESCRIC","X3_DESCSPA","X3_DESCENG","X3_PICTURE","X3_VALID"  ,"X3_USADO"  ,"X3_RELACAO","X3_F3"     ,"X3_NIVEL"  ,;
			"X3_RESERV" ,"X3_CHECK"  ,"X3_TRIGGER","X3_PROPRI" ,"X3_BROWSE" ,"X3_VISUAL" ,"X3_CONTEXT","X3_OBRIGAT","X3_VLDUSER",;
			"X3_CBOX"   ,"X3_CBOXSPA","X3_CBOXENG","X3_PICTVAR","X3_WHEN"   ,"X3_INIBRW" ,"X3_GRPSXG" ,"X3_FOLDER", "X3_PYME"}

dbSelectArea("SX3")
SX3->(DbSetOrder(2))

/*******************************************************************************************
Seleciona as informacoes de alguns campos para uso posterior
*******************************************/
If SX3->( dbSeek("JAE_CODIGO") ) //Este campo eh chave
	cUsadoKey	:= SX3->X3_USADO
	cReservKey	:= SX3->X3_RESERV
EndIf

If SX3->( dbSeek("JAE_DESC") ) //Este campo eh obrigatorio e permite alterar
	cUsadoObr	:= SX3->X3_USADO
	cReservObr	:= SX3->X3_RESERV
EndIf

If SX3->( dbSeek("JAE_DISPAI") ) //Este campo eh opcional e permite alterar
	cUsadoOpc	:= SX3->X3_USADO
	cReservOpc	:= SX3->X3_RESERV
EndIf

If SX3->( dbSeek("JAE_FILIAL") ) //Este campo nao eh usado
	cUsadoNao	:= SX3->X3_USADO
	cReservNao	:= SX3->X3_RESERV
EndIf

/*******************************************************************************************
Monta o array com os campos das tabelas/*
*******************************************/

SX3->( dbSetOrder(1) )
SX3->( dbSeek("JCS") )
while SX3->( !eof() .and. X3_ARQUIVO == "JCS" )
	cOrdem := SX3->X3_ORDEM
	SX3->( dbSkip() )
end

aAdd(aSX3,{	"JCS",;								//Arquivo
			Soma1(cOrdem),;						//Ordem
			"JCS_SUBTUR",;						//Campo
			"C",;								//Tipo
			4,;									//Tamanho
			0,;									//Decimal
			"Sub-Turma",;			    		//Titulo
			"Sub-Turma",;			    		//Titulo
			"Sub-Turma",;			    		//Titulo
			"Sub-Turma",;			    		//Titulo
			"Sub-Turma",;			    		//Titulo
			"Sub-Turma",;			    		//Titulo
			"@!",;								//Picture
			"AC670VlSub()",;					//VALID
			cUsadoOpc,;							//USADO
			"",;								//RELACAO
			"JBL001",;								//F3
			1,;									//NIVEL
			cReservOpc,;						//RESERV
			"","","","S","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"","","",;							//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME

SX3->( dbSeek("JC7") )
while SX3->( !eof() .and. X3_ARQUIVO == "JC7" )
	cOrdem := SX3->X3_ORDEM
	SX3->( dbSkip() )
end

aAdd(aSX3,{	"JC7",;								//Arquivo
			Soma1(cOrdem),;						//Ordem
			"JC7_SEQ",;							//Campo
			"C",;								//Tipo
			3,;									//Tamanho
			0,;									//Decimal
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"",;								//Picture
			"",;								//VALID
			cUsadoNao,;							//USADO
			"",;								//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservNao,;						//RESERV
			"","","","S","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"","","",;							//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME

SX3->( dbSeek("JBE") )
while SX3->( !eof() .and. X3_ARQUIVO == "JBE" )
	cOrdem := SX3->X3_ORDEM
	SX3->( dbSkip() )
end

aAdd(aSX3,{	"JBE",;								//Arquivo
			Soma1(cOrdem),;						//Ordem
			"JBE_SEQ",;							//Campo
			"C",;								//Tipo
			3,;									//Tamanho
			0,;									//Decimal
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"Sequencial",;			    		//Titulo
			"",;								//Picture
			"",;								//VALID
			cUsadoNao,;							//USADO
			"",;								//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservNao,;						//RESERV
			"","","","S","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"","","",;							//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME

SX3->( dbSeek("PA2") )
while SX3->( !eof() .and. X3_ARQUIVO == "PA2" )
	cOrdem := SX3->X3_ORDEM
	SX3->( dbSkip() )
end

aAdd(aSX3,{	"PA2",;								//Arquivo
			Soma1(cOrdem),;						//Ordem
			"PA2_DTVENC",;						//Campo
			"D",;								//Tipo
			8,;									//Tamanho
			0,;									//Decimal
			"Dt.Vencto.",;			    		//Titulo
			"Dt.Vencto.",;			    		//Titulo
			"Dt.Vencto.",;			    		//Titulo
			"Dt.Vencto.",;			    		//Titulo
			"Dt.Vencto.",;			    		//Titulo
			"Dt.Vencto.",;			    		//Titulo
			"",;								//Picture
			"",;								//VALID
			cUsadoOpc,;							//USADO
			"",;								//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservOpc,;						//RESERV
			"","","","S","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"","","",;							//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME

/******************************************************************************************
Grava informacoes do array no banco de dados
******************************************************************************************/
ProcRegua(Len(aSX3))

SX3->(DbSetOrder(2))	

For i:= 1 To Len(aSX3)

	If !Empty(aSX3[i][1])

		If !dbSeek(aSX3[i,3])
			RecLock("SX3",.T.)		
		Else
			RecLock("SX3",.F.)		
		EndIf

		lSX3	:= .T.
		If !(aSX3[i,1]$cAlias)
			cAlias += aSX3[i,1]+"/"
			if aScan(aArqUpd, aSX3[i,1] ) == 0
				aAdd(aArqUpd,aSX3[i,1])
			endif
		EndIf

		For j:=1 To Len(aSX3[i])
			If FieldPos(aEstrut[j])>0 .And. aSX3[i,j] != NIL
				FieldPut(FieldPos(aEstrut[j]),aSX3[i,j])
			EndIf
		Next j
		MsUnLock()
		IncProc("Atualizando Dicionario de Dados...")

	EndIf
Next i

Return 
            

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSX6  � Autor �Bruno Paulinelli      � Data � 07/Jul/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SX6 - Parametros    ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSX6()

Local aSX6   := {}					//Array que contera os dados dos gatilhos
Local aEstrut:= {}					//Array que contem a estrutura da tabela SX6
Local i      := 0					//Contador para laco
Local j      := 0					//Contador para laco
/*********************************************************************************************
Define a estrutura da tabela SX6
*********************************************************************************************/
aEstrut:= { "X6_VAR","X6_TIPO","X6_DESCRIC","X6_DSCSPA","X6_DSCENG","X6_DESC1","X6_DSCSPA1",;
			"X6_DSCENG1","X6_DESC2","X6_DSCSPA2","X6_DSCENG2","X6_CONTEUD","X6_CONTSPA",;
			"X6_CONTENG","X6_PROPRI","X6_PYME"}

/*
aAdd(aSX6,{	"MV_ACANOCR",;					   //Parametro			 		
			"C",;              				   //Tipo
			"Indica o ano letivo corrente",;   //Descricao
			"Indica o ano letivo corrente",;   //Descricao SPA
			"Indica o ano letivo corrente",;   //Descricao ENG
			"","","",;						   //Descricao1,Descricao SPA1, Descricao ENG1
			"","","",;                        //Descricao2,Descricao SPA2, Descricao ENG2
			"2006","2006","2006",;            //Conteudo, Conteudo SPA, Conteudo ENG
			"S","S"})	                          //Propri, PYME
*/

/*********************************************************************************************
Realiza a gravacao das informacoes do array na tabela SX6
*********************************************************************************************/
ProcRegua(Len(aSX6))

dbSelectArea("SX6")
SX6->(DbSetOrder(1))	
For i:= 1 To Len(aSX6)
	If !Empty(aSX6[i][1])
		If !DbSeek('  '+aSX6[i,1])
			RecLock("SX6",.T.)
		Else	
			RecLock("SX6",.F.)
		Endif	
		For j:=1 To Len(aSX6[i])
			If !Empty(FieldName(FieldPos(aEstrut[j])))
				FieldPut(FieldPos(aEstrut[j]),aSX6[i,j])
			EndIf
		Next j
		MsUnLock()
		IncProc("Atualizando Parametros...")
	EndIf
Next i

Return(.T.)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSX7  � Autor �Rafael Rodrigues      � Data � 20/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SX7 - Gatilhos      ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSX7()

Local aSX7   := {}					//Array que contera os dados dos gatilhos
Local aEstrut:= {}					//Array que contem a estrutura da tabela SX7
Local i      := 0					//Contador para laco
Local j      := 0					//Contador para laco
/*********************************************************************************************
Define a estrutura da tabela SX7
*********************************************************************************************/
aEstrut:= { "X7_CAMPO","X7_SEQUENC","X7_REGRA","X7_CDOMIN","X7_TIPO","X7_SEEK","X7_ALIAS",;
			"X7_ORDEM","X7_CHAVE","X7_CONDIC","X7_PROPRI"}

/*
aAdd(aSX7,{	"JBL_CODDIS",;			 												  //Campo
			"002",;																	  //Sequencia
			"JBO->JBO_CODLOC",;														  //Regra
			"JBL_CODLOC",;      													  //Campo Dominio
			"P",;              														  //Tipo
			"S",;  																	  //Posiciona?
			"JBO",;																	  //Alias
			1,;																		  //Ordem do Indice
			"xFilial('JBO')+M->JBK_CODCUR+M->JBK_PERLET+M->JBK_HABILI+M->JBK_TURMA",;//Chave
			"FunName() <> 'ACAA280'",;												 //Condi
			"S"})																	 //Proprietario
*/

/*********************************************************************************************
Realiza a gravacao das informacoes do array na tabela SX7
*********************************************************************************************/
ProcRegua(Len(aSX7))

dbSelectArea("SX7")
SX7->(DbSetOrder(1))	
For i:= 1 To Len(aSX7)
	If !Empty(aSX7[i][1])
		If !DbSeek(aSX7[i,1]+aSX7[i,2])
			RecLock("SX7",.T.)
		Else	
			RecLock("SX7",.F.)
		Endif	
		For j:=1 To Len(aSX7[i])
			If !Empty(FieldName(FieldPos(aEstrut[j])))
				FieldPut(FieldPos(aEstrut[j]),aSX7[i,j])
			EndIf
		Next j
		MsUnLock()
		IncProc("Atualizando Gatilhos...")
	EndIf
Next i

Return(.T.)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSIX  � Autor �Rafael Rodrigues      � Data � 20/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SIX - Indices       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSIX()
//INDICE ORDEM CHAVE DESCRICAO DESCSPA DESCENG PROPRI F3 NICKNAME SHOWPESQ
Local lSix      := .F.                      //Verifica se houve atualizacao
Local aSix      := {}						//Array que armazenara os indices
Local aEstrut   := {}				        //Array com a estrutura da tabela SiX
Local i         := 0 						//Contador para laco
Local j         := 0 						//Contador para laco
Local cAlias    := ''						//Alias para tabelas
Local lDelInd   := .F.

/*********************************************************************************************
Define estrutura do array
*********************************************************************************************/
aEstrut:= {"INDICE","ORDEM","CHAVE","DESCRICAO","DESCSPA","DESCENG","PROPRI","F3",;
		   "NICKNAME","SHOWPESQ"}

aAdd(aSIX,{	"JC7",;   										//Indice
			"1",;                 								//Ordem
			"JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SEQ",;		//Chave
			"Numero RA + Cod.Curso + Per. Letivo + Habilitacao + Turma + Cod. Disci",;			//Descicao Port.
			"Numero RA + Cod.Curso + Per. Letivo + Habilitacao + Turma + Cod. Disci",;			//Descicao Port.
			"Numero RA + Cod.Curso + Per. Letivo + Habilitacao + Turma + Cod. Disci",;			//Descicao Port.
			"S",; 												//Proprietario
			"",;  												//F3
			"",;  												//NickName
			"S"}) 												//ShowPesq  

aAdd(aSIX,{	"JBE",;   										//Indice
			"1",;                 								//Ordem
			"JBE_FILIAL+JBE_NUMRA+JBE_CODCUR+JBE_PERLET+JBE_HABILI+JBE_TURMA+JBE_SEQ",;		//Chave
			"Numero RA + Cod.Curso + Per. Letivo + Habilitacao + Turma",;			//Descicao Port.
			"Numero RA + Cod.Curso + Per. Letivo + Habilitacao + Turma",;			//Descicao Port.
			"Numero RA + Cod.Curso + Per. Letivo + Habilitacao + Turma",;			//Descicao Port.
			"S",; 												//Proprietario
			"",;  												//F3
			"",;  												//NickName
			"S"}) 												//ShowPesq  

/*********************************************************************************************
Grava as informacoes do array na tabela six
*********************************************************************************************/
ProcRegua(Len(aSIX))

dbSelectArea("SIX")
SIX->(DbSetOrder(1))	

For i:= 1 To Len(aSIX)
	If !Empty(aSIX[i,1])
		If !DbSeek(aSIX[i,1]+aSIX[i,2])
			RecLock("SIX",.T.)
			lDelInd := .F.
		Else
			RecLock("SIX",.F.)
			lDelInd := .T. //Se for alteracao precisa apagar o indice do banco
		EndIf
		
		If UPPER(AllTrim(CHAVE)) != UPPER(Alltrim(aSIX[i,3]))
			if aScan(aArqUpd, aSIX[i,1]) == 0
				aAdd(aArqUpd,aSIX[i,1])
			endif
			
			lSix := .T.
			If !(aSIX[i,1]$cAlias)
				cAlias += aSIX[i,1]+"/"
			EndIf
			For j:=1 To Len(aSIX[i])
				If FieldPos(aEstrut[j])>0
					FieldPut(FieldPos(aEstrut[j]),aSIX[i,j])
				EndIf
			Next j
			MsUnLock()
			If lDelInd
				TcInternal(60,RetSqlName(aSix[i,1]) + "|" + RetSqlName(aSix[i,1]) + aSix[i,2]) //Exclui sem precisar baixar o TOP
			Endif	
		EndIf
		IncProc("Atualizando �ndices...")
	EndIf
Next i

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSXB  �Autora �Solange Zanardi        � Data �02/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao para atualiza��o das consultas padroes do sistema   ���
���          � para quando o cliente for utilizar visibilidade            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSXB(cCodFilial)
Local lSXB      := .F.                      //Verifica se houve atualizacao
Local aSXB      := {}						//Array que armazenara os indices
Local aEstrut   := {}				        //Array com a estrutura da tabela SXB
Local i         := 0 						//Contador para laco
Local j         := 0 						//Contador para laco

//�������������������������Ŀ
//�Define estrutura do array�
//���������������������������
aEstrut:= {"XB_ALIAS", "XB_TIPO", "XB_SEQ", "XB_COLUNA", "XB_DESCRI", "XB_DESCSPA", "XB_DESCENG", "XB_CONTEM", "XB_WCONTEM"}

//���������������������������������������������������Ŀ
//�Define os novos conteudos dos filtros das consultas�
//�����������������������������������������������������

aAdd(aSXB,{	"JBL001","1","01","RE",;		// ALIAS, TIPO, SEQ, COLUNA
			"Selecione a sub-turma",;		// DESCRI
			"Selecione a sub-turma",;		// DESCRI
			"Selecione a sub-turma",;		// DESCRI
			"JBL", "" })				// CONTEM, WCONTEM  

aAdd(aSXB,{	"JBL001","2","01","01",;		// ALIAS, TIPO, SEQ, COLUNA
			"",;						// DESCRI
			"",;						// DESCRI
			"",;						// DESCRI
			"AC670SelSub()", "" })		// CONTEM, WCONTEM

aAdd(aSXB,{	"JBL001","5","01","",;		// ALIAS, TIPO, SEQ, COLUNA
			"",;						// DESCRI
			"",;						// DESCRI
			"",;						// DESCRI
			"M->JCS_SUBTUR", "" })			// CONTEM, WCONTEM	   

//���������������������������������������������������Ŀ
//�Processa consultas para alteracao                  �
//�����������������������������������������������������
ProcRegua(Len(aSXB))

dbSelectArea("SXB")
SXB->(dbSetOrder(1)) //XB_ALIAS+XB_TIPO+XB_SEQ+XB_COLUNA	
For i := 1 To Len(aSXB)
	If !DbSeek(PadR(aSXB[i,1],6)+aSXB[i,2]+aSXB[i,3]+aSXB[i,4])
		RecLock("SXB",.T.)
	Else
		RecLock("SXB",.F.)
	EndIf
	lSxB := .T.
	For j:=1 To Len(aSXB[i])
		If FieldPos(aEstrut[j]) > 0
			FieldPut(FieldPos(aEstrut[j]),aSXB[i,j])
		EndIf
	Next j
	MsUnLock()
	IncProc("Atualizando consulta padrao...")
Next i

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �MyOpenSM0Ex� Autor �Sergio Silveira       � Data �07/01/2003���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Efetua a abertura do SM0 exclusivo                         ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao FIS                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function MyOpenSM0Ex()

Local lOpen := .F. 
Local nLoop := 0 

For nLoop := 1 To 20  
	dbUseArea( .T.,, "SIGAMAT.EMP", "SM0", .F., .F. ) 	
	If !Empty( Select( "SM0" ) ) 
		lOpen := .T. 
		dbSetIndex("SIGAMAT.IND") 
		Exit	
	EndIf
	Sleep( 500 ) 
Next nLoop

If !lOpen
	Aviso( "Atencao !", "Nao foi possivel a abertura da tabela de empresas de forma exclusiva !", { "Ok" }, 2 ) 
EndIf

Return( lOpen )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GELimpaSX � Autor �Rafael Rodrigues    � Data � 01/Fev/2006 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Elimina dados do dicionario antes da atualizacao            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GELimpaSX()
Local i
Local aDelSX2	:= {} //{"JBE", "JC7"}
Local aDelSIX	:= {}
Local aDelSXB	:= {}
Local aDelSX3	:= {}
Local aDelSX6	:= {}

SX2->( dbSetOrder(1) )
for i := 1 to len( aDelSX2 )
	if SX2->( dbSeek( aDelSX2[i] ) )
		TCSQLExec("DROP INDEX "+RetSQLName(aDelSX2[i])+"."+RetSQLName(aDelSX2[i])+"_UNQ")
		RecLock( "SX2", .F. )
		SX2->( dbDelete() )
		SX2->( msUnlock() )
	endif
next i

SXB->( dbSetOrder(1) )
for i := 1 to len( aDelSXB )
	while SXB->( dbSeek( aDelSXB[i] ) )
		RecLock( "SXB", .F. )
		SXB->( dbDelete() )
		SXB->( msUnlock() )
	end
next i

SX3->( dbSetOrder(2) )
for i := 1 to len( aDelSX3 )
	if SX3->( dbSeek( aDelSX3[i] ) )
		RecLock( "SX3", .F. )
		SX3->( dbDelete() )
		SX3->( msUnlock() )
	endif
next i

SIX->( dbSetOrder(1) )
for i := 1 to len( aDelSIX )
	if SIX->( dbSeek( aDelSIX[i] ) )
		RecLock( "SIX", .F. )
		SIX->( dbDelete() )
		SIX->( msUnlock() )
	endif
next i 

SX6->( dbSetOrder(1) )
for i := 1 to len( aDelSX6 )
	if SX6->(dbSeek( aDelSX6[i] ) )
		RecLock( "SX6", .F. )
		SX6->( dbDelete() )
		SX6->( msUnlock() )
	endif
next i

Return