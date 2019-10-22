#include "protheus.ch"

User function Ajupedv()

Local cQuery	:= ""

cQuery += "SELECT C6_NUM,C6_ENTREG,C6_ITEM "
cQuery += "FROM SC6010 "
cQuery += "WHERE D_E_L_E_T_ <> '*' "
cQuery += "AND C6_FILIAL = '01' "
cQuery += "AND C6_NUM BETWEEN 'OR0001' AND 'OR9999' "
cQuery += "AND C6_ENTREG >= '20150101' "
cQuery += "AND C6_NOTA = '' "
cQuery += "ORDER BY C6_NUM,C6_ENTREG,C6_ITEM DESC"

Return