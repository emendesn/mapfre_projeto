#INCLUDE "Protheus.ch" 
#include "tbiconn.ch"   

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �UpdGE29    �Autor  � Renato Ceadareanu    � Data � 24/07/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualizacao do dicionario de dados                   	  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGE                                                     ���
�������������������������������������������������������������������������Ĵ��
���Analista  � Data/Bops/Ver �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �        �      �                                            ���
���          �        �      �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function UpdGE29()
Local cMsg := ""

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

Private cMessage
Private aArqUpd	 := {}
Private aREOPEN	 := {}
Private oMainWnd      

Set Dele On

cMsg += "Este programa tem como objetivo ajustar os dicion�rios e base de dados "
cMsg += "para a implementa��o da melhoria ... "
cMsg += "Esta rotina deve ser processada em modo exclusivo! "
cMsg += "Fa�a um backup dos dicion�rios e base de dados antes do processamento!"

oMainWnd := MSDIALOG():Create()
oMainWnd:cName := "oMainWnd"
oMainWnd:cCaption := "Implementando ..."
oMainWnd:nLeft := 0
oMainWnd:nTop := 0
oMainWnd:nWidth := 640
oMainWnd:nHeight := 490
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
Conout("Verificando integridade dos dicion�rios....")
          
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
  			//��������������������Ŀ
			//�Atualiza os indices.�
			//����������������������
			SM0->(dbGoto(aRecnoSM0[nI,1]))
			RpcSetType(2) 
			RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)			
			
			IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Indices")
			Conout( dtoc( Date() )+" "+Time()+" "+"Inicio - Indices")
			cTexto += "Analisando arquivos de �ndices. "+CHR(13)+CHR(10)
			GEAtuSIX()
			cTexto += "Atualizando �ndices. "+CHR(13)+CHR(10)
			IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Indices")
			Conout( dtoc( Date() )+" "+Time()+" "+"Fim - Indices")

			__SetX31Mode(.F.)
			For nX := 1 To Len(aArqUpd)
				IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx])
				Conout( dtoc( Date() )+" "+Time()+" "+"Inicio Atualizando Estruturas "+aArqUpd[nx])
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
				Conout( dtoc( Date() )+" "+Time()+" "+"Fim Atualizando Estruturas "+aArqUpd[nx])
				
			Next nX 
		next nI     
		
		If lOpen

			IncProc( dtoc( Date() )+" "+Time()+" "+"Atualiza��o Conclu�da." )
			Conout( dtoc( Date() )+" "+Time()+" "+"Atualiza��o Conclu�da." )
				
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
	endif 
endif
return nil

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �GEAtuSIX  � Autor �Renato Ceadareanu     � Data � 24/Jul/07 ���
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
              
// Altera��o executada no UPDGE12         
aAdd(aSIX,{"JCH",;   										//Indice
		"1",;                 								//Ordem
		"JCH_FILIAL+JCH_NUMRA+JCH_CODCUR+JCH_PERLET+JCH_HABILI+JCH_TURMA+DTOS(JCH_DATA)+JCH_ITEM+JCH_DISCIP+JCH_CODAVA+JCH_MATPRF",;//Chave
		"RA + Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Aula + Cod. Discip. + Cod. Avaliacao + Cod. Professor",;//Descicao Port.
		"RA + Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Aula + Cod. Discip. + Cod. Avaliacao + Cod. Professor",;//Descicao Port.
		"RA + Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Aula + Cod. Discip. + Cod. Avaliacao + Cod. Professor",;//Descicao Port.
		"S",; 												//Proprietario
		"",;  												//F3
		"",;  												//NickName
		"S"}) 

aAdd(aSIX,{"JCH",;   										//Indice
		"3",;                 								//Ordem
		"JCH_FILIAL+JCH_CODCUR+JCH_PERLET+JCH_HABILI+JCH_TURMA+DTOS(JCH_DATA)+JCH_ITEM+JCH_DISCIP+JCH_CODAVA+JCH_MATPRF+JCH_NUMRA",;//Chave
		"Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Aula + Cod. Discip. + Cod. Avaliacao + Cod. Professor + RA",;//Descicao Port.
		"Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Aula + Cod. Discip. + Cod. Avaliacao + Cod. Professor + RA",;//Descicao Port.
		"Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Aula + Cod. Discip. + Cod. Avaliacao + Cod. Professor + RA",;//Descicao Port.
		"S",; 												//Proprietario
		"",;  												//F3
		"",;  												//NickName
		"S"}) 		             
             
aAdd(aSIX,{"JCH",;   										//Indice
		"4",;                 								//Ordem
		"JCH_FILIAL+JCH_NUMRA+JCH_CODCUR+JCH_PERLET+JCH_HABILI+JCH_TURMA+DTOS(JCH_DATA)+JCH_DISCIP+JCH_MATPRF+JCH_HORA1",;//Chave
		"RA+Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Cod. Discip. + Cod. Professor + Hora 1",;//Descicao Port.
		"RA+Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Cod. Discip. + Cod. Professor + Hora 1",;//Descicao Port.
		"RA+Cod.Curso + Per. Letivo + Habilitacao + Turma + Data + Cod. Discip. + Cod. Professor + Hora 1",;//Descicao Port.
		"S",; 												//Proprietario
		"",;  												//F3
		"",;  												//NickName
		"S"}) 	

aAdd(aSIX,{"JCH",;   										//Indice
		"5",;                 								//Ordem
		"JCH_FILIAL+JCH_CODCUR+JCH_PERLET+JCH_HABILI+JCH_TURMA+JCH_DISCIP",;//Chave
		"Cod.Curso + Per. Letivo + Habilitacao + Turma + Cod. Discip.",;//Descicao Port.
		"Cod.Curso + Per. Letivo + Habilitacao + Turma + Cod. Discip.",;//Descicao Port.
		"Cod.Curso + Per. Letivo + Habilitacao + Turma + Cod. Discip.",;//Descicao Port.
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
	dbUseArea( .T.,, "sigamat.emp", "SM0", .F., .F. ) 	
	If !Empty( Select( "SM0" ) ) 
		lOpen := .T. 
		dbSetIndex("sigamat.ind") 
		Exit	
	EndIf
	Sleep( 500 ) 
Next nLoop

If !lOpen
	Aviso( "Atencao !", "Nao foi possivel a abertura da tabela de empresas de forma exclusiva !", { "Ok" }, 2 ) 
EndIf

Return( lOpen )	
