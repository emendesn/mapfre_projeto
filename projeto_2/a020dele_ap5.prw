#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

User Function A020dele()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("COLDORDER,LACHOU,CMSG,")


cOldOrder:=SA5->(ORDNAME())

SA5->(ORDSETFOCUS(1))
IF SA5->(DBSEEK(XFILIAL("SA5")+SA2->A2_COD+SA2->A2_LOJA))
   lAchou:=.T.
ELSE
   lAchou:=.F.
ENDIF

IF !lAchou
   SA5->(ORDSETFOCUS(4))
   IF SA5->(DBSEEK(XFILIAL("SA5")+SA2->A2_COD))
      lAchou:=.T.
   ELSE
      lAchou:=.F.
   ENDIF
ENDIF

IF lAchou
/* cMsg:=OemtoAnsi("Este Forn/Fabr Pertence a Amarra‡Æo: Forn. "+;
         ALLTRIM(SA5->A5_FORNECE)+" Prod. "+ALLTRIM(SA5->A5_PRODUTO)+;
         " Fabr. "+ALLTRIM(SA5->A5_FABR))
   MSGINFO(cMsg)*/
   Help(" ",1,"E_DELFOFA1")
ENDIF

SA5->(ORDSETFOCUS(cOldOrder))

// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==> __RETURN(!lAchou)
Return(!lAchou)        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01
