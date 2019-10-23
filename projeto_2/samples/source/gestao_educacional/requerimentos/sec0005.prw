#include "rwmake.ch"
#include "acadef.ch"
#define CRLF Chr(13)+Chr(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005a  �Autor  �Rafael Rodrigues    � Data �  18/jun/02  ���
�������������������������������������������������������������������������͹��
���Desc.     �Regra Final do Requerimento de Trancamento de Matricula.    ���
���          �Rotina para trancar o curso especificado no script.         ���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpL1 : Informando se a gravacao obteve sucesso             ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005a()
                                                  
local aRet		:= ACScriptReq( JBH->JBH_NUM )
local cNumRA	:= Left( JBH->JBH_CODIDE, TamSX3("JA2_NUMRA")[1] )
local aPrefixo	:= ACPrefixo()

//�����������������������������������������������������������������������������������������������������������������������Ŀ
//� Apaga reservas do aluno e libera vaga no curso, periodo, turma e em todas as disciplinas em que ele est� matriculado. �
//� Atualiza o status no curso e nas disciplinas para trancado e apaga todos os titulos em aberto.                        �
//�������������������������������������������������������������������������������������������������������������������������
U_ACLibVaga( cNumRA, aRet[1], aRet[3], aRet[6], aPrefixo, "004", "7", "4", aRet[4] )	// Trancamento
	
Return( .T. )
 
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005b  �Autor  �Rafael Rodrigues    � Data �  19/jun/02  ���
�������������������������������������������������������������������������͹��
���Desc.     �Inicializador Padrao da Justificativa do Script.            ���
���          �Verifica a situacao financeira do aluno e alerta caso esteja���
���          �irregular. O aluno deve reguralizar a situacao financeira do���
���          �curso antes de requerer trancamento/cancelamento/desistencia���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpC1 : Brancos.                                            ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005b()
Local lRet 

// Utiliza a funcao de validacao para exibir as mensagens
lRet := U_SEC0005c()
     
Return lRet
 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005c  �Autor  �Rafael Rodrigues    � Data �  19/jun/02  ���
�������������������������������������������������������������������������͹��
���Desc.     �Validacao da Justificativa do Script.                       ���
���          �Verifica a situacao financeira do aluno e alerta caso esteja���
���          �irregular. O aluno deve reguralizar a situacao financeira do���
���          �curso antes de requerer trancamento/cancelamento/desistencia���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpL1 : Indicador de validacao.                             ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005c(lweb)

local aArea		:= GetArea()
local lRet		:= .T.      
local aRet      := {}
local cNumRA	:= Padr(M->JBH_CODIDE ,TamSx3("JA2_NUMRA")[1])
local cCurso	:= Padr(M->JBH_SCP01  ,TamSx3("JBE_CODCUR")[1])
local cHabili   := Padr(M->JBH_SCP04  ,TamSx3("JBE_HABILI")[1])
local cTurma	:= Padr(M->JBH_SCP06  ,TamSx3("JBE_TURMA")[1]) 
local cPerLet	:= Padr(M->JBH_SCP03  ,TamSx3("JBE_PERLET")[1])
local cCliente	:= Posicione("JA2", 1, xFilial("JA2")+cNumRA, "JA2_CLIENT")
local cLoja		:= Posicione("JA2", 1, xFilial("JA2")+cNumRA, "JA2_LOJA"  )
local aAtraso	:= {}
local cTexto	:= ""
local i

lWeb := IIf(lWeb == NIL, .F., lWeb)

//�������������������������������������������������������������Ŀ
//� Verifica se o aluno ja ultrapassou o limite de trancamentos �
//���������������������������������������������������������������
JBE->( dbSetOrder(1) )
JBE->( dbSeek( xFilial("JBE") + cNumRA ) )  

//Validacao de "qtd tracamento" movida para a funcao SEC005g em atendimento ao bops 143117 - SIGA6439
/*do while JBE->( ! EoF() .And. JBE_FILIAL + JBE_NUMRA == xFilial("JBE") + cNumRA )
	if JBE->JBE_ATIVO == "4" .And. ( aScan( aQtdTranc, JBE->JBE_PERLET ) == 0 )
		AAdd( aQtdTranc, JBE->JBE_PERLET )
	endif 
	JBE->( dbSkip() )                
enddo*/

if lRet

	JBE->( dbSetOrder(1) )
	JBE->( dbSeek(xFilial("JBE") + cNumRA + cCurso + cPerLet + cHabili + cTurma) )
	
	do while JBE->( ! EoF() .And.	JBE_FILIAL + JBE_NUMRA + JBE_CODCUR + JBE_PERLET + JBE_HABILI + JBE_TURMA == ;
									xFilial( "JBE" ) + cNumRA + cCurso + cPerLet + cHabili + cTurma )
		                                   
		if JBE->JBE_ATIVO == "1"
			exit
		endif
		 
		JBE->( dbSkip() )							
									
	enddo                                       
	
	//Reposiciona a JBE apos sair do laco acima.
	//Validacao de "ativo em curso" movida para a funcao SEC005g em atendimento ao bops 143117 - SIGA6439
	/*if JBE->( dbSeek(xFilial("JBE") + cNumRA + cCurso + cPerLet + cHabili + cTurma) )	
		if JBE->JBE_ATIVO <> "1" .AND. JBE->JBE_SITUAC != '1' 	// Se nao for ativo e nao for pre-matriculado
		    If lWeb
				aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">O aluno n�o est� ativo no curso e per�odo letivo solicitados.</font></b><br>'})
		    Else
		        MsgStop("O aluno n�o est� ativo no curso e per�odo letivo solicitados.")
		        lRet := .F.
		    EndIf    
		endif
	else
		lRet := .f.
	endif */          
	 
    if lRet           

		//��������������������������������������������������������������������������������Ŀ
		//� Nao permite trancar a matricula se estiver no primeiro periodo letivo do curso �
		//����������������������������������������������������������������������������������
		//Validacao de "trancamento em perlet 01" movida para a funcao SEC005g em atendimento ao bops 143117 - SIGA6439
		/*If JBE->JBE_PERLET == "01"
		    If lWeb
				aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">O trancamento da matr�cula n�o pode ser feito no primeiro periodo letivo do curso.</font></b><br>'})
		    Else
		        MsgStop("O trancamento da matr�cula n�o pode ser feito no primeiro periodo letivo do curso.")
		        lRet := .F.
		    EndIf    
		EndIf*/                                                                               
		
		//Validacao de "qtd de trancamentos" movida para a funcao SEC005g em atendimento ao bops 143117 - SIGA6439
		/*if Len( aQtdTranc )>= Posicione( "JAH", 1, xFilial("JAH") + cCurso, "JAH_QTDTRA" )
			if lWeb
				aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+;
						'Quantidade de trancamentos do aluno � maior que a quantidade permitida no curso.</font></b><br>'})
			else
			    MsgStop("Quantidade de trancamentos do aluno � maior que a quantidade permitida no curso.")
				lRet := .F.
		    endif	
		endif*/

		
		If lRet		
	
			//�����������������������������������������������������������������Ŀ
			//�Percorre todos os titulos do aluno verificando t�tulos em atraso �
			//�para o curso solicitado no script.                               �
			//�������������������������������������������������������������������
			SE1->( dbSetOrder(2) )	// (F) E1_FILIAL+E1_CLIENTE+E1_LOJA
			SE1->( dbSeek(xFilial("SE1")+cCliente+cLoja) )
			while !SE1->( eof() ) .and. SE1->E1_CLIENTE+SE1->E1_LOJA == cCliente+cLoja
				
				// Se o curso for outro, ignora
				if Left( SE1->E1_NRDOC, 6 ) <> cCurso
					SE1->( dbSkip() )
				    loop
				// Se estiver em atraso, acumula no array 
				elseif SE1->E1_VENCREA < dDatabase .and. SE1->E1_STATUS <> "B"
					aAdd( aAtraso, {SE1->E1_PARCELA+" / "+SE1->E1_PREFIXO, SE1->E1_VENCREA, SE1->E1_VALOR} )
				endif
				
				SE1->( dbSkip() )
			end
			
			if len( aAtraso ) > 0
				    If lWeb
						aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Existem t�tulos pendentes para este aluno.</font></b><br>'})
						aadd(aRet,{.F.,'<table width="60%" border="0" cellspacing="0" cellpadding="0" align="center">'})
						aadd(aRet,{.F.,'<tr align="center">'})
						aadd(aRet,{.F.,'<td height="11"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">T&iacute;tulo</font></b></td>'})
						aadd(aRet,{.F.,'<td height="11"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Vencimento</font></b></td>'})
						aadd(aRet,{.F.,'<td height="11"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Valor</font></b></td>'})
						aadd(aRet,{.F.,'</tr>'})
				    Else
						lRet	:= .F.
						cTexto	+= "Existem t�tulos pendentes para este aluno."+CRLF
						cTexto	+= "� necess�ria a negocia��o destes t�tulos antes de prosseguir com a inclus�o deste requerimento."+CRLF+CRLF
						cTexto	+= "Titulo         Vencimento               Valor"+CRLF
					EndIf	
			endif
			
			for i := 1 to len( aAtraso )
				    If lWeb
						aadd(aRet,{.F.,'<tr align="center">'})
						aadd(aRet,{.F.,'<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+Alltrim(aAtraso[i][1])+'</font></td>'})
						aadd(aRet,{.F.,'<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+dtoc(aAtraso[i][2])+'</font></td>'})
						aadd(aRet,{.F.,'<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+Alltrim(Transform(aAtraso[i][3], "@E 9,999.99"))+'</font></td>'})
						aadd(aRet,{.F.,'</tr>'})
				    Else
						cTexto += aAtraso[i][1] + Space(6) + dtoc(aAtraso[i][2]) + Space(6) + Transform(aAtraso[i][3], "@E 999,999,999.99") + CRLF
					EndIf	
			next i
			
			if len( aAtraso ) > 0 
				if !lWeb
					MsgStop( cTexto )
					Return(lRet)
				else
					aadd(aRet,{.F.,'</table>'})	
				endIf	
			else
					
				//���������������������������������������������������������������������������������������������Ŀ
				//� Verifica se o aluno esta tentando trancar a matricula no ultimo mes do periodo letivo atual �
				//�����������������������������������������������������������������������������������������������
				lRet := U_ACValPrz( cCurso, cPerLet, cHabili )
			
				If ! lRet
				
					if ! lWeb
						MsgStop( "O trancamento da matr�cula n�o pode ser efetuado no �ltimo m�s do per�odo letivo." )
						lRet := .F.
					else
						aadd(aRet,{.F.,	'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">' +;
										'O trancamento da matr�cula n�o pode ser efetuado no �ltimo m�s do per�odo letivo.</font></b><br>'})
					endif
				
				Else		
				    
				    /* Removida a validacao de titulos de matricula em aberto, em atendimento ao BOPS 00000128890 - Usr Alteracao: SIGA6439
					//��������������������������������������������������������������������������������Ŀ
					//� Verifica se existe titulo de matricula em aberto para o aluno, caso exista nao �
					//� permite que o aluno efetue o trancamento ate que ele pague a matricula         �
					//����������������������������������������������������������������������������������
					lRet := U_ACMatPaga( cCurso, cPerLet, cNumRA )
					
					If !lRet
					
						if ! lWeb     
							MsgStop( "O t�tulo referente a matr�cula deste aluno deve ser baixado antes da solicita��o do trancamento." )
						else
							aadd(aRet,{.F.,	'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">' +;
											'O t�tulo referente a matr�cula deste aluno deve ser baixado antes da solicita��o do trancamento.</font></b><br>'})
						endif
						
					EndIf */		
				
				EndIf	
			
			endif
	
		endif
	
	endif
	
endif
	
RestArea(aArea)

Return( Iif( lWeb, aRet, lRet ) )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005d  �Autor  �Rafael Rodrigues    � Data �  02/jul/02  ���
�������������������������������������������������������������������������͹��
���Desc.     �Validacoes do script.                                       ���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpL1 : Indicador de validacao.                             ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005d( lScript, cKey, lWeb )
local lRet	:= .T.

lScript	:= if( lScript == nil, .F., lScript )
cKey	:= if( cKey == nil, "", cKey ) 
lWeb	:= if( lWeb == nil, .F., lWeb )

if lScript
	lRet	:= ExistCpo("JBE",Padr(M->JBH_CODIDE,TAMSX3("JA2_NUMRA")[1])+cKey, 1)

	if lRet

		JBE->( dbSetOrder(3) )
		lRet := JBE->( dbSeek( xFilial("JBE")+"1"+Padr(M->JBH_CODIDE,TAMSX3("JA2_NUMRA")[1])+cKey ) )
	
		if !lRet                      
			If !lWeb
				MsgStop("Curso inv�lido para este aluno.")
			Else 
				aadd(aRet,{.F.,"Curso inv�lido para este aluno."})
				Return aRet
			EndIf	
		else
			M->JBH_SCP02	:= Posicione("JAF",1,xFilial("JAF")+Posicione("JAH",1,xFilial("JAH")+JBE->JBE_CODCUR,"JAH_CURSO")+JAH->JAH_VERSAO,"JAF_DESMEC")
			M->JBH_SCP03	:= JBE->JBE_PERLET
			M->JBH_SCP04    := JBE->JBE_HABILI
			M->JBH_SCP06	:= JBE->JBE_TURMA
			M->JBH_SCP07	:= Posicione("JAR",1,xFilial("JAR")+JBE->JBE_CODCUR+JBE->JBE_PERLET+JBE->JBE_HABILI,"JAR_ANOLET")
			M->JBH_SCP08	:= Posicione("JAR",1,xFilial("JAR")+JBE->JBE_CODCUR+JBE->JBE_PERLET+JBE->JBE_HABILI,"JAR_PERIOD")
			M->JBH_SCP09	:= Posicione("JA2",1,xFilial("JA2")+JBE->JBE_NUMRA,"JA2_FRESID")
		endif
	endif
endif

Return lRet  


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005e  �Autor  �Fernando Gomes      � Data �  31/Ago/07  ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que posiciona no ultimo periodo do aluno.            ���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpC1:Posicione na tabela JBE.                              ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005e()
Local cQuery  := ""
Local cNumRa  := ""
Local cCodCur := ""
Local cPerLet := ""
Local cAlocTR := ""    

//Pesquisa para encontrar o ultimo curso vinculado ao aluno.
cQuery := " SELECT MAX(JBE_CODCUR) JBE_CODCUR "
cQuery += " FROM "+RetSqlName("JBE") + " JBE "
cQuery += " WHERE JBE_NUMRA= '"+SubStr(M->JBH_CODIDE,1,15)+"' "
cQuery += " AND JBE_PERLET > '01' "  
cQuery += " AND D_E_L_E_T_ <> '*' "
cQuery := ChangeQuery( cQuery ) 
dbUseArea( .T., "TopConn", TCGenQry(,,cQuery), "TRF", .F., .F. )
cNumRA  := SubStr(M->JBH_CODIDE,1,15)
cCodCur := TRF->JBE_CODCUR
TRF->( dbCloseArea() )

//Pesquisa para encontrar o ultimo periodo letivo do curso vinculado ao aluno.
cQuery := " SELECT MAX(JBE_PERLET) JBE_PERLET  "
cQuery += " FROM "+RetSqlName("JBE") + " JBE "
cQuery += " WHERE JBE_NUMRA= '"+SubStr(M->JBH_CODIDE,1,15)+"' "
cQuery += " AND JBE_CODCUR = '"+cCodCur+"'" 
cQuery += " AND D_E_L_E_T_ <> '*' "
cQuery := ChangeQuery( cQuery ) 
dbUseArea( .T., "TopConn", TCGenQry(,,cQuery), "TRF", .F., .F. )
cPerLet := TRF->JBE_PERLET
TRF->( dbCloseArea() )

cAlocTR := Posicione("JBE",1,xFilial("JBE")+cNumRA+cCodCur+cPerLet,"JBE_CODCUR")


Return (cAlocTR)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005f  �Autor  �Fernando Gomes      � Data �  31/Ago/07  ���
�������������������������������������������������������������������������͹��
���Desc.     �Validacoes do script / Pre-Matriculado.                     ���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpL1 : Indicador de validacao.                             ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005f( lScript, cKey, lWeb )

Local lRet	  := .T.
Local cQuery  := ""    
Local cHabili := ""
Local cNumRa,cCodCur  := "" 
Local cTurma,cPerLet  := ""

lScript	:= if( lScript == nil, .F., lScript )
cKey	:= if( cKey == nil, "", cKey ) 
lWeb	:= if( lWeb == nil, .F., lWeb )

If lScript
	lRet	:= ExistCpo("JBE",Padr(M->JBH_CODIDE,TAMSX3("JA2_NUMRA")[1])+cKey, 1)

	If lRet

		cQuery += " SELECT JBE_NUMRA,JBE_CODCUR,JBE_PERLET,JBE_TURMA,JBE_HABILI "
		cQuery += " FROM "+RetSqlName("JBE") + " JBE "
		cQuery += " WHERE JBE_NUMRA= '"+SubStr(M->JBH_CODIDE,1,15)+"' " 
		cQuery += " AND  JBE_CODCUR= '"+SubStr(cKey,1,6)+"' "
		cQuery += " AND  JBE_PERLET= '"+M->JBH_SCP03+"' "
		cQuery += " AND  D_E_L_E_T_ <> '*' "
		cQuery := ChangeQuery( cQuery ) 
		dbUseArea( .T., "TopConn", TCGenQry(,,cQuery), "TRF", .F., .F. )

		cNumRa   := TRF->JBE_NUMRA
		cCodCur  := TRF->JBE_CODCUR
		cPerLet  := TRF->JBE_PERLET
		cTurma   := TRF->JBE_TURMA
		cHabili  := TRF->JBE_HABILI
		
		TRF->( dbCloseArea() )

		DbSelectArea("JBE")
		
		If Empty(cNumRa) .And. Empty(cCodCur) .And. Empty(cPerLet)
			If !lWeb
				MsgStop("Curso inv�lido para este aluno.")
			Else 
				aadd(aRet,{.F.,"Curso inv�lido para este aluno."})
				Return aRet
			EndIf	
		Else
			M->JBH_SCP02	:= Posicione("JAF",1,xFilial("JAF")+Posicione("JAH",1,xFilial("JAH")+cCodCur,"JAH_CURSO")+JAH->JAH_VERSAO,"JAF_DESMEC")
			M->JBH_SCP03	:= cPerLet
			M->JBH_SCP04    := cHabili
			M->JBH_SCP06	:= cTurma
			M->JBH_SCP07	:= Posicione("JAR",1,xFilial("JAR")+cCodCur+cPerLet+cHabili,"JAR_ANOLET")
			M->JBH_SCP08	:= Posicione("JAR",1,xFilial("JAR")+cCodCur+cPerLet+cHabili,"JAR_PERIOD")
			M->JBH_SCP09	:= Posicione("JA2",1,xFilial("JA2")+cNumRa,"JA2_FRESID")
		Endif
	Endif
Endif

Return lRet  


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SEC0005g  �Autor  �Fernando Gomes      � Data �  31/Ago/07  ���
�������������������������������������������������������������������������͹��
���Desc.     �Validacao da Justificativa do Script / Pre-Matriculado.     ���
���          �Verifica a situacao financeira do aluno e alerta caso esteja���
���          �irregular. O aluno deve reguralizar a situacao financeira do���
���          �curso antes de requerer trancamento/cancelamento/desistencia���
�������������������������������������������������������������������������͹��
���Param.    �Nenhum.                                                     ���
�������������������������������������������������������������������������͹��
���Retorno   �ExpL1 : Indicador de validacao.                             ���
�������������������������������������������������������������������������͹��
���Uso       �Gestao Educacional - Requerimentos                          ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SEC0005g(lweb)

local aArea		:= GetArea()
local lRet		:= .T.      
local aRet      := {}
local aQtdTranc := {}
local cNumRA	:= Padr(M->JBH_CODIDE ,TamSx3("JA2_NUMRA")[1])
local cCurso	:= Padr(M->JBH_SCP01  ,TamSx3("JBE_CODCUR")[1])
local cHabili   := Padr(M->JBH_SCP04  ,TamSx3("JBE_HABILI")[1])
local cTurma	:= Padr(M->JBH_SCP06  ,TamSx3("JBE_TURMA")[1]) 
local cPerLet	:= Padr(M->JBH_SCP03  ,TamSx3("JBE_PERLET")[1])
local cCliente	:= Posicione("JA2", 1, xFilial("JA2")+cNumRA, "JA2_CLIENT")
local cLoja		:= Posicione("JA2", 1, xFilial("JA2")+cNumRA, "JA2_LOJA"  )
local aAtraso	:= {}
local cTexto	:= ""
local i

lWeb := IIf(lWeb == NIL, .F., lWeb)

//�������������������������������������������������������������Ŀ
//� Verifica se o aluno ja ultrapassou o limite de trancamentos �
//���������������������������������������������������������������
JBE->( dbSetOrder(1) )
JBE->( dbSeek( xFilial("JBE") + cNumRA ) )

do while JBE->( ! EoF() .And. JBE_FILIAL + JBE_NUMRA == xFilial("JBE") + cNumRA )

	if JBE->JBE_ATIVO == "4" .And. ( aScan( aQtdTranc, JBE->JBE_PERLET ) == 0 )
		AAdd( aQtdTranc, JBE->JBE_PERLET )
	endif
     
	JBE->( dbSkip() )      
enddo

if lRet

	JBE->( dbSetOrder(1) )
	JBE->( dbSeek(xFilial("JBE") + cNumRA + cCurso + cPerLet + cHabili + cTurma) )
	
	//��������������������������������������������������������������������������������Ŀ
	//� Nao permite trancar a matricula se estiver no primeiro periodo letivo do curso �
	//����������������������������������������������������������������������������������
	If JBE->JBE_PERLET == "01"
	    If lWeb
			aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">O trancamento da matr�cula n�o pode ser feito no primeiro periodo letivo do curso.</font></b><br>'})
	    Else
	        MsgStop("O trancamento da matr�cula n�o pode ser feito no primeiro periodo letivo do curso.")
	        lRet := .F.
	    EndIf    
	EndIf
	
	//�����������������������������������������������Ŀ
	//�Nao permite trancar se o periodo nao esta ativo�
	//�������������������������������������������������
	If (JBE->JBE_ATIVO <> "2" .And. JBE->JBE_SITUAC == "1") .Or. (JBE->JBE_ATIVO <> "1" .And. JBE->JBE_SITUAC == "2") .and. lRet
	    If lWeb
			aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">O aluno n�o est� ativo no curso e per�odo letivo solicitados.</font></b><br>'})
	    Else
	        MsgStop("O aluno n�o est� ativo no curso e per�odo letivo solicitados.")
	        lRet := .F.
	    EndIf    
	Endif
	
		
	Do while JBE->( ! EoF() .And.	JBE_FILIAL + JBE_NUMRA + JBE_CODCUR + JBE_PERLET + JBE_HABILI + JBE_TURMA == ;
									xFilial( "JBE" ) + cNumRA + cCurso + cPerLet + cHabili + cTurma )
		                                   
		If (JBE->JBE_ATIVO == "2" .And. JBE->JBE_SITUAC == "1") .Or. (JBE->JBE_ATIVO == "1" .And. JBE->JBE_SITUAC == "2")
			Exit
		Endif
		 
		JBE->( dbSkip() )							
									
	Enddo
	              
    if lRet           
	 
		if Len( aQtdTranc ) >= Posicione( "JAH", 1, xFilial("JAH") + cCurso, "JAH_QTDTRA" )
			if lWeb
				aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+;
						'Quantidade de trancamentos do aluno � maior que a quantidade permitida no curso.</font></b><br>'})
			else
			    MsgStop("Quantidade de trancamentos do aluno � maior que a quantidade permitida no curso.")
				lRet := .F.
		    endif	
		endif

		
		If lRet		
	
			//�����������������������������������������������������������������Ŀ
			//�Percorre todos os titulos do aluno verificando t�tulos em atraso �
			//�para o curso solicitado no script.                               �
			//�������������������������������������������������������������������
			SE1->( dbSetOrder(2) )	// (F) E1_FILIAL+E1_CLIENTE+E1_LOJA
			SE1->( dbSeek(xFilial("SE1")+cCliente+cLoja) )
			while !SE1->( eof() ) .and. SE1->E1_CLIENTE+SE1->E1_LOJA == cCliente+cLoja
				
				// Se o curso for outro, ignora
				if Left( SE1->E1_NRDOC, 6 ) <> cCurso
					SE1->( dbSkip() )
				    loop
				// Se estiver em atraso, acumula no array 
				elseif SE1->E1_VENCREA < dDatabase .and. SE1->E1_STATUS <> "B" .and. SE1->E1_PREFIXO <> "MAT"
					aAdd( aAtraso, {SE1->E1_PARCELA+" / "+SE1->E1_PREFIXO, SE1->E1_VENCREA, SE1->E1_VALOR} )
				endif
				
				SE1->( dbSkip() )
			end
			
			if len( aAtraso ) > 0
				    If lWeb
						aadd(aRet,{.F.,'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Existem t�tulos pendentes para este aluno.</font></b><br>'})
						aadd(aRet,{.F.,'<table width="60%" border="0" cellspacing="0" cellpadding="0" align="center">'})
						aadd(aRet,{.F.,'<tr align="center">'})
						aadd(aRet,{.F.,'<td height="11"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">T&iacute;tulo</font></b></td>'})
						aadd(aRet,{.F.,'<td height="11"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Vencimento</font></b></td>'})
						aadd(aRet,{.F.,'<td height="11"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Valor</font></b></td>'})
						aadd(aRet,{.F.,'</tr>'})
				    Else
						lRet	:= .F.
						cTexto	+= "Existem t�tulos pendentes para este aluno."+CRLF
						cTexto	+= "� necess�ria a negocia��o destes t�tulos antes de prosseguir com a inclus�o deste requerimento."+CRLF+CRLF
						cTexto	+= "Titulo         Vencimento               Valor"+CRLF
					EndIf	
			endif
			
			for i := 1 to len( aAtraso )
				    If lWeb
						aadd(aRet,{.F.,'<tr align="center">'})
						aadd(aRet,{.F.,'<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+Alltrim(aAtraso[i][1])+'</font></td>'})
						aadd(aRet,{.F.,'<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+dtoc(aAtraso[i][2])+'</font></td>'})
						aadd(aRet,{.F.,'<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">'+Alltrim(Transform(aAtraso[i][3], "@E 9,999.99"))+'</font></td>'})
						aadd(aRet,{.F.,'</tr>'})
				    Else
						cTexto += aAtraso[i][1] + Space(6) + dtoc(aAtraso[i][2]) + Space(6) + Transform(aAtraso[i][3], "@E 999,999,999.99") + CRLF
					EndIf	
			next i
			
			if len( aAtraso ) > 0 
				if !lWeb
					MsgStop( cTexto )
				else
					aadd(aRet,{.F.,'</table>'})	
				endIf	
			else
					
				//���������������������������������������������������������������������������������������������Ŀ
				//� Verifica se o aluno esta tentando trancar a matricula no ultimo mes do periodo letivo atual �
				//�����������������������������������������������������������������������������������������������
				lRet := U_ACValPrz( cCurso, cPerLet, cHabili )
			
				If ! lRet
				
					if ! lWeb
						MsgStop( "O trancamento da matr�cula n�o pode ser efetuado no �ltimo m�s do per�odo letivo." )
						lRet := .F.
					else
						aadd(aRet,{.F.,	'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">' +;
										'O trancamento da matr�cula n�o pode ser efetuado no �ltimo m�s do per�odo letivo.</font></b><br>'})
					endif
				
				Else		
				    
				    /* Removida a validacao de titulos de matricula em aberto, em atendimento ao BOPS 00000128890 - Usr Alteracao: SIGA6439
					//��������������������������������������������������������������������������������Ŀ
					//� Verifica se existe titulo de matricula em aberto para o aluno, caso exista nao �
					//� permite que o aluno efetue o trancamento ate que ele pague a matricula         �
					//����������������������������������������������������������������������������������
					lRet := U_ACMatPaga( cCurso, cPerLet, cNumRA )
					
					If !lRet        
					
						if ! lWeb   
							lRet := .T.   //   Possibilita trancar caso o titulo de matricula que nao seja pago.
							MsgAlert( "O t�tulo referente a matr�cula deste aluno se encontra em aberto, aluno pr�-matriculado" )
						else
							lRet := .T.   //   Possibilita trancar caso o titulo de matricula que nao seja pago.						
							aadd(aRet,{.F.,	'<b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">' +;
											'O t�tulo referente a matr�cula deste aluno se encontra em aberto, aluno pr�-matriculado.</font></b><br>'})
						endif
					else
						lRet := .T.	 
					EndIf  */		
				
				EndIf	
			
			endif
	
		endif
	
	endif
	
endif
	
RestArea(aArea)

Return( Iif( lWeb, aRet, lRet ) )
