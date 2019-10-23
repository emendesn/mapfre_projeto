#INCLUDE "Protheus.ch" 

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �UpdGE31    �Autor  � Otacilio A. Junior   � Data �05/05/2008���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualizacao do dicionario de dados para contemplacao do	  ���
���          � n�mero m�ximo de colunas no indice limite 16 colunas.      ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function UpdGE31()

Local cMsg := ""

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

Private cMessage
Private aArqUpd	 := {}
Private aREOPEN	 := {}
Private oMainWnd

Set Dele On

cMsg += "Este programa tem como objetivo ajustar os dicion�rios e base de dados "
cMsg += "para a implementa��o da melhoria de subturma na grade de aulas di�ria."+Chr(13)+Chr(10)+Chr(13)+Chr(10)
cMsg += "Esta rotina deve ser processada em modo exclusivo! "+Chr(13)+Chr(10)+Chr(13)+Chr(10)
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
oMainWnd:bInit := {|| if( Aviso( "Atualizador de Base", cMsg, {"Cancelar", "Prosseguir"}, 3 ) == 2 , ( Processa({|lEnd| GEProc(@lEnd)} , "Atualizador de Base" ) , oMainWnd:End() ), ( MsgAlert( "Opera�ao cancelada!" ), oMainWnd:End() ) ) }

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
			
	        //Atualiza indices e chave unica existentes nas tabelas                                 
			cTexto+= AtuBase()
			
			//Utiliza o Select Area para forcar a criacao das tabelas
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Retirando registros deletados dos dicionarios...")
			SIX->( Pack() )
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Retirando registros deletados dos dicionarios...")

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

If Select("SM0") == 0
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
Else
	lOpen := .T. 
EndIf
	
Return( lOpen )


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    |AtuBase   � Autor �Karen Honda         � Data � 29/out/2007 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Atualiza os indices 1 e chave unica no banco de dados       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
            
Static Function AtuBase()
                
Local lSeq   := JC7->( FieldPos("JC7_SEQ") ) > 0
Local cTexto := ' '

//��������������������������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Troca a chave da tabela JC7 para subturma                                       		  		  		                                                               �
//�De: JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SEQ              |
//�Para: JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SEQ+JC7_SUBTUR �
//�Adiciona campo de sub-turma na chave 1 da JC7                                                                                                                       �
//����������������������������������������������������������������������������������������������������������������������������������������������������������������������
SX3->(DbSetOrder(2))
If SX3->( dbSeek("JC7_SUBTUR") )
	if SIX->( dbSeek("JC71") ) .and. .NOT. Alltrim(SIX->CHAVE) == iif(lSeq,	"JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SEQ",;	
																				"JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SUBTUR")
		if Select("JC7") > 0
			JC7->( dbCloseArea() )
		endif
		// So atualiza se conseguir acesso exclusivo aa tabela
		if ChkFile("JC7",.T.)
		
			// FECHA A TABELA PARA MANIPULAR O INDICE
			JC7->( dbCloseArea() )
			
			RecLock("SIX",.F.)
			if lSeq
				SIX->CHAVE := "JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SEQ"
			else
				SIX->CHAVE := "JC7_FILIAL+JC7_NUMRA+JC7_CODCUR+JC7_PERLET+JC7_HABILI+JC7_TURMA+JC7_DISCIP+JC7_CODLOC+JC7_CODPRE+JC7_ANDAR+JC7_CODSAL+JC7_DIASEM+JC7_HORA1+JC7_SUBTUR"
			endif
			SIX->( msUnlock() )
			
			// FECHA A TABELA PARA MANIPULAR O INDICE
			JC7->( dbCloseArea() )
			
			// APAGA E RECRIA INDICE NO DATABASE COM NOVO CAMPO
			TcSqlExec( "DROP INDEX "+RetSqlName("JC7")+"."+RetSQLName("JC7")+"1" )
			If lSeq
				TcSqlExec( "CREATE INDEX "+RetSQLName("JC7")+"1 ON "+RetSQLName("JC7")+" ( JC7_FILIAL,JC7_NUMRA,JC7_CODCUR,JC7_PERLET,JC7_HABILI,JC7_TURMA,JC7_DISCIP,JC7_CODLOC,JC7_CODPRE,JC7_ANDAR,JC7_CODSAL,JC7_DIASEM,JC7_HORA1,JC7_SEQ,R_E_C_D_E_L_ )" )
			Else
				TcSqlExec( "CREATE INDEX "+RetSQLName("JC7")+"1 ON "+RetSQLName("JC7")+" ( JC7_FILIAL,JC7_NUMRA,JC7_CODCUR,JC7_PERLET,JC7_HABILI,JC7_TURMA,JC7_DISCIP,JC7_CODLOC,JC7_CODPRE,JC7_ANDAR,JC7_CODSAL,JC7_DIASEM,JC7_HORA1,JC7_SUBTUR,R_E_C_D_E_L_ )" )
			EndIf
			TCSQLExec( "commit" )
		endif

		// Reabre a Tabela em modo compartilhado
		ChkFile("JC7",.F.) 
		cTexto:= "Atualizado o Indice 1 da Tabela JC7"+CHR(13)+CHR(10)
	EndIf	
endif                                             

Return cTexto
