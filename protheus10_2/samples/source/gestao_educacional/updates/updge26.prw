#INCLUDE "Protheus.ch"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � UpdGE26  � Autor � karen Honda          � Data � 02/Abr/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualizacao do dicionario de dados para alterar o filtro   ���
��� da consulta padr�o utilizada no req. Transferencia curso Vet.
��� Campo curso destino, para exibir todas as vers�es do curso
�������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SigaGE                                                     ���
�������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function UpdGE26() 

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

PRIVATE cMessage

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
			
			//��������������������Ŀ
			//�Atualiza Consultas  �
			//����������������������
			IncProc("Analisando consultas padroes...") 
			cTexto += GEAtuSxB( SM0->M0_CODIGO )

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
���Fun��o    �GEAtuSXB  �Autora �Karen Honda            � Data �01/Mar/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao para atualiza��o das consultas padroes do sistema   ���
���          � para quando o cliente for utilizar visibilidade            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao GE                                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function GEAtuSXB(cCodFilial)
Local cTexto    := ''						//String para msg ao fim do processo
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

//ALTERA CONSULTA PADRAO
aAdd(aSXB,{	"J13","6","01","",;					// ALIAS, TIPO, SEQ, COLUNA
			"",;									// DESCRI
			"",;									// DESC SPA
			"",;									// DESC ENG
			"", ""})					// CONTEM, WCONTEM


//���������������������������������������������������Ŀ
//�Processa consultas para alteracao                  �
//�����������������������������������������������������
ProcRegua(Len(aSXB))

dbSelectArea("SXB")
SXB->(dbSetOrder(1)) //XB_ALIAS+XB_TIPO+XB_SEQ	
For i := 1 To Len(aSXB)
	If !dbSeek(Padr(aSXB[i,1],6)+aSXB[i,2]+aSXB[i,3]+aSXB[i,4])
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
	cTexto  += (aSXB[i][1]+Chr(13)+Chr(10))
	IncProc("Atualizando consulta padrao...")
Next i

If lSXB
	cTexto += "Consulta atualizada com sucesso"
EndIf

Return(cTexto)

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
