#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F060SEA2  �Autor  �Jose Novaes         � Data �  18/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �PE para gravacao do numero do bordero no campo E1_NODIA.    ���
���          �Tirar de uso assim que a TOTVS liberar a correcao do FINA150���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function f060sea2()

Reclock("SE1")
SE1->E1_NODIA := SEA->EA_NUMBOR
SE1->(MsUnlock())

Return()