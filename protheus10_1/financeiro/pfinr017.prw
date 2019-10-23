#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH" 
#Include 'Ap5Mail.Ch'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PFINR017 ³ Autor ³ EDINILSON             ³ Data ³ JUL/2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ ENVIA EMAIL DE AVISO ANTECIPADO DE VENCIMENTO DE TITULOS   ³±±
±±³          ³  VENCER DENTRO DE 05 A 7 DIAS (DEPENDE DO PARAMETRO)       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PFINR017()

Processa({|| AVISOCOB()},"Processando E_mail de Aviso de Vencimento.......")

Return
/****************************************************************/

Static Function AVISOCOB()
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

dDtmail := Date() + 7  //avanca 7 dias na data base para selecionar os tituls a vencer daqui a 7 dias
dDtmail := DataValida(dDtmail,.T.)
// TIRAR TOP 10 HSG
cQuery := "SELECT TOP 10 SE1.E1_VENCREA,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA,SE1.E1_TIPO,SE1.E1_SALDO,"
cQuery += "SA1.A1_EMAIL,SA1.A1_COD,SA1.A1_LOJA,SA1.A1_NOME "
cQuery += "FROM " + RetSqlName("SE1") + " SE1 "
cQuery += "INNER JOIN " + RetSqlName("SA1") + " SA1 ON "
cQuery += "SA1.A1_COD = SE1.E1_CLIENTE AND "
cQuery += "SA1.A1_LOJA = SE1.E1_LOJA AND "
cQuery += "SA1.A1_XCOBMAI = 'S' AND "
cQuery += "SA1.D_E_L_E_T_ <> '*' AND "
cQuery += "SE1.E1_SALDO > 0 AND "
cQuery += "SE1.E1_VENCREA = '" + DTOS(dDtmail) + "' AND "
cQuery += "SE1.E1_TIPO = 'NF' AND "
cQuery += "SE1.D_E_L_E_T_ <> '*' "
cQuery += "ORDER BY SA1.A1_COD,SA1.A1_LOJA,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA"
TCQUERY cQuery NEW ALIAS "SQLSE1"

DbSelectArea("SQLSE1")
DbGoTop()
ProcRegua(RecCount())

DbSelectArea("SE1")
DbSetOrder(1)
achou := .T.

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
	cmensagem += "Informamos abaixo a relação da(s) fatura(s) que vencerão nos"
	cmensagem += cQuebra
	cmensagem += "próximos dias:"
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
	cmensagem += "Caso não tenha recebido o(s) boleto(s) acima, por favor solicite-nos através deste e-mail."
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Atenciosamente,"
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += cQuebra
	cmensagem += "Fabio Marton
	cmensagem += cQuebra
	cmensagem += "Contas a Receber"
	cmensagem += cQuebra
	cmensagem += "(11) 5112-7678"
	cmensagem += cQuebra
	cmensagem += "cobranca@cesvibrasil.com.br"
	cmensagem += cQuebra
	cmensagem += "CESVI BRASIL S/A"
	
	CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword RESULT lConectou
	If lConectou
		SEND MAIL FROM cAccount;
		TO cDestino,cCobranca;
		SUBJECT cAssunto;
		BODY cMensagem;
		RESULT lEnviado
		DISCONNECT SMTP SERVER Result lDisConectou
	Else
	    Msgalert("Aviso de Vencimento - Falha de envio de e-mail")   
	    DbSelectArea("SQLSE1")
		DbCloseArea()
	    Return
	EndIf 
EndDo

DbSelectArea("SQLSE1")
DbCloseArea()
return()