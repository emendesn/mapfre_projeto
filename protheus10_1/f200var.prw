#INCLUDE "RWMAKE.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � F200var � Autor � Murilo                 � Data � 14/07/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorno da comunica��o banc�ria  HSBC                      ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � FinA200()                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
�������������������������������������������������������������������������Ĵ��
���			ATUALIZACOES SOFRIDAS                                          ��
��� POR RILDO OLIVEIRA EM 21-09-09: 									   ��
��� ALTERADA A VARIAVEL _cPrefixo := MV_PAR13 PARA MV_PAR14 EM FUNCAO DE   ��
��  BT QUE CRIA O MV_PAR13 PADRAO DA ROTINA                                ��
�������������������������������������������������������������������������Ĵ��
���                                                                       ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function F200var()

If alltrim(mv_par05) == 'HSBCR.RET'
	_cParcela := SUBSTR(cNumTit,7,1)
	
	If _cParcela='1'
		_cParc:='A'
	Elseif _cParcela='2'
		_cParc:='B'
	Elseif _cParcela='3'
		_cParc:='C'
	Elseif _cParcela='4'
		_cParc:='D'
	Elseif _cParcela='5'
		_cParc:='E'
	Elseif _cParcela='6'
		_cParc:='F'
	Elseif _cParcela='7'
		_cParc:='G'
	Elseif _cParcela='8'
		_cParc:='H'
	Elseif _cParcela='9'
		_cParc:='I'
	Elseif _cParcela='0'
		_cParc:=' '
	Endif
	
	_cPrefixo := MV_PAR14
	
	cNumTit := _cPrefixo+substr(cNumTit,1,6)+_cParc
EndIf

Return