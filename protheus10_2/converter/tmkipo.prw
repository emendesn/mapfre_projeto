/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �TMKPOS    � Autor �Luis Marcelo           � Data �12/12/98  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Cadastro de Prospects na escolha de clientes via F3         ���
���Descri��o �pela consulta "CLT" - no arquivo SXB (Consulta de clientes) ���
�������������������������������������������������������������������������Ĵ��
���Uso	    �TmkA010						                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/   

aRotina := { { "Incluir"   ,"AxInclui", 0 , 3} }

INCLUI := .T.
	
cAliasOld:= Alias()
lRet := .T.

cCadastro := "Cadastro de Prospects"
aTELA := {0,0}
aGETS	:= {0}
lRefresh := .T.

DbSelectarea("SUS")
setapilha()
nOpcA := AxInclui("SUS",RECNO(),1)
If nOpcA <> 1
	lProspect := .F.
Endif
   	
DbSelectarea(cAliasOld)
__Return(.T.)

