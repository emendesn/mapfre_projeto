#Include "protheus.CH"

// rotina utilizada no lancamento padronizado de integração de baixa de contas a pagar
// LP 530 002 e estorno LP 531 002

USER Function PCTBA005()

Local _cConta := '2124610001'

If alltrim(SE2->E2_NATUREZ) == "211002"
	_cConta := "2122330002"
ElseIf alltrim(SE2->E2_NATUREZ) == "PIS"   
	_cConta := "2122310007"
ElseIf alltrim(SE2->E2_NATUREZ) == "IRF"
	_cConta := "2122310004"
ElseIf alltrim(SE2->E2_NATUREZ) == "211003"  
	_cConta := "2122330003"
ElseIf alltrim(SE2->E2_NATUREZ) == "COFINS"
	_cConta := "2122310008"
ElseIf alltrim(SE2->E2_NATUREZ) == "CSLL"
	_cConta := "2122310009"
ElseIf alltrim(SE2->E2_NATUREZ) == "211004"
	_cConta := "2122330001"
ElseIf alltrim(SE2->E2_NATUREZ) == "ISS" 
	If alltrim(SE2->E2_ORIGEM) == "MATA460"
		_cConta := "2122330001"
	Else
		_cConta := "2122310002"
	EndIf
ElseIf alltrim(SE2->E2_NATUREZ) == "211005"
	_cConta := "2122320002"
ElseIf alltrim(SE2->E2_NATUREZ) == "INSS"
	_cConta := "2122310001"
EndIf

Return(_cConta)