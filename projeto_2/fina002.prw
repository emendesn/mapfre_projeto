#INCLUDE "PROTHEUS.CH"

//
// Liberar cheques para reimpress�o
//

User Function FINA002()
Local cEdit1	 := Space(06)
Local oEdit1

// Variaveis Private da Funcao
Private _oDlg				// Dialog Principal
// Variaveis que definem a Acao do Formulario
Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.                        

DEFINE MSDIALOG _oDlg TITLE "Reimpress�o de Cheque" FROM C(364),C(486) TO C(527),C(787) PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(013),C(090) MsGet oEdit1 Var cEdit1 Size C(043),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(015),C(013) Say "Informe o N�mero do Cheque:" Size C(073),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(065),C(062) Button "Confirma" Size C(037),C(012) PIXEL OF _oDlg ACTION OkProc(cEdit1)
	@ C(065),C(105) Button "Fechar" Size C(037),C(012) PIXEL OF _oDlg   ACTION _oDlg:End()

ACTIVATE MSDIALOG _oDlg CENTERED 

Return(.T.)

/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   �   C()   � Autores � Norbert/Ernani/Mansano � Data �10/05/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Funcao responsavel por manter o Layout independente da       ���
���           � resolucao horizontal do Monitor do Usuario.                  ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function C(nTam)                                                         
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor     
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//���������������������������Ŀ                                               
	//�Tratamento para tema "Flat"�                                               
	//�����������������������������                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                           

//----------------------------------------------------------------------------
Static Function OkProc(_cheque)

dbSelectArea("SEF")
dbSetOrder(4)
dbSeek(xFilial("SEF")+_cheque)
If Found()
	If Reclock("SEF",.F.)
   		SEF->EF_IMPRESS := " "
   		MsUnlock()
   	Endif
	MsgStop("Cheque liberado para reimpress�o")
Endif

Return                                     

//----------------------------------------------------------------------------
Static Function Fechar()
Close(_oDlg)
Return