#include "protheus.ch"

User Function PFINR470()

Pergunte("FIN470",.T.)

cQuery := "UPDATE " + RetSqlName("SE5") + " SET D_E_L_E_T_ = '*' "
cQuery += "WHERE E5_DATA >= '" + DTOS(MV_PAR04) + "' AND E5_DATA <= '" + DTOS(MV_PAR05) + "' "
cQuery += "AND E5_VALOR = 0.01"

TcSqlExec(cQuery)

FINR470()

Return