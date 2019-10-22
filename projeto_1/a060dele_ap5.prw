#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

User Function A060dele()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("COLDORDER,LACHOU,")

cOldOrder:=SW3->(ORDNAME())
lAchou   :=.F.

SW3->(DBSETORDER(3))
IF SW3->(DBSEEK(XFILIAL("SW3")+SA5->A5_PRODUTO))

   DO WHILE SW3->(!EOF()) .AND. SW3->W3_FILIAL == XFILIAL("SW3") .AND.;
            SW3->W3_COD_I == SA5->A5_PRODUTO

      IF SW3->W3_COD_I == SA5->A5_PRODUTO .AND.;
         SW3->W3_FORN  == SA5->A5_FORNECE .AND.;
         SW3->W3_FABR  == SA5->A5_FABR
         lAchou:=.T.
         EXIT
      ENDIF

      SW3->(DBSKIP()); LOOP

   ENDDO
   
ENDIF


IF lAchou
   Help(" ",1,"E_DELFOFA2")
ENDIF

SW3->(ORDSETFOCUS(cOldOrder))

// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==> __RETURN(!lAchou)
Return(!lAchou)        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01
