#include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณF050MDVC  บAutor  ณJose Novaes         บ Data ณ  09/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para altera็ใo da data de vencimento dos   บฑฑ
ฑฑบ          ณtํtulos de impostos. Desenvolvido para deixar o vencimento  บฑฑ
ฑฑบ          ณdos tํtulos de INSS de PF igual ao de PJ. INC000004343296   บฑฑ
ฑฑบ          ณPARAMIXB := {dNextDay,cImposto,dEmissao,dEmis1,dVencRea}    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico para CESVI                                       บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณConsultor   ณ Data       ณ Altera็ใo                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณJose Novaes ณ 02/12/2014 ณ #JN20141202 - Ajuste para nao permitir data ณฑฑ
ฑฑณ            ณ            ณ de vencimento posterior ao dia 20           ณฑฑ
ฑฑศออออออออออออฯออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function F050MDVC()

Local _dNextDay	:= ParamIXB[1]
Local _cNextDay	:= DTOC(_dNextDay)
Local _cImposto := ParamIXB[2]
Local _cDia		:= GetMV("MV_XDINSS",,"20")	//#JN20141202.n

//If	_cImposto == "INSS" .and. Left(_cNextDay,2) < "20"	//#JN20141202.o
If	_cImposto == "INSS" .and. Left(_cNextDay,2) < _cDia	//#JN20141202.n
	_cNextDay	:= _cDia+Substr(_cNextDay,3)
	_dNextDay	:= DataValida(CTOD(_cNextDay),.T.)
	While Day(_dNextDay) > Val(_cDia)	//#JN20141202.n
		_cDia		:= Strzero(Val(_cDia)-1,2)	//#JN20141202.n
		_cNextDay	:= _cDia+Substr(_cNextDay,3)	//#JN20141202.n
		_dNextDay	:= DataValida(CTOD(_cNextDay),.T.)	//#JN20141202.n
	EndDo	//#JN20141202.n
EndIf

Return (_dNextDay)