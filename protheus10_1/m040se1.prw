#include "rwmake.ch"   
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ M040SE1 ³ Autor ³ TRADE                 ³ Data ³ 31/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ GRAVA VALOR DO ISS NO TITULO A RECEBER - NFS DE SERVICO    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                      
User Function M040SE1() 
LOCAL aAlias := getarea()
LOCAL nVALiss := 0

If  SE1->E1_ISS = 0
    IF  ALLTRIM(SE1->E1_PREFIXO) == 'S2'
        IF  ALLTRIM(SE1->E1_PARCELA)=='' .OR. ALLTRIM(SE1->E1_PARCELA)=='A' .OR. ALLTRIM(SE1->E1_PARCELA)=='1' //GRAVA NA PRIMEIRA PARCELA
            DBSELECTAREA("SF2")
            DBSETORDER(1)
            Dbseek(XFILIAL("SF2")+SE1->E1_NUM+SE1->E1_PREFIXO+SE1->E1_CLIENTE+SE1->E1_LOJA)
            IF   found()
                 nValIss := SF2->F2_VALISS
            ENDIF     
        ENDIF
        IF   nValISS > 0
  //           ALERT("MAIOR QUE ZERO - LEU NOTA")
             Dbselectarea("SE1")
             SE1->E1_ISS := nValIss
        ENDIF
    Endif
Endif

RestArea(aAlias)

Return()