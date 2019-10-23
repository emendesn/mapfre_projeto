#Include "RWMAKE.CH"

// rotina utilizada no lancamento padronizado de integração de baixa de contas a pagar
// LP 530 001/002 e estorno LP 531 001/002

USER Function PCTBA002()

Local _cHist := "PGTO NF/FAT."

If alltrim(SE2->E2_NATUREZ) $ "IRF/IRFF/PIS/IR/COFINS/CSLL/ISS/INSS/IPTU/IPVA"
	_cHist := "RECOL."+alltrim(SE2->E2_NATUREZ)+" S/ NF. "
EndIf

Return(_cHist)