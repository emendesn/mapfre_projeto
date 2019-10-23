#include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFINEXP01  บAutor  ณTrade Consulting    บ Data ณ  17/07/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para exportar os dados do contas a pagar SE2, que    บฑฑ
ฑฑบ          ณtenham codigo de barras do documentum                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Cesvi Brasil                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FinExp01()

Local nOpc     := .F.
Private cPerg  := "FINE01"
Private lErro  := .F.

ValidPerg()
nOpc := Pergunte(cPerg, .T.)

If nOpc
	Processa({|| ProcExp()},"Gera็ใo do Arquivo")
    If lErro
       MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
    Else
	   Aviso("Aten็ใo","Processo concluํdo com sucesso.",{"Ok"})
	EndIf   
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPROCEXP   บAutor  ณTrade               บ Data ณ  17/09/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina auxiliar na geracao do arquivo                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Mapfre Seguros                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcExp(lAutom)
Local cArquivo  := MV_PAR05
Local nContReg  := 0

Private cEOL    := "CHR(13)+CHR(10)"
Private nHdl    := fCreate(cArquivo)

If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

If nHdl == -1
	MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
	lErro := .T.
	Return
Endif

cQuery := "SELECT * FROM " + retsqlname("SE2")
cQuery += " WHERE E2_FILIAL = '" + xFilial("SE2") + "'"
cQuery += " AND E2_CODDOC  BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'"
cQuery += " AND E2_VENCREA BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "'"
cQuery += " AND E2_CODDOC <> '      '"
cQuery += " AND D_E_L_E_T_ <> '*'"

cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), "TMP", .F., .T.)

dbSelectArea("TMP")
DbEval({|| nContReg++})
ProcRegua(nContReg)

TMP->(DbGoTop())

nLinha := 1

Do While !TMP->(Eof())
	IncProc()
	cLin := StrZero(nLinha,5)
	cLin += Posicione("SA2",1,xFilial("SA2")+TMP->E2_FORNECE+TMP->E2_LOJA,"A2_CGC")
    cLin += " "
    cLin += Subs(Posicione("SA2",1,xFilial("SA2")+TMP->E2_FORNECE+TMP->E2_LOJA,"A2_NOME"),1,30)
    cLin += TMP->E2_NUM
    cLin += Right(TMP->E2_VENCREA,2,1) + Subs(TMP->E2_VENCREA,5,2) + Subs(TMP->E2_VENCREA,1,4)
    cLin += SM0->M0_CGC
    cLin += " "
    cLin += Subs(SM0->M0_NOMECOM,1,30)
    cLin += Right(TMP->E2_EMISSAO,2,1) + Subs(TMP->E2_EMISSAO,5,2) + Subs(TMP->E2_EMISSAO,1,4)    
    cLin += StrZero(TMP->E2_VALOR * 100, 18)
    cLin += StrZero(TMP->E2_VALOR * 100, 18)
    cLin += StrZero(Val(TMP->E2_CODDOC),20) + cEOL   
	
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")   
		    lErro := .T.
			Return
		Endif
	EndIf
	nLinha ++
	TMP->(dbSkip())
EndDo

TMP->(DbCloseArea())

fClose(nHdl)

Return Nil

/*
+------------+----------+-------+-----------------------+------+----------+
|  Funcao    |ValidPerg | Autor |Microsiga              | Data | 04/12/00 |
+------------+----------+-------+-----------------------+------+----------+
|  Descricao | Ajusta Grupo de Perguntas                                  |
+------------+------------------------------------------------------------+
*/
Static Function ValidPerg()
Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg  := PADR(cPerg,len(sx1->x1_grupo))

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AAdd(aRegs,{cPerg,"01","Cod. Barra De"		,"E","I","mv_ch1","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"02","Cod. Barra Ate"		,"E","I","mv_ch2","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"03","Vencimento De"  	,"E","I","mv_ch3","D",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"04","Vencimento Ate"		,"E","I","mv_ch4","D",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"05","Caminho/Arquivo"	,"E","I","mv_ch5","C",99,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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