#include "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ 	PCTBA003 ³ Trade Consulting   			 ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Geracao de Arquivo TXT para movimento contabil              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico CESVI                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PCTBA003()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define as variaveis utilizadas na rotina                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cCadastro	:= "Gera arquivo em formato TXT para movimento contabil."
Private cPerg		:= "PCTBA3"
Private nOpca		:= 0

ValidPerg(cPerg)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega perguntas do programa                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !Pergunte(cPerg,.t.)
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a tela principal do programa                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 000,000 TO 140,460 DIALOG oDlg2 TITLE cCadastro

@ 012,012 SAY " Este programa gera arquivo TXT referente"
@ 022,012 SAY " ao movimento CONTABIL."
@ 012,200 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.t.)
@ 026,200 BMPBUTTON TYPE 1 ACTION ProcTxT()
@ 040,200 BMPBUTTON TYPE 2 ACTION Close(oDlg2)

ACTIVATE DIALOG oDlg2 CENTERED

Return

/****************************************************************/

Static Function ProcTxt()

Close(oDlg2)

Processa({|| GERAHFM()},"Gerando o Arquivo TXT" )

Return

/****************************************************************/

Static Function GERAHFM()
Local cNomArq	:= "D"+"060"+substr(dtoc(mv_par03),4,2)+substr(dtoc(mv_par03),7,2)+'.TXT'
Local cPath		:= alltrim(mv_par01)   
Local cBuffer	:= ''
Local aSaldoIni
Local aSaldoFim
Local nDebito
Local nCredito
Local nSaldo
Local cTipo

If File( cPath+cNomArq )
	If MsgYesNo("O arquivo ja Existe Deseja Substituir")
		nHdlArq := MsFCreate( cPath+cNomArq,0)
	Else
		Return
	EndIf
Else
	nHdlArq := MsFCreate(cPath+cNomArq,0)
EndIf  
    
DbSelectArea("CT1")
DbSetOrder(1)
DbGoTop()
ProcRegua(RecCount())

Do While ! CT1->(eof())

	IncProc("Processando Conta : " + CT1->CT1_CONTA)
	
	If CT1->(CT1_CLASSE) == '2'
	
		aSaldoIni	:= SaldoCt7(CT1->CT1_CONTA,MV_PAR02,'01','1')
		aSaldoFim	:= SaldoCT7(CT1->CT1_CONTA,MV_PAR03,'01','1')

		nDebito		:= aSaldoFim[4] - aSaldoIni[7]
		nCredito	:= aSaldoFim[5] - aSaldoIni[8]
		nSaldo		:= aSaldoFim[1]
		
		cTipo := Iif(nSaldo < 0,'D','C')
		
		If nSaldo < 0 
			nSaldo := nSaldo * -1
		EndIf
		
		nSaldo		:= strzero((nSaldo*100),17)
		nDebito		:= strzero((nDebito*100),17)
		nCredito	:= strzero((nCredito*100),17)
		
		cBuffer := CT1->CT1_CONTA + Space(20) 
		cBuffer += CT1->CT1_DESC01 + Space(10)
		cBuffer += cTipo 						// Tipo (D/C)
		cBuffer += nSaldo						// Saldo Atual
		cBuffer += '00060'						// Codigo da Empresa
		cBuffer += Substr(dtos(mv_par03),1,6)	// Ano e Mes (AAAAMM)
		cBuffer += nDebito						// Debito
		cBuffer += nCredito						// Credito
		cBuffer += chr(13)+chr(10)
		Fwrite(nHdlArq,cBuffer)

	EndIf
	CT1->(DbSkip())
Enddo

Fclose(nHdlArq)

MsgBox("Arquivo " + cPath+cNomArq + " criado com sucesso !", "Atencao")

Return
/****************************************************************/
Static Function ValidPerg(cPerg)
Local _sAlias	:= Alias()
Local aRegs		:= {}
Local i,j
cPerg  := PADR(cPerg,len(sx1->x1_grupo))
dbSelectArea("SX1")
dbSetOrder(1)
aAdd(aRegs,{cPerg,"01","Diretorio Destino?","","","mv_ch1","C",10,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
AADD(aRegs,{cPerg,"02","Data de          ?","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})
AADD(aRegs,{cPerg,"03","Data ate         ?","","","mv_ch3","D",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","   ","","","","",""})

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