#Include "RwMake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ MPFA001  ºAutor  ³ Emerson Custodio   º Data ³ 19/10/2006  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula digito verificador.                                º±±
±±º          ³ Solicitacao especifica (Tadeu)-MAPFRE 811                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MPFA001(_cAGENCIA,_nVLRINIC)

Local _nSOMAVLR := 0
Local _nRESULTA := 0
Local _cDIGVERI := "0"

If SE2->E2_BANCO $ "001"
	For I := Len(_cAGENCIA) To 1 Step -1
		_nSOMAVLR += Val(SubStr(_cAGENCIA,I,1)) * _nVLRINIC
		_nVLRINIC --
	Next
Else
	For I := 1 To Len(_cAGENCIA)
		_nSOMAVLR += Val(SubStr(_cAGENCIA,I,1)) * _nVLRINIC
		_nVLRINIC --
	Next
EndIf
_nRESULTA := Int(_nSOMAVLR / 11)
_nSOMAVLR := _nSOMAVLR - (11 * _nRESULTA)

If _nSOMAVLR > 1
	_cDIGVERI := AllTrim(Str(11 - _nSOMAVLR))
ElseIf _nSOMAVLR == 1
	_cDIGVERI := "0"
ElseIf SE2->E2_BANCO <> "237" .And. Len(_cAGENCIA) <= 5
	_cDIGVERI := "1" 
EndIf

If SE2->E2_PORTADO == "237" .And. _nSOMAVLR <= 1
	_cDIGVERI := "0"
EndIf
Return(_cDIGVERI)
