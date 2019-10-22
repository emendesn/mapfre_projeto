#Include "RWMake.ch"

/*
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������ͻ��
���Programa  � CNABINFO   �Autor  � Emerson Custodio   �Data  � 01/03/04    ���
���������������������������������������������������������������������������͹��
���Descri��o � Identifica as informacoes complementares do codigo de barra. ���
���          �                                                              ���
���������������������������������������������������������������������������͹��
���Altera��es� dd/mm/aa - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     ���
���          � dd/mm/aa - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     ���
���          � dd/mm/aa - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     ���
���������������������������������������������������������������������������͹��
���Uso       � AP710 - Financeiro / Mapfre                                  ���
���������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
*/

User Function CNABINFO()

Local cRet

Do Case
	Case SubStr(SEA->EA_MODELO,1,2) $ "03/41/43"
		cRet := Iif(SA2->A2_CGC==SM0->M0_CGC,"D","C")+"000000"+"01"+"01"+Space(29)
		
	Case SubStr(SEA->EA_MODELO,1,2) $ "31/30"
		cRet := SubStr(SE2->E2_CODBAR,20,25)+SubStr(SE2->E2_CODBAR,05,01)+SubStr(SE2->E2_CODBAR,04,01)+Space(13)
		
	OtherWise
		cRet := Space(40)
		
EndCase

Return(cRet)