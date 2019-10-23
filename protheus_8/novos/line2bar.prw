#include "Protheus.ch"

User Function Line2Bar(cLine)

Local cRet	:= ""

If Len(Alltrim(cLine)) < 47

	MsgAlert("A linha digitada tem menos de 47 caracteres. Por favor verifique.")

Else

	/*DEPARA
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Cod.Bar.  Tam  Conteudo             Linha            ³
	//³01 A 03   3    BANCO                01 A 03          ³
	//³04 A 04   1    CODIGO DA MOEDA      04 A 04          ³
	//³05 A 05   1    DV DO CODIGO BARRAS  33 A 33          ³
	//³06 A 09   4    FATOR DE VENCIMENTO  34 A 37          ³
	//³10 A 19   10   VALOR                38 A 47          ³
	//³20 A 23   4    AGENCIA CEDENTE      05 A 08          ³
	//³24 A 25   2    CARTEIRA             09 A 09 + 11 A 11³
	//³26 A 36   11   NOSSO NUMERO         12 A 20 + 22 A 23³
	//³37 A 43   7    CONTA DO CEDENTE     24 A 30          ³
	//³44 A 44   1    ZERO                 31 a 31          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/

	cRet	+= Left(cLine,3)
	cRet	+= Substr(cLine,4,1)
	cRet	+= Substr(cLine,33,1)
	cRet	+= Substr(cLine,34,4)
	cRet	+= Substr(cLine,38,10)
	cRet	+= Substr(cLine,5,4)
	cRet	+= Substr(cLine,9,1) + Substr(cLine,11,1)
	cRet	+= Substr(cLine,12,9) + Substr(cLine,22,2)
	cRet	+= Substr(cLine,24,7)
	cRet	+= Substr(cLine,31,1)

EndIf

Return cRet