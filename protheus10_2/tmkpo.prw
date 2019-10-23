#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

User Function Tmkpo()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("INCLUI,ALTERA,LGOTFOCUS,LPROSPECT,CALIASOLD,XPAD")

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
SETAPILHA()

inclui := .f.
altera := .f.
lGotFocus := .F. 	// desliga o gotfocus do oCliTmk
lProspect := .T.

cAliasOld:= Alias()

Dbselectarea("SUS")
xPad:=Conpad1("","","","TMP",cCliTmk,.F.)
   	
DbSelectarea(cAliasOld)
// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==> __Return(.T.)
Return(.T.)        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01


