#include "protheus.ch"

User Function F200DB2()

If SE5->E5_TIPODOC == "OD"
   RecLock("SE5",.T.)
   Dele
   MsUnLock()
EndIf

Return Nil