#include "rwmake.ch"

User Function PFINR016()

SetPrvt("CTITULO,CCADASTRO,LEND,CDELFUNC,AROTINA,CINDEX")
SetPrvt("CKEY,CFILTER,NINDEX,CPERG,CFILTRASE1")

cTitulo   := "Relação de Titulos versus Envio de Email de Cobrança"
cCadastro := OEMTOANSI (cTitulo)

cPerg := "PFIN16"
ValidPerg()

Pergunte(cPerg,.F.)
MV_PAR03 := GetMV('MV_XCOBPSW')
If ! Pergunte(cPerg,.T.)
	Return()
EndIf
PutMV('MV_XCOBPSW',MV_PAR03)

aRotina := {{"Pesquisar","AxPesqui" , 0 , 1},;
			{"Visualizar","FA280Visua", 0 , 2},;
			{"Imprimir","U_IMPEMAIL()", 0 , 3}}

dbSelectArea("SE1")
cFiltraSE1 := "dtos(E1_XDTMAIL) >= '"+dtos(MV_PAR01)+"' .AND. dtos(E1_XDTMAIL) <= '"+dtos(MV_PAR02)+"'"
cFiltraSE1 += " .AND. E1_SALDO > 0"
SE1->(dbSetFilter({|| &cFiltraSE1 }, cFiltraSE1 ))

mBrowse(06,01,22,75,"SE1")

SE1->(dbSetFilter({|| .T. }, ".T." ))

Return()
/*************************************************************************************************************/
USER Function IMPEMAIL()      
Private oPrint // impressão grafica
Private oFont10 := TFont():New("Courier New",9,10  ,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont12 := TFont():New("Courier New",9,11.5,.T.,.T.,5,.T.,5,.T.,.F.)
Private nlin := 0
Private nTotal := 0

oPrint:=TMSPrinter():New( "Relação de Titulos versus Envio de Email de Cobrança" )	// inicialização do formulário
oPrint:SetPortrait() // retrato
oPrint:StartPage()	// inicializacao pagina

nlin += 80
oPrint:Say  (nlin,0010, "Relação de Titulos versus Envio de Email de Cobrança" ,oFont12)
nlin += 40
oPrint:Say  (nlin,0010, "Data : " + dtoc(ddatabase) ,oFont12)
nlin += 40
oPrint:Say  (nlin,0010, "Hora : " + time() ,oFont12)
nlin += 80
oPrint:Say  (nlin,0010, "Titulo    Cliente                     Vencimento   Venc.Original      Valor  Cobranca" ,oFont12)
nlin += 80

Do While ! SE1->(eof()) 
	If nlin >= 2900 //2750
		oPrint:EndPage() // Finaliza a página
		oPrint:StartPage()	// inicializacao pagina
		nlin := 0
		
		nlin += 80
		oPrint:Say  (nlin,0010, "Relação de Titulos versus Envio de Email de Cobrança" ,oFont12)
		nlin += 40
		oPrint:Say  (nlin,0010, "Data : " + dtoc(ddatabase) ,oFont12)
		nlin += 40
		oPrint:Say  (nlin,0010, "Hora : " + time() ,oFont12)
		nlin += 80
		oPrint:Say  (nlin,0010, "Titulo    Cliente                     Vencimento   Venc.Original      Valor  Cobranca" ,oFont12)
		nlin += 80
	EndIf

	oPrint:Say  (nlin,0010, SE1->E1_NUM + "/" + SE1->E1_PARCELA + SPACE(3) +;
							SE1->E1_CLIENTE + "/" + SE1->E1_LOJA + " " + SE1->E1_NOMCLI + SPACE(3) +;
							DTOC(SE1->E1_VENCREA) + SPACE(8) +;
							DTOC(SE1->E1_VENCORI) + SPACE(3) +;
							transform(SE1->E1_SALDO,"@E 99,999,999.99") + SPACE(3) +;
							DTOC(SE1->E1_XDTMAIL),oFont10)
	nTotal += SE1->E1_SALDO
	nlin += 40

	SE1->(dbskip())
EndDo

nlin += 40
oPrint:Say  (nlin,0010, "TOTAL " + SPACE(65) + transform(nTotal,"@E 99,999,999.99") ,oFont10)

oPrint:EndPage() // Finaliza a página
oPrint:Preview() // Visualiza antes de imprimir

Return()

/*************************************************************************************************************/
Static Function ValidPerg()
ssAlias      := Alias()
cPerg        := PADR(cPerg,len(sx1->x1_grupo))
aRegs        := {}
dbSelectArea("SX1")
dbSetOrder(1)  //                                                                1v 1p 1e 1i 1c 2v 2p 2e 2i 2c 3v 3p 3e 3i 3c 4v 4p 4e 4i 4c 5v 5p 5e 5i 5c f3 py gr he pi
AADD(aRegs,{cPerg,"01","Enviados de ","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Enviados ate","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Senha Email ","","","mv_ch3","C",30,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
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