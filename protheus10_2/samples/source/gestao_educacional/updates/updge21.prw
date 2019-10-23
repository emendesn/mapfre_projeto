#INCLUDE "Protheus.ch"        
#INCLUDE "Fileio.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �UpdGE21    �Autor  �Eduardo de Souza      � Data �30/Out/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualizacao do Dicionario de Dados e Base de Dados para 	  ���
���          � contemplar a melhoria do ENADE                             ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
�������������������������������������������������������������������������Ĵ��
���Analista  � Data/Bops/Ver �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���			�        �      �						                    ���
���          �        �      �                                            ���
���          �        �      �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function UpdGE21()
Local cMsg := ""         

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

Private cMessage
Private aArqUpd	 := {}
Private aREOPEN	 := {}
Private oMainWnd          

Set Dele On

cMsg += "Este programa tem como objetivo ajustar os dicion�rios e base de dados "
cMsg += "para a implementa��o da melhoria de ENADE e Historico Escolar. "
cMsg += "Esta rotina deve ser processada em modo exclusivo! "
cMsg += "Fa�a um backup dos dicion�rios e base de dados antes do processamento!" 

oMainWnd			:= MSDIALOG():Create()
oMainWnd:cName		:= "oMainWnd"
oMainWnd:cCaption	:= "Implementando Melhoria (ENADE) / Historico Escolar"
oMainWnd:nLeft		:= 0
oMainWnd:nTop		:= 0
oMainWnd:nWidth		:= 680
oMainWnd:nHeight	:= 540
oMainWnd:lShowHint	:= .F.
oMainWnd:lCentered	:= .T.
oMainWnd:bInit		:= {|| if( Aviso( "Atualizador de Base", cMsg, {"Cancelar", "Prosseguir"}, 2 ) == 2 , ( Processa({|lEnd| GEProc(@lEnd)} , "Atualizador de Base" ) , oMainWnd:End() ), ( MsgAlert( "Opera�ao cancelada!" ), oMainWnd:End() ) ) }

oMainWnd:Activate()
	
Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEProc    � Autora�Eduardo de Souza      � Data �30/Out/06  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de Processamento da Gravacao dos Arquivos           ���
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

Private cArquivo   	:= "UpdGE21.LOG"
Private cErros   	:= "UpdErr.LOG"

//��������������������������������������������������������������������������Ŀ
//�Inicia o Processamento													 �
//����������������������������������������������������������������������������
IncProc("Verificando integridade dos dicion�rios....")

If ( lOpen := MyOpenSm0Ex() )

	dbSelectArea("SM0")
	dbGotop()
	While !Eof() 
		//��������������������������������������������������������������������������Ŀ
		//�Somente adiciona no aRecnoSM0 se a Empresa for Diferente					 �
		//����������������������������������������������������������������������������
  		If ( nI := Ascan( aRecnoSM0, {|x| x[2] == M0_CODIGO} ) ) == 0 
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
			//�����������������������������������Ŀ
			//�Atualiza o Dicionario de Dados SX3 �
			//�������������������������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Dicionario de Dados SX3")			
			cTexto += "Analisando Dicionario de Dados SX3..."+CHR(13)+CHR(10)
			GEAtuSX3()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Dicionario de Dados SX3")              
			AcaLog( cArquivo, dtoc( Date() )+" "+Time()+" "+"Processado Dicionario de Dados SX3" )
			cTexto += "Processado Dicionario de Dados SX3..."+CHR(13)+CHR(10)


			__SetX31Mode(.F.)
			For nX := 1 To Len(aArqUpd)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx])
				AcaLog( cArquivo, dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx] )
				
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
				AcaLog( cArquivo, dtoc( Date() )+" "+Time()+" "+"Fim Atualizando Estruturas "+aArqUpd[nx] )				
			Next nX
			
			RpcClearEnv()
			If !( lOpen := MyOpenSm0Ex() )
				Exit 
			EndIf
			
		Next nI 

		//��������������������������������������������������������������������������Ŀ
		//�Atualiza a base de dados da Empresa para cada Filial						 �
		//����������������������������������������������������������������������������
		For nI := 1 To Len(aRecnoSM0)
		
			For nX := 1 To Len(aRecnoSM0[nI,3])
	
				RpcSetType(2)
				RpcSetEnv(aRecnoSM0[nI,2], aRecnoSM0[nI,3,nX])
				lMsFinalAuto := .F.
				
				IncProc( dtoc( Date() )+" "+Time()+" "+"Atualizando Base de Dados: "+aRecnoSM0[nI,3,nX] )
				cTexto += "Atualizando Base de Dados: "+aRecnoSM0[nI,3,nX]+CHR(13)+CHR(10)
				AcaLog( cArquivo, dtoc( Date() )+" "+Time()+" "+"Atualizando Base de Dados: "+aRecnoSM0[nI,3,nX] )
				
				AtuBase(aRecnoSM0[nI,2], aRecnoSM0[nI,3,nX])
				
				ProcRegua()
	
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
���Fun��o    �GEAtuSX3  � Autor �Eduardo de Souza      � Data �30/Out/06  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de Processamento da Gravacao do SX3 - Campos        ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSX3()
Local aSX3		:= {}		//Array com os campos das tabelas
Local aEstrut	:= {}     	//Array com a estrutura da tabela SX3
Local i			:= 0		//Laco para contador
Local j			:= 0		//Laco para contador
Local lSX3		:= .F.    	//Indica se houve atualizacao
Local cAlias	:= ''		//String para utilizacao do noem da tabela
Local nPosDTEnc	:= 0
//��������������������������������������������������������������������������Ŀ
//�Define a Estrutura do Array												 �
//����������������������������������������������������������������������������
aEstrut:= { "X3_ARQUIVO","X3_ORDEM"  ,"X3_CAMPO"  ,"X3_TIPO"   ,"X3_TAMANHO","X3_DECIMAL","X3_TITULO" ,"X3_TITSPA" ,"X3_TITENG" ,;
			"X3_DESCRIC","X3_DESCSPA","X3_DESCENG","X3_PICTURE","X3_VALID"  ,"X3_USADO"  ,"X3_RELACAO","X3_F3"     ,"X3_NIVEL"  ,;
			"X3_RESERV" ,"X3_CHECK"  ,"X3_TRIGGER","X3_PROPRI" ,"X3_BROWSE" ,"X3_VISUAL" ,"X3_CONTEXT","X3_OBRIGAT","X3_VLDUSER",;
			"X3_CBOX"   ,"X3_CBOXSPA","X3_CBOXENG","X3_PICTVAR","X3_WHEN"   ,"X3_INIBRW" ,"X3_GRPSXG" ,"X3_FOLDER", "X3_PYME"}

dbSelectArea("SX3")
SX3->(DbSetOrder(2))

//��������������������������������������������������������������������������Ŀ
//�Procura o Campo de Exemplo para criar o JA1_TIPREL (Religiao)    		 �
//����������������������������������������������������������������������������
If SX3->( dbSeek("JA2_NOME"))
	cUsado 	:= SX3->X3_USADO
	cReserv :=	SX3->X3_RESERV
EndIf  

//��������������������������������������������������������������������������Ŀ
//�Caso nao encontrar o Campo no SX3 cria-lo						   		 �
//����������������������������������������������������������������������������

//��������������������������������������������������������������������������Ŀ
//�Procura a proxima Ordem para o Novo Campo (Tabela JA1 - Candidatos)   	 �
//����������������������������������������������������������������������������
i := 0
SX3->( dbSetOrder(1) )
SX3->( dbSeek("JBE") )
while SX3->( !eof() .and. X3_ARQUIVO == "JBE" )
	If Alltrim(SX3->X3_CAMPO) == "JBE_DTENC"
		nPosDTEnc := VAL(SX3->X3_ORDEM)
		SX3->( dbSkip() )
		Loop			
	Endif
	If nPosDTEnc > 0			
		RecLock("SX3",.F.)
		SX3->X3_ORDEM := StrZero(Val(SX3->X3_ORDEM)+1,2)
		SX3->(MsUnlock())
	Endif
	SX3->( dbSkip() )
end
	
//��������������������������������������������������������������������������Ŀ
//�Cria o Novo Campo JA1_TIPREL (Religiao)       		 					 �
//����������������������������������������������������������������������������
aAdd(aSX3,{	"JBE",;							//Arquivo
			StrZero(nPosDTEnc+1,2),;		//Ordem
			"JBE_ENADE",;					//Campo
			"C",;							//Tipo
			1,;								//Tamanho
			0,;								//Decimal
			"Situac.ENADE",; 				//Titulo
			"Situac.ENADE",;				//Titulo SPA
			"Situac.ENADE",;	    		//Titulo ENG
			"Situacao do aluno - ENADE",;	//Descricao
			"Situacao do aluno - ENADE",;	//Descricao SPA
			"Situacao do aluno - ENADE",;	//Descricao ENG
			"@!",;							//Picture
			"",;	 						//VALID
			cUsado,;						//USADO
			'',;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReserv,;						//RESERV
			"","","","N","",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;						//CONTEXT, OBRIGAT, VLDUSER
			"1=Nao Compareceu;2=Compareceu;3=Dispensado","1=Nao Compareceu;2=Compareceu;3=Dispensado",;
			"1=Nao Compareceu;2=Compareceu;3=Dispensado",;		//CBOX, CBOX SPA, CBOX ENG
			"","","","","1","S"})			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME	        

			dbSelectArea("SX3")
			SX3->(DbSetOrder(2))
			If SX3->( dbSeek("JCF_UNIDAD"))
				cUsado 	:= SX3->X3_USADO
				cReserv :=	SX3->X3_RESERV
			EndIf  
			
			aAdd(aSX3,{	"JCF",;				//Arquivo
			"11",;							//Ordem
			"JCF_PORMEC",;					//Campo
			"C",;							//Tipo
			20,;							//Tamanho
			0,;								//Decimal
			"Portaria MEC",; 				//Titulo
			"Portaria MEC",;				//Titulo SPA
			"Portaria MEC",;	    		//Titulo ENG
			"Portaria MEC",;				//Descricao
			"Portaria MEC",;				//Descricao SPA
			"Portaria MEC",;				//Descricao ENG
			"@!",;							//Picture
			"",;							//VALID
			cUsado,;						//USADO
			'',;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReserv,;						//RESERV
			"","","","N","",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;						//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","1","S"})			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME	
			
			aAdd(aSX3,{	"JCF",;				//Arquivo
			"12",;							//Ordem
			"JCF_DTPMEC",;					//Campo
			"D",;							//Tipo
			8,;								//Tamanho
			0,;								//Decimal
			"Dt.Port. MEC",; 				//Titulo
			"Dt.Port. MEC",;				//Titulo SPA
			"Dt.Port. MEC",;				//Titulo SPA
			"Data da Portaria MEC",;		//Descricao
			"Data da Portaria MEC",;		//Descricao SPA
			"Data da Portaria MEC",;		//Descricao ENG
			"@!",;							//Picture
			"",;	  						//VALID
			cUsado,;						//USADO
			'',;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReserv,;						//RESERV
			"","","","N","",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;						//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","1","S"})			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME	

			aAdd(aSX3,{	"JCF",;				//Arquivo
			"13",;							//Ordem
			"JCF_DTPUBL",;					//Campo
			"D",;							//Tipo
			8,;								//Tamanho
			0,;								//Decimal
			"Data da Publ",; 				//Titulo
			"Data da Publ",;				//Titulo SPA
			"Data da Publ",;				//Titulo SPA
			"Data da Publicacao",;			//Descricao
			"Data da Publicacao",;			//Descricao SPA
			"Data da Publicacao",;			//Descricao ENG
			"@!",;							//Picture
			"",;	  						//VALID
			cUsado,;						//USADO
			'',;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReserv,;						//RESERV
			"","","","N","",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;						//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","1","S"})			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME	

//��������������������������������������������������������������������������Ŀ
//�Grava Informacoes do Array no Dicionario de Dados						 �
//����������������������������������������������������������������������������
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
	EndIf
Next i

//��������������������������������������������������������������������������Ŀ
//�Atualiza as nomenclaturas de campos                                       �
//����������������������������������������������������������������������������
SX3->(DbSetOrder(2))
if SX3->( dbSeek( "JBE_DTENC" ) )
	RecLock("SX3",.F.)
	SX3->X3_TITULO	:= "Data ENADE"
	SX3->X3_TITENG	:= "ENADE Date"
	SX3->X3_TITSPA	:= "Fecha ENADE"
	SX3->X3_DESCRIC	:= "Data aluno fez o ENADE"
	SX3->X3_DESCSPA	:= "Fec alum hizo ENADE"
	SX3->X3_VALID	:= "AC240DTENC()"
	SX3->X3_USADO	:= cUsado
	SX3->X3_RESERV	:= cReserv
	SX3->X3_WHEN	:= ""
	SX3->(MsUnlock())
endif

dbSelectArea("JA2")

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
	dbUseArea( .T.,, "SIGAMAT.EMP", "SM0", .T., .F. )
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