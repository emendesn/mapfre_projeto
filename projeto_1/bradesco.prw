#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BRADESCO  ºAutor  ³Andreza Favero      º Data ³  03/15/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcoes especificas para cnab do Bradesco                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Cesvi                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function Bradesco(cOpcao)

Local aArea	:= GetArea()
Local nRet	:= 0
Local nsaldo := 0
Local nAbat	:= 0

If cOpcao == 1  // Calcula o saldo do titulo
	
	nSaldo	:= SE1->E1_SALDO
	// faz o calculo dos abatimentos do titulo (AB-, Pis ], cofins, Csll)
	nAbat  = SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,dDataBase,SE1->E1_CLIENTE,SE1->E1_LOJA)
	nsaldo := nsaldo - nAbat
	nRet:= StrZero(nSaldo*100,13)
	
ElseIf cOpcao == 2 // Calculo a taxa diaria
	
	nSaldo	:= SE1->E1_SALDO
	// faz o calculo dos abatimentos do titulo (AB-, Pis ], cofins, Csll)
	nAbat -= SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,dDataBase,SE1->E1_CLIENTE,SE1->E1_LOJA)
	nSaldo := nSaldo - nAbat
	If SE1->E1_VALJUR == 0
		nMora := STRZERO((nSaldo*(GETMV("MV_TXPER")/100))*100,13)
	Else
		nMora := STRZERO((nSaldo*(SE1->E1_VALJUR/100))*100,13)
	EndIf                                
	
	nRet	:= nMora
	
ElseIf	cOpcao == 3		//Calculo do Nosso Numero
	
	//If Empty(SE1->E1_NUMBCO)
		cNumero := Alltrim(SEE->EE_FAXATU)
		RecLock("SE1",.f.)
		SE1->E1_NUMBCO := cNumero
		MsUnlock()
		
		DbSelectArea("SEE")
		RecLock("SEE",.F.)
		SEE->EE_FAXATU := STRZERO((VAL(ALLTRIM(cNumero))+1),Len(Alltrim(cNumero)))
		MsUnlock()
		
		///////////////////////////////////////////////////////////////////////////
		///// CHAMA FUNCAO DE CALCULO DO DIGITO VERIFICADOR
		///////////////////////////////////////////////////////////////////////////
		CalcDV()
		
	//Endif
	
	nRet:= "00000"
	
EndIf

RestArea(aArea)

Return(nRet)
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³  CALCDV ³ Autor ³ Andreza Favero   ³ Data ³ 16.12.02 ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Funcao de calculo do Digito Verificador.             ³±
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CALCDV()

Local nResult:= 0
Local nSoma  := 0
Local cDc    := ""
Local i      := 0
Local cCart  := 19
Local nTam   :=Len((Alltrim(SE1->E1_NUMBCO)+ "09"))
Local nDc    := 0
Local nAlg   := 2
Local nCalNum:= space(13)
		
nCalNum:= ("09" + ALLTRIM(SE1->E1_NUMBCO))

For i  := nTam To 1 Step -1
	nSoma   := Val(Substr(nCalNum,i,1))*nAlg
	nResult := nResult + nSoma
	nAlg    := nAlg + 1
	If nAlg > 7
		nAlg := 2
	Endif
Next i

nDC  := MOD(nResult,11)
cDig := 11 - nDc


IF nDC == 1
	cDig := "P"
ElseIf nDC == 0
	cDig := 0
	cDig := STR(cDig,1)
Else
	cDig := STR(cDig,1)
EndIF

Nossonum := Alltrim(SE1->E1_NUMBCO) + Alltrim(cDig)

DbSelectArea("SE1")
RecLock("SE1",.F.)
SE1->E1_NUMBCO := Nossonum
MsUnlock()
Return