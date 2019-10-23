#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �HSBC      �Autor  � TRADE SISTEMAS     � Data �  25/04/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcoes especificas para cnab do HSBC                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Cesvi                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function HSBC(cOpcao)

Local aArea	:= GetArea()
Local nRet	:= 0

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
	
	nRet:= "00000"
	
EndIf

RestArea(aArea)

Return(nRet)
/*/
���������������������������������������������������������������������
������������������������������������������������������������������Ŀ�
��Funcao    �  CALCDV � Autor � Andreza Favero   � Data � 16.12.02 ��
������������������������������������������������������������������Ĵ�
��Descricao � Funcao de calculo do Digito Verificador.             ��
�������������������������������������������������������������������ٱ
���������������������������������������������������������������������
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