#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Finr131()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("LEND,CDESC1,CDESC2,CDESC3,CSTRING,TITULO")
SetPrvt("CABEC1,CABEC2,ALINHA,ARETURN,CPERG,NJUROS")
SetPrvt("NLASTKEY,NOMEPROG,TAMANHO,WNREL,AORD,CBCONT")
SetPrvt("CBTXT,LIMITE,NORDEM,LCONTINUA,CCOND1,CCOND2")
SetPrvt("CCARANT,NTIT1,NTIT2,NTIT3,NTOTJ,NTOT1")
SetPrvt("NTOT2,NTOT3,NTOT4,NTOTTIT,NTOTJUR,ACAMPOS")
SetPrvt("ATAM,NATRASO,NTOTABAT,NSALDO,DDATAREAJ,CFILTRO")
SetPrvt("BFILTRO,DDATAANT,LQUEBRA,NMESTIT1,NMESTIT2,NMESTIT3")
SetPrvt("NMESTIT4,NMESTTIT,NMESTITJ,CMOEDA,DBAIXA,ACDISPLAY")
SetPrvt("CNOMERESP,NDIAATR,NVLRPAG,NMULTA,NTOTPAG,LI")
SetPrvt("M_PAG,DDATA1,DDATA2,DDATA3,_NI,CALIAS")
SetPrvt("APERG,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 21/06/01 ==>     #DEFINE PSAY SAY
#ENDIF

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � FINR131  � Autor � Claudio Diniz         � Data � 07.12.99 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Carta de Cobranca para clientes em atraso                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe e � FINR131                                                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � CESVI BRASIL S/A                                           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿌lteracoes� Inclusao de parametro para taxa de permanencia e juros de  낢�
굇�          � mora - Alexandre P Athayde - jan/00                        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿌lteracoes� Alteracao no totalizador por pagina pois ele agregando os  낢�
굇�          � valores das paginas sequencialmente - Humberto S. Favero - 낢�
굇�          � data: 14/07/00                                             낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//�  Declaracao de variaveis                                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�



lEnd     := .F.
cDesc1   := "Imprime cartas de cobranca para clientes em atraso"
cDesc2   := ""
cDesc3   := ""
cString  := "SE1"
titulo   :=""
cabec1   :=""
cabec2   :=""
aLinha   :={}
aReturn  :={ "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
cPerg    :="FIN131"
nJuros   :=0
nLastKey :=0
nomeprog :="FINR131"
tamanho  :="G"

//旼컴컴컴컴컴컴컴컴컴컴컴컴커
//� Defini뇙o dos cabe놹lhos �
//읕컴컴컴컴컴컴컴컴컴컴컴컴켸

titulo := ""
cabec1 := ""
cabec2 := ""

ajustasx1()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

pergunte("FIN131",.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros   �
//� mv_par01         // Do Cliente         �
//� mv_par02         // Ate o Cliente      �
//� mv_par03         // Do Prefixo         �
//� mv_par04         // Ate o prefixo      �
//� mv_par05         // Do Titulo          �
//� mv_par06         // Ate o Titulo       �
//� mv_par07         // Do Banco           �
//� mv_par08         // Ate o Banco        �
//� mv_par09         // Do Vencimento      �
//� mv_par10         // Ate o Vencimento   �
//� mv_par11         // Da Natureza        �
//� mv_par12         // Ate a Natureza     �
//� mv_par13         // Da Emissao         �
//� mv_par14         // Ate a Emissao      �
//� mv_par15         // Qual Moeda         �
//� mv_par16         // Modelo de Carta    �
//� mv_par17         // Reajuste pelo vecto�
//� mv_par18         // Impr Tit em Descont�
//� mv_par19         // Relatorio Anal/Sint�
//� mv_par20         // Cons Data Base     �
//� mv_par21         // Nome Responsavel   �
//� mv_par22         // Taxa de permanecia �
//� mv_par23         // Multa              �
//� mv_par24         // Banco              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Envia controle para a fun뇙o SETPRINT �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

wnrel:="CARTACB"            //Nome Default do relatorio em Disco
aOrd :={"Por Cliente"}
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey == 27
	Return
End

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
End

#IFDEF WINDOWS
     RptStatus({|| FA130Imp()},titulo)// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==>      RptStatus({|| Execute(FA130Imp)},titulo)
     Return
// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==>      Function FA130IMP
Static Function FA130IMP()
#ENDIF

CbCont    := 0
CbTxt     := ""
limite    := 220
nOrdem    := 0
lContinua := .T.
cCond1    := ""
cCond2    := ""
cCarAnt   := ""
nTit1     := 0
nTit2     := 0
nTit3     := 0 
nTotJ     := 0
nTot1     := 0
nTot2     := 0
nTot3     := 0
nTot4     := 0
nTotTit   := 0
nTotJur   := 0
aCampos   := {}
aTam      := {}
nAtraso   := 0
nTotAbat  := 0
nSaldo    := 0
dDataReaj := CTOD("")
cFiltro   := ""
bFiltro   := NIL
dDataAnt  := dDataBase
lQuebra   := .F.
nMesTit1  := nMesTit2 := nMesTit3 := nMesTit4 := nMesTTit := nMesTitj := 0
nOrdem    := aReturn[8]
cMoeda    := Str(mv_par15,1)
dBaixa    := dDataBase
acDisplay := {}
cNomeResp := mv_par21
nDiaAtr   := 0
nJuros    := 0
nVlrPag   := 0
nMulta    := 0
nTotPag   := 0         
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Vari쟶eis utilizadas para Impress꼘 do Cabe놹lho e Rodap� �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cbtxt   := ""
cbcont  := 0
li      := 80
m_pag   := 1

dbSelectArea("SE1")
Set Softseek On


If Len( aReturn[7] ) > 0
	#IFDEF TOP
		msFilter( aReturn[7] )
	#ELSE
		cFiltro := "{|| "+aReturn[7] +"}"
		bFiltro := &cFiltro
		dbSetFilter(bFiltro)
	#ENDIF
EndIf


DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial()+MV_PAR01,.T.)
SetRegua(RecCount())
While !EOF() .and. xFILIAL()==SA1->A1_FILIAL .and. SA1->A1_COD<=MV_PAR02
 IncRegua()
 If SA1->A1_CARTACO == "N"
  DbSkip()
  Loop
 End

 nTot1     := 0
 nTot2     := 0
 nTot3     := 0
 dData1    := ctod("")
 dData2    := ctod("")
 dData3    := ctod("")

 dbSelectArea("SE1")
 dbSetOrder(2)
 Set Softseek On
 DbSeek(xFilial()+SA1->A1_COD)
 While !EOF() .and. xFilial()==E1_FILIAL .and. E1_CLIENTE==SA1->A1_COD

  //If SE1->E1_PREFIXO < mv_par03 .OR. SE1->E1_PREFIXO > mv_par04 .OR. ;
  //   SE1->E1_NUM < mv_par05 .OR. SE1->E1_NUM    > mv_par06 .OR. ;
  //   SE1->E1_PORTADO < mv_par07 .OR. SE1->E1_PORTADO > mv_par08 .OR. ;
  //   SE1->E1_VENCREA < mv_par09 .OR. SE1->E1_VENCREA > mv_par10 .OR. ;
  //   SE1->E1_NATUREZ < mv_par11 .OR. SE1->E1_NATUREZ > mv_par12 .or. ;
  //   SE1->E1_EMISSAO < mv_par13 .OR. SE1->E1_EMISSAO > mv_par14
  //   dbSkip()
  //   Loop
  //End
                               
   If SE1->E1_PREFIXO < mv_par03 .OR. SE1->E1_PREFIXO > mv_par04 
      dbSkip()
      Loop
    End
   
   If SE1->E1_PORTADO < mv_par07 .OR. SE1->E1_PORTADO > mv_par08 
      dbSkip()
      Loop
    End
   
   If SE1->E1_VENCREA < mv_par09 .OR. SE1->E1_VENCREA > mv_par10
      dbSkip()
      Loop
    End      
    
   If SE1->E1_NATUREZ < mv_par11 .OR. SE1->E1_NATUREZ > mv_par12
      dbSkip()
      Loop
    End    
      
    If SE1->E1_EMISSAO < mv_par13 .OR. SE1->E1_EMISSAO > mv_par14
      dbSkip()
      Loop
    End   
   
 
 
  If mv_par18 == 2 .and. E1_SITUACA $ "27"
   dbSkip()
   Loop
  End

  IF !Empty(SE1->E1_FATURA) .and. Substr(SE1->E1_FATURA,1,6) != "NOTFAT" .and. SE1->E1_DTFATUR <= dDataBase
   dbSkip()
   Loop
  End

  If xFilial("SE1") != SE1->E1_FILIAL
   dbSkip()
   Loop
  End

  #IFNDEF WINDOWS
    Inkey()
    If LastKey() == 286
     lEnd := .t.
    End
  #ENDIF

  IF lEnd
   Exit
  End

  IF SubStr(SE1->E1_TIPO,3,1) == "-" .Or. SE1->E1_EMISSAO>dDataBase .or.;
   (nOrdem==3.and.Empty(SE1->E1_PORTADO)) .or. ;
   (!Empty(E1_FATURA).and.Substr(E1_FATURA,1,6)!="NOTFAT".and.SE1->E1_DTFATUR<=dDataBase)
   dbSkip()
   Loop
  End

  If !Empty(SE1->E1_DTFATUR)              // Retroativo
   nSaldo := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,mv_par15)
  Else
   dDataReaj := IIF(mv_par17=1,dDataBase,E1_VENCREA)
   If mv_par20 == 1
    nSaldo:=SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,mv_par15,dDataReaj,,SE1->E1_LOJA)
   Else
    nSaldo:=xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,mv_par15)
   Endif 
   If SE1->E1_TIPO != "RA " .And. SE1->E1_TIPO != "NCC"
    nSaldo := nSaldo - SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1)
   EndIf
   nSaldo:=Round(NoRound(nSaldo,3),2)
  Endif

  If nSaldo <= 0.01
   dbSkip()
   Loop
  EndIf

  If MV_PAR16==1     // Modelo de Carta
//   If SE1->E1_CARTA1 == ctod("") 
    aadd(acDisplay,{SE1->E1_VENCREA,nSaldo,SE1->E1_NUM})
    RecLock("SE1",.F.)
    SE1->E1_CARTA1 := dtoc(dDataBase)
    MsUnlock()
    nTot1  := nTot1 + nSaldo
//   End
  End
 
  If MV_PAR16==2 
//   If SE1->E1_CARTA2 == ctod("") .and. SE1->E1_CARTA1 != ctod("")
    aadd(acDisplay,{SE1->E1_VENCREA,nSaldo,SE1->E1_NUM})
    RecLock("SE1",.F.)
    SE1->E1_CARTA2 := dtoc(dDataBase)
    MsUnlock()
    nTot2 := nTot2 + nSaldo
    dData1:= SE1->E1_CARTA1
//   End
  End

  If MV_PAR16==3 
//   If SE1->E1_CARTA3 == ctod("") .and. SE1->E1_CARTA2 != ctod("")
    aadd(acDisplay,{SE1->E1_VENCREA,nSaldo,SE1->E1_NUM})
    RecLock("SE1",.F.)
    SE1->E1_CARTA3 := dtoc(dDataBase)
    MsUnlock()
    nTot3 := nTot3 + nSaldo
//   End
  End

  DbSelectArea("SE1")
  Dbskip()
 End

 If nTot1 > 0  //carta1
  @ 03,06 PSAY "Sao Paulo, "
  @ 03,17 PSAY dtoc(dDATABASE)
  @ 05,06 PSAY "A"
  @ 06,06 PSAY SA1->A1_NOME
  @ 07,06 PSAY SA1->A1_END
  @ 08,06 PSAY SA1->A1_MUN+"-"+SA1->A1_EST+" CEP: "+SA1->A1_CEP
  @ 09,06 PSAY "Fone: " + SA1->A1_TEL + " " + "Fax : " + SA1->A1_FAX
  @ 10,06 PSAY "e-mail : " + SA1->A1_EMAIL
  @ 14,06 PSAY "A/C: Sr(a). "
  @ 14,18 PSAY SA1->A1_CONTATO
  @ 16,06 PSAY "Prezados Senhores:"
  @ 19,06 PSAY "REF.: DEBITOS EM ATRASO "
  @ 22,06 PSAY "Atraves de nosso sistema de cobranc"
  @ 22,41 PSAY "a,verificamos que encontra-se pen-"
  @ 23,06 PSAY "dente de regularizacao, o(s) titul"
  @ 23,40 PSAY "o(s) abaixo relacionado(s) referen-"
  @ 24,06 PSAY "te a utilizacao de nossos servicos."
  @ 25,06 PSAY "Caso o pagamento ja tenha sido efe"
  @ 25,40 PSAY "tuado, favor enviar via fax  numero"
  @ 26,06 PSAY "(11)3941-2348 o comprovante do mesm"
  @ 26,41 PSAY "o,para que possamos efetuar  a li-"
  @ 27,06 PSAY "quidacao do(s) titulos no sistema."
  @ 28,06 PSAY "Caso o pagamento nao tenha sido ef"
  @ 28,40 PSAY "etuado, proceder um deposito  ban -"
  @ 29,06 PSAY "cario identificado, da seguinte fo"
  @ 29,40 PSAY "rma: "
  @ 30,06 PSAY "CESVI BRASIL S/A"
  If MV_PAR24=1
     @ 31,06 PSAY "BANCO BRADESCO - AGENCIA: 665-3 CONTA No. 64057-3"
  Else
     @ 31,06 PSAY "BANCO UNIBANCO - AGENCIA: 0352 CONTA No. 820440-1
  EndIf   
  @ 33,06 PSAY "Para qualquer esclarecimento, liga"
  @ 33,40 PSAY "r para (11)3941-0699 Ramal 225/204"

  @ 35,06 PSAY "Vencimento       Valor"
  @ 35,30 PSAY "Titulo"
  @ 35,39 PSAY "D.A."
  @ 35,44 PSAY "Jrs.a.d."
  @ 35,54 PSAY "Multa"
  @ 35,64 PSAY "A Pagar"
  @ 36,06 PSAY "----------       -----"
  @ 36,30 PSAY "------  ----  --------  -----     -------"
			 
  li := 37
 
  nTotPag  := 0

  For _nI  := 1 to len( acDisplay )
   nDiaAtr := ddatabase - acDisplay[_nI, 1]
   nJuros  := nDiaAtr * mv_par22  
   nMulta  := (Mv_Par23/100) * acDisplay[_nI, 2]
   nVlrPag := acDisplay[_nI, 2] + nJuros + nMulta
   
   @ li, 06 PSAY acDisplay[_nI, 1]
   @ li, 19 PSAY acDisplay[_nI, 2] Picture "@er 999,999.99"
   @ li, 30 PSAY acDisplay[_nI, 3]

   @ li, 39 PSAY nDiaAtr Picture "@er 999"
   @ li, 43 PSAY nJuros  Picture "@er 9,999.99"
   @ li, 51 PSAY nMulta  Picture "@er 99,999.99"
   @ li, 62 PSAY nVlrPag Picture "@el 999,999.99"
   nTotPag  := nTotPag + nVlrPag
   li := li + 1
  
  Next
   

  @ li, 06 PSAY "Valor Total"
  @ li, 19 PSAY nTot1   Picture "@er 999,999.99"
  
  @ li, 62 PSAY nTotPag  Picture "@el 999,999.99"
  
  acDisplay := {} 

  @ 51,06 PSAY "Cesvi Brasil S/A"
  @ 52,06 PSAY cNomeResp
  @ 53,06 PSAY "Contas a Receber"
 End


 If nTot2 > 0 // carta 2  
  @ 03,06 PSAY "Sao Paulo, "
  @ 03,17 PSAY dtoc(dDATABASE)
  @ 05,06 PSAY "A"
  @ 06,06 PSAY SA1->A1_NOME
  @ 07,06 PSAY SA1->A1_END
  @ 08,06 PSAY SA1->A1_MUN+"-"+SA1->A1_EST+" CEP: "+SA1->A1_CEP
  @ 09,06 PSAY "Fone: " + SA1->A1_TEL + " " + "Fax : " + SA1->A1_FAX
  @ 10,06 PSAY "e-mail : " + SA1->A1_EMAIL
  @ 14,06 PSAY "A/C: Sr(a). "
  @ 14,18 PSAY SA1->A1_CONTATO
  @ 16,06 PSAY "Prezados Senhores:"
  @ 19,06 PSAY "REF.: DEBITOS EM ATRASO "
  @ 22,06 PSAY "Conforme correspondencia anterior "
  @ 22,40 PSAY "datada em "+ Transform(dDATA1,"99/99/99") +" nosso  sistema"
  @ 23,06 PSAY "registra que encontra-se pendente "
  @ 23,40 PSAY "de regularizacao, o(s) titulo(s) a-"
  @ 24,06 PSAY "baixo relacionado(s) referente a u"
  @ 24,40 PSAY "tilizacao de nossos servicos."
  @ 25,06 PSAY "Aguardamos a quitacao da pendencia"
  @ 25,40 PSAY " em pauta, na data do recebimento  "
  @ 26,06 PSAY "desta correspondecia, efetuando de"
  @ 26,40 PSAY "posito bancario identificado da se-"
  @ 27,06 PSAY "guinte forma:"
  @ 29,06 PSAY "CESVI BRASIL S/A"
  If MV_PAR24=1
    @ 30,06 PSAY "BANCO BRADESCO - AGENCIA: 665-3 CONTA No. 64057-3"
  Else
     @ 30,06 PSAY "BANCO UNIBANCO - AGENCIA: 0352 CONTA No. 820440-1
  EndIf   

  @ 31,06 PSAY "Para qualquer esclarecimento, liga"
  @ 31,40 PSAY "r para (11)3941-0699 Ramal 225/204"

  @ 34,06 PSAY "Vencimento       Valor"
  @ 34,30 PSAY "Titulo"
  @ 34,39 PSAY "D.A."
  @ 34,44 PSAY "Jrs.a.d."
  @ 34,54 PSAY "Multa"
  @ 34,64 PSAY "A Pagar"
  @ 35,06 PSAY "----------       -----"
  @ 35,30 PSAY "------  ----  --------  -----     -------"
			 

  li := 36

  nTotPag  :=  0

  For _nI  := 1 to len( acDisplay )
   nDiaAtr := ddatabase - acDisplay[_nI, 1]
   nJuros  := nDiaAtr * mv_par22  
   nMulta  := (Mv_Par23/100) * acDisplay[_nI, 2]
   nVlrPag := acDisplay[_nI, 2] + nJuros + nMulta
   
   @ li, 06 PSAY acDisplay[_nI, 1]
   @ li, 19 PSAY acDisplay[_nI, 2] Picture "@er 999,999.99"
   @ li, 30 PSAY acDisplay[_nI, 3]

   @ li, 39 PSAY nDiaAtr Picture "@er 999"
   @ li, 43 PSAY nJuros  Picture "@er 9,999.99"
   @ li, 51 PSAY nMulta  Picture "@er 99,999.99"
   @ li, 62 PSAY nVlrPag Picture "@el 999,999.99"
   nTotPag  := nTotPag + nVlrPag
   li := li + 1
  
  Next
   

  @ li, 06 PSAY "Valor Total"
  @ li, 19 PSAY nTot2   Picture "@er 999,999.99"
  
  @ li, 62 PSAY nTotPag  Picture "@el 999,999.99"
  
  acDisplay := {} 

  @ 51,06 PSAY "Cesvi Brasil S/A"
  @ 52,06 PSAY cNomeResp
  @ 53,06 PSAY "Contas a Receber"
 End

 If nTot3 > 0  

 End

 DbSelectArea("SA1")
 dbSkip()

End

Set Device To Screen
dbSelectArea("SE1")
Set Filter To
dbSetOrder(1)

If aReturn[5] == 1
 Set Printer TO
 dbCommitAll()
 ourspool(wnrel)
Endif
MS_FLUSH()
Return

// Substituido pelo assistente de conversao do AP5 IDE em 21/06/01 ==> FUNCTION AjustaSx1
/*/
Static FUNCTION AjustaSx1()
cAlias := Alias()
aPerg  := {}
cPerg  := "FIN131"

Aadd(aPerg,{"Considera Data Base ? ","N",1})

dbSelectArea("SX1")
If !dbSeek(cPerg+"20")
 RecLock("SX1",.T.)
 SX1->X1_GRUPO    := cPerg
 SX1->X1_ORDEM    := "20"
 SX1->X1_PERGUNT  := aPerg[1][1]
 SX1->X1_VARIAVL  := "mv_chj"
 SX1->X1_TIPO     := aPerg[1][2]
 SX1->X1_TAMANHO  := aPerg[1][3]
 SX1->X1_PRESEL   := 1
 SX1->X1_GSC      := "C"
 SX1->X1_VAR01    := "mv_par20"
 SX1->X1_DEF01    := "Sim"
 SX1->X1_DEF02    := "N꼘"
EndIf
dbSelectArea(cAlias)
Return
/*/




/*_______________________________________________________________________________
└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└�
└+-----------+------------+-------+----------------------+------+------------+└
└� Fun豫o    � CriaSX1    � Autor �                      � Data � 01/07/2006 └�
└+-----------+------------+-------+----------------------+------+------------+└
└� Descri醴o � Objetivo desta funcao e verificar se existe o grupo de        └�
└�           � perguntas, se nao existir a funcao ira cria-lo.               └�
└+-----------+---------------------------------------------------------------+└
└� Par�metro � cPerg -> Nome com  grupo de perguntas em quest�o.             └�
└+-----------+---------------------------------------------------------------+└
└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└└�
�������������������������������������������������������������������������������*/
Static Function CriaSx1()
Local j  := 0
Local nY := 0
Local aAreaAnt := GetArea()
Local aAreaSX1 := SX1->(GetArea())
Local aReg := {}
cPerg        := PADR(cPerg,len(sx1->x1_grupo))
aAdd(aReg,{cPerg,"01","Do cliente      : ?     ","mv_ch1","C",6,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"02","Ate o cliente   : ?     ","mv_ch2","C",6,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"03","Do prefixo      : ?     ","mv_ch3","C",3,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"04","Ate o prefixo   : ?     ","mv_ch4","C",3,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"05","Do titulo       : ?     ","mv_ch5","C",6,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"06","Ate o titulo    : ?     ","mv_ch6","C",6,0,0,"G","","mv_par06","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"07","Do banco        : ?     ","mv_ch7","C",3,0,0,"G","","mv_par07","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"08","Ate o banc0     : ?     ","mv_ch8","C",3,0,0,"G","","mv_par08","","","","","","","","","","","","","","",""})    
aAdd(aReg,{cPerg,"09","Do banco        : ?     ","mv_ch9","C",6,0,0,"G","","mv_par09","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"10","Ate o banco     : ?     ","mv_cha","C",6,0,0,"G","","mv_par10","","","","","","","","","","","","","","",""})    
aAdd(aReg,{cPerg,"11","Do vencimento   : ?     ","mv_chb","D",8,0,0,"G","","mv_par11","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"12","Ate o vencimento: ?     ","mv_chc","D",8,0,0,"G","","mv_par12","","","","","","","","","","","","","","",""}) 
aAdd(aReg,{cPerg,"13","Da natureza     : ?     ","mv_chd","C",10,0,0,"G","","mv_par13","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"14","Ate a natureza  : ?     ","mv_che","C",10,0,0,"G","","mv_par14","","","","","","","","","","","","","","",""})  
aAdd(aReg,{cPerg,"15","Da emissao      : ?     ","mv_chf","D",8,0,0,"G","","mv_par15","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"16","Ate a emissao   : ?     ","mv_chg","D",8,0,0,"G","","mv_par16","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"17","Moeda           : ?     ","mv_chh","N",2,0,0,"G","","mv_par17","","","","","","","","","","","","","","",""})                                                                                                                                       
aAdd(aReg,{cPerg,"18","Modelo de carta : ?     ","mv_chi","N",1,0,0,"G","","mv_par18","","","","","","","","","","","","","","",""}) 
aAdd(aReg,{cPerg,"17","Moeda           : ?     ","mv_chj","N",2,0,0,"G","","mv_par19","","","","","","","","","","","","","","",""}) 




aAdd(aReg,{"X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_CNT01","X1_VAR02","X1_DEF02","X1_CNT02","X1_VAR03","X1_DEF03","X1_CNT03","X1_VAR04","X1_DEF04","X1_CNT04","X1_VAR05","X1_DEF05","X1_CNT05","X1_F3"})

dbSelectArea("SX1")
dbSetOrder(1)
                               
For ny:=1 to Len(aReg)-1
	If !dbSeek(aReg[ny,1]+aReg[ny,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aReg[ny])
			FieldPut(FieldPos(aReg[Len(aReg)][j]),aReg[ny,j])
		Next j
		MsUnlock()
	EndIf
Next ny

RestArea(aAreaSX1)
RestArea(aAreaAnt)

Return Nil