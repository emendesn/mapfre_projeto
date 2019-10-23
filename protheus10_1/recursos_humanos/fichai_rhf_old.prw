#INCLUDE "rwmake.ch"

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

Private cString
Private aOrd         	 := {"NOME","MATRICULA"}
Private CbTxt        	 := ""
Local cDesc1        	 := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2             := "de acordo com os parametros informados pelo usuario."
Local cDesc3             := "Ficha de Registro do empregado"
Local cPict              := ""
Private lEnd             := .F.
Private lAbortPrint      := .F.
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "FICHA1" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey         := 0
Private cPerg            := "FICHA1"
Local titulo             := "Ficha de Registro do Empregado"
Local nLin               := 80

Local Cabec1       := ""
Local Cabec2       := ""
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Local imprime      := .T.
Private wnrel      := "FICHA1" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString := "SRA"
/*
Definicoes para padrao grafico
*/
oFont   := TFont():New( "Arial"             ,,nHeight,,lBold,,,,,lUnderLine )
oFont1  := TFont():New( "Times New Roman"   ,,10     ,,lBold,,,,,lUnderLine )
oFont2  := TFont():New( "Times New Roman"   ,,12     ,,.t.  ,,,,,lUnderLine )
oFont3  := TFont():New( "Times New Roman"   ,,11     ,,lBold,,,,,lUnderLine )
oFont4  := TFont():New( "Times New Roman"   ,,10     ,,.t.  ,,,,,lUnderLine )
oFont5  := TFont():New( "Times New Roman"   ,,14     ,,lBold,,,,,lUnderLine )
oFont6  := TFont():New( "Times New Roman"   ,,11     ,,.t.  ,,,,,lUnderLine )
oFont7  := TFont():New( "Times New Roman"   ,,16     ,,.t.  ,,,,,lUnderLine )

oPrn := TMSPrinter():New()

dbSelectArea("SRA")
//dbSetOrder(1)


ValidPerg()

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

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

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)


Local nOrdem

dbSelectArea(cString)
dbgotop()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento das ordens. A ordem selecionada pelo usuario esta contida³
//³ na posicao 8 do array aReturn. E um numero que indica a opcao sele- ³
//³ cionada na mesma ordem em que foi definida no array aOrd. Portanto, ³
//³ basta selecionar a ordem do indice ideal para a ordem selecionada   ³
//³ pelo usuario, ou criar um indice temporario para uma que nao exista.³
//³ Por exemplo:                                                        ³
//³                                                                     ³
//³ nOrdem := aReturn[8]                                                ³
//³ If nOrdem < 5                                                       ³
//³     dbSetOrder(nOrdem)                                              ³
//³ Else                                                                ³
//³     cInd := CriaTrab(NIL,.F.)                                       ³
//³     IndRegua(cString,cInd,"??_FILIAL+??_ESPEC",,,"Selec.Registros") ³
//³ Endif                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nOrdem := aReturn[8]      

IF nOrdem == 1
   dbSetOrder(3)  
   dbSeek(cFilDe)
ElseIf nOrdem ==2
   dbSetOrder(1)
   dbSeek(cFilDe)
EndIf

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
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
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





    // IMPRIMINDO DADOS DO FUNCIONARIO
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+If(SRA->RA_CATFUNC$"H*M","           F I C H A  D E  R E G I S T R O  D E  E M P R E G A D O           ","           F I C H A  D E  R E G I S T R O  D E  E S T A G I A R I O         ")+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+SPACE(77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Empresa :"+ cEmp+Space(2)+"CGC:"+cCgc+Space(1)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Endereco:"+ cEnd+Space(38)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Bairro  :"+cBair+Space(1)+"Cidade:"+cCid+Space(20)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+"CEP  :"+cCepEmp+"Estado "+cUf+Space(20)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Nome "+cNome+" "+Space(20)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Matricula "+cMat+Space(7)+SRA->RA_CHAPA + Space(15)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+replicate('-',63)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Cart.Profissional :"+cCtps+Space(3)+"Serie:"+cSerie+Space(3)+"Emissao"+dEmiss+Space(9)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Cert.Reservista   :"+ cReserv + Space(1)+"Categoria"+Space(1)+" Reg. Profiss" +Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Titulo Eleitor    :"+cEleit+Space(1)+"Zona "+cEleitZ+Space(1)+"Secao "+cEleitS+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"C.P.F.            :"+cCPF+Space(3)+"Pis:"+cPIS+Space(1)+"Cadast. "+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Cart. Habilitacao "+cHabili+Space(3)+"Categoria "+Space(11)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(14)+"|"+"Cart. Identidade  :"+cRG+Space(1)+"Orgao Emissor"+Space(1)+"Emissao"+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      /*
      segunda parte
      */
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Data Admissao  : "+DAdmis+Space(15)+"Opcao FGTS  : "+dAdmis+"Forma Pagamento "+If(SRA->RA_TIPOPGT=="M","Mensal ","Semanal")+Space(1)+"Jornada "+nJornad+Space(1)+ "|"
      nlin++
      @ NLIN, 01 PSAY "|"+"Cargo : "+cFuncao+Space(20)+"Secao "+cDesc_CC+"Salario "+cSalario+ Space(1)+"Sal.Hora"+cSalHora+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      /*
      terceira parte
      */
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Data Nascimento : "+dNascto+Space(1)+"Estado Civil "+cCiv+Space(8)+"Sexo "+SRA->RA_SEXO+Space(1)+"Grau Instrucao "+cInstr+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+"Nacionalidade   : "+SRA->RA_NACIONA+Space(1)+cNaciona+"Naturalidade: "+cLocNas+"Estado Natal "+SRA->RA_NATURAL +Space(1) +"|"
      nlin++
                                                                                   
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      /*
      quarta parte
      */
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++                                                                                                                                                                
      @ NLIN, 01 PSAY "|"+"Quando Estrangeiro "+Space(58) +"|"
      nlin++
      @ NLIN, 01 PSAY "|"+"Data Chegada "+Space(1)+"Conjuge Brasileiro "+Space(1)+"Nu.Carteira Ident "+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+"Tipo de Visto "+Space(1)+"Nu.Registro Geral"+Space(1)+"Nu.Decreto"+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+"Naturalizado"+Space(1)+"Valid.Cart.Identidade"+Space(1)+"Valid.Cart.Trabalho"+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+"Nu.Filhos"+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      /*
      quinta parte
      */
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++                                                                                                                                                                
      @ NLIN, 01 PSAY "|"+"Beneficiarios"+Space(1)+"Nome do Dependente"+Space(1)+"Nascimento"+Space(1)+"Est.Civil"+Space(1)+"Parentesco"+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++                                                                                                                                                                
      IF LEN(ADEP) > 0 
                                            
         // IMPRIMINDO DADOS DOS DEPENDENTES
         FOR I:=1 TO LEN(ADEP)
              @ NLIN, 01 PSAY  + ADEP[I,1] + SPACE(5) + ADEP[I,2] + SPACE(1) + ADEP[I,3] + SPACE(7)+ ADEP[I,5]+Space(9)+ADEP[I,4]+Space(4)
              NLIN++
         NEXT    
         ADEP:={}
      Else
               @ NLIN, 01 PSAY " "
               NLIN++
      ENDIF                      
      
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Endereco"+Space(1)+"Rua"+Space(1)+"Numero"+Space(1)+"Bairro"+Space(1)+"Cidade"+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY Space(10)+cEndf+ Space(1)+cBairf+Space(3)+cCidf
      nlin++                                                                             
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Endereco Anterior"+Space(1)+"Rua"+Space(1)+"Numero"+Space(1)+"Bairro"+Space(1)+"Cidade"+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY Space(10)+cEndf+ Space(1)+cBairf+Space(3)+cCidf
      nlin++                                                                             
      
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Ferias"+Space(1)+"Periodo Aquisitivo"+Space(1)+"Periodo Gozo"+Space(1)+"|"
      nlin++
      NLIN++
      
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Alteracoes de Salarios"+Space(1)+"Data"+Space(1)+"Salario "+Space(1)+"Motivo "+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      IF LEN(AALTSAL) > 0 
                                            
         // IMPRIMINDO DADOS DOS DEPENDENTES
         FOR I:=1 TO LEN(AALTSAL)
              @ NLIN, 10 PSAY  + AALTSAL[I,1] + SPACE(5) + AALTSAL[I,2] + SPACE(1) + AALTSAL[I,3] 
              NLIN++
         NEXT    
         AALTSAL:={}
      Else
              @ NLIN, 01 PSAY " "
               NLIN++
      ENDIF                      

      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Alteracoes de Cargo"+Space(1)+"Data"+Space(1)+"Funcao "+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++

      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Alteracoes de Secao"+Space(1)+"Data"+Space(1)+"Secao "+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"                                 
      NLIN++


      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Mudanca de horario"+Space(1)+"Data"+Space(1)+"Horario "+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+replicate('-',77)+"|"
      NLIN++
                                                                                    
      @ NLIN, 01 PSAY "|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+"Data Demissao "+Space(11)+"|"+"Assinatura Empregador   "+"|"+Space(1)+"Assinatura do Funcionario"+Space(1)+"|"
      nlin++
      @ NLIN, 01 PSAY "|"+Space(25)+"|"+"|"+Space(25)+"|"+"|"+Space(25)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+Space(25)+"|"+"|"+Space(25)+"|"+"|"+Space(25)+"|"
      NLIN++
      @ NLIN, 01 PSAY "|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"+"|"+replicate('-',25)+"|"
      NLIN++

      SETPRC(0,0)
      eject
      DBSELECTAREA("SRA")                        
      dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   DBSELECTAREA("SRA")                        
   dbsetorder(1)
   
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

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
