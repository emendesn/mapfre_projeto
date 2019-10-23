#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH" 
#Include 'Ap5Mail.Ch'


User Function PFINR014()

Processa({|| EMAILCOB()},"Processando E_mail de Cobranca...........")

Return
/****************************************************************/

Static Function EMAILCOB()
Local cProc     := 'S'
Local cQuery
Local cServer	:= GetMV('MV_RELSERV')
Local cAccount	:= GetMV('MV_XCOBCNT')
Local cPassword	:= GetMV('MV_XCOBPSW')
Local cMensagem	:= ''
Local cAssunto	:= 'CESVI BRASIL'
Local cDestino	:= ''
Local cCobranca := 'cobranca@cesvibrasil.com.br'
Local dDtmail	// Data para verificação do envio de email
Local dDtRmail	// Data para verificação repetição do envio de email
Local nConta
Local cQuebra := Chr(13)+Chr(10)
Local aTitulo := {}
Local nNumEm := 0

// MV_XCOBCNT (CARACTER) - CONTA DE EMAIL PARA ENVIO DE COBRANCA
// MV_XCOBPSW (CARACTER) - SENHA DA CONTA DE EMAIL PARA ENVIO DE COBRANCA
// MV_XCBMAIL (NUMERICO) - NUMERO DE DIAS PARA APOS O VENCIMENTO DEVER SER 7 DEVIDO AO SABADO E DOMINGO
// MV_XRPMAIL (NUMERICO) - NUMERO DE VEZES QUE SERÁ REPETIDO O EMAIL PARA UM CLIENTE
// A1_XCOBMAI (CARACTER S/N) - CASO NÃO QUEIRA ENVIAR MAIL DE COBRANCA PARA UM CLIENTE
// E1_XDTMAIL (DATA) - DATA DO ULTIMO ENVIO DE EMAIL DE COBRANÇA
// E1_XMAIL (NUMERICO) - NUMERO DE VEZES QUE FOI ENVIADO COBRANCA PARA ESTE TITULO

nConta := 0
Do While .t.
	dDtmail := DATE() - (GetMV('MV_XCBMAIL') + nConta)
	dDtmail := DataValida(dDtmail,.T.)
	If (DATE() - dDtmail) >= GetMV('MV_XCBMAIL')
		exit
	EndIf
	nConta ++
EndDo

//tirar top 10
cQuery := "SELECT TOP 10  SE1.E1_VENCREA,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA,SE1.E1_TIPO,SE1.E1_SALDO,"
cQuery += "SA1.A1_EMAIL,SA1.A1_COD,SA1.A1_LOJA,SA1.A1_NOME "
cQuery += "FROM " + RetSqlName("SE1") + " SE1 "
cQuery += "INNER JOIN " + RetSqlName("SA1") + " SA1 ON "
cQuery += "SA1.A1_COD = SE1.E1_CLIENTE AND "
cQuery += "SA1.A1_LOJA = SE1.E1_LOJA AND "
cQuery += "SA1.A1_XCOBMAI = 'S' AND "
cQuery += "SA1.D_E_L_E_T_ <> '*' AND "
cQuery += "SE1.E1_SALDO > 0 AND "
cQuery += "SE1.E1_VENCREA <= '" + DTOS(dDtmail) + "' AND "
cQuery += "(SE1.E1_XDTMAIL = '' OR SE1.E1_XDTMAIL < '" + DTOS(dDtmail) + "') AND "
cQuery += "SE1.E1_XMAIL <= " + STR(GetMV("MV_XRPMAIL")) + " AND "
cQuery += "SE1.E1_TIPO = 'NF' AND "
cQuery += "SE1.D_E_L_E_T_ <> '*' "
cQuery += "ORDER BY SA1.A1_COD,SA1.A1_LOJA,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA"
TCQUERY cQuery NEW ALIAS "SQLSE1"

DbSelectArea("SQLSE1")
DbGoTop()
ProcRegua(RecCount())

DbSelectArea("SE1")
DbSetOrder(1)

Do While ! SQLSE1->(EOF())

	cDestino  := alltrim(SQLSE1->A1_EMAIL)
	         
	cMensagem := ''
	cmensagem += "À " + SQLSE1->A1_NOME
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Prezado Cliente,"
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Informamos que em nossos registros não localizamos o(s) pagamento(s) referente(s)"
	cmensagem += cQuebra
	cmensagem += "ao(s) boleto(s) abaixo:"
	cmensagem += cQuebra
	cmensagem += cQuebra
	
	cCliente := alltrim(SQLSE1->A1_COD)+alltrim(SQLSE1->A1_LOJA)
	Do While ! SQLSE1->(EOF()) .AND. cCliente == alltrim(SQLSE1->A1_COD)+alltrim(SQLSE1->A1_LOJA)
		cmensagem += SQLSE1->E1_NUM
		cmensagem += space(5)
		cmensagem += SQLSE1->E1_PARCELA
		cmensagem += space(8)
		cmensagem += dtoc(stod(SQLSE1->E1_VENCREA))
		cmensagem += space(4)
		cmensagem += transform(SQLSE1->E1_SALDO,"@E 99,999,999.99")
		cmensagem += cQuebra
		
		aadd(aTitulo,SQLSE1->E1_PREFIXO+SQLSE1->E1_NUM+SQLSE1->E1_PARCELA+SQLSE1->E1_TIPO)
		SQLSE1->(dbSkip())
	EndDo
	
	cmensagem += cQuebra
	cmensagem += "Solicitamos entrar em contato o mais breve possível para uma posição quanto ao"
	cmensagem += cQuebra
	cmensagem += "pagamento, evitando possível suspensão na prestação de serviços."
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Caso já tenha liquidado o(s) título(s) aqui objetivado(s), favor  responder este e-mail"
	cmensagem += cQuebra
	cmensagem += "e encaminhar o(s) comprovante(s) para efetuarmos a regularização"
	cmensagem += cQuebra
	cmensagem += "em nosso sistema, informando o número do título e o nome da empresa."
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Atenciosamente,"
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Contas a Receber"
	cmensagem += cQuebra
	cmensagem += "(11) 2663-5203 / 5250"
	cmensagem += cQuebra
	cmensagem += "cobranca@cesvibrasil.com.br"
	cmensagem += cQuebra
	cmensagem += "CESVI BRASIL S/A"
	
	CONNECT SMTP SERVER cServer  ACCOUNT cAccount PASSWORD cPassword RESULT lConectou
    
    MailAuth(cAccount, cPassword)
	
	If lConectou     

	   cBCC    :=' ' 
	   cAnexo1 :=' '
	   cAnexo2 :=' '	   
	   cAnexo3 :=' '
	   cAnexo4 :=' '
	   cAnexo5 :=' '
	   
	   Send Mail From cAccount To cDestino CC cCobranca BCC cBCC Subject cAssunto Body cMensagem;
			Attachment cAnexo1, cAnexo2, cAnexo3, cAnexo4, cAnexo5;
			Result lEnviado

	
		If lEnviado
			if len(aTitulo) > 0
				For i := 1 to len(aTitulo)
					If dbseek(xfilial("SE1")+aTitulo[i])
						nNumEm := E1_XMAIL
						RECLOCK("SE1",.F.)
						REPLACE E1_XDTMAIL WITH DATE() //dDataBase
						REPLACE E1_XMAIL WITH (nNumEm + 1)
						MsUnlock()
					EndIf
				Next
			EndIf
		Else
			
			Conout("PFINR014.PRW - Não foi possível enviar o email para: " + SQLSE1->A1_NOME )                                                          
	        cProc := 'N'		
	        
		EndIf
		
	Else
	
	    Conout("PFINR014.PRW - Erro na conexão com o servidor - SMTP")
        cProc := 'N'
        
	EndIf
	
	DISCONNECT SMTP SERVER Result lDisConectou

EndDo

DbSelectArea("SQLSE1")
DbCloseArea()

IF cProc = 'N'
   Alert("A rotina apresentou erro, Log gravado no arquivo TotvsConsole.Log")
Endif

return()
