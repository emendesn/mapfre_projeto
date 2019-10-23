#include "rwmake.ch"
#include "TOPCONN.ch"

User Function PFINR100()

LOCAL cDesc1 := "Este relatorio destaca a posicao de faturamento por"
LOCAL cDesc2 := "cliente."
LOCAL cDesc3 := " "

PRIVATE titulo   :="Rela豫o de Faturamento por Cliente."
PRIVATE CbTxt    :=""
PRIVATE CbCont   :=0
PRIVATE nOrdem   :=0
PRIVATE tamanho  :="M"
PRIVATE aReturn  :={ "Especial", 1,"Administracao", 1, 2, 1,"",1 }
PRIVATE nomeprog :="PFINR100"
PRIVATE cPerg    :="PFR100"
PRIVATE nLastKey := 0
PRIVATE nLin     := 60
PRIVATE cabec1   := ""
PRIVATE cabec2   := ""
PRIVATE nTipo    := 0
PRIVATE M_Pag    := 1
PRIVATE cString  := ""

ValidPerg()
Pergunte(cPerg,.F.)

wnrel := SetPrint(cString,nomeprog,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                                                              �
//� Inicio do Processamento                                      �
//�                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

RptStatus({|| RptDt()})
Return

Static Function RptDt()
Local cQuery
Local nCompra1 := 0
Local nCompra2 := 0
Local nTValor1
Local nTValor2
Local nTGValor1 := 0
Local nTGValor2 := 0 
Local nABC := 0
Local cAno := mv_par09
Local cMesIni := "01"
Local cMesFim := strzero(mv_par10,2) //"12"
Local cCampo
Local aCodigo := array(1,3,0)
Local nVer
Local lFaz := .t.
Local _nTotalRegs := 0
Local cArqtrb
Local cArqtrb1
Local aStru := {}

If mv_par09 >= substr(dtos(dDataBase),1,4)
	MSGBOX("Parametro Ano Inicial invalido !","Aten豫o...","INFO")
	Return()
Else
	If strzero(val(mv_par09) + 1,4) == substr(dtos(dDataBase),1,4)
		cMesFim := substr(dtos(dDataBase),5,2)
	EndIf
Endif
	
// ARQUIVO DE COMPARA플O PARA 2 ANOS
AADD(aStru, {"TE_CLIENTE","C",6,0})
AADD(aStru, {"TE_LOJA","C",2,0})
AADD(aStru, {"TE_CODIGO","C",15,0})
AADD(aStru, {"TE_VALOR1","N",12,2})
AADD(aStru, {"TE_VALOR2","N",12,2})

cArqtrb := CriaTrab(aStru,.T.)
dbCreate(cArqtrb,aStru)
dbUseArea(.T.,,cArqtrb,"TEB",.F.,.F.)
IndRegua("TEB",cArqtrb,"TE_CLIENTE+TE_LOJA+TE_CODIGO",,," Criando Indice ... ")

// ARQUIVO PARA CLASSIFICA플O DO RANK
aStru := {}
AADD(aStru, {"TR_CLIENTE","C",6,0})
AADD(aStru, {"TR_LOJA","C",2,0})
AADD(aStru, {"TR_VALOR","N",14,2})

cArqtrb1 := CriaTrab(aStru,.T.)
dbCreate(cArqtrb1,aStru)
dbUseArea(.T.,,cArqtrb1,"TRB",.F.,.F.)
IndRegua("TRB",cArqtrb1,"TR_CLIENTE+TR_LOJA",,," Criando Indice ... ")

For i := 1 to 2
	If mv_par07 == 1
		cQuery := "SELECT "
		cQuery += "D2_CLIENTE CLIENTE, "
		cQuery += "D2_LOJA LOJA, "
		cQuery += "D2_COD CODIGO, "
		cQuery += "isnull(SUM(D2_TOTAL+D2_VALIPI),0) VALOR "
		cQuery += "FROM " + retsqlname("SD2") + " A "
		
		cQuery += "INNER JOIN " + RetSqlName("SF4") + " B ON "
		cQuery += "B.F4_FILIAL = '" + xFilial("SF4") + "' AND "
		cQuery += "B.F4_CODIGO = A.D2_TES AND "
		cQuery += "B.F4_DUPLIC = 'S' AND "
		cQuery += "B.D_E_L_E_T_ <> '*' "
		
		cQuery += "WHERE "
		cQuery += "A.D2_FILIAL = '" + XFILIAL("SD2") + "' AND "
		cQuery += "A.D2_CLIENTE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' AND "
		cQuery += "A.D2_COD BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' AND "
		cQuery += "SUBSTRING(A.D2_EMISSAO,1,6) BETWEEN '" + cAno+cMesIni + "' AND '" + cAno+cMesFim + "' AND "
		cQuery += "A.D_E_L_E_T_ = '' "
		cQuery += "GROUP BY D2_CLIENTE,D2_LOJA,D2_COD"
	ElseIf mv_par07 == 2
		cQuery := "SELECT "
		cQuery += "F2_CLIENTE CLIENTE, "
		cQuery += "F2_LOJA LOJA, "
		cQuery += "E1_NATUREZ CODIGO, "
//		cQuery += "SUM(F2_VALFAT) VALOR "
		cQuery += "SUM(F2_VALMERC) VALOR "
		cQuery += "FROM " + retsqlname("SF2") + " A "
		
		cQuery += "INNER JOIN " + RetSqlName("SE1") + " B ON "
		cQuery += "B.E1_FILIAL = '" + xFilial("SE1") + "' AND "
//		cQuery += "B.E1_PREFIXO = A.F2_PREFIXO AND "
//		cQuery += "B.E1_NUM = A.F2_DUPL AND "
		cQuery += "B.E1_PREFIXO = A.F2_SERIE AND "
		cQuery += "B.E1_NUM = A.F2_DOC AND "
		cQuery += "B.E1_NATUREZ BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "' AND "
		cQuery += "B.E1_TIPO = 'NF' AND "
		cQuery += "B.E1_PARCELA IN ('','A') AND "
		cQuery += "B.D_E_L_E_T_ <> '*' "
		
		cQuery += "WHERE "
		cQuery += "A.F2_FILIAL = '" + XFILIAL("SF2") + "' AND "
		cQuery += "A.F2_CLIENTE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' AND "
//		cQuery += "A.F2_VALFAT > 0 AND "
		cQuery += "SUBSTRING(A.F2_EMISSAO,1,6) BETWEEN '" + cAno+cMesIni + "' AND '" + cAno+cMesFim + "' AND "
		cQuery += "A.D_E_L_E_T_ = '' "
		cQuery += "GROUP BY F2_CLIENTE,F2_LOJA,E1_NATUREZ"
	EndIf
    MemoWrit("C:\PFINR100.SQL",cQuery)	
	If Select("TMP") > 0
		DbSelectArea("TMP")
		DbCloseArea()
	Endif
	TCQUERY cQuery NEW ALIAS "TMP"
	
	DbSelectArea("TMP")
	DBGOTOP()
	TMP->((DbEval({|| ++_nTotalRegs }),DbGotop()))
	SetRegua(_nTotalRegs)

	cCampo := "TE_VALOR" + alltrim(str(i))	
	Do While TMP->(!Eof())
		IncRegua("Gerando Arquivo " + cAno + " ...")
		
		// ARQUIVO DE COMPARA플O PARA 2 ANOS
		DbSelectArea("TEB")
		If TEB->(DbSeek(TMP->CLIENTE+TMP->LOJA+TMP->CODIGO))
			RecLock("TEB",.F.)
		Else
			RecLock("TEB",.T.)
			REPLACE TE_CLIENTE WITH TMP->CLIENTE
			REPLACE TE_LOJA WITH TMP->LOJA
			REPLACE TE_CODIGO WITH TMP->CODIGO
		EndIf
		REPLACE &(cCampo) WITH &(cCampo) + TMP->VALOR
		MsUnlock()

		// ARQUIVO PARA CLASSIFICA플O DO RANK	
		DbSelectArea("TRB")
		If TRB->(DbSeek(TMP->CLIENTE+TMP->LOJA))
			RecLock("TRB",.F.)
		Else
			RecLock("TRB",.T.)
			REPLACE TR_CLIENTE WITH TMP->CLIENTE
			REPLACE TR_LOJA WITH TMP->LOJA
		EndIf
		REPLACE TR_VALOR WITH TR_VALOR + TMP->VALOR
		MsUnlock()
		
		TMP->(dbSkip())
	EndDo
	DbSelectArea("TMP")
	DbCloseArea()
	
	cAno := soma1(cAno)
Next

cabec1 := "    PRODUTO                                                            ANO DE " + mv_par09 + "    ANO DE " + soma1(mv_par09) + "    VL.VARIA플O"

//"    PRODUTO                                                            ANO DE XXXX    ANO DE XXXX    VL.VARIA플O"
//     123456789012345 - 123456789012345678901234567890123456789012345 999,999,999.99 999,999,999.99 999,999,999.99
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//           1         2         3         4         5         6         7         8         9         10
                                  
// ARQUIVO PARA CLASSIFICA플O DO RANK
DbSelectArea("TRB")
dbClearIndex()
IndRegua("TRB",cArqtrb1,"StrZero(1000000000000 - TR_VALOR,12)",,," Criando Indice ... ")
dbGoTop()
SetRegua(RecCount())
	
DbSelectArea("TRB")
Do While TRB->(!Eof())

	IncRegua("Imprimindo...")
	
	nABC ++   
	If nABC > mv_par11
		Exit
	EndIf
	nTValor1 := 0
	nTValor2 := 0
	lFaz := .t.

	// ARQUIVO DE COMPARA플O PARA 2 ANOS
	DbSelectArea("TEB")
	TEB->(DbSeek(TRB->TR_CLIENTE+TRB->TR_LOJA))

	Do While TEB->(!Eof()) .AND. TEB->TE_CLIENTE == TRB->TR_CLIENTE .AND. TEB->TE_LOJA == TRB->TR_LOJA
	
		If NLIN >= 58
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
 			NLIN := 8
	 		lFaz := .t.
		EndIf
		                            
		If mv_par08 == 1 // analitico
			If lFaz
				@ NLIN,000 PSAY TRB->TR_CLIENTE + "/" + TRB->TR_LOJA + " - " + ;
								POSICIONE("SA1",1,XFILIAL("SA1")+TRB->TR_CLIENTE+TRB->TR_LOJA,"A1_NOME")
				NLIN ++
				lFaz := .f.
			EndIf

			If mv_par07 == 1
				@ NLIN,004 PSAY TEB->TE_CODIGO + ' - ' + POSICIONE("SB1",1,XFILIAL("SB1")+TEB->TE_CODIGO,"B1_DESC")
			ElseIf mv_par07 == 2
				@ NLIN,004 PSAY TEB->TE_CODIGO + ' - ' + POSICIONE("SED",1,XFILIAL("SED")+TEB->TE_CODIGO,"ED_DESCRIC")
			EndIf
		
			@ NLIN,068 PSAY TEB->TE_VALOR1 PICTURE '@E 999,999,999.99'
			@ NLIN,083 PSAY TEB->TE_VALOR2 PICTURE '@E 999,999,999.99'
			@ NLIN,098 PSAY (TEB->TE_VALOR2 - TEB->TE_VALOR1) PICTURE '@E 999,999,999.99'
			NLIN ++
		EndIf

		If TEB->TE_VALOR1 > 0
			nVer := ascan(aCodigo[1,1],TEB->TE_CODIGO)
			If nVer == 0
				aadd(aCodigo[1,1],TEB->TE_CODIGO)
        		aadd(aCodigo[1,2],0)
		        aadd(aCodigo[1,3],0)
			EndIf
			nVer := ascan(aCodigo[1,1],TEB->TE_CODIGO)
			aCodigo[1,2,nVer] ++
			If TEB->TE_VALOR2 > 0
				aCodigo[1,3,nVer] ++
			EndIf
		EndIf

		nTValor1 += TEB->TE_VALOR1
		nTValor2 += TEB->TE_VALOR2
		nTGValor1 += TEB->TE_VALOR1
		nTGValor2 += TEB->TE_VALOR2

		TEB->(dbSkip())
	EndDo

	If nTValor1 > 0
		nCompra1 ++
		If nTValor2 > 0
			nCompra2 ++
		EndIf
	EndIf

	If NLIN >= 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
 		NLIN := 8
	EndIf

	If mv_par08 == 1 // analitico	
		@ NLIN,000 PSAY "TOTAL CLIENTE"
	Else
		@ NLIN,000 PSAY TRB->TR_CLIENTE + "/" + TRB->TR_LOJA + " - " + ;
						POSICIONE("SA1",1,XFILIAL("SA1")+TRB->TR_CLIENTE+TRB->TR_LOJA,"A1_NOME")
	EndIf
	@ NLIN,068 PSAY nTValor1 PICTURE '@E 999,999,999.99'
	@ NLIN,083 PSAY nTValor2 PICTURE '@E 999,999,999.99'
	@ NLIN,098 PSAY (nTValor2 - nTValor1) PICTURE '@E 999,999,999.99'
	NLIN ++
	NLIN ++
	  
	TRB->(dbSkip())
	
EndDo

NLIN := 60
If nTGValor1 + nTGValor1 > 0
	If NLIN >= 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		NLIN := 8
	EndIf

	@ NLIN,000 PSAY "TOTAL DE FATURAMENTO"
	@ NLIN,068 PSAY nTGValor1 PICTURE '@E 999,999,999.99'
	@ NLIN,083 PSAY nTGValor2 PICTURE '@E 999,999,999.99'
	@ NLIN,098 PSAY (nTGValor2 - nTGValor1) PICTURE '@E 999,999,999.99'
	NLIN ++
	NLIN ++
	@ NLIN,000 PSAY "% DE RETEN플O DE CLIENTES"
	@ NLIN,098 PSAY ROUND((nCompra2*100) / nCompra1,2) PICTURE '@E 999,999,999.99'
	NLIN ++
	NLIN ++
	@ NLIN,000 PSAY "% DE RETEN플O POR PRODUTO"
	NLIN ++
	For i := 1 to len(aCodigo[1][1])
		If NLIN >= 58
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			NLIN := 8
		EndIf
		If mv_par07 == 1
			@ NLIN,004 PSAY aCodigo[1][1][i] + ' - ' + POSICIONE("SB1",1,XFILIAL("SB1")+aCodigo[1][1][i],"B1_DESC")
		ElseIf mv_par07 == 2
			@ NLIN,004 PSAY aCodigo[1][1][i] + ' - ' + POSICIONE("SED",1,XFILIAL("SED")+aCodigo[1][1][i],"ED_DESCRIC")
		EndIf
		@ NLIN,098 PSAY ROUND((aCodigo[1][3][i]*100) / aCodigo[1][2][i],2) PICTURE '@E 999,999,999.99'
		NLIN ++
	Next i
EndIf

Roda(CbCont,CbTxt,tamanho)

DbSelectArea("TRB")
DbCloseArea()

DbSelectArea("TEB")
DbCloseArea()

FERASE(cArqtrb+".DBF")
FERASE(cArqtrb+ordbagext())

FERASE(cArqtrb1+".DBF")
FERASE(cArqtrb1+ordbagext())

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

RETURN()
/*************************************************************/
Static Function ValidPerg()
ssAlias := Alias()
cPerg   := PADR(cPerg,len(sx1->x1_grupo))
aRegs   := {}
dbSelectArea("SX1")
dbSetOrder(1)

AADD(aRegs,{cPerg,"01","Cliente de    ?"," "," ","mv_ch1","C",06,0,0,"G","","mv_par01","         ","","","","","         ","","","","","","","","","","","","","","","","","","","CLI","","","","",""})
AADD(aRegs,{cPerg,"02","Cliente ate   ?"," "," ","mv_ch2","C",06,0,0,"G","","mv_par02","         ","","","","","         ","","","","","","","","","","","","","","","","","","","CLI","","","","",""})
AADD(aRegs,{cPerg,"03","Produto de    ?"," "," ","mv_ch3","C",15,0,0,"G","","mv_par03","         ","","","","","         ","","","","","","","","","","","","","","","","","","","SB1","","","","",""})
AADD(aRegs,{cPerg,"04","Produto ate   ?"," "," ","mv_ch4","C",15,0,0,"G","","mv_par04","         ","","","","","         ","","","","","","","","","","","","","","","","","","","SB1","","","","",""})
AADD(aRegs,{cPerg,"05","Natureza de   ?"," "," ","mv_ch5","C",10,0,0,"G","","mv_par05","         ","","","","","         ","","","","","","","","","","","","","","","","","","","SED","","","","",""})
AADD(aRegs,{cPerg,"06","Natureza ate  ?"," "," ","mv_ch6","C",10,0,0,"G","","mv_par06","         ","","","","","         ","","","","","","","","","","","","","","","","","","","SED","","","","",""})
AADD(aRegs,{cPerg,"07","Agrupar por   ?"," "," ","mv_ch7","N",01,0,0,"C","","mv_par07","Produto  ","","","","","Natureza ","","","","","","","","","","","","","","","","","","","   ","","","","",""})
AADD(aRegs,{cPerg,"08","Formato       ?"," "," ","mv_ch8","N",01,0,0,"C","","mv_par08","Analitico","","","","","Sintetico","","","","","","","","","","","","","","","","","","","   ","","","","",""})
AADD(aRegs,{cPerg,"09","Ano inicial   ?"," "," ","mv_ch9","C",04,0,0,"G","","mv_par09","         ","","","","","         ","","","","","","","","","","","","","","","","","","","   ","","","","",""})
AADD(aRegs,{cPerg,"10","Ate o Mes     ?"," "," ","mv_cha","N",02,0,0,"G","mv_par10>0.and.mv_par10<13","mv_par10","         ","","","","","         ","","","","","","","","","","","","","","","","","","","   ","","","","",""})
Aadd(aRegs,{cPerg,"11","Maiores (ABC) ?"," "," ","mv_chb","N",04,0,0,"G","","mv_par11","         ","","","","","         ","","","","","","","","","","","","","","","","","","","   ","","","","",""})

For i := 1 to Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j := 1 to FCount()
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(ssAlias)

Return()