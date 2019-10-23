#INCLUDE "RWMAKE.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PFINR013 ³ Autor ³ GILBERTO              ³ Data ³ OUT/2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ GERAÇÃO DE ARQUIVO CSV PARA TITULO DE CONTAS A RECEBER EM  ³±±
±±³          ³ ATRAS0.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PFINR013()

Private lExec		:= .F.
Private cIndexName	:= ''
Private cIndexKey	:= ''
Private cFilter	:= ''
Private cPerg	:= "PFIN13"
Private lEnd	:= .F.
Private oDlg

dbSelectArea("SE1")

ValidPerg()
If ! Pergunte(cPerg,.t.)
	Return()
EndIf

cIndexName	:= Criatrab(Nil,.F.)
cIndexKey	:= "E1_PREFIXO+E1_NUM"
cFilter	+= "E1_FILIAL == '"+xFilial("SE1")+"' .And. "
cFilter	+= "E1_SALDO > 0.01 .And. "
cFilter	+= "DTOS(E1_VENCREA) >= '" + dtos(mv_par01) + "' .And. DTOS(E1_VENCREA) <= '" + dtos(mv_par02) + "' .And. "
cFilter	+= "E1_PORTADO >= '" + mv_par03 + "' .And. E1_PORTADO <= '" + mv_par04 + "' .And. "
cFilter	+= "E1_CLIENTE >= '" + mv_par05 + "' .And. E1_CLIENTE <= '" + mv_par06 + "' .And. "
cFilter	+= "E1_TIPO == 'NF '"

IndRegua("SE1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")
DbSelectArea("SE1")
dbGoTop()

@ 001,001 TO 400,700 DIALOG oDlg TITLE "Titulos de Contas a Receber em Atraso conforme parametros."
@ 001,001 TO 170,350 BROWSE "SE1"
@ 180,310 BMPBUTTON TYPE 01 ACTION (lExec := .T.,Close(oDlg))
@ 180,280 BMPBUTTON TYPE 02 ACTION (lExec := .F.,Close(oDlg))
ACTIVATE DIALOG oDlg CENTERED

dbGoTop()
If lExec
	Processa({|lEnd|MontaRel()})
EndIf
RetIndex("SE1")
Ferase(cIndexName+OrdBagExt())

Return Nil
/***************************************************************/
Static Function MontaRel()
Local cNomArq := alltrim(mv_par07)+'.CSV'
Local cPath   := alltrim(mv_par08)   
Local cBuffer := ''
Local nHdlArq

If File( cPath+cNomArq )
	If MsgYesNo("O arquivo ja Existe Deseja Substituir")
		nHdlArq := MsFCreate( cPath+cNomArq,0)
	Else
		Return
	EndIf
Else
	nHdlArq := MsFCreate(cPath+cNomArq,0)
EndIf  

cBuffer := 'DEVEDOR;ENDERECO;BAIRRO;CIDADE;UF;CEP;TELEFONE;FAX;CONTATO;EMAIL;CNPJ;INCR.ESTADUAL;'
cBuffer += 'NATUREZA;NUMERO TITULO;VENC.ORIGINAL;VENC.REAL;VALOR'
cBuffer += chr(13)+chr(10)
Fwrite(nHdlArq,cBuffer)

SA1->(DbSetOrder(1))

dbGoTop()
ProcRegua(RecCount())
Do While ! SE1->(EOF())
	IncProc()
	If SA1->(DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA))
		cBuffer := ALLTRIM(SA1->A1_NOME)+';'+ALLTRIM(SA1->A1_END)+';'+ALLTRIM(SA1->A1_BAIRRO)+';'
		cBuffer += ALLTRIM(SA1->A1_MUN)+';'+ ALLTRIM(SA1->A1_EST)+';'+ALLTRIM(SA1->A1_CEP)+';'
		cBuffer += ALLTRIM(SA1->A1_TEL)+';'+ALLTRIM(SA1->A1_FAX)+';'+ALLTRIM(SA1->A1_CONTATO)+';'
		cBuffer += ALLTRIM(SA1->A1_EMAIL)+';'+ALLTRIM(SA1->A1_CGC)+';'+ALLTRIM(SA1->A1_INSCR)+';'
		cBuffer += ALLTRIM(POSICIONE("SED",1,XFILIAL("SED")+SE1->E1_NATUREZ,"ED_DESCRIC"))+';'
		cBuffer += SE1->E1_NUM+'/'+SE1->E1_PARCELA+';'+DTOC(SE1->E1_VENCORI)+';'+DTOC(SE1->E1_VENCREA)+';'
		cValor := ALLTRIM(STR(SE1->E1_SALDO))
		cValor := STRTRAN(cValor,".",",")
		cBuffer += cValor
		cBuffer += chr(13)+chr(10)
		Fwrite(nHdlArq,cBuffer)
    EndIf
	SE1->(dbSkip())
EndDo

Fclose(nHdlArq)

Return Nil
/***************************************************************/
Static Function ValidPerg()
ssAlias := Alias()
cPerg   := PADR(cPerg,len(sx1->x1_grupo))
aRegs   := {}
dbSelectArea("SX1")
dbSetOrder(1)

Aadd(aRegs,{cPerg,"01","Vencidos de      ?","","","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
Aadd(aRegs,{cPerg,"02","Vencidos ate     ?","","","mv_ch2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
Aadd(aRegs,{cPerg,"03","Portador de      ?","","","mv_ch3","C",03,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
Aadd(aRegs,{cPerg,"04","Portador ate     ?","","","mv_ch4","C",03,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
Aadd(aRegs,{cPerg,"05","Do Cliente       ?","","","mv_ch5","C",06,0,0,"C","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","CLI","","","","",""})
Aadd(aRegs,{cPerg,"06","Ate Cliente      ?","","","mv_ch6","C",06,0,0,"C","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","CLI","","","","",""})
Aadd(aRegs,{cPerg,"07","Arquivo Destino  ?","","","mv_ch7","C",30,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
Aadd(aRegs,{cPerg,"08","Diretorio Destino?","","","mv_ch8","C",10,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})

For i := 1 to Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j := 1 to FCount()
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	EndIf
Next
DbSelectArea(ssAlias)

Return()