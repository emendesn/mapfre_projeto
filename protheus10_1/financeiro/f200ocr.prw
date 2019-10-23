#include "protheus.ch"

User Function F200OCR()

If SE5->E5_VALOR <= 0.01
   AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DATA,SE5->E5_VALOR,"-")
   RecLock("SE5",.T.)
   Dele
   MsUnLock()
EndIf

Return Nil