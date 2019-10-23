//#INCLUDE "RWMAKE.CH"	//#JN20140831.o
//#INCLUDE "TOPCONN.CH"	//#JN20140831.o
#INCLUDE "PROTHEUS.CH"	//#JN20140831.n

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PATIR001 ³ Autor ³ Gilberto Alvarenga    ³ Data ³Maio/2004 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rela‡„o de controle Patrimonial                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Microsiga Cesvi                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Data      ³ Alteracao                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³31/08/2014³ #JN20140831 - Revisao de Fonte - Migracao P11              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PATIR001()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local   cDesc1   := AnsiToOem("Este programa irá emitir a Rela‡ão de Controle de Patrimonial,")
Local   cDesc2   := AnsiToOem("conforme parâmetros")
Local   cDesc3   := AnsiToOem("")
Private wnrel    := "PATIR001"
Private nomeprog := "PATIR001"
//Private cPerg    := "ATIR01"	//#JN20140831.o
Private cPerg    := Padr("ATIR01",Len(SX1->X1_GRUPO))	//#JN20140831.n
Private tamanho  := "G"
Private limite   := 220
Private lAbortPrint  := .F.
Private cString  := "SN3"
Private titulo   := OemToAnsi("RELACAO DE CONTROLE PATRIMONIAL")
Private cabec1   := ""
Private cabec2   := ""
Private cbtxt    := SPACE(10)
Private cbcont   := 0
Private m_pag    := 1
Private cNomeArq := ""
Private aReturn  := { OemToAnsi("Zebrado"), 1,OemToAnsi("Administracao"), 1, 2, 1, "",1 }
Private nLastKey := 0

AjustaSX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01            // da data da baixa                  ³
//³ mv_par02            // at‚ a data da baixa               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo += " - Periodo: " + dtoc(mv_par05) + " a " + dtoc(mv_par06)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If nLastKey == 27
	Return(Nil)
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return(Nil)
EndIf

cFilterUser := aReturn[7]

RptStatus({|| ATR01Imp()},Titulo)

Return(Nil)


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
//±±³Fun‡„o    ³ ATR01Imp ³ Autor ³ Gilberto Alvarenga    ³ Data ³Maio/2004 ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Descri‡„o ³ Impressao do Relatorio PATIR001                            ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Sintaxe e ³ ATR01Imp(lEnd,wnRel,cString)                               ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
//±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
//±±³          ³ cString - Mensagem                                         ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
//±±³ Uso      ³ Gen‚rico                                                   ³±±
//±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
Static Function ATR01Imp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local lContinua  := .T.
Local _nAcGOri   := 0
Local _nAcGDMes  := 0
Local _nAcGDAcu  := 0
Local _nAcGSaldo := 0
Local _nAcGBaixa := 0
Local _nAcOri    := 0
Local _nAcDMes   := 0
Local _nAcDAcu   := 0
Local _nAcSaldo  := 0
Local _nAcBaixa  := 0
Local _nSaldoBem := 0
Local _dData     := ""
Local _nTotalBx  := 0
Local _cBemAnt   := ""
Local _cGrupoAnt := ""
Local _lListaBx  := IIF(mv_par07 == 1, .T., .F.)
Local _nCtGer    := 0
Local _nCtGru    := 0
local _nTotalRegs := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cEmpresa := ALLTRIM(SM0->M0_NOME)

Titulo := ALLTRIM(Titulo) + " - "+_cEmpresa

DbSelectArea("SN3")

_cQuery := "SELECT "
_cQuery += "N1_GRUPO, N1_CBASE, N1_ITEM, N1_DESCRIC, N1_AQUISIC, N1_BAIXA, N1_NFISCAL, "
_cQuery += "N3_CBASE, N3_ITEM, N3_VORIG1, N3_VRDMES1, N3_VRDACM1, N3_DTBAIXA, N3_CCONTAB, "
_cQuery += "N3_TXDEPR1, N3_DINDEPR, N3_CCDEPR "
_cQuery += " FROM "+ RetSqlName('SN1')+" SN1, "
_cQuery +=           RetSqlName('SN3')+" SN3  "
_cQuery += " WHERE "
_cQuery += " SN1.N1_FILIAL = '" + xFilial("SN1")+"' "
_cQuery += " AND SN3.N3_FILIAL = '" + xFilial("SN3")+"' "	//#JN20140831.n
_cQuery += " AND SN1.D_E_L_E_T_ <> '*' AND SN3.D_E_L_E_T_ <> '*' "
_cQuery += " AND SN1.N1_CBASE  =  SN3.N3_CBASE "
_cQuery += " AND SN1.N1_ITEM   =  SN3.N3_ITEM  "
_cQuery += " AND SN1.N1_GRUPO   >= '"+mv_par01+"' AND SN1.N1_GRUPO <= '"+mv_par02+"'"
_cQuery += " AND SN1.N1_CBASE   >= '"+mv_par03+"' AND SN1.N1_CBASE <= '"+mv_par04+"'"

If !_lListaBx
	_cQuery += " AND SN1.N1_AQUISIC BETWEEN '"+DTOS(mv_par05)+"' AND '"+DTOS(mv_par06)+"'"
	_cQuery += " AND SN1.N1_BAIXA = ''"
Else
	_cQuery += " AND (SN1.N1_AQUISIC BETWEEN '"+DTOS(mv_par05)+"' AND '"+DTOS(mv_par06)+"'"
	_cQuery += " OR SN1.N1_BAIXA BETWEEN '"+DTOS(mv_par05)+"' AND '"+DTOS(mv_par06)+"')"
EndIf

_cQuery += " ORDER BY N1_GRUPO, N1_AQUISIC"
_cQuery :=  ChangeQuery(_cQuery)
DbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQuery), "TRB", .F.,.F.)	//#JN20140831.n
//TCQUERY _cQuery NEW ALIAS "TRB"	//#JN20140831.o

//  Leiaute do Relatorio
//         |....:....1....:....2....:....3....:....4....:....5....:....6....:....7....:....8....:....9....:....0....:....1....:....2....:....3....:....4....:....5....:....6....:....7....:....8....:....9....:....0....:....1
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
cabec1 := "Grupo Codigo     Item  Descricao                                 Conta              Data          Valor  Conta          Depreciacao    Depreciacao      Saldo a     Data      Valor da    Nota     Taxa de   Data Inicio"
cabec2 := "      Bem                                                        Contabil      Aquisicao       Original  Depr/Amort          no Mes      Acumulada    Depreciar    Baixa         Baixa   Fiscal  Depreciacao Depreciacao"
//         1234  1234567890/1234  1234567890123456789012345678901234567890  1234567890     99/99/99 999,999,999.99  1234567890 999,999,999.99 999,999,999.99 999,999,999.99 99/99/99 999,999,999.99  XXXXXX     999,9999     99/99/99
//

SetPrc(80,01)

dbSelectArea("TRB")
dbGoTop()
TRB->((DbEval({|| ++_nTotalRegs }),DbGotop()))
SetRegua(_nTotalRegs)

_nAcGOri   := 0
_nAcGDMes  := 0
_nAcGDAcu  := 0
_nAcGSaldo := 0
_nAcGBaixa := 0
_nCtGer    := 0

While !Eof() .and. lContinua
	
	If lAbortPrint
		@Prow()+2,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		lContinua := .F.
		Exit
	Endif
	
	_cGrupoAnt := TRB->N1_GRUPO
	
	_nAcOri   := 0
	_nAcDMes  := 0
	_nAcDAcu  := 0
	_nAcSaldo := 0
	_nAcBaixa := 0
	_nCtGru   := 0
	
	While !Eof() .and. lContinua .and. _cGrupoAnt == TRB->N1_GRUPO
		
		IncRegua("Imprimindo o Relatorio ...")
		
		If lAbortPrint
			@Prow()+2,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			lContinua := .F.
			Exit
		Endif
		
		If Prow() > 58
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		EndIf
		
		_cBemAnt   := TRB->N1_CBASE +  TRB->N1_ITEM
		_nTotalBx  := 0
		_nAcuDep   := 0 // Depreciacao Acumulada
		_nMesDep   := 0 // Depreciacao Mes
		
		@Prow()+1,0 PSAY ''
		@Prow(),000 PSAY TRB->N1_GRUPO
		@Prow(),006 PSAY TRB->N3_CBASE + "/" + TRB->N3_ITEM
		@Prow(),023 PSAY SUBSTR(TRB->N1_DESCRIC,1,40)
		@Prow(),065 PSAY TRB->N3_CCONTAB
		@Prow(),081 PSAY SUBSTR(TRB->N1_AQUISIC,7,2)+"/"+SUBSTR(TRB->N1_AQUISIC,5,2)+"/"+SUBSTR(TRB->N1_AQUISIC,3,2)
		@Prow(),090 PSAY TRB->N3_VORIG1  Picture "@E 999,999,999.99"
		@Prow(),107 PSAY ALLTRIM(TRB->N3_CCDEPR)
		
		DbSelectArea("SN4")
		dbSetOrder(1)
		dbSeek(xFilial("SN4")+_cBemAnt)
		
		While !Eof() .and. _cBemAnt == (SN4->N4_CBASE +  SN4->N4_ITEM)
			
			If _lListaBx .And. SN4->N4_OCORR == '01' .and. SN4->N4_TIPOCNT == '1'
				_nTotalBx += SN4->N4_VLROC1
			EndIf
			
			If SN4->N4_OCORR $ '05/06' .and. SN4->N4_TIPOCNT $ '3' .And. SN4->N4_DATA <= MV_PAR08
				_nAcuDep += SN4->N4_VLROC1
				If DTOS(SN4->N4_DATA) >= Subs(DTOS(MV_PAR08),1,6)+"01" .And. DTOS(SN4->N4_DATA) <= DTOS(MV_PAR08)
					_nMesDep += SN4->N4_VLROC1
				EndIf
			EndIf
			
			DbSelectArea("SN4")
			SN4->(DbSkip())
			
		EndDo
		
		@Prow(),117 PSAY _nMesDep Picture "@E 999,999,999.99"
		@Prow(),131 PSAY _nAcuDep Picture "@E 999,999,999.99"
		
		_nSaldoBem := TRB->N3_VORIG1  - _nAcuDep
		
		@Prow(),146 PSAY _nSaldoBem      Picture "@E 999,999,999.99"
		@Prow(),161 PSAY SUBSTR(TRB->N1_BAIXA,7,2)+"/"+SUBSTR(TRB->N1_BAIXA,5,2)+"/"+SUBSTR(TRB->N1_BAIXA,3,2)
		@Prow(),170 PSAY _nTotalBx          Picture "@E 999,999,999.99"
		@Prow(),186 PSAY TRB->N1_NFISCAL
		@Prow(),197 PSAY TRB->N3_TXDEPR1    Picture "@E 999.9999"
		@Prow(),209 PSAY STOD(TRB->N3_DINDEPR)
		
		_nAcOri   += TRB->N3_VORIG1
		_nAcDMes  += _nMesDep
		_nAcDAcu  += _nAcuDep
		_nAcSaldo += _nSaldoBem
		_nAcBaixa += _nTotalBx
		_nCtGru   +=  1
		
		DbSelectArea("TRB")
		TRB->(DbSkip())
		
	EndDo   // Grupo
	
	If Prow() > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	EndIf
	
	@Prow()+2,0 PSAY 'TOTAL DO GRUPO'
	@Prow(),089 PSAY _nAcOri    Picture "@E 999,999,999.99"
	@Prow(),116 PSAY _nAcDMes   Picture "@E 999,999,999.99"
	@Prow(),130 PSAY _nAcDAcu   Picture "@E 999,999,999.99"
	@Prow(),145 PSAY _nAcSaldo  Picture "@E 999,999,999.99"
	@Prow(),169 PSAY _nAcBaixa  Picture "@E 999,999,999.99"
	
	@Prow()+1,0 PSAY 'QUANTIDADE DE BENS'
	@Prow(),089 PSAY TRANSFORM(_nCtGru, "@E 999,999,999")
	@Prow()+1,0 PSAY __PrtThinLine()
	
	_nAcGOri   += _nAcOri
	_nAcGDMes  += _nAcDMes
	_nAcGDAcu  += _nAcDAcu
	_nAcGSaldo += _nAcSaldo
	_nAcGBaixa += _nAcBaixa
	_nCtGer    += _nCtGru
	
EndDo

If Prow() <> 80
	
	If Prow() > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	EndIf
	
	@Prow()+2,0 PSAY 'TOTAL GERAL'
	@Prow(),089 PSAY _nAcGOri    Picture "@E 999,999,999.99"
	@Prow(),116 PSAY _nAcGDMes   Picture "@E 999,999,999.99"
	@Prow(),130 PSAY _nAcGDAcu   Picture "@E 999,999,999.99"
	@Prow(),145 PSAY _nAcGSaldo  Picture "@E 999,999,999.99"
	@Prow(),169 PSAY _nAcGBaixa  Picture "@E 999,999,999.99"
	
	@Prow()+1,0 PSAY 'QUANTIDADE DE BENS'
	@Prow(),089 PSAY TRANSFORM(_nCtGer, "@E 999,999,999")
	Roda(cbCont,CbTxt,Tamanho)
	
	SET DEVICE TO SCREEN
	
	If aReturn[5] == 1
		Set Printer to
		dbCommit()
		OurSpool(wnrel)
	Endif
	
EndIf

dbSelectArea("TRB")
DbCloseArea("TRB")

dbSelectArea("SN1")
dbSetOrder(1)

dbSelectArea("SN3")
dbSetOrder(1)

MS_FLUSH()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AjustaSX1³ Autor ³                       ³ Data ³ 26/09/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ FINR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustaSX1()
Local _aArea  := GetArea()
Local _Nx     := 0
Local _aRegs  := {}
Local _cOrdem := 1
//cPerg  := PADR(cPerg,len(sx1->x1_grupo))	//#JN20140831.o

AAdd(_aRegs,{OemToansi("Do Grupo           ?"),OemToansi("Do Grupo           ?"),OemToansi("Do Grupo           ?"),"mv_ch1","C", 4,0,0,"G","","mv_par01","","","","","","","","","SZE",""})
AAdd(_aRegs,{OemToansi("Ate o Grupo        ?"),OemToansi("Ate o Grupo        ?"),OemToansi("Ate o Grupo        ?"),"mv_ch2","C", 4,0,0,"G","","mv_par02","","","",REPLICATE("Z",4),"","","","","SZE",""})
AAdd(_aRegs,{OemToansi("Do Bem             ?"),OemToansi("Do Bem             ?"),OemToansi("Do Bem             ?"),"mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","SN1",""})
AAdd(_aRegs,{OemToansi("Ate o Bem          ?"),OemToansi("Ate o Bem          ?"),OemToansi("Ate o Bem          ?"),"mv_ch4","C",10,0,0,"G","","mv_par04","","","",REPLICATE("Z",10),"","","","","SN1",""})
AAdd(_aRegs,{OemToansi("Data Aquisicao de   "),OemToansi("Data Aquisicao de   "),OemToansi("Data Aquisicao de   "),"mv_ch5","D", 8,0,0,"G","","mv_par05","","","","","","","","","",""})
AAdd(_aRegs,{OemToansi("Data Aquisicao ate  "),OemToansi("Data Aquisicao ate  "),OemToansi("Data Aquisicao ate  "),"mv_ch6","D", 8,0,0,"G","","mv_par06","","","","","","","","","",""})
AAdd(_aRegs,{OemToansi("Lista Baixados     ?"),OemToansi("Lista Baixados     ?"),OemToansi("Lista Baixados     ?"),"mv_ch7","C", 1,0,0,"C","","mv_par07","Sim","","","","","Nao","","","",""})
AAdd(_aRegs,{OemToansi("Posicao de Deprec.em"),OemToansi("Posicao de Deprec.em"),OemToansi("Posicao de Deprec.em"),"mv_ch8","D", 8,0,0,"G","","mv_par08","","","","","","","","","",""})

dbSelectArea("SX1")
dbSetOrder(1)
For _Nx:=1 to Len(_aRegs)
	_cOrdem := StrZero(_Nx,2)
	If !MsSeek(cPerg+_cOrdem)
		RecLock("SX1",.T.)
		SX1->X1_GRUPO	  := cPerg
		SX1->X1_ORDEM	  := _cOrdem
		SX1->X1_PERGUNTE := _aRegs[_Nx][01]
		SX1->X1_PERSPA	  := _aRegs[_Nx][02]
		SX1->X1_PERENG	  := _aRegs[_Nx][03]
		SX1->X1_VARIAVL  := _aRegs[_Nx][04]
		SX1->X1_TIPO	  := _aRegs[_Nx][05]
		SX1->X1_TAMANHO  := _aRegs[_Nx][06]
		SX1->X1_DECIMAL  := _aRegs[_Nx][07]
		SX1->X1_PRESEL	  := _aRegs[_Nx][08]
		SX1->X1_GSC		  := _aRegs[_Nx][09]
		SX1->X1_VALID	  := _aRegs[_Nx][10]
		SX1->X1_VAR01	  := _aRegs[_Nx][11]
		SX1->X1_DEF01	  := _aRegs[_Nx][12]
		SX1->X1_DEFSPA1  := _aRegs[_Nx][13]
		SX1->X1_DEFENG1  := _aRegs[_Nx][14]
		SX1->X1_CNT01	  := _aRegs[_Nx][15]
		SX1->X1_VAR02	  := _aRegs[_Nx][16]
		SX1->X1_DEF02	  := _aRegs[_Nx][17]
		SX1->X1_DEFSPA2  := _aRegs[_Nx][18]
		SX1->X1_DEFENG2  := _aRegs[_Nx][19]
		SX1->X1_F3		  := _aRegs[_Nx][20]
		SX1->X1_GRPSXG	  := _aRegs[_Nx][21]
		MsUnlock()
	Endif
Next
RestArea(_aArea)

Return NIL