#include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTB200DEL �Autor  �Microsiga           � Data �  06/02/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada para tratar a exclus�o da amarra��o        ���
���          �Moeda x Calend�rio. Chamada pelo CTBA200                    ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico para MSF                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CTB200DEL()

Local aArea		:= GetArea()
Local aParam	:= PARAMIXB
Local cQuery	:= ""
Local nReg		:= Recno()

If SM0->M0_CODIGO <> "01" .and. CTE->(!dbSeek(xFilial("CTE")+aParam[1]+aParam[2]))

	MsgAlert("A amarra��o Moeda x Calend�rio somente pode ser exclu�da atrav�s da empresa CESVI!")
	
	cQuery := "UPDATE " + RetSqlName("CTE") + " SET D_E_L_E_T_ = '', R_E_C_D_E_L = 0 "
	cQuery := "WHERE R_E_C_N_O_ = "+STR(nReg)
	TcSqlExec(cQuery)

EndIf

RestArea(aArea)

Return