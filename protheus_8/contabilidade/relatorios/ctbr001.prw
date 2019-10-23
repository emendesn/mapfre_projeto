#include "protheus.ch"
#include "topconn.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTBR001   � Autor � Trade Consulting   � Data �  29/09/08   ���
�������������������������������������������������������������������������͹��
���Descricao � Relacao dos lancamentos efetuados diretamente no modulo    ���
���          � CTB - Auditoria                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CESVI Brasil                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CTBR001()

Local cDesc1		:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2		:= "de acordo com os parametros informados pelo usuario."
Local cDesc3		:= "RELACAO DOS LANCAMENTOS MANUAIS - CTB"
Local cPict			:= ""
Local titulo		:= "RELACAO DOS LANCAMENTOS MANUAIS - CTB"
Local nLin			:= 80
Local Cabec1		:= "Data      Debito      Credito             Valor  Historico                                 Usuario          Rotina"
Local Cabec2		:= ""
Local imprime		:= .T.
Local aOrd			:= {}
Private lEnd		:= .F.
Private lAbortPrint	:= .F.
Private CbTxt		:= ""
Private limite		:= 80
Private tamanho		:= "M"
Private nomeprog	:= "CTBR001"
Private nTipo		:= 18
Private aReturn		:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey	:= 0
Private cbtxt		:= Space(10)
Private cbcont		:= 00
Private CONTFL		:= 01
Private m_pag		:= 01
Private wnrel		:= "CTBR001"
Private cPerg		:= "CTBR01"
Private cString		:= "CT2"

ValidPerg()
pergunte(cPerg,.T.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  03/07/07   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
Local nTotal := 0    

dIni := DTOS(MV_PAR01)
dFim := DTOS(MV_PAR02)

cQuery := "SELECT CT2_DATA, CT2_DEBITO, CT2_CREDIT, CT2_VALOR, CT2_HIST, CT2_USERGI, CT2_USERGA, CT2_ROTINA FROM" + RetSqlName("CT2")
cQuery += " WHERE CT2_DATA BETWEEN '" + dIni + "' AND '" + dFim + "'"
cQuery += " AND CT2_ROTINA LIKE 'CTBA%' AND D_E_L_E_T_ <> '*' " 
cQuery += " AND CT2_USERGI <> ' '"

cQuery := ChangeQuery(cQuery)
TCQUERY cQuery NEW ALIAS "TMP"

dbSelectArea("TMP")
SetRegua(RecCount())
dbGoTop()

Do While !EOF()
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif

	IncRegua()

	If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif

	@ nLin,000 PSAY STOD(TMP->CT2_DATA)
	@ nLin,010 PSAY Subs(TMP->CT2_DEBITO,1,10)
	@ nLin,022 PSAY Subs(TMP->CT2_CREDIT,1,10)
	@ nLin,034 PSAY TMP->CT2_VALOR	                PICTURE "@E 99,999,999.99"
	@ nLin,049 PSAY TMP->CT2_HIST
	@ nLin,091 PSAY Subs(Embaralha(TMP->CT2_USERGI,1),1,15)  
	@ nLin,108 PSAY TMP->CT2_ROTINA
	
	nLin ++
	dbSkip()

EndDo

If nLin <> 80
   @ nLin,000 PSAY __PrtThinLine()
   Roda(cbcont,cbtxt,Tamanho)
EndIf

SET DEVICE TO SCREEN

dbSelectArea("TMP")
dbCloseArea()

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ValidPerg � Autor �Microsiga              � Data � 04/12/00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta Grupo de Perguntas                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ValidPerg
Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg  := PADR(cPerg,len(sx1->x1_grupo))

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AAdd(aRegs,{cPerg,"01","Data Inicial","E","I","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"02","Data Final  ","E","I","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
dbSelectArea(_sAlias)
Return