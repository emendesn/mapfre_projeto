#INCLUDE "Protheus.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  |Updge32   �Autor  �Tatiane Maestrello  � Data � 25/Out/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualizador de dicionarios para contemplar as novas funciona���
���          �lidades do processo seletivo							      ���
�������������������������������������������������������������������������͹��
���Uso       � GE                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function UpdGE32() //Para maiores detalhes sobre a utilizacao deste fonte leia o boletim

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

PRIVATE cMessage
PRIVATE aArqUpd	 := {}
PRIVATE aREOPEN	 := {}
PRIVATE oMainWnd

Set Dele On

lHistorico 	:= MsgYesNo("Deseja efetuar a atualizacao do dicion�rio? Esta rotina deve ser utilizada em modo exclusivo! Faca um backup dos dicion�rios e da base de dados antes da atualiza��o para eventuais falhas de atualiza��o!", "Aten��o")

If lHistorico
	Processa({|lEnd| GEProc(@lEnd)},"Processando","Aguarde, preparando os arquivos",.F.)
	Final("Atualiza��o efetuada!")
endif
	
Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEProc    � Autor �Tatiane Maestrello    � Data � 25/Out/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao dos arquivos           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEProc(lEnd)
Local cTexto    := '' 				//Exibira o log ao final do processo  
Local cTextoAux	:= ""
Local cFile     :="" //Nome do arquivo, caso o usuario deseje salvar o log das operacoes
Local cMask     := "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    := 0
Local nI        := 0                //Contador para laco
Local nX        := 0	            //Contador para laco
Local aRecnoSM0 := {}				     
Local lOpen     := .F. 				//Retorna se conseguiu acesso exclusivo a base de dados
Local nModulo := 49 				//SIGAGE - GESTAO EDUCACIONAL

/********************************************************************************************
Inicia o processamento.
********************************************************************************************/
ProcRegua(1)
IncProc("Verificando integridade dos dicion�rios....")
If ( lOpen := MyOpenSm0Ex() )

	dbSelectArea("SM0")
	dbGotop()
	While !Eof() 
  		If Ascan(aRecnoSM0,{ |x| x[2] == M0_CODIGO}) == 0 //--So adiciona no aRecnoSM0 se a empresa for diferente
			aAdd(aRecnoSM0,{Recno(),M0_CODIGO})
		EndIf			
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
						
			ProcRegua(3)

			//�������������������������������Ŀ
			//�Atualiza o dicionario de dados.�
			//���������������������������������
			IncProc("Analisando Dicionario de Dados...")
			cTexto += AtuSX3()
			GeAtuSXB()

			__SetX31Mode(.F.)
			For nX := 1 To Len(aArqUpd)
				IncProc("Atualizando estruturas. Aguarde... ["+aArqUpd[nx]+"]")
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
			Next nX 
			
			
			//��������������������Ŀ
			//�Atualiza os indices.�
			//����������������������
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Indices")
			cTextoAux += dtoc( Date() )+" "+Time()+" "+"Inicio - Indices" +CHR(13)+CHR(10)
			cTexto += "Analisando arquivos de �ndices. "+CHR(13)+CHR(10)
			GEAtuSIX()
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Indices")
			cTextoAux += dtoc( Date() )+" "+Time()+" "+"Fim - Indices" +CHR(13)+CHR(10)
			
			For nX := 1 To Len(aArqUpd)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx])
				cTextoaux += dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx]+CHR(13)+CHR(10)
				
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
				cTextoAux += dtoc( Date() )+" "+Time()+" "+"Fim Atualizando Estruturas "+aArqUpd[nx] +CHR(13)+CHR(10)
			Next nX

			//Utiliza o Select Area para forcar a criacao das tabelas 
			dbSelectArea("JA9")
			dbSelectArea("JGL")
			dbSelectArea("JGM")

			RpcClearEnv()
			If !( lOpen := MyOpenSm0Ex() )
				Exit 
			EndIf 
		Next nI 
		   
		If lOpen
			cTexto := "Log da atualizacao "+CHR(13)+CHR(10)+cTexto
			__cFileLog := MemoWrite(Criatrab(,.f.)+".LOG",cTexto)
			DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
			DEFINE MSDIALOG oDlg TITLE "Atualizacao concluida." From 3,0 to 340,417 PIXEL
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
���Fun��o    �GEAtuSX3  � Autor �Rafael Rodrigues      � Data � 20/Dez/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SX3 - Campos        ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
����������������������������������������������������������������������������*/
Static Function AtuSX3()
Local aSX3           := {}				//Array com os campos das tabelas
Local aEstrut        := {}              //Array com a estrutura da tabela SX3
Local i              := 0				//Laco para contador
Local j              := 0				//Laco para contador
Local lSX3	         := .F.             //Indica se houve atualizacao
Local cTexto         := ''				//String para msg ao fim do processo
Local cAlias         := ''				//String para utilizacao do noem da tabela
Local cUsadoKey		 := ''				//String que servira para cadastrar um campo como "USADO" em campos chave
Local cReservKey	 := ''				//String que servira para cadastrar um campo como "Reservado" em campos chave
Local cUsadoObr		 := ''				//String que servira para cadastrar um campo como "USADO" em campos obrigatorios
Local cReservObr	 := ''				//String que servira para cadastrar um campo como "Reservado" em campos obrigatorios
Local cUsadoOpc		 := ''				//String que servira para cadastrar um campo como "USADO" em campos opcionais
Local cReservOpc	 := ''				//String que servira para cadastrar um campo como "Reservado" em campos opcionais
Local cUsadoNao		 := ''				//String que servira para cadastrar um campo como "USADO" em campos fora de uso
Local cReservNao	 := ''				//String que servira para cadastrar um campo como "Reservado" em campos fora de uso

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
aAdd(aSX3,{	"JAV",;								//Arquivo
			"20",;								//Ordem
			"JAV_HIFASE",;						//Campo
			"C",;								//Tipo
			5,;									//Tamanho
			0,;									//Decimal
			"Hr.Ini Fase",;				    //Titulo
			"Hr.Ini Fase",;				    //Titulo
			"Hr.Ini Fase",;				    //Titulo
			"Hr.Ini Fase",;				    //Titulo
			"Hr.Ini Fase",;				    //Titulo
			"Hr.Ini Fase",;				    //Titulo
			"@!",;								//Picture
			"",;					//VALID
			cUsadoOpc,;							//USADO
			'" "',;	//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservOpc,;						//RESERV
			"","","","","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"1=Sim;2=N�o","1=Sim;2=N�o","1=Sim;2=N�o",;//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME 
			
/*______________________________________________________________________________________*/
			
aAdd(aSX3,{	"JAV",;								//Arquivo
			"21",;								//Ordem
			"JAV_HFFASE",;						//Campo
			"C",;								//Tipo
			5,;									//Tamanho
			0,;									//Decimal
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"@!",;								//Picture
			"",;					//VALID
			cUsadoOpc,;							//USADO
			'" "',;	//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservOpc,;						//RESERV
			"","","","","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"1=Sim;2=N�o","1=Sim;2=N�o","1=Sim;2=N�o",;//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME			

/*______________________________________________________________________________________*/

aAdd(aSX3,{	"JA9",;								//Arquivo
			"15",;								//Ordem
			"JA9_HRNDE",;						//Campo
			"C",;								//Tipo
			5,;									//Tamanho
			0,;									//Decimal
			"Hr.Ini Fase",;				    //Titulo
			"Hr.ini Fase",;				    //Titulo
			"Hr.ini Fase",;				    //Titulo
			"Hr.ini Fase",;				    //Titulo
			"Hr.ini Fase",;				    //Titulo
			"Hr.ini Fase",;				    //Titulo
			"@!",;								//Picture
			"",;					//VALID
			cUsadoOpc,;							//USADO
			'" "',;	//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservOpc,;						//RESERV
			"","","","","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"1=Sim;2=N�o","1=Sim;2=N�o","1=Sim;2=N�o",;//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME
/*______________________________________________________________________________________*/

aAdd(aSX3,{	"JA9",;								//Arquivo
			"16",;								//Ordem
			"JA9_HRNATE",;						//Campo
			"C",;								//Tipo
			5,;									//Tamanho
			0,;									//Decimal
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"Hr.Fim Fase",;				    //Titulo
			"@!",;								//Picture
			"",;					//VALID
			cUsadoOpc,;							//USADO
			'" "',;	//RELACAO
			"",;								//F3
			1,;									//NIVEL
			cReservOpc,;						//RESERV
			"","","","","",;					//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"","","",;							//CONTEXT, OBRIGAT, VLDUSER
			"1=Sim;2=N�o","1=Sim;2=N�o","1=Sim;2=N�o",;//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})				//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME
/*______________________________________________________________________________________*/									

/******************************************************************************************
Grava informacoes do array no banco de dados
******************************************************************************************/
ProcRegua(Len(aSX3))

SX3->(DbSetOrder(2))	

For i:= 1 To Len(aSX3)
	If !Empty(aSX3[i][1])
		If !dbSeek(aSX3[i,3])
			lSX3	:= .T.
			If !(aSX3[i,1]$cAlias)
				cAlias += aSX3[i,1]+"/"
				aAdd(aArqUpd,aSX3[i,1])
			EndIf
			RecLock("SX3",.T.)
			For j:=1 To Len(aSX3[i])
				If FieldPos(aEstrut[j])>0 .And. aSX3[i,j] != NIL
					FieldPut(FieldPos(aEstrut[j]),aSX3[i,j])
				EndIf
			Next j
			MsUnLock()
			IncProc("Atualizando Dicionario de Dados...")
		Endif
	EndIf
Next i

If lSX3
	cTexto := 'Foram alteradas as estruturas das seguintes tabelas : '+cAlias+CHR(13)+CHR(10)
EndIf

Return cTexto         


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSXB   �Autora � Tatiane Maestrello   � Data � 25/10/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Efetua a manuten��o da tabela SXB                          ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
�������������������������������������������������������������������������Ĵ��
���Analista  � Data/Bops/Ver �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �        �      �                                            ���
���          �        �      �                                            ���
���          �        �      �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function GEAtuSXB()
Local lSXB      := .F.                      //Verifica se houve atualizacao
Local aSXB      := {}						//Array que armazenara os indices
Local aEstrut   := {}				        //Array com a estrutura da tabela SXB
Local i         := 0 						//Contador para laco
Local j         := 0 						//Contador para laco
Local aArea     := {}
//�������������������������Ŀ
//�Define estrutura do array�
//���������������������������
aEstrut:= {"XB_ALIAS", "XB_TIPO", "XB_SEQ", "XB_COLUNA", "XB_DESCRI", "XB_DESCSPA", "XB_DESCENG", "XB_CONTEM", "XB_WCONTEM"}

//���������������������������������������������������Ŀ
//�Define os novos conteudos dos filtros das consultas�
//�����������������������������������������������������
aAdd(aSXB,{	"JA9   ",;    //XB_ALIAS
			"6",;         //XB_TIPO
			"01",;          //XB_SEQ
			"",;	      //XB_COLUNA
			"",;	  	  //XB_DESCRI
			"",;	  	  //XB_DESCSPA
			"",;       	  //XB_DESCENG
			'JA9->JA9_FILIAL+JA9->JA9_CODIGO+JA9->JA9_FASE+DtoS(JA9->JA9_DTNOR)+JA9->JA9_ITEM == @#A070Filloc()',;
			""})	      //XB_WCONTEM                  
			
aAdd(aSXB,{	"JA9","2","01","02",;				// ALIAS, TIPO, SEQ, COLUNA1
			"Codigo P.s. + Codigo",;							// DESCRI
			"Codigo P.s. + Codigo",;							// DESC SPA
			"Codigo P.s. + Codigo",;							// DESC ENG
			"", "" })				// CONTEM, WCONTEM				

dbSelectArea("SXB")
SXB->(dbSetOrder(1)) //XB_ALIAS+XB_TIPO+XB_SEQ+XB_COLUNA	

aArea:= SXB->(GetArea())
For i := 1 To Len(aSXB)   
	If !Empty(aSXB[i,1])
		If !dbSeek(iif(aSXB[i,2] =="2", PadR(aSXB[i,1],6)+aSXB[i,2]+aSXB[i,3], PadR(aSXB[i,1],6)+aSXB[i,2]+aSXB[i,3]+aSXB[i,4] ))
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
	EndIf	
Next i
RestArea(aArea)

Return


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSIX  � Autor �Fernando Amorim       � Data � 29/JAN/08 ���
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

aAdd(aSIX,{"JA9",;   										//Indice
	   		"6",;                 							//Ordem
			"JA9_FILIAL+JA9_CODIGO+JA9_FASE+DTOS(JA9_DTNOR)+JA9_HRNDE+JA9_HRNATE+JA9_CODLOC+JA9_CODPRE+JA9_ANDAR+JA9_CODSAL",;//Chave
			"Proc Sel + Fase + Data Prova + Horario Ini + Horario Fim  + Local + Predio + Andar + Sala",;//Descicao Port.
			"Proc Sel + Fase + Data Prova + Horario Ini + Horario Fim  + Local + Predio + Andar + Sala",;//Descicao Port.
			"Proc Sel + Fase + Data Prova + Horario Ini + Horario Fim  + Local + Predio + Andar + Sala",;//Descicao Port.
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
		Conout("Atualizando �ndices...")
	EndIf
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