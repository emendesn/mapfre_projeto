#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �UPDGAC04  �Autor  �Cesar A. Bianchi    � Data �  02/21/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Melhoria disponibilizada a partir dos BOPS 00000133244,     ���
���          �00000094183 e 00000125524 referente ao cadastro de autores  ��� 
���          �para qualquer tipo de publicacao cadastrada no sistema      ��� 
���       	 �Realiza a compatibilizacao do dicionario de dados, criando a���
���       	 �tabela JMV (Publicacoes Diversas x Autores				  ���
�������������������������������������������������������������������������͹��
���Uso       � MP811 e MP912                                              ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

User Function UPDGAC04()
Local cMsg := ""         

cArqEmp := "SigaMAT.Emp"
__cInterNet := Nil

Private cMessage
Private aArqUpd	 := {}
Private aREOPEN	 := {}
Private oMainWnd          

Set Dele On

cMsg += "Este programa tem como objetivo ajustar os dicion�rios e base de dados, "
cMsg += "para compatibilizacao com a melhoria de Autores x Publicacoes. "
cMsg += "Esta rotina deve ser processada em modo exclusivo! "
cMsg += "Fa�a um backup dos dicion�rios e base de dados antes do processamento!" 

oMainWnd := MSDIALOG():Create()
oMainWnd:cName := "oMainWnd"
oMainWnd:cCaption := "Atualizacao de Cadastros de Publica��es x Autores"
oMainWnd:nLeft := 0
oMainWnd:nTop := 0
oMainWnd:nWidth := 640
oMainWnd:nHeight := 460
oMainWnd:lShowHint := .F.
oMainWnd:lCentered := .T.
oMainWnd:bInit := {|| if( Aviso( "Atualizador de Base", cMsg, {"Cancelar", "Prosseguir"}, 2 ) == 2 , ( Processa({|lEnd| Gac04Run(@lEnd)} , "Atualizador de Base" ) , oMainWnd:End() ), ( MsgAlert( "Opera�ao cancelada!" ), oMainWnd:End() ) ) }

oMainWnd:Activate()

                                
Return(.T.)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Gac04Run  �Autor  �Cesar A Bianchi     � Data �  02/22/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ajuste dicionarios SX's                                     ���
���          �Executa a Funcao de Ajuste de Dicionarios p/ cada empresa   ���
���		     �presente no sigamat.emp	                                  ���
�������������������������������������������������������������������������͹��
���Uso       � MP811 E MP912                                              ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
����������������������������������������������������������������������������*/

Static Function Gac04Run(lEnd)
Local cTexto    := '' 				//Exibira o log ao final do processo
Local cMask     := "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    := 0
Local lOpen     := .F. 				//Retorna se conseguiu acesso exclusivo a base de dados
Private aRecnoSM0 := {}
Private nI       := 0               //Contador para laco
//Private cLogFile 
//Private cNomeArq := "UPDGAC04"
//Private cExtArq	 := ".##R"

//cLogFile	:= __RelDir + cNomeArq + cExtArq 

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
			nI := 1
			While nI <= Len(aRecnoSM0)
			
				SM0->(dbGoto(aRecnoSM0[nI,1]))
				RpcSetType(2) 
				RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)
				lMsFinalAuto := .F.
	
				cTexto += Replicate("-",128)+CHR(13)+CHR(10)
				cTexto += "Empresa : "+SM0->M0_CODIGO+SM0->M0_NOME+CHR(13)+CHR(10)
	
				ProcRegua( nI)
				IncProc("Empresa : "+SM0->M0_CODIGO+SM0->M0_NOME)			
				
				//Cria os Campos e indices novos
				IncProc( dtoc( Date() )+" "+Time()+" "+"Inicio - Ajustando Dicion�rios")
				Conout( dtoc( Date() )+" "+Time()+" "+"Inicio - Ajustando Dicion�rios")			
				cTexto += "Ajustando Dicion�rios..."+CHR(13)+CHR(10)
				
				//AcaLog( cLogFile, Dtoc( date() )+" "+Time()+' '+cTexto)
				
			   
				UpdGAC04Go()
					
									
				IncProc( dtoc( Date() )+" "+Time()+" "+"Fim - Ajuste de Dicion�rios")						
				Conout( dtoc( Date() )+" "+Time()+" "+"Fim - Ajuste de Dicion�rios")
		    	nI++
		    	cTexto := "Fim - Ajuste de Dicion�rios..."+CHR(13)+CHR(10)
		    	//AcaLog( cLogFile, Dtoc( date() )+" "+Time()+' '+cTexto)
		    EndDo
		    
	endif
endif

MsgAlert('Processamento Finalizado.')
	         
Return()    
   
/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �UpdGac04Go�Autor  �Cesar A Bianchi     � Data �  02/22/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ajuste dicionarios SX's                                     ���
���          �Cria��o da tabela JMV                                       ���
�������������������������������������������������������������������������͹��
���Uso       � MP811 E MP912                                              ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
����������������������������������������������������������������������������*/

Static Function UpdGac04Go()
Local lRet := .T.
Local aEstrut  := {}
Local aGravaSX := {}
Local i	:= 1 
Local j := 1
Local cReservOpc := '�A'
Local cUsadoOpc  := '���������������'
Local cObrigat   := '�'

dbSelectArea('SX3')
SX3->(dbSetOrder(2))
SX3->(dbSeek('JMR_ITEM')) 

//Verifica se Possui a UPDGAC02 aplicada (Melhoria de Autores x Publicacoes Sequenciais)
If SX3->(Found())         
	
	
	//�����������������Ŀ
	//�Cria a tabela JMV�
	//�������������������
	dbSelectArea('SX2')
	SX2->(dbSetOrder(1))
	if SX2->(!dbSeek('JMV'))
		RecLock('SX2',.T.) 
		SX2->X2_CHAVE   := 'JMV'
		SX2->X2_ARQUIVO := 'JMV'+alltrim(aRecnoSM0[nI,2]+'0')
		SX2->X2_NOME := 'PUBLIC. X AUTORES'         
		SX2->X2_NOMESPA := 'Public. X Autores'
		SX2->X2_NOMEENG := 'PUBLIC. X AUTHORS'
		SX2->X2_MODO    := 'C'
		SX2->X2_DELET   :=  0
		SX2->(msUnlock())
		//AcaLog( cLogFile, Dtoc( date() )+" "+Time()+' Tabela JMV'+alltrim(aRecnoSM0[nI,2])+' gravada com sucesso em SX2'+alltrim(aRecnoSM0[nI,2]))
		conout(Dtoc( date() )+" "+Time()+' Tabela JMV gravada com sucesso em SX2'+alltrim(aRecnoSM0[nI,2])+'0')
	endif
	
	
	
	//����������������������������Ŀ
	//�Cria os campos da tablea JMV�
	//������������������������������
	dbSelectArea('SX3')
	SX3->(dbSetOrder(2))
	if SX3->(!dbSeek('JMV_FILIAL'))
		//Adiciona os novos campos em um vetor e o utiliza o vetor aEstrut como base no RecLock
		aEstrut:= { "X3_ARQUIVO","X3_ORDEM"  ,"X3_CAMPO"  ,"X3_TIPO"   ,"X3_TAMANHO","X3_DECIMAL","X3_TITULO" ,"X3_TITSPA" ,"X3_TITENG" ,;
					"X3_DESCRIC","X3_DESCSPA","X3_DESCENG","X3_PICTURE","X3_VALID"  ,"X3_USADO"  ,"X3_RELACAO","X3_F3"     ,"X3_NIVEL"  ,;
					"X3_RESERV" ,"X3_CHECK"  ,"X3_TRIGGER","X3_PROPRI" ,"X3_BROWSE" ,"X3_VISUAL" ,"X3_CONTEXT","X3_OBRIGAT","X3_VLDUSER",;
					"X3_CBOX"   ,"X3_CBOXSPA","X3_CBOXENG","X3_PICTVAR","X3_WHEN"   ,"X3_INIBRW" ,"X3_GRPSXG" ,"X3_FOLDER", "X3_PYME"}
		
		aAdd(aGravaSX,{ 'JMV','01','JMV_FILIAL',;    	                                        //Arquivo,  //Ordem,         //Campo,
			   			'C',2,0,;					   				                            //Tipo,     //Tamanho,       //Decimal																    							
			   			'Filial','Sucursal','Branch',;				                            //Titulo,   //Titulo SPA,    //Titulo ENG		    		
			   			'Filial do Sistema','Sucursal','Branch of yhe system',;					//Descricao	//Descricao SPA  //Descricao ENG				
			   			'@!','','���������������',;							        			//Picture   //VALID          //USADO				
						'','',1,;							   									//RELACAO	//F3   			 //NIVEL							
			   			cReservOpc,'','','','N','A',;						                    //RESERV    //CHECK,         //TRIGGER,     //PROPRI,  //BROWSE, //VISUAL			
			   			'R','','',;						                                    	//CONTEXT,  //OBRIGAT,       //VLDUSER
						'','','',			;													//CBOX,     //CBOX SPA,      //CBOX ENG
			   			'','','','','',''})														//PICTVAR,  //WHEN, 		 //INIBRW, 		//SXG, 	   //FOLDER, //PYME 	                    
		
		
		aAdd(aGravaSX,{ 'JMV','02','JMV_ITEM',;    	                            				//Arquivo,  //Ordem,         //Campo,
			   			'C',3,0,;					   				                            //Tipo,     //Tamanho,       //Decimal																    							
			   			'Seq.','Seq.','Seq.',;						                            //Titulo,   //Titulo SPA,    //Titulo ENG		    		
			   			'Seq.','Seq.','Seq.',;													//Descricao	//Descricao SPA  //Descricao ENG				
			   			'999','',cUsadoOpc,;							           				//Picture   //VALID          //USADO				
						'','',1,;								   								//RELACAO	//F3   			 //NIVEL							
			   			cReservOpc,'','','','S','A',;						                    //RESERV    //CHECK,         //TRIGGER,     //PROPRI,  //BROWSE, //VISUAL			
			   			'R',cObrigat,'',;				                                    	//CONTEXT,  //OBRIGAT,       //VLDUSER
						'','','',			;													//CBOX,     //CBOX SPA,      //CBOX ENG
			   			'','','','','',''})														//PICTVAR,  //WHEN, 		 //INIBRW, 		//SXG, 	   //FOLDER, //PYME 	                    
		
		
		aAdd(aGravaSX,{ 'JMV','03','JMV_PUBLIC',;    	                           				//Arquivo,  //Ordem,         //Campo,
			   			'C',10,0,;					   				                            //Tipo,     //Tamanho,       //Decimal																    							
			   			'Cod Publica','Cod Publica','Cod Publica',;	                            //Titulo,   //Titulo SPA,    //Titulo ENG		    		
			   			'Cod Publicacao','Cod Publicacao','Cod Publicacao',;					//Descricao	//Descricao SPA  //Descricao ENG				
			   			'@!','',cUsadoOpc,;			   											//Picture   //VALID     	 //USADO				
						'M->JM0_PUBLIC','',1,;								   					//RELACAO	//F3   			 //NIVEL							
			   			cReservOpc,'','','','S','A',;						                    //RESERV    //CHECK,         //TRIGGER,     //PROPRI,  //BROWSE, //VISUAL			
			   			'R',cObrigat,'',;				                                    	//CONTEXT,  //OBRIGAT,       //VLDUSER
						'','','',			;													//CBOX,     //CBOX SPA,      //CBOX ENG
			   			'','','','','',''})														//PICTVAR,  //WHEN, 		 //INIBRW, 		//SXG, 	   //FOLDER, //PYME 	                    
		
		aAdd(aGravaSX,{ 'JMV','04','JMV_AUTOR',;    	                            			//Arquivo,  //Ordem,         //Campo,
			   			'C',6,0,;					   				                            //Tipo,     //Tamanho,       //Decimal																    							
			   			'Cod Autor','Cod Autor','Cod Autor',;	 	                            //Titulo,   //Titulo SPA,    //Titulo ENG		    		
			   			'Codigo do Autor','Codigo do Autor','Codigo do Autor',;					//Descricao	//Descricao SPA  //Descricao ENG				
			   			'@!','GEExistCpo("JMF",M->JMV_AUTOR) .AND. GACA010_21()',cUsadoOpc,;    //Picture   //VALID          //USADO				
						'','JMF001',1,;							   								//RELACAO	//F3   			 //NIVEL							
			   			cReservOpc,'','','','S','A',;						                    //RESERV    //CHECK,         //TRIGGER,     //PROPRI,  //BROWSE, //VISUAL			
			   			'R',cObrigat,'',;				                                    	//CONTEXT,  //OBRIGAT,       //VLDUSER
						'','','',			;													//CBOX,     //CBOX SPA,      //CBOX ENG
			   			'','','','','',''})														//PICTVAR,  //WHEN, 		 //INIBRW, 		//SXG, 	   //FOLDER, //PYME 	                    
		
		
		aAdd(aGravaSX,{ 'JMV','05','JMV_AUTNOM',;    	                            			//Arquivo,  //Ordem,         //Campo,
			   			'C',40,0,;					   				                            //Tipo,     //Tamanho,       //Decimal																    							
			   			'Nome Autor','Nome Autor','Nome Autor',;	                            //Titulo,   //Titulo SPA,    //Titulo ENG		    		
			   			'Nome do Autor','Nome do Autor','Nome do Autor',;	   					//Descricao	//Descricao SPA  //Descricao ENG				
			   			'@!','',cUsadoOpc,;							           					//Picture   //VALID          //USADO				
						'IF(!INCLUI .AND. ISMEMVAR("JMV_AUTOR"), POSICIONE("JMF",1,XFILIAL("JMF")+M->JMV_AUTOR,"JMF->JMF_NOME"), "")','',1,;							   					     			//RELACAO	//F3   			 //NIVEL							
			   			cReservOpc,'','','','S','V',;						                    //RESERV    //CHECK,         //TRIGGER,     //PROPRI,  //BROWSE, //VISUAL			
			   			'V','','',;						                                    	//CONTEXT,  //OBRIGAT,       //VLDUSER
						'','','',			;													//CBOX,     //CBOX SPA,      //CBOX ENG
			   			'','','Posicione("JMF",1,xFilial("JMF")+JMV->JMV_AUTOR,"JMF->JMF_NOME")','','',''})														//PICTVAR,  //WHEN, 		 //INIBRW, 		//SXG, 	   //FOLDER, //PYME 	                    
		
		
		aAdd(aGravaSX,{ 'JMV','06','JMV_TIPO',;    	                            				//Arquivo,  //Ordem,         //Campo,
			   			'C',1,0,;					   				                            //Tipo,     //Tamanho,       //Decimal																    							
			   			'Tipo Autor','Tipo Autor','Tipo Autor',;	                            //Titulo,   //Titulo SPA,    //Titulo ENG		    		
			   			'Tipo do Autor','Tipo do Autor','Tipo do Autor',;						//Descricao	//Descricao SPA  //Descricao ENG				
			   			'@!','',cUsadoOpc,;							        					//Picture   //VALID          //USADO				
						'','',1,;							   						 			//RELACAO	//F3   			 //NIVEL							
			   			cReservOpc,'','','','S','A',;						                    //RESERV    //CHECK,         //TRIGGER,     //PROPRI,  //BROWSE, //VISUAL			
			   			"R",'','',;						                                    	//CONTEXT,  //OBRIGAT,       //VLDUSER
						'1=Escritor;2=Descritor;3=Ilustrador;4=Tradutor','1=Escritor;2=Descritor;3=Ilustrador;4=Tradutor','1=Escritor;2=Descritor;3=Ilustrador;4=Tradutor',;				//CBOX,     //CBOX SPA,      //CBOX ENG
			   			'','','','','',''})										     			//PICTVAR,  //WHEN, 		 //INIBRW, 		//SXG, 	   //FOLDER, //PYME 	                    
	                                                                                
		//Grava tudo do vetor aGravaSx no SX3
		For i:= 1 to len(aGravaSX)	
			RecLock("SX3",.T.)
			For j:=1 To Len(aGravaSX[i])
				If FieldPos(aEstrut[j])>0 .And. aGravaSX[i,j] != NIL
					FieldPut(FieldPos(aEstrut[j]),aGravaSX[i,j])
				EndIf
			Next j
			SX3->(MsUnLock())
		Next i
		//AcaLog( cLogFile, Dtoc( date() )+" "+Time()+' Tabela JMV'+alltrim(aRecnoSM0[nI,2])+' gravada com sucesso em SX3'+alltrim(aRecnoSM0[nI,2]))		
		conout(Dtoc( date() )+" "+Time()+' Tabela JMV gravada com sucesso em SX3'+alltrim(aRecnoSM0[nI,2])+'0')
	endif
	    
	
	
	//������������������������������Ŀ
	//�Cria os indices da tabela JMV �
	//�������������������������������� 
	dbSelectArea('SIX')
	SIX->(dbSetOrder(1))
	if SIX->(!dbSeek('JMV'))
		aGravaSx := {}
		                        
		//Adiciona os novos campos em um vetor e o utiliza o vetor aEstrut como base no RecLock
		aEstrut    := {"INDICE","ORDEM","CHAVE","DESCRICAO","DESCSPA","DESCENG","PROPRI","F3","NICKNAME","SHOWPESQ"}
		aAdd(aGravaSx,{"JMV","1","JMV_FILIAL+JMV_PUBLIC+JMV_ITEM","Cod Publica+Seq.","Cod Publica+Seq.","Cod Publica+Seq.",'S',"","","S"})
		aAdd(aGravaSx,{"JMV","2","JMV_FILIAL+JMV_PUBLIC+JMV_AUTOR+JMV_ITEM","Cod Publica+Cod Autor+Seq.","Cod Publica+Cod Autor+Seq.","Cod Publica+Cod Autor+Seq.",'S',"","","S"})		
		//Grava tudo do vetor aGravaSx no SIX
		For i:=1 to Len(aGravaSx)
			RecLock('SIX',.T.)	
			For j:=1 To Len(aGravaSx[i])
				If FieldPos(aEstrut[j])>0
					FieldPut(FieldPos(aEstrut[j]),aGravaSx[i,j])
				EndIf
			Next j
			MsUnLock()
		Next i
		//AcaLog( cLogFile, Dtoc( date() )+" "+Time()+' Tabela JMV'+alltrim(aRecnoSM0[nI,2])+' gravada com sucesso em SIX'+alltrim(aRecnoSM0[nI,2]))
		conout(Dtoc( date() )+" "+Time()+' Tabela JMV gravada com sucesso em SIX'+alltrim(aRecnoSM0[nI,2])+'0')
	endif     
	
	
	
	
	//�������������������������Ŀ
	//�Atualiza o banco de dados�
	//���������������������������
	X31UpdTable('JMV')
	TcRefresh("JMV")
	dbSelectArea('JMV')
	JMV->(dbSetOrder(1))
	JMV->(dbSetOrder(2))
	JMV->(dbCloseArea())      
	
	
else	
	msgAlert('Imposs�vel continuar com a atualizacao na empresa '+aRecnoSM0[nI,2]+' O Sistema n�o possui a update 02 aplicada. Execute a atualizacao updgac02 antes de implementar esta atualiza��o')
	lRet := .F.
	
endif

Return(lRet)
                 

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

Return(lOpen)
