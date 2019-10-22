#include "protheus.ch"

User Function FA050DEL()     
Local aArea	:= GetArea()

If SE2->E2_TIPO == "PA " .AND. SE2->E2_PREFIXO == "SAC"
   dbSelectArea("SE5")
   dbSetOrder(7)
   dbSeek(xFilial("SE5")+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA)
   If Found()
      RecLock("SE5",.F.)
      Dele
      SE5->(MsUnLock())
   EndIf
EndIf

RestArea(aArea)

Return .T.