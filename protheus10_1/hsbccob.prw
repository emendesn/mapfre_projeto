#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                         
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³HSBCCOB   ºAutor  ³TRADE SISTEMAS      º Data ³  MAIO/2006  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcoes especificas para cnab do HSBC                      º±±
±±º          ³  												          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Cesvi                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function HSBCCOBA(cOpcao)

Local aArea	:= GetArea()
Local nRet	:= 0
Local nsaldo := 0
Local nAbat	:= 0
Local cDocumen:= " "
Local cDg1	:= " "
Local cDg2  := " "
Local cCodCed := " "

If  cOpcao == 1	
	nSaldo	:= SE1->E1_SALDO
	// faz o calculo dos abatimentos do titulo (AB-, Pis ], cofins, Csll)
	nAbat -= SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,dDataBase,SE1->E1_CLIENTE,SE1->E1_LOJA)
	nSaldo := nSaldo - nAbat
	
	nSaldo := nSaldo + SE1->E1_ACRESC
	If SE1->E1_VALJUR == 0
		nMora := STRZERO((nSaldo*(GETMV("MV_TXPER")/100))*10000,17)
	Else
		nMora := STRZERO((nSaldo*(SE1->E1_VALJUR/100))*10000,17)
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
	
	//nRet:= SPACE(2)
	
EndIf

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³  CALCDV ³ Autor ³ TRADE SISTEMAS   ³ Data ³ MAIO/2006³±
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

User Function HSBCSaldo()
	nSaldo	:= SE1->E1_SALDO + SE1->E1_ACRESC          // IANNA - TRADE - 20100710
	// faz o calculo dos abatimentos do titulo (AB-, Pis ], cofins, Csll)
	nAbat  = SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,dDataBase,SE1->E1_CLIENTE,SE1->E1_LOJA)
	nsaldo := nsaldo - nAbat
	nRet:= StrZero(nSaldo*10000,17)
Return(nRet)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³  CalcDocc³ Autor ³ TRADE SISTEMAS   ³ Data ³ MAIO/2006³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Calculo do numero do documento para cobranca nao     ³±
              escriturada
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function CalcDocc()

Local nResult:= 0
Local nSoma  := 0
Local cDc    := ""
Local i      := 0
Local ntam	 := 7
Local nDc    := 0
Local nAlg   := 9
Local nCalNum:= space(16)  
Local cNossoNum := " "                     
Local nVencto := 0
Local cCodCed := ALLTRIM(SEE->EE_CODEMP) //"3465055"
Private cNumPar := "0"

If  ALLTRIM(SE1->E1_PARCELA) == ""
    cNumPar := "0"
Else    
	convparcela()
Endif

nCalNum:= substr(SE1->E1_NUM,1,6)+ALLTRIM(cNumPar)

nPos  := Len(nCalNum)     
// calcula o primeiro digito
For i  := 1 To Len(nCalNum)
	nSoma   := Val(Substr(nCalNum,npos,1))*nAlg
	nResult := nResult + nSoma
	nPos    := nPos - 1
	nAlg    := nAlg - 1
	If nAlg < 2
		nAlg := 9
	Endif
Next i

nDC  := MOD(nResult,11)

If nDC == 0 .or. nDc == 10
	cDig := 0
	cDig := Str(cDig,1)
Else
	cDig := Str(nDC,1)
EndIf	

cNossonum := SUBSTR(SE1->E1_NUM,1,6)+ALLTRIM(cNumPar)+ Alltrim(cDig)+"4"  // o numero 4 e o tipo identificador
                                             // para o calculo do numero

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$¿
//³Calcula o segundo digito³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$Ù

nVencto := dtoc(SE1->E1_VENCREA)
nVencto := StrTran(nVencto,"/","")

nCalNum := val(cNossoNum) + val(cCodCed) + val(nVencto)
nCalNum := alltrim(str(nCalNum))

nAlg := 9
nPos := Len(nCalNum)
nResult := 0
For i  := 1 To Len(nCalNum)
	nSoma   := Val(Substr(nCalNum,nPos,1))*nAlg
	nResult := nResult + nSoma
	nAlg    := nAlg - 1
	nPos    := nPos - 1
	If nAlg < 2
		nAlg := 9
	Endif
Next i

nDC  := MOD(nResult,11)

If nDC == 0 .or. nDc == 10
	cDig := 0
	cDig := Str(cDig,1)
Else
	cDig := Str(nDC,1)
EndIf	

cNossoNum := alltrim(cNossoNUm) + alltrim(cDig)  
cNossoNum := STRZERO( VAL(CNOSSONUM),16) 

DbSelectArea("SE1")
RecLock("SE1",.F.)
SE1->E1_NUMBCO := cNossonum
MsUnlock()
Return(cNossoNum)

Static Function convparcela()
//CONVERTE A PARCELA "LETRA" PARA "NUMERO"
aParc := {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

For i:= 1 to Len(aParc)
    If  ALLTRIM(UPPER(SE1->E1_PARCELA))== aParc[I]
        cNumPar := str(i)
        exit
    Endif
Next        

Return 