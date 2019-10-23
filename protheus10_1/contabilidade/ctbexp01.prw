#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBEXP01  บAutor  ณTrade               บ Data ณ  28/05/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para exportacao dados do Razao Contabil para o       บฑฑ
ฑฑบ          ณsistema de origem da Mapfre - SUN                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CESVI                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTBEXP01()
Local nOpc     := .F.
Private cPerg  := "CTBE01"
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

cQuery := "SELECT * FROM " + retsqlname("CT2")
cQuery += " WHERE CT2_FILIAL = '" + xFilial("CT2") + "'"
cQuery += " AND CT2_DEBITO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'"
cQuery += " AND CT2_DATA   BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "'"
cQuery += " AND D_E_L_E_T_ <> '*'"

cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), "TMP", .F., .T.)

dbSelectArea("TMP")
DbEval({|| nContReg++})
ProcRegua(nContReg)

TMP->(DbGoTop())

Do While !TMP->(Eof())
	IncProc()
	cLin := SUBS(TMP->CT2_DEBITO,1,10)
	cLin += Space(05)
	cLin += StrZero(Year(MV_PAR04),4) + "00" + StrZero(Month(MV_PAR04),2)
	cLin += TMP->CT2_DATA
	cLin += Space(02)
	cLin += "F00"
	cLin += Space(12)
	cLin += StrZero((TMP->CT2_VALOR*100),17) + "0"
	cLin += "D"
	cLin += Space(01)
	cLin += "00000"
	cLin += Space(05)
	cLin += Space(10)
	cLin += Space(05)
	cLin += Subs(TMP->CT2_HIST,1,25)
	cLin += DTOS(dDataBase)
	cLin += StrZero(Year(MV_PAR04),4) + "00" + StrZero(Month(MV_PAR04),2)
    cLin += Space(14)
	cLin += Repl("0",24)
	cLin += Space(21)
	cLin += Repl("0",36)
	cLin += Space(21) + cEOL
	
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
		    lErro := .T.
			Return
		Endif
	EndIf
	
	TMP->(dbSkip())
EndDo

TMP->(DbCloseArea())

cQuery := "SELECT * FROM " + retsqlname("CT2")
cQuery += " WHERE CT2_FILIAL = '" + xFilial("CT2") + "'"
cQuery += " AND CT2_CREDIT BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'"
cQuery += " AND CT2_DATA   BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "'"
cQuery += " AND D_E_L_E_T_ <> '*'"

cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), "TMP", .F., .T.)

dbSelectArea("TMP")
DbEval({|| nContReg++})
ProcRegua(nContReg)

TMP->(DbGoTop())

Do While !TMP->(Eof())
	IncProc()
	cLin := SUBS(TMP->CT2_CREDIT,1,10)
	cLin += Space(05)
	cLin += StrZero(Year(MV_PAR04),4) + "00" + StrZero(Month(MV_PAR04),2)
	cLin += TMP->CT2_DATA
	cLin += Space(02)
	cLin += "F00"
	cLin += Space(12)
	cLin += StrZero((TMP->CT2_VALOR*100),17) + "0"
	cLin += "C"
	cLin += Space(01)
	cLin += "00000"
	cLin += Space(05)
	cLin += Space(10)
	cLin += Space(05)
	cLin += Subs(TMP->CT2_HIST,1,25)
	cLin += DTOS(dDataBase)
	cLin += StrZero(Year(MV_PAR04),4) + "00" + StrZero(Month(MV_PAR04),2)
    cLin += Space(14)
	cLin += Repl("0",24)
	cLin += Space(21)
	cLin += Repl("0",36)
	cLin += Space(14) + cEOL
	
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
		    lErro := .T.
			Return
		Endif
	EndIf
	
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
AAdd(aRegs,{cPerg,"01","Conta De"		,"E","I","mv_ch1","C",20,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","CT1",""})
AAdd(aRegs,{cPerg,"02","Conta Ate"      ,"E","I","mv_ch2","C",20,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","CT1",""})
AAdd(aRegs,{cPerg,"03","Periodo De"     ,"E","I","mv_ch3","D",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"04","Periodo Ate"    ,"E","I","mv_ch4","D",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"05","Caminho/Arquivo","E","I","mv_ch5","C",99,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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