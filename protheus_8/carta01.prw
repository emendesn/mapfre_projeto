#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO4     º Autor ³ AP6 IDE            º Data ³  31/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CARTA01


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa ira emitir uma Carta de Cobranca para o Cliente, "
Local cDesc2         := "relacionando os Titulos em Atraso."
Local cDesc3         := ""
Local cPict          := ""
Local titulo       := ""
Local LI         := 80

Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "CARTA" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "CARTA" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg    :="RFIN01" 
Private cString := "SE1"



dbSelectArea("SE1")
dbSetOrder(7)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte( "RFIN01", .F. )

wnrel := SetPrint(cString,NomeProg,CPERG,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas por Este Programa                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cFilial  := xFilial("SE1")
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
	   { "NAVISOS"  , "N",  2, 0 } ,;
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

Pergunte( "RFIN01", .F. )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,LI) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,LI)

Local nOrdem
cArqTrab := CriaTrab(aStru,.T.)
Use &cArqTrab ALIAS TRB New
dbSelectArea("TRB")
Index On CLIENTE+PREFIXO+NUM To &cArqTrab

cArqx := Subs(cArqTrab,1,7)+"A"
dbSelectArea("SE1")
dbSetOrder(7)
cKey := "E1_FILIAL+dtos(E1_VENCREA)+E1_PREFIXO+E1_NUM+E1_PARCELA"
cFiltro := 'E1_FILIAL == "'+xFilial("SE1")+'" .and. E1_SALDO > 0.01 .and. DTOS(E1_VENCREA) >= "'+dtos(mv_par01)+'"'
cFiltro := cFiltro + ".and. E1_CLIENTE >= '"+mv_par06+"' .and. E1_CLIENTE <= '"+mv_par07+"'"



//-> Variaveis p/ geracao de FAX via OBJFax
nHora := 0
nMin  := 0
dData := dDataBase


cFaxC := ""                 //Contato p/ Envio do Fax
cFaxT := ""                 //Data e Hora de Expedicao do FAX

dbSelectArea(cString)
dbSetOrder(7)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posicionamento do primeiro registro e loop principal. Pode-se criar ³
//³ a logica da seguinte maneira: Posiciona-se na filial corrente e pro ³
//³ cessa enquanto a filial do registro for a filial corrente. Por exem ³
//³ plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    ³
//³                                                                     ³
//³ dbSeek(xFilial())                                                   ³
//³ While !EOF() .And. xFilial() == A1_FILIAL                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbGoTop()
While !EOF() .and. SE1->E1_VENCREA <= MV_PAR02

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica o cancelamento pelo usuario...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If lAbortPrint
      @LI,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif
       
 Inkey()
   IF LastKey() == 286        // Alt-A
      @ Prow()+1,001 Say "CANCELADO PELO OPERADOR"
      Exit
   EndIF

   If Empty(SE1->E1_SALDO) .or. SE1->E1_SITUACA $ "0/2/3/4/5"
      dbSelectArea("SE1")
      dbSkip()
      Loop
   Endif

   If ((SE1->E1_PORTADO < mv_par03) .or. ;
       (SE1->E1_PORTADO > mv_par04) .or. ;
       (SE1->E1_CLIENTE < mv_par06) .or. ;
       (SE1->E1_CLIENTE > mv_par07))
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
   // Funcao Para Imprimir a Carta
/////   cArqFax:=Substr("C"+Alltrim(TRB->CLIENTE),1,8)
   If Empty(SA1->A1_FAX) .OR. SA1->A1_PRIOR == "A" 
		dbSkip()
		Loop
	Endif
  
    ImpCarta()
Enddo

_CRLF := Chr(13)+Chr(10)

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
Set Device To Screen

If aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
Endif

MS_FLUSH()
Return      
// Funcao para Criar Registros no Arquivo de Trabalho
// Substituido pelo assistente de conversao do AP5 IDE em 16/03/01 ==> Function CriaReg
Static Function CriaReg()
//   Correcao()                // Calcula o Valor Corrigido
   nAreaSalva := Select()
   dbSelectArea("TRB")
   RecLock("TRB",.T.)
   TRB->CLIENTE  := SE1->E1_CLIENTE
   TRB->LOJA     := SE1->E1_LOJA
   TRB->AGENTE   := " " // SE1->E1_PORTADO
   TRB->PREFIXO  := SE1->E1_PREFIXO
   TRB->NUM      := SE1->E1_NUM
   TRB->PORTADO  := SE1->E1_PORTADO
   TRB->PARCELA  := SE1->E1_PARCELA
   TRB->VENCREA  := SE1->E1_VENCTO // ERA E1_VENCREA
   TRB->VLRORI   := SE1->E1_SALDO
   TRB->VLRCORRIG:= nVlrCorrig
   TRB->SITUACAO := SE1->E1_SITUACA
  // TRB->NAVISOS  := SE1->E1_NAVISOS + IIf(mv_par05#"S",0,1)
   TRB->DTPROTES := SE1->E1_VENCREA  //+ GetMV("MV_DTAPROT")
  // msUnlock()
  // dbSelectArea("SE1")
  // RecLock("SE1",.F.)
  // SE1->E1_NAVISOS := SE1->E1_NAVISOS + IIf(mv_par05#"S",0,1)
//	IF EMPTY(SE1->E1_DTAVISO) .and. mv_par05 == "S"
//		SE1->E1_DTAVISO := dDataBase
//	Endif
//   msUnlock()
   dbSelectArea(nAreaSalva)
Return(.T.)


Static Function ImpCarta()  
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impressao do cabecalho do relatorio. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LI := 55                      


   If LI > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      LI := 8
   Endif

   Li := 5
   @ Li, 01 PSAY RTrim(SM0->M0_CIDCOB)+", "+StrZero(Day(mv_par08),2,0)+" de "+aMes[Month(mv_par08)]+" de "+Str(Year(mv_par08),4,0)
   Li:=Li+2
   @ Li,01 PSAY "A"
   Li:=Li+1
   @ Li,01 PSAY SA1->A1_NOME
   Li:=Li+1
   @ Li,01 PSAY IIf(Empty(SA1->A1_ENDCOB),SA1->A1_END,SA1->A1_ENDCOB)
   Li:=Li+1
   @ Li,01 PSAY Alltrim(SA1->A1_MUN) + " - " + SA1->A1_EST + " - CEP.: " + Subs(SA1->A1_CEP,1,5)+"-"+Subs(SA1->A1_CEP,6,6) + " - FAX: " + SA1->A1_FAX
   for x:= 1 to 2
     	Li:=Li+1
     	@ LI,01 PSAY "  "	
   next
   Li:=Li+1

	@ Li,01 PSAY "A/C : Sr(a) " + ALLTRIM(SA1->A1_CONTATO) + " e/ou Contas a Pagar "
   for x:= 1 to 3
     	Li:=Li+1
     	@ LI,01 PSAY "  "	
   next
   Li:=Li+1

   @ Li,01 PSAY "Ref.: DEBITOS EM ATRASO"
   for x:= 1 to 3
     	Li:=Li+1
     	@ LI,01 PSAY "  "	
   next
   Li:=Li+1

   @ Li, 01 PSAY "Prezado Cliente, "
   for x:= 1 to 3
     	Li:=Li+1
     	@ LI,01 PSAY "  "	
   next
   Li:=Li+1

   @ Li, 01 PSAY "Atraves de nosso sistema de cobrança, verificamos que  encontra-se pendente de"
   Li:=Li+1   
   @ Li, 01 PSAY "de regularizacao, o(s) titulo(s) abaixo relacionado(s) referente(s) a utiliza-"
   Li:=Li+1   
   @ Li, 01 PSAY "cao de nossos servicos."  
   Li:=Li+1   
   @ Li, 01 PSAY "Caso o  pagamento tenha  sido efetuado, favor  enviar fax  para (11) 3942-1584"     
   Li:=Li+1   
   @ Li, 01 PSAY "ou para o email cobranca@cesvibrasil.com.br o comprovante do  mesmo, para  que"
   Li:=Li+1   
   @ Li, 01 PSAY "possamos efetuar liquidacao  do(s) titulo(s)."
   Li:=Li+1   
   @ Li, 01 PSAY "Caso o pagamento  nao tenha  sido efetuado, favor  proceder o mesmo atraves do" 
   Li:=Li+1   
   @ Li, 01 PSAY "boleto anexo.  "    
   Li:=Li+1   
   @ Li, 01 PSAY "Ressaltamos que ate a data de vencimento do boleto nao estamos cobrando multa/"
   Li:=Li+1
   @ Li, 01 PSAY "juros do(s) debito(s) apresentado(s)."    
   Li:=Li+1   
   @ Li, 01 PSAY "Apos o vencimento, o(s) titulo(s) estarao sujeito(s) a protesto. " 
         
   
   
   for x:= 1 to 2
     	Li:=Li+1
     	@ LI,01 PSAY "  "	
   next
   Li:=Li+1

   cabec1 := "Duplicata  Parcela  Vencimento     Valor   " //Vlr.Corrigido  No.Avisos  Dt. Protesto"    
   //      xxxxxxxxxx  xxx    xxxxxxxx  xxxxxxxxxx   xxxxxxxxxx        x        xxxxxxxx      
   //      12345678901234567890123456789012345678901234567890123456789012345678901234567890
      
   @ Li,01 PSAY cabec1
   Li:=Li+1

   While TRB->CLIENTE+TRB->LOJA+TRB->AGENTE == cCliente+cLoja+cAgente .and. !Eof()
      Li:=Li+1
      @ Li,03 PSAY TRB->NUM  //+IIf(Empty(TRB->PARCELA),"","/"+TRB->PARCELA)
      @ Li,15 PSAY TRB->PARCELA   
//      @ Li,15 PSAY IIf(Empty(TRB->PARCELA),"",TRB->PARCELA)
      @ Li,22 PSAY TRB->VENCREA
      @ Li,33 PSAY TRB->VLRORI    Picture "@E@Z 999,999.99"
     // @ Li,42 PSAY TRB->VLRCORRIG Picture "@E@Z 999,999.99"
     // @ Li,60 PSAY TRB->NAVISOS   Picture "99"
     // @ Li,70 PSAY TRB->DTPROTES  
      dbSelectArea("TRB")
      dbSkip()
   Enddo
   for x:= 1 to 3
   	Li:=Li+1
   	@ LI,01 PSAY "  "	
   next
   Li:=Li+1
    /////    _cModelo := AllTrim(GetMV("MV_CAR0"+Str(MV_PAR09,1,0)))

     //  @ Li,01 PSAY "Encontram-se pendente(s)."
     //   Li:=Li+1
       // @ Li,01 PSAY  Subs(_cModelo,01,79)
        //Li:=Li+1
        //If !Empty(Subs(_cModelo,80,79))
        //   @ Li,01 PSAY Subs(_cModelo,80,79)
        //   Li:=Li+1
        //EndIf
        //If !Empty(Subs(_cModelo,160,79))
        //   @ Li,01 PSAY Subs(_cModelo,160,79)
        //   Li:=Li+1
        //EndIf
        //If !Empty(Subs(_cModelo,240))
        //   @ Li,01 PSAY Subs(_cModelo,240)
        //   Li:=Li+1
        //EndIf
	@ Li,01 PSAY " "
	Li:=Li+1
	@ Li,01 PSAY " "
   Li:=Li+1
   @ Li, 01 PSAY "Atenciosamente," 
   Li:=Li+1
	@ Li,01 PSAY " "
	Li:=Li+1
	@ Li,01 PSAY " "
   Li:=Li+1	
	@ Li,01 PSAY " "
   Li:=Li+1	
   @ Li,01 PSAY  SUBSTR(SM0->M0_NOMECOM,1,16) //"Microsiga Ass. Software e Com. de Comp. Ltda"
   Li:=Li+1
   _cCob  := GetMv("MV_RESPCOB")

//        @ Li,01 PSAY  "Contato "+SM0->M0_TEL + "c/ "+_cCob   
        
        @ Li,01 PSAY  "Cleber Moraes - (11) 3948-4825 - cmoraes@cesvibrasil.com.br "
    	Li:=Li+1
        @ Li,01 PSAY  "Fabio Rosa    - (11) 3948-4815 - frosa@cesvibrasil.com.br "
    	Li:=Li+1   
    	 @ Li,01 PSAY  "Depto. Contas a Receber "
    	Li:=Li+1                                       
    	
//        @ Li,01 PSAY  "     ou (011) 6950-5079"
//   Li:=Li+1	
//   @ Li,01 PSAY  "Programa de Cobranca Automatica"
   // @ li,000 PSAY Chr(27)+"O"       // 1/6 Linhas por Polegada
	
Return(.T.)
   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return
