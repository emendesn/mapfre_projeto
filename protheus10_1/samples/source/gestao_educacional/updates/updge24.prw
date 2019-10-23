#INCLUDE "Protheus.ch"
/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � UpdGE24  � Autor � Cristiane Tuji       � Data � 15/Fev/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Cria��o de Grupo de Campos SX3 no configurador (SXG) para  ���
���          � atualiza��o em cascata.                                    ���
���          � Grupo de Campos de Descri��o de Processo Seletivo.         ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SigaGE                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function UpdGE24() 

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
Local cFile     := "" 				//Nome do arquivo, caso o usuario deseje salvar o log das operacoes
Local cMask     := "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    := 0               	
Local nI        := 0                //Contador para laco
Local nX        := 0	            //Contador para laco
Local aRecnoSM0 := {}				     
Local lOpen     := .F. 				//Retorna se conseguiu acesso exclusivo a base de dados
Local nModulo := 49 				//SIGAGE - GESTAO EDUCACIONAL


//�����������������������Ŀ
//�Inicia o processamento.�
//�������������������������

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
			
			//���������������������������������������Ŀ
			//�Elimina do SX o que deve ser eliminado.�
			//�����������������������������������������
			ProcRegua(9)
			IncProc("Atualizando Dicionario de Arquivos...")
			GECriaSXG()
			GEAtuSX3()		

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
���Fun��o    �GECriaSXG	 � Autor �Cristiane Tuji        � Data �15/02/2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Cria grupo SXG no Configurador.                            ���
���          � Descri��o do Processo Seletivo.                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

Static Function GECriaSXG()
Local aSXG   := {}							//Array que contem as informacoes das tabelas
Local aEstrut:= {}							//Array que contem a estrutura da tabela SXG
//Local cAlias :=''							//Nome da tabela
Local nCont1 := 0							//Contador para laco                     
Local nCont2 := 0							//Contador para laco                    

aEstrut:= {"XG_GRUPO","XG_DESCRI","XG_SIZEMAX","XG_SIZEMIN","XG_SIZE","XG_PICTURE" }

ProcRegua(Len(aSXG))

dbSelectArea("SXG")
SXG->(DbSetOrder(1))	

//����������������������������������������������������������������������Ŀ
//�Adiciona as informacoes das tabelas num array, para trabalho posterior�
//������������������������������������������������������������������������

aAdd(aSXG,{	"018",; 								//Grupo
			"Descricao do Processo Seletivo",;		//Descricao 
			45,;									//Tamanho Maximo
			30,;									//Tamanho Minimo
			30,;                                    //Tamanho
			"@!"})									//Picture


//������������������������������Ŀ
//�Realiza a inclusao das tabelas�
//��������������������������������

For nCont1:= 1 To Len(aSXG)
	If !Empty(aSXG[nCont1,1])      
 //		If !DbSeek(aSXG[nCont1,1]+aSXG[nCont1,2]) 
 		If !DbSeek(aSXG[nCont1,1])
			RecLock("SXG",.T.) //Adiciona registro
		Else
			RecLock("SXG",.F.)
		EndIf
//		If !(aSXG[nCont1,1]$cAlias)
  //			cAlias += aSXG[nCont1,1]+"/"
	//	EndIf
		
		For nCont2:=1 To Len(aSXG[nCont1])
			If FieldPos(aEstrut[nCont2]) > 0.And. aSXG[nCont1,nCont2] != NIL
				FieldPut(FieldPos(aEstrut[nCont2]),aSXG[nCont1,nCont2])
			EndIf
		Next nCont2
		MsUnLock()
		IncProc("Atualizando Dicionario de Arquivos...")
	EndIf
Next nCont1

Return
/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSX3() � Autor �Cristiane Tuji        � Data �15/02/2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Cria grupo SXG no Configurador.                            ���
���          � Descri��o do Processo Seletivo.                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

Static Function GEAtuSX3()
Local aCampos := {"JA1_DESCPR","JA6_DESC","JA7_DCODIG","JA8_DCODIG","JAA_DESC", "JAC_DCODIG", "JAI_DCODIG","JAV_DPROCE","JB7_DPROSE"}  
Local nCont	  := 0
dbSelectArea("SX3")
SX3->(DbSetOrder(2))

/*�����������������������������������������Ŀ
//�Seleciona os campos que ser�o atualizados�
//�������������������������������������������*/
For nCont := 1 to Len(aCampos)
	If SX3->(dbSeek(aCampos[nCont]))
		RecLock("SX3",.F.)
		SX3->X3_GRPSXG	:= "018"		
		SX3->(msunlock())
	Endif
Next nCont

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