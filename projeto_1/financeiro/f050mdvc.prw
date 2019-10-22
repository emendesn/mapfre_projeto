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
�������������������������������������������������������������������������Ĵ��
���Consultor   � Data       � Altera��o                                   ���
�������������������������������������������������������������������������Ĵ��
���Jose Novaes � 02/12/2014 � #JN20141202 - Ajuste para nao permitir data ���
���            �            � de vencimento posterior ao dia 20           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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