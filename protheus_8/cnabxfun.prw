#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNABXFUN  ºAutor  ³                    º Data ³  08/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Repositorio de funcoes para CNAB                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GLINDIGI  ºAutor  ³                     º Data ³  08/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função que gera a representação numérica do código de barrasº±±
±±º          ³a partir da linha digitável.                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user function GLinDigi()

//Verifica com o usuário se é concessionária de serviços públicos
Local _lConcess := .F.	//MsgYesNo("E concessionaria de servicos publicos?")
Local _lDvOk

Private _cLinDigi := M->E2_LINDIGI
Private _cFator := ""

//Cálculo do fator de vencimento
Private _nFator := 1000
Private _cFatorrea := StrZero(_nFator + (M->E2_VENCREA - Ctod("03/07/00")),4)
Private _cFatorven := StrZero(_nFator + (M->E2_VENCTO - Ctod("03/07/00")), 4)
_cRet := ""
FOR _N:=1 TO Len(_cLinDigi)
	_cRet += Iif(Substr(_cLinDigi, _n, 1)$"0123456789", Substr(_cLinDigi, _n, 1), "")
NEXT
_cLinDigi := _cRet

//Organiza os segmentos da linha digitável para formação do código de barras
IF _lConcess
	_cRet := ""
	_cRet += Substr(_cLinDigi, 1,11)
	_cRet += Substr(_cLinDigi,13,11)
	_cRet += Substr(_cLinDigi,25,11)
	_cRet += Substr(_cLinDigi,37,11)
ELSE
	_cRet := ""
	_cRet += Substr(_cLinDigi, 1, 3) //341
	_cRet += Substr(_cLinDigi, 4, 1) //9
	_cRet += Substr(_cLinDigi,33, 1) //6
	_cFator := Substr(_cLinDigi,34, 4) //1667
	_cRet += IIF(_cFator == _cFatorRea .OR. _cFator == _cFatorVen, _cFator, "")
	_nPos := IIF(_cFator == _cFatorRea .OR. _cFator == _cFatorVen, 38, 34)
	_nPo2 := IIF(_cFator == _cFatorRea .OR. _cFator == _cFatorVen, 10, 14)
	//	_cRet += StrZero(Val(Substr(_cLinDigi,_nPos,_nPo2)), 10) //12345
	_cRet += Substr(_cLinDigi,_nPos,_nPo2) //12345
	_cRet += Substr(_cLinDigi, 5, 5)
	_cRet += Substr(_cLinDigi,11,10)
	_cRet += Substr(_cLinDigi,22,10)
ENDIF

//Efetua a validação do DV do código de barras obtido pela linha digitável
_lDvOk := U_FCalcDvB(_cRet, _lConcess)

//Se o DV estiver errado, informa o usuário, mas não impede o procedimento
IF _lDvOk
	MsgBox("Digito verificador correto!", "DV", "INFO")
ELSE
	MsgBox("Digito verificador incorreto!", "Atencao", "ERRO")
	_cRet := space(44)
ENDIF

RETURN(_cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FCALCDVB  ºAutor  ³                    º Data ³  08/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para efetuar a validação do dígito verificador geral º±±
±±º          ³dos códigos de barras de títulos a pagar.                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION FCALCDVB(_cDv, _lConcess)
_lRet := .t.
_nFat := 2
_nProd := 0
_nItem := 0
_cItem := ""

IF _lConcess
	_nDvComp := Val(Substr(_cDv,4,1))
	
	FOR _n := Len(_cDv) TO 1 STEP -1
		IF _n == 4
			LOOP
		ENDIF
		_nFat := Iif(_nFat==0, 2, _nFat)
		_cItem += Alltrim(Str(Val(Substr(_cDv, _n, 1)) * _nFat,18,0))
		_nFat--
	NEXT
	FOR _n := 1 TO Len(_cItem)
		_nItem += Val(Substr(_cItem, _n, 1))
	NEXT
	_nDvCalc := 10 - (_nItem%10)
ELSE
	_nDvComp := Val(Substr(_cDv,5,1))
	
	FOR _n := Len(_cDv) TO 1 STEP -1
		IF _n == 5
			LOOP
		ENDIF
		_nFat := Iif(_nFat>9, 2, _nFat)
		_nItem += Val(Substr(_cDv, _n, 1)) * _nFat
		_nFat++
	NEXT
	
	_nDvCalc := 11 - (_nItem%11)
	
	IF _nDvCalc == 0 .OR. _nDvCalc == 10 .OR. _nDvCalc == 11
		_nDvCalc := 1
	ENDIF
ENDIF
_lRet := _nDvCalc == _nDvComp

RETURN(_lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CALCLNDG  ºAutor  ³                    º Data ³  08/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função a ser executada via gatilho no campo E2_CODBAR para  º±±
±±º          ³calcular a linha digitável do código de barras para o campo º±±
±±º          ³E2_LINDIGI. Foi criado para viabilizar o pagamento de con-  º±±
±±º          ³cessionárias de serviços públicos via CNAB - SISPAG.        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION CalcLnDg()
//Verifica junto ao usuário se é concessionária de serviços públicos
Local _lConcess := .f.	//MsgYesNo("E concessionaria de servicos publicos?")

Private _cCodBar := M->E2_CODBAR
Private _cRet := ""

//Efetua a validação do dígito verificador do código de barras
//para prevenir erros na leitura ótica
Private _lDvOk := U_FCALCDVB(_cCodBar, _lConcess)

//Neste caso, não permite o prosseguimento da rotina e obriga o usuário
//a efetuar o INPUT pela linha digitável.
IF _lDvOk
	IF _lConcess
		_aSegm := {}
		Aadd(_aSegm, {Substr(_cCodBar, 1, 11), nil})
		Aadd(_aSegm, {Substr(_cCodBar,12, 11), nil})
		Aadd(_aSegm, {Substr(_cCodBar,23, 11), nil})
		Aadd(_aSegm, {Substr(_cCodBar,34, 11), nil})
		
		FOR _n:=1 TO Len(_aSegm)
			_cBloco := ""
			_nBase := 2
			FOR _n2 := Len(_aSegm[_n, 1]) TO 1 STEP -1
				_nBase := Iif(_nBase==0,2,_nBase)
				_cBloco += Alltrim(Str(Val(Substr(_aSegm[_n, 1], _n2, 1))*_nBase,18,0))
				_nBase--
			NEXT
			_nTotal := 0
			FOR _n2:=1 TO Len(_cBloco)
				_nTotal += Val(Substr(_cBloco, _n2, 1))
			NEXT
			_nDvCalc := 10 - (_nTotal%10)
			_aSegm[_n, 2] := Iif(_nDvCalc == 10, "0", Str(_nDvCalc, 1,0))
			_cRet += _aSegm[_n, 1] + _aSegm[_n, 2]
		NEXT
	ELSE
		_aSegm := {}
		Aadd(_aSegm, {Substr(_cCodBar, 1, 04) + Substr(_cCodBar,20, 5), nil})
		Aadd(_aSegm, {Substr(_cCodBar,25, 10), nil})
		Aadd(_aSegm, {Substr(_cCodBar,35, 10), nil})
		
		FOR _n:=1 TO Len(_aSegm)
			_cBloco := ""
			_nBase := 2
			FOR _n2 := Len(_aSegm[_n, 1]) TO 1 STEP -1
				_nBase := Iif(_nBase==0,2,_nBase)
				_cBloco += Alltrim(Str(Val(Substr(_aSegm[_n, 1], _n2, 1))*_nBase,18,0))
				_nBase--
			NEXT
			_nTotal := 0
			FOR _n2:=1 TO Len(_cBloco)
				_nTotal += Val(Substr(_cBloco, _n2, 1))
			NEXT
			_nDvCalc := 10 - (_nTotal%10)
			_aSegm[_n, 2] := Iif(_nDvCalc == 10, "0", Str(_nDvCalc, 1,0))
			_cRet += _aSegm[_n, 1] + _aSegm[_n, 2]
		NEXT
		_cRet += Substr(_cCodBar, 5,15)
	ENDIF
ELSE
	MsgBox("O digito verificador do codigo de barras informado nao e valido!", "Atencao")
	_cRet := space(47)
ENDIF

RETURN(_cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MASKLDG   ºAutor  ³                    º Data ³  08/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Picture do campo  E2_LINDIGI, que contem a representacao    º±±
±±º          ³da linha digitavel do codigo de barras.                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user function MaskLDG()
Local _cRet	:= "@R 99999.99999 99999.999999 99999.999999 9 99999999999999%C"
RETURN(_cRet)                                                                                 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FCALCDVC  ºAutor  ³                    º Data ³  08/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para efetuar a validação do dígito verificador geral º±±
±±º          ³dos códigos de barras de títulos a pagar e enviar p/ o cnab º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION FCALCDVC(_cDv, _lConcess)
_lRet := .t.
_nFat := 2
_nProd := 0
_nItem := 0
_cItem := ""

IF _lConcess
	_nDvComp := Val(Substr(_cDv,4,1))
	
	FOR _n := Len(_cDv) TO 1 STEP -1
		IF _n == 4
			LOOP
		ENDIF
		_nFat := Iif(_nFat==0, 2, _nFat)
		_cItem += Alltrim(Str(Val(Substr(_cDv, _n, 1)) * _nFat,18,0))
		_nFat--
	NEXT
	FOR _n := 1 TO Len(_cItem)
		_nItem += Val(Substr(_cItem, _n, 1))
	NEXT
	_nDvCalc := 10 - (_nItem%10)
ELSE
	_nDvComp := Val(Substr(_cDv,5,1))
	
	FOR _n := Len(_cDv) TO 1 STEP -1
		IF _n == 5
			LOOP
		ENDIF
		_nFat := Iif(_nFat>9, 2, _nFat)
		_nItem += Val(Substr(_cDv, _n, 1)) * _nFat
		_nFat++
	NEXT
	
	_nDvCalc := 11 - (_nItem%11)
	
	IF _nDvCalc == 0 .OR. _nDvCalc == 10 .OR. _nDvCalc == 11
		_nDvCalc := 1
	ENDIF
ENDIF
_lRet := _nDvCalc == _nDvComp

RETURN(_nDvClac)
