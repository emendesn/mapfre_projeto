#include "rwmake.ch"
#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "tbicode.ch"
#Include "tbiconn.ch"
#Include "Fileio.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PFINR015 ³ Autor ³ TRADE CONSULTING      ³ Data ³ JUL/2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ CHAMA ROTINAS DE AVISO DE COBRANCA E/OU AVISO DE VENCIMENTO³±±
±±³          ³ DE TITULOS                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±                       
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PFINR015()
Local dUltCob 

Prepare Environment EMPRESA "01" FILIAL "01"

dUltCob := GetMV('MV_XULTCOB') // Data da ultima execução desta rotina

If dUltCob < DATE()  
	FAVISA := GETMV('MV_XAVICOB') //FLAG PARA ATIVAR ENVIO DE E-MAIL DE COBRANCA
	IF  FAVISA //hsg
		U_PFINR014() 
   		//PutMV('MV_XULTCOB',DATE())  
    ENDIF
   	
   	FAVISA := GETMV('MV_XAVIVEN')
   	IF  FAVISA  //PARAMETRO PARA ATIVAR DISPARO DE E-MAIL PARA AVISO DE VENCIMENTO
		U_PFINR017()
   		//PutMV('MV_XULTCOB',DATE())  
    ENDIF
    
    PutMV('MV_XULTCOB',DATE())
EndIf

return()