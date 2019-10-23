#include "rwmake.ch"

User Function CARTA()

SetPrvt("TAMANHO,LIMITE,CDESC1,CDESC2,CDESC3,CSTRING")
SetPrvt("NOMEPROG,NTIPO,ARETURN,AORD,CPERG,NLASTKEY")
SetPrvt("LI,CSAVSCR1,CSAVCUR1,CSAVROW1,CSAVCOL1,CSAVCOR1")
SetPrvt("CFILIAL,NJUR,NMULTA,NVLRCORRIG,ASTRU,AMES")
SetPrvt("CBTXT,CBCONT,M_PAG,TITULO,CABEC1,CABEC2")
SetPrvt("WNREL,CARQTRAB,CARQX,CKEY,CFILTRO,NHORA")
SetPrvt("NMIN,DDATA,CFAXD,CFAXC,CFAXT,AFILES")
SetPrvt("NI,P_CNT,P_ATU,P_ANT,AARQFAX")
SetPrvt("CCLIENTE,CLOJA,CAGENTE,CFAXF")
SetPrvt("NHANDLE,I,CTEL,CSTR,NAREASALVA,X")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EMICARTA ³ Autor ³ Alexandre N. Gomes    ³ Data ³ 27/07/95 ³±±
±±³          ³          ³       ³ Alberto S Garcia      ³      ³ 01/09/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao de Carta para Cobranca                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Microsiga                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private LI := 80
Private tamanho := "P"
Private cDesc1 := "Este programa ira emitir uma Carta de Cobranca para o Cliente,"
Private cDesc2 := "relacionando os Titulos em Atraso"
Private cDesc3 := ""
Private cString := "SE1"
Private wnrel := "EMICARTA"
Private nTipo := 18
Private aReturn := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private aOrd := {}
Private cPerg := "RFIN01"
Private nomeprog := "CARTAC"

Private _aEtiq1a := {}
Private _aEtiq2a := {}
Private _aEtiq3a := {}
Private _aEtiq4a := {}
Private _aEtiq5a := {}
Private _aEtiq6a := {}
Private _aEtiq7a := {}
Private _aEtiq8a := {}

nLastKey := 0
li := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas por Este Programa                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilial := xFilial("SE1")
nJur := 0
nMulta := 0
nVlrCorrig := 0
aStru := { { "CLIENTE"  , "C",  6, 0 } ,;
{ "LOJA"     , "C",  2, 0 } ,;
{ "AGENTE"   , "C",  3, 0 } ,;
{ "PREFIXO"  , "C",  3, 0 } ,;
{ "NUM"      , "C",  6, 0 } ,;
{ "PORTADO"  , "C",  3, 0 } ,;
{ "PARCELA"  , "C",  1, 0 } ,;
{ "VENCREA"  , "D",  8, 0 } ,;
{ "VLRORI"   , "N",  9, 2 } ,;
{ "VLRCORRIG", "N",  9, 2 } ,;
{ "DTPROTES" , "D",  8, 0 } ,;
{ "SITUACAO" , "C",  1, 0 }  }

aMes := { "Janeiro"   , "Fevereiro" , "Marco", "Abril", "Maio" ,;
"Junho", "Julho", "Agosto", "Setembro", "Outubro"    ,;
"Novembro", "Dezembro" }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
m_pag    := 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := ""
cabec1 := ""
cabec2 := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte( "RFIN01", .F. )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If LastKey() == 27 .or. nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If LastKey() == 27 .or. nLastKey == 27
	Return
Endif

///  Cria Arquivo de Trabalho
cArqTrab := CriaTrab(aStru,.T.)
Use &cArqTrab ALIAS TRB New
dbSelectArea("TRB")
Index On CLIENTE+PREFIXO+NUM To &cArqTrab

cArqx := Subs(cArqTrab,1,7)+"A"
dbSelectArea("SE1")
dbSetOrder(7)
cKey := "E1_FILIAL+dtos(E1_VENCREA)+E1_PREFIXO+E1_NUM+E1_PARCELA"
cFiltro := 'E1_FILIAL == "'+xFilial("SE1")+'" .and. E1_SALDO > 0.01 .and. DTOS(E1_VENCREA) >= "'+dtos(mv_par01)+'"'
cFiltro := cFiltro + ".and. E1_CLIENTE >= '"+mv_par05+"' .and. E1_CLIENTE <= '"+mv_par06+"'"

IndRegua("SE1",cArqx,cKey,,cFIltro,"Filtrando SE1...")

//-> Variaveis p/ geracao de FAX via OBJFax
nHora := 0
nMin  := 0
dData := dDataBase
cFaxC := ""                 //Contato p/ Envio do Fax
cFaxT := ""                 //Data e Hora de Expedicao do FAX

dbSelectArea("SE1")
dbGoTop()
While ! Eof() .and. SE1->E1_VENCREA <= MV_PAR02
	Inkey()
	IF LastKey() == 286        // Alt-A
		@ Prow()+1,001 Say "CANCELADO PELO OPERADOR"
		Exit
	EndIF
	
//	If Empty(SE1->E1_SALDO) .or. SE1->E1_SITUACA $ "0/2/3/4/5"
//		dbSelectArea("SE1")
//		dbSkip()
//		Loop
//	Endif
	
	If ((SE1->E1_PORTADO < mv_par03) .or. ;
		(SE1->E1_PORTADO > mv_par04) .or. ;
		(SE1->E1_CLIENTE < mv_par05) .or. ;
		(SE1->E1_CLIENTE > mv_par06))
		dbSelectArea("SE1")
		dbSkip()
		Loop
	Endif
	
	CriaReg()
	
	dbSelectArea("SE1")
	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o conteudo do arquivo de trabalho                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")
dbGoTop()
aArqFax:={}
Do While ! Eof()
	cCliente := TRB->CLIENTE
	cLoja    := TRB->LOJA
	cAgente  := TRB->AGENTE
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+TRB->CLIENTE+TRB->LOJA)
	dbSelectArea("TRB")

	aadd(_aEtiq1a,ALLTRIM(SA1->A1_NOME))
	aadd(_aEtiq2a,UPPER(ALLTRIM(SA1->A1_CONTATO)))
	aadd(_aEtiq3a,ALLTRIM(SA1->A1_END))
	aadd(_aEtiq4a," ")
	aadd(_aEtiq5a,ALLTRIM(SA1->A1_BAIRRO))
	aadd(_aEtiq6a,ALLTRIM(SA1->A1_MUN)) 
	aadd(_aEtiq7a," / "+ALLTRIM(SA1->A1_EST))
	aadd(_aEtiq8a,TRANSFORM(SA1->A1_CEP,"@R 99999-999"))

	If mv_par08 == 2
		ImpCarta()
	Else
		dbSkip()
		While TRB->CLIENTE+TRB->LOJA+TRB->AGENTE == cCliente+cLoja+cAgente .and. !Eof()
			dbSkip()
		Enddo
	EndIf
Enddo

If len(_aEtiq1a) > 0 
	If (len(_aEtiq1a) % 2) > 0
		aadd(_aEtiq1a," ");aadd(_aEtiq2a," ");aadd(_aEtiq3a," ");aadd(_aEtiq4a," ")
		aadd(_aEtiq5a," ");aadd(_aEtiq6a," ");aadd(_aEtiq7a," ");aadd(_aEtiq8a," ")
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deleta Arquivo Temporario e Restaura os Indices Nativos.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("TRB") > 0
	dbCloseArea()
	If File(cArqTrab+".DBF")
		Ferase(cArqTrab+".DBF")    //arquivo de trabalho
	EndIf
	If File(cArqTrab+OrdBagExt())
		Ferase(cArqTrab+OrdBagExt())    //indice gerado
	EndIf
Endif
RETINDEX("SE1")
Set FIlter to
Ferase(cArqx+OrdBagExt())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cString)
RetIndex("SE1")

If mv_par08 == 2
	Set Device To Screen
	If aReturn[5] == 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif
EndIf
MS_FLUSH()
	
If MsgYesNo("Confirma Impressão das Etiquetas ? ")
	u_ImpEtiqCli()
EndIf
	
Return

/*****************************************************************/
Static Function CriaReg()
nAreaSalva := Select()
dbSelectArea("TRB")
RecLock("TRB",.T.)
TRB->CLIENTE  := SE1->E1_CLIENTE
TRB->LOJA     := SE1->E1_LOJA
TRB->AGENTE   := " "
TRB->PREFIXO  := SE1->E1_PREFIXO
TRB->NUM      := SE1->E1_NUM
TRB->PORTADO  := SE1->E1_PORTADO
TRB->PARCELA  := SE1->E1_PARCELA
TRB->VENCREA  := SE1->E1_VENCTO
TRB->VLRORI   := SE1->E1_SALDO
TRB->VLRCORRIG:= nVlrCorrig
TRB->SITUACAO := SE1->E1_SITUACA
TRB->DTPROTES := SE1->E1_VENCREA
msUnlock()
dbSelectArea(nAreaSalva)
Return(.T.)

/*****************************************************************/
Static Function ImpCarta()

If  Li > 80
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 5
Endif

Li := 5
@ Li, 01 PSAY RTrim(SM0->M0_CIDCOB)+", "+StrZero(Day(mv_par07),2,0)+" de "+aMes[Month(mv_par07)]+" de "+Str(Year(mv_par07),4,0)
Li := Li+3
@ Li,01 PSAY "A"
Li := Li+1
@ Li,01 PSAY SA1->A1_NOME
Li := Li+1
@ Li,01 PSAY IIf(Empty(SA1->A1_ENDCOB),SA1->A1_END,SA1->A1_ENDCOB)
Li := Li+1
@ Li,01 PSAY Alltrim(SA1->A1_MUN) + " - " + SA1->A1_EST + " - CEP.: " + Subs(SA1->A1_CEP,1,5)+"-"+Subs(SA1->A1_CEP,6,6) + " - FAX: " + SA1->A1_FAX
Li := Li+3
@ Li,01 PSAY "A/C : Sr(a) " + ALLTRIM(SA1->A1_CONTATO) + " e/ou Contas a Pagar "
Li := Li+3
@ Li,01 PSAY "Ref.: TITULO(S) EM ATRASO"
Li := Li+3
@ Li, 01 PSAY "Prezado Cliente, "
Li := Li+3
@ Li, 01 PSAY "Informamos que em nossos registros não localizamos o(s) pagamento(s) referente(s)"
Li := Li+1
@ Li, 01 PSAY "ao(s) boleto(s) abaixo:"
Li := Li+1
While TRB->CLIENTE+TRB->LOJA+TRB->AGENTE == cCliente+cLoja+cAgente .and. !Eof()
	Li := Li+1
	@ Li,03 PSAY TRB->NUM
	@ Li,15 PSAY TRB->PARCELA
	@ Li,22 PSAY TRB->VENCREA
	@ Li,33 PSAY TRB->VLRORI    Picture "@E@Z 999,999.99"
	dbSelectArea("TRB")
	dbSkip()
Enddo

Li := Li+2
@ Li, 01 PSAY "Caso já tenha liquidado o(s) título(s) aqui objetivado(s), favor encaminhar para o"
Li := Li+1
@ Li, 01 PSAY "fax (11) 3942-1584 ou para o email cobranca@cesvibrasil.com.br o(s) comprovante(s)"
Li := Li+1
@ Li, 01 PSAY "para  efetuarmos a regularização  em  nosso sistema, informando o número do título"
Li := Li+1
@ Li, 01 PSAY "e o nome da empresa."
Li := Li+2
@ Li, 01 PSAY "Caso o pagamento  não tenha  sido efetuado, favor  entrar em contato por meio do"
Li := Li+1
@ Li, 01 PSAY "telefone abaixo informado em até 48 horas para liquidar esta(s) pendência(s)."
Li := Li+2
@ Li, 01 PSAY "Ressaltamos que  após o prazo informado o(s) titulo(s)  estará(ão)  sujeito(s) a"
Li := Li+1
@ Li, 01 PSAY "protesto."
Li := Li+4
@ Li, 01 PSAY "Atenciosamente,"
Li := Li+4
@ Li,01 PSAY  SUBSTR(SM0->M0_NOMECOM,1,16)
Li := Li+1
@ Li, 01 PSAY "Fabio Marton"
Li := Li+1
@ Li, 01 PSAY "Tel (11) 3948-4815" 
Li := Li+1
@ Li, 01 PSAY "Fax (11) 3942-1584"
Li := Li+1
@ Li, 01 PSAY "cobranca@cesvibrasil.com.br"
Li := Li+1
@ Li,01 PSAY  "Depto. Contas a Receber "
Li := Li+1

Return(.T.)
/*****************************************************************/