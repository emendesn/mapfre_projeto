#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

User Function Tmkva1()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �TMKVA1    � Autor �Luis Marcelo           � Data �12/12/98  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Cadastro do Prospect selecionado para o Cadastro de Clientes���
���          �quando for um FATURAMENTO. Depois de incluido no SA1 apagar ���
���          �do SUS o prospect.                                          ���
�������������������������������������������������������������������������Ĵ��
���Uso	    �TmkA010						                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/   

DbSelectarea("SUS")
DbSetorder(1)
If DbSeek(xFilial("SUS")+cCliTmk+cLoja)

	DbSelectarea("SA1")
	Reclock("SA1",.T.)
	SA1->A1_FILIAL := SUS->US_FILIAL
	SA1->A1_COD 	:= SUS->US_COD
	SA1->A1_LOJA	:= SUS->US_LOJA
	SA1->A1_NOME	:= SUS->US_NOME
	SA1->A1_NREDUZ	:= SUS->US_NREDUZ
	SA1->A1_MUN		:= SUS->US_MUN
	SA1->A1_END		:= SUS->US_END
	SA1->A1_EST		:= SUS->US_EST
	SA1->A1_TIPO	:= SUS->US_TIPO
	SA1->A1_CODHIST:= SUS->US_CODHIST
	Do Case
		case (SUS->US_SATIV) == "1"
			  SA1->A1_SATIV1 := "1"
			  
		case (SUS->US_SATIV) == "2"
			  SA1->A1_SATIV2 := "1"
			  		
		case (SUS->US_SATIV) == "3"
			  SA1->A1_SATIV3 := "1"
			  
		case (SUS->US_SATIV) == "4"
			  SA1->A1_SATIV4 := "1"
			  
		case (SUS->US_SATIV) == "5"
			  SA1->A1_SATIV5 := "1"
			  
		case (SUS->US_SATIV) == "6"
			  SA1->A1_SATIV6 := "1"
			  
		case (SUS->US_SATIV) == "7"
			  SA1->A1_SATIV7 := "1"
			  
		case (SUS->US_SATIV) == "8"		
			  SA1->A1_SATIV8 := "1"
	Endcase

	Dbcommit()
	MsUnlock()

	Reclock( "SUS" ,.F.,.T.)
	DbDelete()
	WriteSx2("SUS")
	MsUnlock()
Endif

// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==> __Return(.T.)
Return(.T.)        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01
