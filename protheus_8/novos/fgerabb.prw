#INCLUDE 'Protheus.ch'
#INCLUDE 'TOPConn.ch'
#INCLUDE 'Rwmake.ch'
#include "TbiConn.ch"
#include "TbiCode.ch"    

#define CRLF Chr(13)+Chr(10)
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  |fgeraBB     ³Autor ³ Gilberto N. Almeida         |Data ³16/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao | Gera o Arquivo para BB.                                          ³±±
±±³          |                                                                  ³±±
±±³			 |                                                  				³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³  Nil                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Indra                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ*/

User Function fgeraBB() 

Local aRet	      	:=	{} 
Local dDataIni      := Ctod("  /  /  ")  
Local dDataFim      := Ctod("  /  /  ") 
Local nOpca         := 1  
Local nL            := 1
Local aSize			:= {}
Local aObjects		:= {}
Local aInfo 		:= {}
Local aPosObj       := {} 
Local cPlanRef      := Space(03)     
Local cLocArq       := ""  
Local aSitOpe       := {"4010","4016"}
Local oSitOpe       := Nil
Local cCombo        := NIL 
Local  aRadio       := {}
Local lContinua     := .T.


Private nHandle     := 0
Private nHandle1    := 0           
Private nHand       := NIL
Private oFocus1     := NIL
Private oFocus2     := NIL
Private oFocus3     := NIL 
Private nRadio      := 1 
Private oFont01     := TFont():New("Arial",07,14,,.T.,,,,.T.,.F.)

aObjects:={}
nOpca   := 0  

aSize   := MsAdvSize()
aInfo   := {aSize[1],aSize[2],aSize[3],aSize[4],3,3}

AADD(aObjects,{100,50,.T.,.F.})
AADD(aObjects,{100,100,.T.,.T.})

aPosObj := MsObjSize(aInfo, aObjects)   

Do While lContinua   

	DEFINE MSDIALOG oDlg2 TITLE OemToAnsi('Exportar CadDoc "Cosif" - Banco Central do Brasil') FROM 0,0 TO 280,450  PIXEL  STYLE DS_MODALFRAME STATUS
	
	@ 006,006 TO 130,210 LABEL "Opções " PIXEL OF oDlg2
	
	@ 015,010 SAY OemToAnsi("Exportar CaDoc - Cosif - Banco Central do Brasil") PIXEL OF oDlg2 COLOR CLR_BLUE FONT oFont01 
	
	@ 30,010 SAY "Data Inicial : " 	FONT oDlg2:oFont  OF oDlg2 PIXEL
	@ 30,070 MSGET oFocus1 vAR dDataIni     Picture "@D" SIZE 60,6	FONT oDlg2:oFont  OF oDlg2 PIXEL
	
	@ 45,010 SAY "Data Final : " 	FONT oDlg2:oFont  OF oDlg2 PIXEL
	@ 45,070 MSGET oFocus2 vAR dDataFim     Picture "@D" SIZE 60,6	FONT oDlg2:oFont  OF oDlg2 PIXEL
	
	@ 60,010 SAY "Plano Referencia : " 	FONT oDlg2:oFont  OF oDlg2 PIXEL
	@ 60,070 MSGET oFocus2 vAR cPlanRef   F3 "CVN1"   Picture "@!" SIZE 60,6	FONT oDlg2:oFont  OF oDlg2 PIXEL   
	
	@ 75,010 SAY "Tipo Documento " 	FONT oDlg2:oFont  OF oDlg2 PIXEL
	@ 75,070 MSCOMBOBOX oSitOpe VAR cCombo SIZE 40,50 COLOR CLR_BLACK ITEMS aSitOpe OF oDlg2 PIXEL 
	
	@ 90,010 SAY "Gera Planilha Excel ? " 	FONT oDlg2:oFont  OF oDlg2 PIXEL
	@ 90,070 RADIO aRadio VAR nRadio 3D SIZE 45, 10 PROMPT "Sim","Não" OF oDlg2 PIXEL
	
	@ 110,105 BUTTON "Cancela" SIZE 55,15 PIXEL OF oDlg2 Action (oDlg2:End(),nOpca:=0 )      
	@ 110,170 BUTTON "OK" SIZE 35,15 PIXEL OF oDlg2 Action (oDlg2:End(),nOpca:=1 )
	
	ACTIVATE MSDIALOG oDlg2 CENTERED  
 
	If  nOpca == 0 
	    lContinua := .F.
	    Exit
	Endif
			                   
    If Empty(dDataIni)

	    Aviso("Atencao","Você Precisa Digitar Data Inicial! "+CRLF+;
				           "  "+CRLF+CRLF+;
				           "  "+CRLF+;
				           "  ",{"Ok"},2,"Erro!!!")  
				           Loop
    ElseIf Empty(dDataFim)

	    Aviso("Atencao","Você Precisa Digitar Data Final! "+CRLF+;
				           ""+CRLF+CRLF+;
				           " "+CRLF+;
				           "  ",{"Ok"},2,"Erro!!!")  
				           Loop	  
	ElseIf Empty(cPlanRef)

		 Aviso("Atencao","Você Precisa Selecionar um Tipo de Plano Referência! "+CRLF+;
			           ""+CRLF+CRLF+;
			           " "+CRLF+;
			           "  ",{"Ok"},2,"Erro!!!")  
			           Loop 				           			           			           
	Endif 	     

	If  nOpca == 1
	    lContinua := .F.
	    Exit
	Endif 	
	
Enddo 
		                       

cLocArq:= cGetFile("(*.*) | *.* | ",OemToAnsi("Salvar arquivo..."), ,     , .F.,GETF_LOCALHARD)

If Empty(cLocArq)
   Return
Endif 

oProcess:= MsNewProcess():New( {|lEnd| Resultado( lEnd, oProcess, cLocArq,dDataIni,dDataFim,cPlanRef,cCombo )} )
	oProcess:Activate()

 Aviso("Atencao","Fim do Processo! "+CRLF+;
				           "  "+CRLF+CRLF+;
				           "  "+CRLF+;
				           "  ",{"Ok"},2,"Aviso!") 
				            
Return    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Resultado  ³ Autor ³ Gilberto N. Almeida  ³ Data ³14/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Processa a Geracao do Arquivo a Ser Importado Protheus.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ fImport                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Resultado(lEnd, oProcess, cLocal,dDataIni,dDataFim,cPlanRef,cCombo)
  
Local aRetRsutl := {}
Local nLinha    := 1 
Local nPos      := 0  
Local nB        := 1  
Local cTotal    := ""  
Local nLinha    := 1  
Local cLinha    := ""
 
Local nErro     := NIL
Private nHand1  :=  FCreate(cLocal,0 )
  
nErro     := FERROR()

IF nErro <> 0
	MSGINFO("Erro na criação do arquivo: ")
	Return
Endif 

fMontaQuery(Dtos(dDataIni),Dtos(dDataFim),cPlanRef)	 
 
DbSelectArea("TRB")

DbGoTop()              

If !Eof()  


// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Registro de Identificação.³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    oProcess:SetRegua2(TRB->(LastRec()))  
    
   	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³Neste ponto e craido o Header do Cosif. ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
    fWrite(nHand1,"#A1") 
    fWrite(nHand1,cCombo)  
    fWrite(nHand1,SM0->M0_CGC)  
    fWrite(nHand1,Space(08)) 
    fWrite(nHand1,StrZero(Month(Date()),2)+StrZero(Year(Date()),4))  
    fWrite(nHand1,"T")   
    fWrite(nHand1,Space(35)+CRLF) 
        
Else
   	Aviso("Erro","Não Existem Dados a Serem Processado!",{"OK"},2,"Cosi")  
   	Return  
Endif



// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Registro de Dados.³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Do While !Eof()
 
               
   oProcess:IncRegua2("Processando : " + TRB->CVD_CTAREF +" Valor : "+ AllTrim(Transform(TRB->TOTAL,"@E 9,999,999.99"))+" ")
  
   cTotal    := Alltrim(Str(TRB->TOTAL,18,2))
   cTotal    :=cTotal+Space(18-Len(cTotal))  
           
   fWrite(nHand1,TRB->CVD_CTAREF) 
   fWrite(nHand1,Space(04)) 
   fWrite(nHand1,cTotal) 
   fWrite(nHand1,Space(18))     
   
   If TRB->TOTAL > 0
      fWrite(nHand1,"+"+CRLF) 
   Else 
      fWrite(nHand1,"-"+CRLF)  
   Endif   
 
   
   nErro := FERROR()
  
   If nErro <> 0                                                                                 
	  Alert("Não foi possível efetuar a gravação!")
	  Return
   Endif
   
   nLinha+=1 
   
   TRB->(DbSkip())
   
 Enddo       
 
 nLinha+=1    
 
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Registro de Controle Final.³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

 cLinha := Alltrim(Str(nLinha,10,0)) 
 cLinha := cLinha+Space(6-Len(cLinha))     
 
 fWrite(nHand1,"@1")
 fWrite(nHand1,cLinha)  
 fWrite(nHand1,Space(63)+CRLF)  

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Fecha o Arquivo Gerado.³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

fClose(nHand1)   

If nRadio == 1
   Processa( {|| fGeraExcel(dDataIni) },"Aguarde Gerando Arquivo Excel" )
   
Endif  
 
Return  
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fMontaQuery³ Autor ³ Gilberto N. Almeida  ³ Data ³17/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rotina para Geracao de Query.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Indra                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fMontaQuery(dDataIni,dDataFim,cPlanRef) 

Local cQuery := ""
Local cAlias := "TRB"

If Select("TRB") > 0
	TRB->(dbCloseArea())
Endif

cQuery += " SELECT CT2.CT2_DEBITO,CT2.CT2_CREDIT,SUM(CT2.CT2_VALOR) TOTAL,CVD.CVD_CONTA,CVD.CVD_CTAREF,CT1_DESC01,CVN_DSCCTA "+CRLF
cQuery += " From " + RetSqlName("CT1")+ " CT1  "+CRLF 
 
cQuery += " INNER JOIN  " + RetSqlName("CVD")+ " CVD ON "+CRLF 
cQuery += "  CVD.D_E_L_E_T_ = ' ' AND CVD_FILIAL = '"+xFilial("CVD")+"' AND CVD_CONTA =CT1.CT1_CONTA  "+CRLF
cQuery += "  And CVD.CVD_CODPLA = '"+cPlanRef+"'  "+CRLF

cQuery += " INNER JOIN " + RetSqlName("CT2")+ " CT2 ON CT2.D_E_L_E_T_= ' ' "+CRLF    

cQuery += "INNER JOIN " + RetSqlName("CVN")+ " CVN ON CVN.D_E_L_E_T_= ' '  "+CRLF
cQuery += "  AND CVN_CTAREF = CVD_CTAREF "+CRLF

cQuery += " WHERE CT1.D_E_L_E_T_ = ' '  AND CT1_FILIAL = '"+xFilial("CT1")+"' AND CT1.CT1_CONTA =  CVD.CVD_CONTA AND CT2.CT2_DEBITO = CT1.CT1_CONTA  "+CRLF
cQuery += "  AND CT2.CT2_DATA  BETWEEN '" + dDataIni + "' AND '" + dDataFim + "'  "+CRLF
 
cQuery += " GROUP BY CT2_DEBITO,CT2_CREDIT,CVD_CONTA,CVD_CTAREF,CT1_DESC01,CVN_DSCCTA "+CRLF 

cQuery := ChangeQuery(cQuery)   

dbUseArea(.T., "TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)

Return 	   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fGeraExcel ³ Autor ³ Gilberto N. Almeida  ³ Data ³22/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rotina para Geracao Excel.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Indra                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fGeraExcel(dDataIni)

Local cDirDocs  := MsDocPath() 
Local cPath	    := AllTrim(GetTempPath())   
Local nErro     := NIL
Local cArquivo  := "" 
Local cArGerado := ""
Local aCabec    := {}
Local aRodape   := {} 
Local nLast     := 0
Local aDiret    := directory(cPath + "\" +"*.xml")  

Local  ncontTem:= 0 
//Limpa os Arquivos antigos XML do diretorio do usuário

For nL :=1 to Len(aDiret) 

    Ferase(cPath + aDiret[nL][1]) 
    
Next nL    

cArquivo  := CriaTrab(,.F.)

cArquivo += ".xml"

cArGerado := FCreate(cDirDocs + "\" + cArquivo)


nErro           := FERROR()

IF nErro <> 0
	MSGINFO("Erro na criação do arquivo: "+cArquivo)
	Return
Endif     

nLast := TRB->(LastRec()) 

DbSelectArea("TRB")
DbGoTop()          
    
TRB->(LastRec())      

DbGoTop()   

If !Eof()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Conta os Itens para montar XML.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Do While !Eof()   
	
	    ncontTem+=1     
	    
		TRB->(DbSkip())
	Enddo	

Endif                

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta o Arquivo XML.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

fMontaXML(@aCabec,@aRodape,ncontTem,dDataIni) 



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta o Arquivo em Disco XML.³
//³Cabecalho.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For nL :=1 to Len(aCabec)
   FWrite(cArGerado, Alltrim(aCabec[nL])+CRLF)
Next nL

DbSelectArea("TRB")
DbGoTop()              



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta os Itens do Arquivo a ser enviado Banco Cntral.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !Eof()               

	//Inicio dos Itens 

	Do While !Eof() 
	
	    ncontTem+=1  
	     
	    IncProc("Gerando Excel : "+TRB->CT2_DEBITO)    
	    
		FWrite(cArGerado, '   <Row ss:StyleID="s67">'+CRLF)     
		
	    FWrite(cArGerado, '   	  <Cell ss:StyleID="s64"><Data ss:Type="String">'+TRB->CT2_DEBITO+' </Data></Cell>'+CRLF)
		FWrite(cArGerado, '       <Cell ss:StyleID="s64"><Data ss:Type="String"> '+TRB->CT1_DESC01+'</Data></Cell>'+CRLF)  
	    FWrite(cArGerado, '   	  <Cell ss:StyleID="s64"><Data ss:Type="String">'+TRB->CT2_CREDIT+' </Data></Cell>'+CRLF)
		FWrite(cArGerado, '       <Cell ss:StyleID="s64"><Data ss:Type="String"> '+Posicione("CT1",1 ,xFilial("CT1") + TRB->CT2_CREDIT,  "CT1_DESC01")	+'</Data></Cell>'+CRLF)
		FWrite(cArGerado, '       <Cell ss:StyleID="s65"><Data ss:Type="Number">'+Alltrim(Str(TRB->TOTAL,10,2))+'</Data></Cell>'+CRLF)
		FWrite(cArGerado, '       <Cell ss:StyleID="s66"><Data ss:Type="String">'+TRB->CVD_CTAREF+'</Data></Cell>'+CRLF) 
		FWrite(cArGerado, '       <Cell ss:StyleID="s64"><Data ss:Type="String">'+NoAcento(AnsiToOem(AllTrim(TRB->CVN_DSCCTA)))+'</Data></Cell>'+CRLF)
		
	    FWrite(cArGerado, '   </Row>'+CRLF)
	    
        DbSelectArea("TRB")
        
		TRB->(DbSkip())   
		
	Enddo	

	//Fim dos Itens 

Endif  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta o Rodape do relatorio XML.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For nL :=1 to Len(aRodape)
   FWrite(cArGerado, Alltrim(aRodape[nL])+CRLF)
Next nL

	   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Fecha o Arquivo Gerado.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

fClose(cArGerado)    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Copia o arquivo do Servidor para o diretorio do usuario.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

CpyS2T(cDirDocs + "\" + cArquivo, cPath, .T.) 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Abre o arquivo XML gerado, no Excel.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open(cPath + cArquivo)
oExcelApp:SetVisible(.T.)
oExcelApp:Destroy() 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Limpas os XMLs dos diretório do usuário TMP, e Dirdoc.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aDiret    := directory(cDirDocs + "\" +"*.xml")  

For nL :=1 to Len(aDiret) 
   
   If  Ferase(cDirDocs + "\" +  aDiret[nL][1]) == -1
      Alert("Erro na Deleção do Arquivo : "+aDiret[nL][1])
   Endif
      
Next nL   
Ferase(cPath + cArquivo)   
Ferase(cDirDocs + "\" + cArquivo)  

Return  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fMontaXML  ³ Autor ³ Gilberto N. Almeida  ³ Data ³22/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rotina para Geracao XML.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Indra                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fMontaXML(aCabec,aRodape,ncontTem,dDataIni) 

Local cXML        := "" 
Local aCabec      := {}
Local aRodape     := {}                         

//Inico da Formatacao de Estilo

AADD(aCabec, '<?xml version="1.0"?> ')  
AADD(aCabec, '<?mso-application progid="Excel.Sheet"?> ') 
AADD(aCabec, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" ') 
AADD(aCabec, ' xmlns:o="urn:schemas-microsoft-com:office:office" ') 
AADD(aCabec, ' xmlns:x="urn:schemas-microsoft-com:office:excel" ') 
AADD(aCabec, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" ') 
AADD(aCabec, ' xmlns:html="http://www.w3.org/TR/REC-html40"> ') 
AADD(aCabec, ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"> ') 
AADD(aCabec, '  <Author>Gilberto Nogueira de Almeida</Author> ') 
AADD(aCabec, '  <LastAuthor>GNA</LastAuthor> ') 
AADD(aCabec, '  <Created>2014-10</Created> ') 
AADD(aCabec, '  <LastSaved>2014-10</LastSaved> ') 
AADD(aCabec, '  <Version>11.9999</Version> ') 
AADD(aCabec, ' </DocumentProperties> ') 
AADD(aCabec, ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office"> ') 
AADD(aCabec, '   <Colors> ') 
AADD(aCabec, '      <Color> ') 
AADD(aCabec, '          <Index>53</Index> ') 
AADD(aCabec, '          <RGB>#E8E4DC</RGB> ') 
AADD(aCabec, '       </Color> ') 
AADD(aCabec, '   <Color> ') 
AADD(aCabec, '    <Index>54</Index> ') 
AADD(aCabec, '    <RGB>#000000</RGB> ') 
AADD(aCabec, '   </Color> ') 
AADD(aCabec, '  </Colors> ') 
AADD(aCabec, ' </OfficeDocumentSettings> ') 
AADD(aCabec, ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel"> ') 
AADD(aCabec, ' <WindowHeight>8670</WindowHeight> ') 
AADD(aCabec, '   <WindowWidth>14115</WindowWidth> ') 
AADD(aCabec, '   <WindowTopX>600</WindowTopX> ') 
AADD(aCabec, '   <WindowTopY>120</WindowTopY> ') 
AADD(aCabec, '   <ProtectStructure>False</ProtectStructure> ') 
AADD(aCabec, '   <ProtectWindows>False</ProtectWindows> ') 
AADD(aCabec, '  </ExcelWorkbook> ') 
AADD(aCabec, '  <Styles> ') 
AADD(aCabec, '      <Style ss:ID="Default" ss:Name="Normal"> ') 
AADD(aCabec, '       <Alignment ss:Vertical="Center"/> ') 
AADD(aCabec, '       <Borders/> ') 
AADD(aCabec, '       <Font x:Family="Swiss"/> ') 
AADD(aCabec, '       <Interior/> ') 
AADD(aCabec, '       <NumberFormat/> ') 
AADD(aCabec, '       <Protection/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s62"> ') 
AADD(aCabec, '    <Borders> ') 
AADD(aCabec, '        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '    </Borders> ') 
AADD(aCabec, '    <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '    <Interior ss:Color="#E8E4DC" ss:Pattern="Solid"/> ') 
AADD(aCabec, '    <NumberFormat/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s63"> ') 
AADD(aCabec, '    <Borders> ') 
AADD(aCabec, '        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '    </Borders> ') 
AADD(aCabec, '    <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '    <Interior ss:Color="#E8E4DC" ss:Pattern="Solid"/> ') 
AADD(aCabec, '    <NumberFormat ss:Format="Standard"/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s64"> ') 
AADD(aCabec, '     <Alignment ss:Horizontal="Left" ss:Vertical="Center"/> ') 
AADD(aCabec, '        <Borders> ') 
AADD(aCabec, '            <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '            <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '            <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '            <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '        </Borders> ') 
AADD(aCabec, '        <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '        <NumberFormat/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s65"> ') 
AADD(aCabec, '    <Alignment ss:Horizontal="Right" ss:Vertical="Center"/> ') 
AADD(aCabec, '       <Borders> ') 
AADD(aCabec, '           <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '           <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '           <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '           <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '       </Borders> ') 
AADD(aCabec, '       <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '       <NumberFormat ss:Format="Standard"/> ') 
AADD(aCabec, '        </Style> ') 
AADD(aCabec, '           <Style ss:ID="s66"> ') 
AADD(aCabec, '              <Alignment ss:Horizontal="Right" ss:Vertical="Center"/> ') 
AADD(aCabec, '                 <Borders> ') 
AADD(aCabec, '                    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '                    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '                    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '                    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/> ') 
AADD(aCabec, '                 </Borders> ') 
AADD(aCabec, '                 <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '    <NumberFormat/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s67"> ') 
AADD(aCabec, '    <Borders/> ') 
AADD(aCabec, '    <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s68"> ') 
AADD(aCabec, '        <Alignment ss:Horizontal="Right" ss:Vertical="Center"/> ') 
AADD(aCabec, '             <Borders/> ') 
AADD(aCabec, '                <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '                <NumberFormat ss:Format="@"/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s69"> ') 
AADD(aCabec, '    <Borders/> ') 
AADD(aCabec, '        <Font x:Family="Swiss" ss:Bold="1"/> ') 
AADD(aCabec, '         <NumberFormat ss:Format="Standard"/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s70"> ') 
AADD(aCabec, '    <Borders/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '   <Style ss:ID="s71"> ') 
AADD(aCabec, '    <Borders/> ') 
AADD(aCabec, '    <NumberFormat ss:Format="Standard"/> ') 
AADD(aCabec, '   </Style> ') 
AADD(aCabec, '  </Styles> ') 
AADD(aCabec, '  <Names> ') 
AADD(aCabec, '   <NamedRange ss:Name="_xlfn.AGGREGATE" ss:RefersTo="=#NAME?" ss:Hidden="1"/> ') 
AADD(aCabec, '  </Names> ') 
AADD(aCabec, '  <Worksheet ss:Name="Grid Results"> ')

//Fim da Formatacao de Estilo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quando adicionar uma nova coluna adicionar aqui ExpandedRowCount= Colocar o numero de colunas.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Inicio do Cabecalho
 
AADD(aCabec, '   <Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="'+Alltrim(Str(ncontTem+6,10,0))+'" x:FullColumns="1" ') 
AADD(aCabec, '    x:FullRows="1" ss:StyleID="s70"> ') 
AADD(aCabec, '    <Column ss:StyleID="s70" ss:AutoFitWidth="0" ss:Width="114" ss:Span="1"/> ') 
AADD(aCabec, '    <Column ss:Index="3" ss:StyleID="s71" ss:AutoFitWidth="0" ss:Width="98.25"/> ') 
AADD(aCabec, '    <Column ss:StyleID="s70" ss:AutoFitWidth="0" ss:Width="166.5"/> ') 
AADD(aCabec, '    <Row ss:StyleID="s67"> ') 
AADD(aCabec, '        <Cell><Data ss:Type="String">PerÃ­odo: '+StrZero(Month(dDataIni),2)+'/'+StrZero(Year(dDataIni),4)+'</Data></Cell> ') 
AADD(aCabec, '        <Cell ss:StyleID="s69"/> ') 
AADD(aCabec, '    </Row> ') 
AADD(aCabec, '    <Row ss:Index="6" ss:StyleID="s67"> ') 
AADD(aCabec, '         <Cell ss:StyleID="s62"><Data ss:Type="String">DÃ©bito </Data></Cell> ') 
AADD(aCabec, '         <Cell ss:StyleID="s62"><Data ss:Type="String">Descricao</Data></Cell> ')       
AADD(aCabec, '         <Cell ss:StyleID="s62"><Data ss:Type="String">Credito </Data></Cell> ') 
AADD(aCabec, '         <Cell ss:StyleID="s62"><Data ss:Type="String">Descricao</Data></Cell> ') 
AADD(aCabec, '         <Cell ss:StyleID="s63"><Data ss:Type="String">Valor</Data></Cell> ') 
AADD(aCabec, '         <Cell ss:StyleID="s62"><Data ss:Type="String">Conta Banco Central</Data></Cell> ')    
AADD(aCabec, '         <Cell ss:StyleID="s62"><Data ss:Type="String">Descricao</Data></Cell> ') 
AADD(aCabec, '    </Row> ') 

//Fim  do Cabecalho     

//Inicio do Rodape 

AADD(aRodape, ' </Table> ')
AADD(aRodape, ' <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel"> ')
AADD(aRodape, '  <PageSetup> ')
AADD(aRodape, '   <PageMargins x:Bottom="0.984251969" x:Left="0.78740157499999996" ')
AADD(aRodape, '    x:Right="0.78740157499999996" x:Top="0.984251969"/> ')
AADD(aRodape, '   </PageSetup> ')
AADD(aRodape, '   <Print> ')
AADD(aRodape, '      <ValidPrinterInfo/> ')
AADD(aRodape, '      <PaperSizeIndex>9</PaperSizeIndex> ')
AADD(aRodape, '      <HorizontalResolution>300</HorizontalResolution> ')
AADD(aRodape, '      <VerticalResolution>300</VerticalResolution> ')
AADD(aRodape, '   </Print> ')
AADD(aRodape, '   <PageBreakZoom>60</PageBreakZoom> ')
AADD(aRodape, '  <Selected/> ')
AADD(aRodape, '   <Panes> ')
AADD(aRodape, '       <Pane> ')
AADD(aRodape, '          <Number>3</Number> ')
AADD(aRodape, '          <ActiveRow>23</ActiveRow> ')
AADD(aRodape, '          <ActiveCol>2</ActiveCol> ')
AADD(aRodape, '       </Pane> ')
AADD(aRodape, '   </Panes> ')
AADD(aRodape, '   <ProtectObjects>False</ProtectObjects> ')
AADD(aRodape, '   <ProtectScenarios>False</ProtectScenarios> ')
AADD(aRodape, '  </WorksheetOptions> ')
AADD(aRodape, ' </Worksheet> ')
AADD(aRodape, '</Workbook> ')    

//Fim do Rodape

Return()
