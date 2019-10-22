//#Include "RWMAKE.CH"	//#JN20140826.o
#Include "PROTHEUS.CH"	//#JN20140826.n

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PCTBA004  ºAutor  ³                    º Data ³  99/99/99   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada no lancamento padronizado de integração   º±±
±±º          ³ de baixa de contas a pagar LP 530 002 e estorno LP 531 002 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Exclusivo para Cesvi                                       º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Consultor   ³ Data       ³ Alteração                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jose Novaes ³ 26/08/2014 ³ #JN20140826 - Adequação ao plano de contas  ³±±
±±³            ³            ³ do empresa 34 - Saude.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jose Novaes ³ 02/01/2015 ³ #JN20150102 - Ajuste na conta de            ³±±
±±³            ³            ³ fornecedores empresa Brasil Participacoes   ³±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCTBA004()

Local _cConta := '2110301'	//FORNECEDORES NACIONAIS

If SM0->M0_CODIGO <> "34"	//#JN20140826.n
	
	_cConta	:= "2111100000"	//#JN20150102.n
	
	If alltrim(SE2->E2_NATUREZ) == "211002"	//PIS A RECOLHER
		_cConta := "2116400000"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "PIS"	//PIS S/TERCEIROS
		_cConta := "2112800001"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "IRF"	//IMPOSTO RENDA RETIDO NA FONTE
		_cConta := "2112200000"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "211003"	//COFINS A RECOLHER 7,6%
		_cConta := "2116300000"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "COFINS"	//COFINS S/TERCEIROS
		_cConta := "2112800002"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "CSLL"	//CSLL S/ TERCEIROS
		_cConta := "2112800003"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "ISS"	//IMPOSTO SOBRE SERVICOS
		
		//If alltrim(SE2->E2_ORIGEM) == "MATA460"	//MODULO DE FATURAMENTO	//#JN20140826.o
			_cConta := "2112300000"
			
		//EndIf	//#JN20140826.o
		
	EndIf

//#JN20140826.bn	
Else
	
	_cConta := "2182190110101"
	
	If alltrim(SE2->E2_NATUREZ) == "211002"
		_cConta := "2161190360102"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "PIS"
		_cConta := "2162190160101"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "IRF"
		_cConta := "2162190120101"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "211003"
		_cConta := "2161190360101"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "COFINS"
		_cConta := "2162190150101"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "CSLL"
		_cConta := "2162190140101"
	
	ElseIf alltrim(SE2->E2_NATUREZ) == "INSS"
		_cConta := "2162190170101"
		
	ElseIf alltrim(SE2->E2_NATUREZ) == "ISS"
		_cConta := "2162190130101"
		
	EndIf
	
EndIf
//#JN20140826.en

Return(_cConta)