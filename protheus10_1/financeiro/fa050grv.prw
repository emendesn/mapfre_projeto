#include "protheus.ch"

User Function FA050GRV()     
Local aArea	:= GetArea()

If SE2->E2_TIPO == "PA " .AND. SE2->E2_PREFIXO == "SAC"
   RecLock("SE5",.T.)
   SE5->E5_FILIAL	:= xFilial("SE5")
   SE5->E5_DATA		:= SE2->E2_EMISSAO
   SE5->E5_TIPO		:= SE2->E2_TIPO
   SE5->E5_VALOR	:= SE2->E2_VALOR
   SE5->E5_NATUREZ	:= SE2->E2_NATUREZ
   SE5->E5_BANCO	:= SE2->E2_BANCO
   SE5->E5_AGENCIA	:= SE2->E2_AGENCIA
   SE5->E5_CONTA	:= SE2->E2_NUMCON
   SE5->E5_DOCUMEN	:= SE2->E2_NUM
   SE5->E5_RECPAG	:= "P"
   SE5->E5_BENEF	:= SE2->E2_NOMFOR
   SE5->E5_HISTOR	:= SE2->E2_HIST
   SE5->E5_TIPODOC	:= "VL"
   SE5->E5_VLMOED2	:= SE2->E2_VALOR
   SE5->E5_LA		:= "S"
   SE5->E5_PREFIXO	:= SE2->E2_PREFIXO
   SE5->E5_NUMERO	:= SE2->E2_NUM
   SE5->E5_PARCELA	:= SE2->E2_PARCELA
   SE5->E5_CLIFOR	:= SE2->E2_FORNECE
   SE5->E5_LOJA		:= SE2->E2_LOJA
   SE5->E5_DTDIGIT	:= dDataBase
   SE5->E5_MOTBX	:= "DEB"
   SE5->E5_SEQ		:= "01"
   SE5->E5_DTDISPO	:= SE2->E2_EMISSAO
   SE5->E5_FORNECE	:= SE2->E2_FORNECE
   SE5->(MsUnLock())
EndIf           

RestArea(aArea)

Return .T.