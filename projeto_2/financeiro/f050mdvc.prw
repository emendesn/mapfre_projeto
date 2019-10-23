#include "Protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F050MDVC  �Autor  �Jose Novaes         � Data �  09/06/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para altera��o da data de vencimento dos   ���
���          �t�tulos de impostos. Desenvolvido para deixar o vencimento  ���
���          �dos t�tulos de INSS de PF igual ao de PJ. INC000004343296   ���
���          �PARAMIXB := {dNextDay,cImposto,dEmissao,dEmis1,dVencRea}    ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico para CESVI                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F050MDVC()

Local _dNextDay	:= ParamIXB[1]
Local _cNextDay	:= DTOC(_dNextDay)
Local _cImposto := ParamIXB[2]

If	_cImposto == "INSS" .and. Left(_cNextDay,2) < "20"
	_cNextDay	:= "20"+Substr(_cNextDay,3)
	_dNextDay	:= DataValida(CTOD(_cNextDay),.T.)		
EndIf

Return (_dNextDay)