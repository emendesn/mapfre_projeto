#INCLUDE "rwmake.ch"
#INCLUDE  "avprint.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ficha1    º Autor ³MAAM                º Data ³  01/11/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Impressao dos funcionarios com dependentes comº±±
±±º          ³idade vencida para assistencia medica                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


User Function Ficha1


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cPerg            := "FICHA1"
Private cString := "SRA"
/*
Definicoes para padrao grafico
*/                                 

cBitMap    := "lgrl01.bmp"
cBitMap1   := "lgrl02.bmp"
nHeight    := 15
lBold      := .F.
lUnderLine := .F.
lPixel     := .T.
lPrint     := .F.
_nPage     := 0
nLin       := 99
dbSelectArea("SRA")
//dbSetOrder(1)

/*
Apos testes na 508 voltar as perguntas
ValidPerg()
*/                                    
VldPerg508()

pergunte(cPerg,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cFilDe  := mv_par01
cFilAte := mv_par02
cCcDe   := mv_par03
cCcAte  := mv_par04
cMatDe  := mv_par05
cMAtAte := mv_par06
cNomeDe := mv_par07
cNomeAte:= mv_par08
cEmp    := Space(17)
cEnd    := Space(30)
cBair   := Space(20)
cCid    := Space(20)
cUF     := Space(2)
cCGC    := Space(14)
cNome   := Space(30)
cCentroc:= Space(9)
cMat    := Space(6)
cPai    := Space(40)
cMae    := Space(40)
cCTPS   := Space(7)
cSerie  := Space(5)                        
cBairf  := Space(15)
cReserv := Space(12)
cEleit  := Space(13)
cEleitZ := Space(3)
cEleitS := Space(7)
cHabili := Space(13)
cRG     := Space(15)
cCPF    := Space(11)
cPIS    := Space(11)
cEstf   := Space(2)
cCidf   := Space(15)
cCepf   := Space(8)
cFormp  := Space(9)
cNOrdem := Space(9)
nJornad := 0.00
dNascto := CTOD("  /  /  ")
cLocNas := Space(2)
cEndF   := Space(30)
DAdmis  := CTOD("  /  /  ")
cFuncao := Space(30)
cSalario:= Space(14)        
cSalHora:= Space(14)        
cPares  := Space(10)
cCiv    := Space(11)
cInstr  := Space(20)
cNaciona:= Space(18)
cSexo   := Space(9)
cSeq    := Space(2)
cNomeDep:= Space(30)                           
cRaca   := Space(15)
cCatF   := Space(18)   
cHorar  := Space(50)
dDatNasc:= ctod("  /  /  ")
cIdade  := Space(2)
aDep    := {}        
aAltSal := {}

ProcRel()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ProcRel()
       RptStatus({|| RunReport() })
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP5 IDE            º Data ³  01/11/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport()

AVPRINT oPrn NAME "avprint"
oPrn:SetPortrait()
//                           Font                W  H  Bold          Underline Device
oFont1 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,10,,.T.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,09,,.T.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,14,,.F.,,,,,,,,,,,oPrn)  
oFont9 := oSend(TFont(),"New","Verdana"          ,0,20,,.T.,,,,,,,,,,,oPrn)  

aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8, oFont9 } 

dbSelectArea(cString)
dbgotop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


SetRegua(RecCount())

//dbGoTop()
While !EOF()

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica o cancelamento pelo usuario...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If lAbortPrint
		nLin := nLin + 100
		oPrn:Say(200,200,"CANCELADO PELO OPERADOR",oFont1)  
      Exit
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impressao do cabecalho do relatorio. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


   If (SRA->RA_Filial < cFilDe) .Or. (SRA->RA_Filial > cFilAte) .Or. ;
      (SRA->RA_NOME < cNomeDe)  .Or. (SRA->RA_NOME > cNomeAte)  .Or. ;
      (SRA->RA_MAT < cMatDe)    .Or. (SRA->Ra_MAT > cMatAte)    .Or. ;
      (SRA->RA_CC < cCcDe)      .Or. (SRA->Ra_CC > cCcAte)  
      
       SRA->(DBSKIP(1))
       Loop
          
   EndIf


   If nLin > 39 // Salto de Página. Neste caso o formulario tem 38 linhas...
      //Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 1
   Endif

    
   DBSELECTAREA("SRB")
   DBSETORDER(1)
   If DBSEEK(SRA->RA_FILIAL+SRA->RA_MAT)
     WHILE !EOF().And. SRA->RA_FILIAL+SRA->RA_MAT = SRB->RB_FILIAL+SRB->RB_MAT
            If SRB->RB_GRAUPAR =="C"
                     cPares:="Conjuge"
               ElseIf SRB->RB_GRAUPAR == "F"
                     cPares:="Filho(a) Valido "
               ElseIf SRB->RB_GRAUPAR == "O"
                     cPares:="Outros "
            EndIf
            If SRB->RB_TIPIR $"1*2*3"
                    cIR = "Sim"
               Else
                    cIR = "Nao"
             EndIf    
             If SRB->RB_TIPSF $"1*2"
                    cSF = "Sim"
                Else
                    cSf = "Nao"
              EndIf                                           
            aadd(aDep,{SRB->RB_NOME,cPares,DTOC(SRB->RB_DTNASC),cIr,cSF})
            DBSKIP()                             
     ENDDO
    EndIf
/*
Aqui       
*/
   DBSELECTAREA("SR7")
   DBSETORDER(1)
   If DBSEEK(SRA->RA_FILIAL+SRA->RA_MAT)
     WHILE !EOF().And. SRA->RA_FILIAL+SRA->RA_MAT = SR3->R3_FILIAL+SR3->R3_MAT              
            DBSELECTAREA("SR3")
            DBSETORDER( 1 )
            IF SR3->( DBSEEK( SR7->R7_FILIAL+SR7->R7_MAT+DTOS( SR7->R7_DATA )) )
               _CDESC := ( SR7->R7_DESCFUN )
            ELSE 
               _CDESC := "N CADASTRADO"   
            ENDIF
            aadd(aAltSal,{DTOC(SR7->R7_DATA),TRANSFORM(SR7->R7_VALOR,"@E 99,999,999.99"),_CDESC })
            DBSKIP()                             
     ENDDO
    EndIf
/*
aqui    
*/   
   DBSELECTAREA("SRA")


cEmp    := SM0->M0_CODFIL+"  -  "+SM0->M0_NOMECOM
cEnd    := SM0->M0_ENDCOB
cBair   := SM0->M0_BAIRCOB
cCid    := SM0->M0_CIDENT
cUF     := SM0->M0_ESTENT
cCGC    := SM0->M0_CGC   
cCepEmp := SM0->M0_CEPENT
cNome   := SRA->RA_NOME
cCentroc:= SRA->RA_CC
cDesc_Cc:= fDesc("SI3",xFilial("SI3")+SRA->RA_CC,"I3_DESC")
cMat    := SRA->RA_MAT
cPai    := SRA->RA_PAI
cMae    := SRA->RA_MAE
cCTPS   := SRA->RA_NUMCP
cSerie  := SRA->RA_SERCP
dEmiss  := DtoC( CtoD("  /  /  " ) )
cReserv := SRA->RA_RESERVI
cNOrdem := SRA->RA_CHAPA
cEleit  := SRA->RA_TITULOE
cEleitZ := SubStr( SRA->RA_ZONASEC,1,3 )
cEleitS := SubStr( SRA->RA_ZONASEC,4,8 )
cHabili := SRA->RA_HABILIT
nJornad := Str( SRA->RA_HRSMES )
cRG     := SRA->RA_RG
cCPF    := SRA->RA_CIC
cPIS    := SRA->RA_Pis
dNascto := DTOC(SRA->RA_NASC)
cLocNas := Subs(fDesc("SX5","12"+SRA->RA_NATURAL,"X5_DESCRI"),1,18)
cEndF   := SRA->RA_ENDEREC
DAdmis  := DTOC(SRA->RA_ADMISSA)
cFuncao := fDesc("SRJ",SRA->RA_CODFUNC,"RJ_DESC")
cSalario:= Transform(SRA->RA_SALARIO,"@E 99,999,999.99")
cSalHora:= Transform(SRA->RA_SALARIO/SRA->RA_HRSMES,"@E 999.99")
cNaciona:= Subs(fDesc("SX5","34"+SRA->RA_NACIONA,"X5_DESCRI"),1,18)
cBairf  := SRA->RA_BAIRRO
cEstf   := SRA->RA_ESTADO
cCidF   := SRA->RA_MUNICIP
cCEP    := SRA->RA_CEP
cFormp  := Subs(fDesc("SX5","40"+SRA->RA_TIPOPGT,"X5_Descri"),1,18)
cCatF   := Subs(fDesc("SX5","28"+SRA->RA_CATFUNC,"X5_Descri"),1,18)
cHorar  := fDesc("SR6",SRA->RA_TNOTRAB,"R6_DESC")
If SRA->RA_RACACOR == "2"
     cRaca:= "Branca   "     
   ElseIf SRA->RA_Sexo == "4"
     cRaca:= "Negra    " 
   ElseIf SRA->RA_Sexo == "6"
     cRaca:= "Amarela  "
   ElseIf SRA->RA_Sexo == "8"
     cRaca:= "Parda    "
   ElseIf SRA->RA_Sexo == "0"
     cRaca:= "Indigena "
 EndIf
              
If SRA->RA_SEXO == "M"
     cSexo:= "Masculino"
   ElseIf SRA->RA_Sexo == "F"
     cSexo:= "Feminino "  
EndIf     
If SRA->RA_ESTCIVI == "C"
     cCiv := "Casado    "
ELSEIF SRA->RA_ESTCIVI == "D"
     cCiv := "Divorciado"
ELSEIF SRA->RA_ESTCIVI == "M"
    cCiv := "Marital   "
ELSEIF SRA->RA_ESTCIVI == "Q"
     cCiv := "Desquitado"  
ELSEIF SRA->RA_ESTCIVI == "S"
     cCiv := "Solteiro  "  
ELSEIF SRA->RA_ESTCIVI == "V"
     cCiv := "Viuvo     "  
ENDIF

IF SRA->RA_GRINRAI == "10"
     cInstr := "Analfabeto         "
ELSEIF SRA->RA_GRINRAI == "20"
     cInstr := "Primario incompleto"
ELSEIF SRA->RA_GRINRAI == "25"
     cInstr := "Primario completo  "
ELSEIF SRA->RA_GRINRAI == "30"
     cInstr := "1o.Grau Imcompleto "  
ELSEIF SRA->RA_GRINRAI == "35"
     cInstr := "1o.Grau Completo   "   
ELSEIF SRA->RA_GRINRAI == "40"
     cInstr := "2o.Grau Imcompleto "  
ELSEIF SRA->RA_GRINRAI == "45"
     cInstr := "2o.Grau Completo   "  
ELSEIF SRA->RA_GRINRAI == "50"
     cInstr := "Superior Imcompleto"  
ELSEIF SRA->RA_GRINRAI == "55"
     cInstr := "Superior Completo  "  
ELSEIF SRA->RA_GRINRAI == "65"
     cInstr := "Mestrado           "  
ELSEIF SRA->RA_GRINRAI == "75"
     cInstr := "Doutorado          "  
ENDIF


      AVNEWPAGE            
      //box titulo
      oPrn:Box(0010,0390,0100,1840)
      //box autenticacao
      oPrn:Box(0010,1850,0360,2350)
      //box dados da empresa
      oPrn:Box(0120,0010,0360,1840)
      //box foto
      oPrn:Box(0370,0010,0920,0550)
      //box nome funcionario
      oPrn:Box(0370,0560,0480,2350)
      //box filiacao
      oPrn:Box(0490,0560,0610,2350)
      //box dados cadastrais
      oPrn:Box(0620,0560,0920,2350)
      //box admissao
      oPrn:Box(0930,0010,1030,2350)
      //box nascimento
      oPrn:Box(1040,0010,1140,2350)
      //box Estrangeiro
      oPrn:Box(1150,0010,1450,2350)
      //box Beneficiarios
      oPrn:Box(1460,0010,1510,2350)
      
      // IMPRIMINDO DADOS DO FUNCIONARIO          
      oPrn:Say( 0015,0400, If(SRA->RA_CATFUNC$"H*M","     FICHA DE REGISTRO DE EMPREGADO","     FICHA DE REGISTRO DE ESTAGIARIO"), oFont9,,,,3)      
      NLIN+=120
      oPrn:Say( NLIN, 0020 ,"EMPRESA ",oFont3,,,,3)
      oPrn:Say( NLIN, 0320,cEmp      ,oFont1,,,,3)
      oPrn:Say( NLIN, 1200,"CGC "    ,oFont3,,,,3)
      oPrn:Say( NLIN, 1400,cCgc      ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( NLIN, 0020,"ENDERECO ",oFont3,,,,3)
      oPrn:Say( NLIN, 0320,cEnd        ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"BAIRRO ",oFont3,,,,3)
      oPrn:Say( nLin,0320,cBair    ,oFont1,,,,3)
      oPrn:Say( nLin,1200,"CIDADE" ,oFont3,,,,3)
      oPrn:Say( nLin,1400,cCid     ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"CEP "        ,oFont3,,,,3)
      oPrn:Say( nLin,0320,cCepEmp       ,oFont1,,,,3)
      oPrn:Say( nLin,1200,"ESTADO"      ,oFont3,,,,3)
      oPrn:Say( nLin,1400,cUf           ,oFont1,,,,3)
      oPrn:Say( nLin,2000,"AUTENTICACAO",oFont3,,,,3)
      nLin+=110
      oPrn:Say( nLin,0570,"NOME",oFont3,,,,3)
      oPrn:Say( nLin,0860,cNome ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0570,"MATRICULA "  ,oFont3,,,,3)
      oPrn:Say( nLin,0860,cMat          ,oFont1,,,,3)
      oPrn:Say( nLin,1160,"No.ORDEM "   ,oFont3,,,,3)
      oPrn:Say( nLin,1260,cNOrdem       ,oFont1,,,,3)
      nLin+=60
      oPrn:Say( nLin,0570,"FILIACA0",oFont3,,,,3)
      oPrn:Say( nLin,0770,"PAI",oFont3,,,,3)
      oPrn:Say( nLin,1070,cPai ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0770,"MAE "  ,oFont3,,,,3)
      oPrn:Say( nLin,1070,cMae          ,oFont1,,,,3)
      nLin+=75
      oPrn:Say( nLin,0570,"CART.PROFISSIONAL ",oFont3,,,,3)
      oPrn:Say( nLin,0970,cCtps               ,oFont1,,,,3)
      oPrn:Say( nLin,1270,"SERIE "            ,oFont3,,,,3)
      oPrn:Say( nLin,1570,cSerie              ,oFont1,,,,3)
      oPrn:Say( nLin,1870,"EMISSAO "          ,oFont3,,,,3)
      oPrn:Say( nLin,2000,dEmiss              ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0570,"CART.RESERVISTA ",oFont3,,,,3)
      oPrn:Say( nLin,0870,cReserv           ,oFont1,,,,3)
      oPrn:Say( nLin,1500,"CATEGORIA "      ,oFont3,,,,3)
      oPrn:Say( nLin,1900,"REG. PROFISS "   ,oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin,0570,"TITULO ELEITOR " ,oFont3,,,,3)
      oPrn:Say( nLin,0870,cEleit            ,oFont1,,,,3)
      oPrn:Say( nLin,1200,"ZONA "           ,oFont3,,,,3)
      oPrn:Say( nLin,1500,cEleitZ           ,oFont1,,,,3)
      oPrn:Say( nLin,1800,"SECAO "          ,oFont3,,,,3)
      oPrn:Say( nLin,2100,cEleitS           ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0570,"CPF "      ,oFont3,,,,3)
      oPrn:Say( nLin,0870,cCPF        ,oFont1,,,,3)
      oPrn:Say( nLin,1200,"PIS/PASEP ",oFont3,,,,3)
      oPrn:Say( nLin,1400,cPis        ,oFont1,,,,3)
      oPrn:Say( nLin,1800,"CADASTRO " ,oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin, 0570,"CART. HABILITACAO ",oFont3,,,,3)
      oPrn:Say( nLin, 0870,cHabili             ,oFont1,,,,3)
      oPrn:Say( nLin, 1200,"CATEGORIA "        ,oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin,0570,"CART. IDENTIDADE ",oFont3,,,,3)
      oPrn:Say( nLin,0870,cRG                ,oFont1,,,,3)
      oPrn:Say( nLin,1200,"ORGAO EMISSOR "   ,oFont3,,,,3)
      oPrn:Say( nLin,1800,"EMISSAO "         ,oFont3,,,,3)
      nLin+=70
      /*
      segunda parte
      */
      oPrn:Say( nLin,0020,"ADMISSAO"     ,oFont3,,,,3)
      oPrn:Say( nLin,0320,dAdmis         ,oFont1,,,,3)
      oPrn:Say( nLin,0620,"OPCAO FGTS"   ,oFont3,,,,3)
      oPrn:Say( nLin,0920,dAdmis         ,oFont1,,,,3)
      oPrn:Say( nLin,1220,"FORM. PAGTO"  ,oFont3,,,,3)
      oPrn:Say( nLin,1520,If(SRA->RA_TIPOPGT=="M","Mensal ","Semanal") ,oFont1,,,,3)
      oPrn:Say( nLin,1820,"JORNADA "     ,oFont3,,,,3)
      oPrn:Say( nLin,2020,nJornad        ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"CARGO "  ,oFont3,,,,3)
      oPrn:Say( nLin,0320,cFuncao   ,oFont1,,,,3)
      oPrn:Say( nLin,0620,"SECAO "  ,oFont3,,,,3)
      oPrn:Say( nLin,0920,cDesc_CC  ,oFont1,,,,3)
      oPrn:Say( nLin,1220,"SALARIO ",oFont3,,,,3)
      oPrn:Say( nLin,1520,cSalario  ,oFont1,,,,3)
      oPrn:Say( nLin,1820,"SAL.HORA",oFont3,,,,3)
      oPrn:Say( nLin,2020,cSalHora  ,oFont1,,,,3)      
      nLin+=50
      /*
      terceira parte
      */
      oPrn:Say( nLin,0020,"DATA NASCIMENTO ",oFont3,,,,3)
      oPrn:Say( nLin,0320,dNascto           ,oFont1,,,,3)
      oPrn:Say( nLin,0620,"ESTADO CIVIL "   ,oFont3,,,,3)
      oPrn:Say( nLin,0920,cCiv              ,oFont1,,,,3)
      oPrn:Say( nLin,1320,"SEXO "           ,oFont3,,,,3)
      oPrn:Say( nLin,1420,SRA->RA_SEXO     ,oFont1,,,,3)
      oPrn:Say( nLin,1720,"GRAU INSTRUCAO"  ,oFont3,,,,3)
      oPrn:Say( nLin,2020,cInstr            ,oFont1,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"NACIONALIDADE ",oFont3,,,,3)
      oPrn:Say( nLin,0320,cNaciona        ,oFont1,,,,3)
      oPrn:Say( nLin,0620,"NATURALIDADE " ,oFont3,,,,3)
      oPrn:Say( nLin,1020,cLocNas         ,oFont1,,,,3)
      oPrn:Say( nLin,1320,"ESTADO NATAL " ,oFont3,,,,3)
      oPrn:Say( nLin,1520,SRA->RA_NATURAL,oFont1,,,,3)
      nLin+=70
      /*
      quarta parte
      */
      oPrn:Say( nLin,0020,"QUANDO ESTRENGEIRO ",oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"DATA CHEGADA "      ,oFont3,,,,3)
      oPrn:Say( nLin,1000,"CONJUGE BRASILEIRO ",oFont3,,,,3)
      oPrn:Say( nLin,1800,"Nu.CARTEIRA IDENT " ,oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"TIPO DE VISTO "   ,oFont3,,,,3)
      oPrn:Say( nLin,1000,"Nu.REGISTRO GERAL",oFont3,,,,3)
      oPrn:Say( nLin,1800,"Nu.DECRETO"       ,oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"NATURALIZADO"         ,oFont3,,,,3)
      oPrn:Say( nLin,1000,"VALID.CART.IDENTIDADE",oFont3,,,,3)
      oPrn:Say( nLin,1800,"VALID.CART.TRABALHO"  ,oFont3,,,,3)
      nLin+=50
      oPrn:Say( nLin,0020,"Nu.FILHOS",oFont3,,,,3)
      nLin+=70
      /*
      quinta parte
      */
      oPrn:Say( nLin,0020,"BENEFICIARIOS"     ,oFont3,,,,3)
      oPrn:Say( nLin,0620,"NOME DO DEPENDENTE",oFont3,,,,3)
      oPrn:Say( nLin,1120,"NASCIMENTO"        ,oFont3,,,,3)
      oPrn:Say( nLin,1320,"EST.CIVIL"         ,oFont3,,,,3)
      oPrn:Say( nLin,1620,"PARENTESCO"        ,oFont3,,,,3)
      nLin+=50

      IF LEN(ADEP) > 0 
                                            
         // IMPRIMINDO DADOS DOS DEPENDENTES
         FOR I:=1 TO LEN(ADEP)
              oPrn:Say( nLin,0620,ADEP[I,1],oFont1,,,,3)
              oPrn:Say( nLin,1120,ADEP[I,3],oFont1,,,,3)
              oPrn:Say( nLin,1320,"",oFont1,,,,3)
              oPrn:Say( nLin,1620,ADEP[I,2],oFont1,,,,3)
              nLin+=50

         NEXT    
         ADEP:={}
      Else
               oPrn:Say( nLin,20," ",oFont1,,,,3)
               nLin+=50
      ENDIF                      
      //box Endereco
      nLin+=10
      oPrn:Box(nLin,0010,nLin+50,2350)
      nLin+=60
      oPrn:Say( nLin,0620,"Endereco",oFont3,,,,3)
      oPrn:Say( nLin,1120,"Rua"     ,oFont3,,,,3)
      oPrn:Say( nLin,1320,"Numero",oFont3,,,,3)
      oPrn:Say( nLin,1630,"Bairro",oFont3,,,,3)
      oPrn:Say( nLin,1950,"Cidade",oFont3,,,,3)
     
      nLin+=50
      /*

      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

     @ NLIN, 01 PSAY Space(10)+cEndf+ Space(1)+cBairf+Space(3)+cCidf
      nLin+=50                                                                             
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Endereco Anterior"+Space(1)+"Rua"+Space(1)+"Numero"+Space(1)+"Bairro"+Space(1)+"Cidade"+Space(1)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY Space(10)+cEndf+ Space(1)+cBairf+Space(3)+cCidf
      nLin+=50                                                                             
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      
      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Ferias"+Space(1)+"Periodo Aquisitivo"+Space(1)+"Periodo Gozo"+Space(1)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      
      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Alteracoes de Salarios"+Space(1)+"Data"+Space(1)+"Salario "+Space(1)+"Motivo "+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      IF LEN(AALTSAL) > 0 
                                            
         // IMPRIMINDO DADOS DOS DEPENDENTES
         FOR I:=1 TO LEN(AALTSAL)
              @ NLIN, 10 PSAY  + AALTSAL[I,1] + SPACE(5) + AALTSAL[I,2] + SPACE(1) + AALTSAL[I,3] 
              nLin+=50
              oPrn:Say( nLin,,,oFont1,,,,3)
              oPrn:Say( nLin,,,oFont1,,,,3)
              oPrn:Say( nLin,,,oFont1,,,,3)
              oPrn:Say( nLin,,,oFont1,,,,3)
         NEXT    
         AALTSAL:={}
      Else
              @ NLIN, 01 PSAY " "
               nLin+=50
               oPrn:Say( nLin,,,oFont1,,,,3)
               oPrn:Say( nLin,,,oFont1,,,,3)
               oPrn:Say( nLin,,,oFont1,,,,3)
               oPrn:Say( nLin,,,oFont1,,,,3)

      ENDIF                      
      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Alteracoes de Cargo"+Space(1)+"Data"+Space(1)+"Funcao "+Space(1)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Alteracoes de Secao"+Space(1)+"Data"+Space(1)+"Secao "+Space(1)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"                                 
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Mudanca de horario"+Space(1)+"Data"+Space(1)+"Horario "+Space(1)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',2000)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+"Data Demissao "+Space(11)+"|"+"Assinatura Empregador   "+"|"+Space(1)+"Assinatura do Funcionario"+Space(1)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+Space(25)+"|"+"|"+Space(25)+"|"+"|"+Space(25)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+Space(25)+"|"+"|"+Space(25)+"|"+"|"+Space(25)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)

      @ NLIN, 01 PSAY "|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"
      nLin+=50
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      oPrn:Say( nLin,,,oFont1,,,,3)
      */
      AvEndPage
      DBSELECTAREA("SRA")                        
      dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DBSELECTAREA("SRA")                        
dbsetorder(1)
/*   
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif
*/

AvEndPage
AvEndPrint
//MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ AP5 IDE            º Data ³  01/11/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
aAdd(aRegs,{cPerg,"01","FILIAL DE ?"          ,,,"mv_ch1","C",02,00,0,"G","","mv_par01","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","FILIAL ATE?"          ,,,"mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","CENTRO CUSTO DE ?"    ,,,"mv_ch3","C",09,00,0,"G","","mv_par03","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","CENTRO DE CUSTO ATE ?",,,"mv_ch4","C",09,00,0,"G","","mv_par04","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","MATRICULA DE ?"       ,,,"mv_ch5","C",06,00,0,"G","","mv_par05","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","MATRICULA ATE ?"      ,,,"mv_ch6","C",06,00,0,"G","","mv_par06","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","NOME DE ?"            ,,,"mv_ch7","C",30,00,0,"G","","mv_par07","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","NOME ATE ?"           ,,,"mv_ch8","C",30,00,0,"G","","mv_par08","","","","","","","","","","","","","",""})
*/
aAdd(aRegs,{cPerg,"01","FILIAL DE ?"          ,"mv_ch1","C",02,00,0,"G","","mv_par01","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","FILIAL ATE?"          ,"mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","CENTRO CUSTO DE ?"    ,"mv_ch3","C",09,00,0,"G","","mv_par03","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","CENTRO DE CUSTO ATE ?","mv_ch4","C",09,00,0,"G","","mv_par04","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","MATRICULA DE ?"       ,"mv_ch5","C",06,00,0,"G","","mv_par05","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","MATRICULA ATE ?"      ,"mv_ch6","C",06,00,0,"G","","mv_par06","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","NOME DE ?"            ,"mv_ch7","C",30,00,0,"G","","mv_par07","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","NOME ATE ?"           ,"mv_ch8","C",30,00,0,"G","","mv_par08","","","","","","","","","","","","","",""})

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

/*
Apenas para teste na versao 508, excluir apos testes
*/

Static Function VldPerg508

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
aAdd(aRegs,{cPerg,"01","FILIAL DE ?"          ,,,"mv_ch1","C",02,00,0,"G","","mv_par01","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","FILIAL ATE?"          ,,,"mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","CENTRO CUSTO DE ?"    ,,,"mv_ch3","C",09,00,0,"G","","mv_par03","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","CENTRO DE CUSTO ATE ?",,,"mv_ch4","C",09,00,0,"G","","mv_par04","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","MATRICULA DE ?"       ,,,"mv_ch5","C",06,00,0,"G","","mv_par05","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","MATRICULA ATE ?"      ,,,"mv_ch6","C",06,00,0,"G","","mv_par06","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","NOME DE ?"            ,,,"mv_ch7","C",30,00,0,"G","","mv_par07","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","NOME ATE ?"           ,,,"mv_ch8","C",30,00,0,"G","","mv_par08","","","","","","","","","","","","","",""})
*/
aAdd(aRegs,{cPerg,"01","FILIAL DE ?"          ,"FILIAL DE ?"          ,"FILIAL DE ?"          ,"mv_ch1","C",02,00,0,"G","","mv_par01","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","FILIAL ATE?"          ,"FILIAL ATE?"          ,"FILIAL ATE?"          ,"mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","CENTRO CUSTO DE ?"    ,"CENTRO CUSTO DE ?"    ,"CENTRO CUSTO DE ?"    ,"mv_ch3","C",09,00,0,"G","","mv_par03","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","CENTRO DE CUSTO ATE ?","CENTRO DE CUSTO ATE ?","CENTRO DE CUSTO ATE ?","mv_ch4","C",09,00,0,"G","","mv_par04","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","MATRICULA DE ?"       ,"MATRICULA DE ?"       ,"MATRICULA DE ?"       ,"mv_ch5","C",06,00,0,"G","","mv_par05","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","MATRICULA ATE ?"      ,"MATRICULA ATE ?"      ,"MATRICULA ATE ?"      ,"mv_ch6","C",06,00,0,"G","","mv_par06","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","NOME DE ?"            ,"NOME DE ?"            ,"NOME DE ?"            ,"mv_ch7","C",30,00,0,"G","","mv_par07","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","NOME ATE ?"           ,"NOME ATE ?"           ,"NOME ATE ?"           ,"mv_ch8","C",30,00,0,"G","","mv_par08","","","","","","","","","","","","","",""})

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
