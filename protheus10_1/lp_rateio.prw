#include "rwmake.ch"   

User Function LP_RATEIO
Local _area    := GetArea()
Local _retorno := 0

dbSelectArea("SDE")
dbSetOrder(1)
dbSeek(xFilial("SDE")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)

IF FOUND()
   _retorno := 0
Else
   _retorno := SD1->D1_TOTAL
EndIf       

RestArea(_area)
Return(_retorno)


