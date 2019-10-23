#INCLUDE "Protheus.ch"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � UpdGE27  � Autor � karen Honda          � Data � 09/Abr/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualizacao do dicionario de dados para ajustar os campos   ��
��� memos JCT_MEMO1/JCT_JUSTIF/JCO_MEMO1/JCT_JUSTIF pois est�o sendo criados ��
��� com tipos e tamanhos incorretos 									   ��
�������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SigaGE                                                     ���
�������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function UpdGE27() 

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

PRIVATE cMessage
Private aArqUpd	 := {}
PRIVATE oMainWnd        
Private cArqJCT := CriaTrab(,.F.)           
Private cArqJCO := CriaTrab(,.F.)
Private lBkpJCO := .F.
Private lBkpJCT := .T.
Set Dele On

lHistorico 	:= MsgYesNo("Deseja efetuar a atualizacao do dicion�rio nas tabelas JCT e JCO? Esta rotina deve ser utilizada em modo exclusivo! Faca um backup dos dicion�rios e da base de dados antes da atualiza��o para eventuais falhas de atualiza��o!", "Aten��o")

If lHistorico
	Processa({|lEnd| GEProc(@lEnd)},"Processando","Aguarde, preparando os arquivos",.F.)
	Final("Atualiza��o efetuada!")
endif
	
Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEProc    � Autor �karen honda           � Data � 02/Abr/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao dos arquivos           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEProc(lEnd)
Local cTexto    := '' 				//Exibira o log ao final do processo
Local cFile     :="" //Nome do arquivo, caso o usuario deseje salvar o log das operacoes
Local cMask     := "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    := 0
Local nI        := 0                //Contador para laco
Local nX        := 0	            //Contador para laco
Local aRecnoSM0 := {}				     
Local lOpen     := .F. 				//Retorna se conseguiu acesso exclusivo a base de dados
Private nModulo := 49 				//SIGAGE - GESTAO EDUCACIONAL

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
			
			//�������������������������������Ŀ
			//�Atualiza o dicionario de dados.�
			//���������������������������������
			IncProc( "Analisando Dicionario de Dados...")
			cTexto += GEAtuSX3()      
			cTexto += CHR(13)+CHR(10)
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Dicionario de Dados")
                                             
			If JCO->( FieldPos( "JCO_MEMO1" ) ) > 0 .and. JCT->( FieldPos( "JCT_MEMO1" ) ) > 0
				//�������������������������������Ŀ
				//�Realiza o backup da tabela     �
				//���������������������������������
				IncProc( "Realizando backup da tabela JCT...")
				cTexto += GEArqJCT()
				cTexto += CHR(13)+CHR(10)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Backup JCT")

				IncProc( "Realizando backup da tabela JCO...")
				cTexto += GEArqJCO()     
				cTexto += CHR(13)+CHR(10)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Backup JCT")
            
			EndIF
			
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
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Abrindo tabelas")
			dbSelectArea("JCO")
			dbSelectArea("JCT")

			If JCO->( FieldPos( "JCO_MEMO1" ) ) > 0 .and. JCT->( FieldPos( "JCT_MEMO1" ) ) > 0
				//�������������������������������Ŀ
				//�Realiza o backup da tabela     �
				//���������������������������������
				IncProc( "Atualizando tabela JCT...")
				cTexto += GEAtuJCT()     
				cTexto += CHR(13)+CHR(10)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Backup JCT")

				IncProc( "Atualizando tabela JCO...")
				cTexto += GEAtuJCO()     
				cTexto += CHR(13)+CHR(10)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Backup JCO")
				
				iif(Select(cArqJCT)>0,(cArqJCT)->(dbCloseArea()),Nil)
				iif(Select(cArqJCO)>0,(cArqJCO)->(dbCloseArea()),NIl)	
            EndIf

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
���Fun��o    �GEAtuSX3  � Autor �Karen Honda           � Data � 09/Abr/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao do SX3 - Campos       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSX3()

Local aSX3   := {}					//Array que contera os dados dos gatilhos
Local aEstrut:= {}					//Array que contem a estrutura da tabela SX6
Local i      := 0					//Contador para laco
Local j      := 0					//Contador para laco
Local lSX6   := .F.                    
Local cTexto := ""
Local cUsadoNao		:= ''				//String que servira para cadastrar um campo como "USADO" em campos fora de uso
Local cReservNao	:= ''				//String que servira para cadastrar um campo como "Reservado" em campos fora de uso
Local cUsadoOpc		:= ''				//String que servira para cadastrar um campo como "USADO" em campos opcionais
Local cReservOpc	:= ''				//String que servira para cadastrar um campo como "Reservado" em campos opcionais
Local cAlias		:= ''

aEstrut:= { "X3_ARQUIVO","X3_ORDEM"  ,"X3_CAMPO"  ,"X3_TIPO"   ,"X3_TAMANHO","X3_DECIMAL","X3_TITULO" ,"X3_TITSPA" ,"X3_TITENG" ,;
"X3_DESCRIC","X3_DESCSPA","X3_DESCENG","X3_PICTURE","X3_VALID"  ,"X3_USADO"  ,"X3_RELACAO","X3_F3"     ,"X3_NIVEL"  ,;
"X3_RESERV" ,"X3_CHECK"  ,"X3_TRIGGER","X3_PROPRI" ,"X3_BROWSE" ,"X3_VISUAL" ,"X3_CONTEXT","X3_OBRIGAT","X3_VLDUSER",;
"X3_CBOX"   ,"X3_CBOXSPA","X3_CBOXENG","X3_PICTVAR","X3_WHEN"   ,"X3_INIBRW" ,"X3_GRPSXG" ,"X3_FOLDER", "X3_PYME"}

dbSelectArea("SX3")
SX3->(DbSetOrder(2))

/*******************************************************************************************
Seleciona as informacoes de alguns campos para uso posterior
*******************************************/
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
aAdd(aSX3,{	"JCT",;							//Arquivo
			"19",;							//Ordem
			"JCT_MEMO1",;					//Campo
			"C",;							//Tipo
			6,;								//Tamanho
			0,;								//Decimal
			"Justificativ",;				//Titulo
			"Justificac.",;					//Titulo SPA
			"Justificat.",;					//Titulo ENG
			"Justificativa de dispensa",;	//Descricao
			"Justificacion de dispensa",;	//Descricao SPA
			"Discharge justification",;		//Descricao ENG
			"",;							//Picture
			"",;							//VALID
			cUsadoNao,;						//USADO
			"",;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReservNao,;					//RESERV
			"","","","N","V",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"R"," ","",;					//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"} )			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME
			
aAdd(aSX3,{	"JCT",;							//Arquivo
			"20",;							//Ordem
			"JCT_JUSTIF",;					//Campo
			"M",;							//Tipo
			80,;							//Tamanho
			0,;								//Decimal
			"Justificativ",;				//Titulo
			"Justificativ",;				//Titulo SPA
			"Justificativ",;		    	//Titulo ENG
			"Justificativa de Dispensa",;	//Descricao
			"Justificativa de Dispensa",;	//Descricao SPA
			"Justificativa de Dispensa",;	//Descricao ENG
			"",;							//Picture
			"",;					 		//VALID
			cUsadoOpc,;						//USADO
			"",;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReservOpc,;					//RESERV
			"","","","N","A",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"V"," ","",;					//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME


aAdd(aSX3,{	"JCO",;							//Arquivo
			"14",;							//Ordem
			"JCO_MEMO1",;					//Campo
			"C",;							//Tipo
			6,;								//Tamanho
			0,;								//Decimal
			"Justificativ",;				//Titulo
			"Justificac.",;					//Titulo SPA
			"Justificat.",;					//Titulo ENG
			"Justificativa de dispensa",;	//Descricao
			"Justificacion de dispensa",;	//Descricao SPA
			"Discharge justification",;		//Descricao ENG
			"",;							//Picture
			"",;							//VALID
			cUsadoNao,;						//USADO
			"",;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReservNao,;					//RESERV
			"","","","N","V",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"R"," ","",;					//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"} )			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME
			
aAdd(aSX3,{	"JCO",;							//Arquivo
			"15",;							//Ordem
			"JCO_JUSTIF",;					//Campo
			"M",;							//Tipo
			80,;							//Tamanho
			0,;								//Decimal
			"Justificativ",;				//Titulo
			"Justificativ",;				//Titulo SPA
			"Justificativ",;		    	//Titulo ENG
			"Justificativa de Dispensa",;	//Descricao
			"Justificativa de Dispensa",;	//Descricao SPA
			"Justificativa de Dispensa",;	//Descricao ENG
			"",;							//Picture
			"",;					 		//VALID
			cUsadoOpc,;						//USADO
			"",;							//RELACAO
			"",;							//F3
			1,;								//NIVEL
			cReservOpc,;					//RESERV
			"","","","N","A",;				//CHECK, TRIGGER, PROPRI, BROWSE, VISUAL
			"V"," ","",;					//CONTEXT, OBRIGAT, VLDUSER
			"","","",;						//CBOX, CBOX SPA, CBOX ENG
			"","","","","","S"})			//PICTVAR, WHEN, INIBRW, SXG, FOLDER, PYME



/*********************************************************************************************
Realiza a gravacao das informacoes do array na tabela SX3
*********************************************************************************************/
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
		cTexto  += (aSX3[i][3]+Chr(13)+Chr(10))
		IncProc("Atualizando Dicionario de Dados...")
		
	EndIf
Next i

If lSX6
	cTexto += "Consulta atualizada com sucesso"
EndIf

Return(cTexto)
                                                                                      
/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEArqJCT   � Autor �karen honda           � Data �13/04/2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Efetua o backup dos dados da tabela JCT, pois ir� alterar o 
��� tipo de campo.
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao FIS                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

Static Function GEArqJCT()
Local aArea  := getArea()
Local lChar  := .F.
Local cQuery := ''    
Local cRet   := ''

dbSelectArea('JCT')
lChar := iif(ValType(JCT->JCT_MEMO1) == 'C',.T.,.F. )                                                                                    

if lChar 
	cQuery := "SELECT R_E_C_N_O_ REC, JCT_MEMO1 "
	cQuery += " FROM "+RetSQLName("JCT")+" JCT "                 
	cQuery += " WHERE JCT.JCT_MEMO1 <> ' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TopConn", TCGenQry(,,cQuery), cArqJCT, .F., .F. )
	TCSetField( cArqJCT, "REC", "N", 10, 0 ) 
	cRet := "Backup tabela JCT"
	lBkpJCT := .T.
else
	cRet := "Nao foi necessario o backup dos itens em JCT_MEMO1, pois este esta nulo."
	lBkpJCT := .F.
endif

RestArea(aArea)
Return (cRet)


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEArqJCO   � Autor �karen honda           � Data �13/04/2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Efetua o backup dos dados da tabela JCO, pois ir� alterar o 
��� tipo de campo.
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao FIS                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

Static Function GEArqJCO()  
Local aArea  := getArea()
Local lChar  := .F.
Local cQuery := ''    
Local cRet   := ''
                      
dbSelectArea('JCO')                             
lChar := iif(ValType(JCO->JCO_MEMO1) == 'C',.T.,.F. ) 
                 
if lChar
	cQuery := "SELECT R_E_C_N_O_ REC, JCO_MEMO1 "
	cQuery += " FROM "+RetSQLName("JCO")+" JCO "
	cQuery += " WHERE JCO_MEMO1 <> '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TopConn", TCGenQry(,,cQuery), cArqJCO, .F., .F. )
	TCSetField( cArqJCO, "REC", "N", 10, 0 ) 
	cRet := "Backup tabela JCO"  
	lBkpJCO := .T.
else
	cRet := "Nao foi necessario o backup dos itens em JCO_MEMO1, pois este esta nulo."
	lBkpJCO := .F.
endif

RestArea(aArea)
Return (cRet)


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuJCO   � Autor �karen honda           � Data �13/04/2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualiza a tabela JCO com o backup dos dados para n�o perder
��� a referencia do campo memo
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao FIS                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

Static Function GEAtuJCO()                

if lBkpJCO
	While (cArqJCO)->( !Eof() )
		JCO->(DbGoTo( (cArqJCO)->REC ) )
		JCO->( RecLock( "JCO", .F. ) )
		JCO->JCO_MEMO1 := (cArqJCO)->JCO_MEMO1
		JCO->( msUnlock() )
		(cArqJCO)->( DbSkip() )
	EndDo
endif
	       
Return ("Atualizado tabela JCO")

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuJCT   � Autor �karen honda           � Data �13/04/2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualiza a tabela JCT com o backup dos dados para n�o perder
��� a referencia do campo memo
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao FIS                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

Static Function GEAtuJCT() 

if lBkpJCT
	While (cArqJCT)->( !Eof() )
		JCT->(DbGoTo( (cArqJCT)->REC ) )
		JCT->( RecLock( "JCT", .F. ) )
		JCT->JCT_MEMO1 := (cArqJCT)->JCT_MEMO1
		JCT->( msUnlock() )
		(cArqJCT)->( DbSkip() )
	EndDo
endif
	       
Return ("Atualizado tabela JCT")

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
