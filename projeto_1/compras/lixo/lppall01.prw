#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

USER FUNCTION LPPALL01()

/*/                                                                           7
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � LPPALL01 � Autor � Edinilson             � Data � 17.06.09 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Para executar Lanc. Pad. do Faturamento (610/6300          ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Especifico PALL DO BRASIL - FELIPE DUARTE                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


_cConta   := ""
_aAlias   := getarea()
_Natureza := ""

cQuery := "SELECT E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA,E2_NATUREZ "
cQuery += " FROM "+retsqlname("SE2")+" WHERE E2_FILIAL = '"+XFILIAL("SE2")+"' AND E2_PREFIXO = '"+ SF1->F1_PREFIXO +"' AND E2_NUM = '"+SF1->F1_DUPL+"' "
cQuery += " AND E2_FORNECE = '"+SF1->F1_FORNECE+"' AND E2_LOJA = '"+SF1->F1_LOJA+"' AND E2_TIPO = '"+SF1->F1_ESPECIE+"' AND D_E_L_E_T_ = ''"
TCQUERY cQuery NEW ALIAS "QUERY"

_Natureza := QUERY->E2_NATUREZ

IF  !empty(_Natureza)
    Dbselectarea("SED")
    Dbsetorder(1)
    If  dbseek(xfilial("SED")+_Natureza)
        _cConta := SED->ED_CONTA
    Endif
Endif        
dbselectarea("QUERY")
dbclosearea()

restarea(_aAlias)
Return(_cConta)  