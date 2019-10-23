#include "rwmake.ch"    

User Function CARTA()   
 /*/
SetPrvt("TAMANHO,LIMITE,CDESC1,CDESC2,CDESC3,CSTRING")
SetPrvt("NOMEPROG,NTIPO,ARETURN,AORD,CPERG,NLASTKEY")
SetPrvt("LI,CSAVSCR1,CSAVCUR1,CSAVROW1,CSAVCOL1,CSAVCOR1")
SetPrvt("CFILIAL,NJUR,NMULTA,NVLRCORRIG,ASTRU,AMES")
SetPrvt("CBTXT,CBCONT,M_PAG,TITULO,CABEC1,CABEC2")
SetPrvt("WNREL,CARQTRAB,CARQX,CKEY,CFILTRO,NHORA")
SetPrvt("NMIN,DDATA,CFAXD,CFAXC,CFAXT,AFILES")
SetPrvt("NI,P_CNT,P_ATU,P_ANT,MV_PAR05,AARQFAX")
SetPrvt("CCLIENTE,CLOJA,CAGENTE,CARQFAX,CFAXF,_CRLF")
SetPrvt("NHANDLE,I,CTEL,CSTR,NAREASALVA,X")
SetPrvt("_CMODELO,_CCOB,")
/*/


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � EMICARTA � Autor � Alexandre N. Gomes    � Data � 27/07/95 ���
���          �          �       � Alberto S Garcia      �      � 01/09/95 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Emissao de Carta para Cobranca                             ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Microsiga                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
/*/
//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Private LI  := 80
Private limite           := 80
Private tamanho          := "P"
Private cDesc1 := "Este programa ira emitir uma Carta de Cobranca para o Cliente,"
Private cDesc2 := "relacionando os Titulos em Atraso"
Private cDesc3 := ""
Private cString:= "SE1"
Private nomeprog := "EMICARTA"
Private nTipo    := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private aOrd     := {}
Private cPerg    :="RFIN01" 
Private nomeprog         := "CARTAC"
nLastKey := 0
li := 0

//��������������������������������������������������������������Ŀ
//� Variaveis Utilizadas por Este Programa                       �
//����������������������������������������������������������������
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

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para Impressao do Cabecalho e Rodape    �
//����������������������������������������������������������������
cbtxt    := SPACE(10)
cbcont   := 0
m_pag    := 1
//��������������������������������������������������������������Ŀ
//� Monta os Cabecalhos                                          �
//����������������������������������������������������������������
titulo := ""
cabec1 := ""
cabec2 := ""
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
//
//
//
//
//
Pergunte( "RFIN01", .F. )
//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
/////wnrel:="CARTAC"            //Nome Default do relatorio em Disco  


Tamanho := "P"
Limite  := 80

wnrel:=SetPrint(cString,nomeprog,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

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
cFiltro := cFiltro + ".and. E1_CLIENTE >= '"+mv_par06+"' .and. E1_CLIENTE <= '"+mv_par07+"'"

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

//��������������������������������������������������������������Ŀ
//� Imprime o conteudo do arquivo de trabalho                    �
//����������������������������������������������������������������
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


//��������������������������������������������������������������Ŀ
//� Deleta Arquivo Temporario e Restaura os Indices Nativos.     �
//����������������������������������������������������������������
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
//��������������������������������������������������������������Ŀ
//� Devolve a condicao original do arquivo principal             �
//����������������������������������������������������������������
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

// Substituido pelo assistente de conversao do AP5 IDE em 16/03/01 ==> Function ImpCarta

Static Function ImpCarta()   

If  Li > 80 
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 5
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

   @ Li, 01 PSAY "Atraves de nosso sistema de cobran�a, verificamos que  encontra-se pendente de"
   Li:=Li+1   
   @ Li, 01 PSAY "de regularizacao, o(s) titulo(s) abaixo relacionado(s) referente(s) a utiliza-"
   Li:=Li+1   
   @ Li, 01 PSAY "cao de nossos servicos."  
   Li:=Li+1   
   @ Li, 01 PSAY "Caso o  pagamento tenha  sido efetuado, favor  enviar fax  para (11) 3942-1584"     
   Li:=Li+1   
   @ Li, 01 PSAY "o comprovante  do mesmo, p/ que  possamos efetuar liquidacao  do(s) titulo(s)."
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
        _cModelo := AllTrim(GetMV("MV_CAR0"+Str(MV_PAR09,1,0)))

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
   
// Substituido pelo assistente de conversao do AP5 IDE em 16/03/01 ==> Function Correcao
Static Function Correcao()
   nJur       := 0
   nMulta     := 0
   nVlrCorrig := 0
   nJur       := ( SE1->E1_SALDO*1.09-SE1->E1_SALDO) / 30 // ERA /(25*30)
   nMulta     := SE1->E1_SALDO*.02  // ERA / 10
   dData      := SE1->E1_VENCTO + 1 // ERA E1_VENCREA
   nVlrCorrig := SE1->E1_SALDO + nMulta
   While dData <= mv_par08
      nVlrCorrig := nVlrCorrig + nJur
      dData  := dData + 1
   Enddo
Return .T.