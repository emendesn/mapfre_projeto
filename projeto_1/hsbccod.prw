#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³HSBCCOB   ºAutor  ³Andreza Favero      º Data ³  25/05/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcoes especificas para cnab do HSBC                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Cesvi                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function HSBCCOB(cOpcao)

Local aArea	:= GetArea()
Local nRet	:= 0
Local nsaldo := 0
Local nAbat	:= 0
Local cDocumen:= " "
Local cDg1	:= " "
Local cDg2  := " "
Local cCodCed := " "

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
	
	If Empty(SE1->E1_NUMBCO)
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
		
	Endif
	
	nRet:= SPACE(2)
	
EndIf

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
//Local nTam   :=Len((Alltrim(SE1->E1_NUMBCO)+ "09"))
Local ntam		:= 10
Local nDc    := 0
Local nAlg   := 2
Local nCalNum:= space(13)  
Local cNossoNum := " "

nCalNum:= ALLTRIM(SE1->E1_NUMBCO)

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

If nDC == 1 .or. nDc == 0
	cDig := 0
	cDig := Str(cDig,1)
Else
	cDig := Str(cDig,1)
EndIf	

cNossonum := Alltrim(SE1->E1_NUMBCO) + Alltrim(cDig)

DbSelectArea("SE1")
RecLock("SE1",.F.)
SE1->E1_NUMBCO := cNossonum
MsUnlock()
Return




/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³  CalcDoc³ Autor ³ Andreza Favero   ³ Data ³ 25.05.05 ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Calculo do numero do documento para cobranca nao     ³±
              escriturada
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function CalcDoc()

Local nResult:= 0
Local nSoma  := 0
Local cDc    := ""
Local i      := 0
Local ntam	 := 6
Local nDc    := 0
Local nAlg   := 2
Local nCalNum:= space(16)  
Local cNossoNum := " "                     
Local nVencto := 0

nCalNum:= SE1->E1_NUM

// calcula o primeiro digito
For i  := 1 To Len(nCalNum)
	nSoma   := Val(Substr(nCalNum,i,1))*nAlg
	nResult := nResult + nSoma
	nAlg    := nAlg + 1
	If nAlg > 9
		nAlg := 2
	Endif
Next i

nDC  := MOD(nResult,11)
cDig := 11 - nDc

If nDC == 0 .or. nDc == 10
	cDig := 0
	cDig := Str(cDig,1)
Else
	cDig := Str(cDig,1)
EndIf	

cNossonum := SE1->E1_NUM + Alltrim(cDig)+"4"  // o numero 4 e o tipo identificador
                                              // para o calculo do numero

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$¿
//³Calcula o segundo digito³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$Ù

nVencto := dtoc(SE1->E1_VENCREA)
nVencto := StrTran(nVencto,"/","")
             
cNossoNum := Str(cNossoNum) + Str(cCodCed)+ Str(nVencto)
nCalNum := cNossoNum

For i  := 1 To Len(nCalNum)
	nSoma   := Val(Substr(nCalNum,i,1))*nAlg
	nResult := nResult + nSoma
	nAlg    := nAlg + 1
	If nAlg > 9
		nAlg := 2
	Endif
Next i

nDC  := MOD(nResult,11)
cDig := 11 - nDc

If nDC == 0 .or. nDc == 10
	cDig := 0
	cDig := Str(cDig,1)
Else
	cDig := Str(cDig,1)
EndIf	

cNossoNum := cNossoNUm + cDig

DbSelectArea("SE1")
RecLock("SE1",.F.)
SE1->E1_NUMBCO := cNossonum
MsUnlock()

Return(cNossoNum)