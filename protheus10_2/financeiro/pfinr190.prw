#include "protheus.ch"

User Function PFINR190()

Pergunte("FIN190",.T.)

cQuery := "UPDATE " + RetSqlName("SE5") + " SET D_E_L_E_T_ = '*' "
cQuery += "WHERE E5_DATA >= '" + DTOS(MV_PAR01) + "' AND E5_DATA <= '" + DTOS(MV_PAR02) + "' "
cQuery += "AND E5_VALOR = 0.01"

TcSqlExec(cQuery)

FINR190()

Return