#include "protheus.ch"

User Function F200DB1()

If SE5->E5_TIPODOC == "DB"
   RecLock("SE5",.T.)
   Dele
   MsUnLock()
EndIf

Return Nil