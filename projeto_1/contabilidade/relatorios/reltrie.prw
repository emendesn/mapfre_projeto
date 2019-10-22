#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±                         
±±ºPrograma  ³ RELTRIE º Autor ³ Juscelino Alves dos SantosºData ³11/11/13º±±          
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±             
±±ºDescricao ³ Relatório Movimentos x Conta                               º±±          
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±             
±±ºUso       ³ Específico                                                º±±                    
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±               
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                  
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                    

User Function RELTRIE()
Local aArea		:= GetArea()
Local aAreaSF1	:= SF1->(GetArea())    
Local cPerg     := "RELTRIE"

PutSx1(cPerg, "01","Emissao Inicial "     ,"Emissao Inicial "     ,"Emissao Inicial "     ,"mv_ch1","D",08,00,01,"G","",""   ,"","","mv_par01",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Data de Emissão da Nota"},{},{})
PutSx1(cPerg, "02","Emissao Final "	      ,"Emissao Final "       ,"Emissao Final "       ,"mv_ch2","D",08,00,01,"G","",""   ,"","","mv_par02",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Data de Emissão da Nota"},{},{})
PutSx1(cPerg, "03","Pagamentos Inicial "  ,"Pagamentos Inicial "  ,"Pagamentos Inicial "  ,"mv_ch3","D",08,00,01,"G","",""   ,"","","mv_par03",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Data de Pagamento dos Titulos"},{},{})
PutSx1(cPerg, "04","Pagamentos Final   "  ,"Pagamentos Final   "  ,"Pagamentos Final   "  ,"mv_ch4","D",08,00,01,"G","",""   ,"","","mv_par04",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Data de Pagamento dos Titulos"},{},{})
PutSx1(cPerg, "05","Vencimentos Inicial " ,"Vencimentos Inicial " ,"Vencimentos Inicial " ,"mv_ch5","D",08,00,01,"G","",""   ,"","","mv_par05",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Data de Vencimento dos Titulos"},{},{})
PutSx1(cPerg, "06","Vencimentos Final "   ,"Vencimentos Final "   ,"Vencimentos Final "   ,"mv_ch6","D",08,00,01,"G","",""   ,"","","mv_par06",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Data de Vencimento dos Titulos"},{},{})
PutSx1(cPerg, "07","Fornecedor Inicial"	  ,"Fornecedor Inicial"   ,"Fornecedor Inicial"   ,"mv_ch7","C",15,00,01,"G","","SA2","","","mv_par07",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Codigo do Fonecedor "},{},{})
PutSx1(cPerg, "08","Fornecedor Final"	  ,"Fornecedor Final"     ,"Fornecedor Final"     ,"mv_ch8","C",15,00,01,"G","","SA2","","","mv_par08",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","",""   ,{"Codigo do Fonecedor "},{},{})                              
PutSx1(cPerg, "09","Titulos"              ,"Titulos"              ,"Titulos"              ,"mv_ch9","N",01,00,01,"C","",""   ,"","","mv_par09","Não","Não","Não","","Sim","Sim","Sim","","","","","","","","",""   ,{"Se (Sim) Imprimi os Titulos a Pagar das Notas"})
PutSx1(cPerg, "10","Produtos"             ,"Produtos"             ,"Produtos"             ,"mv_cha","N",01,00,01,"C","",""   ,"","","mv_par10","Não","Não","Não","","Sim","Sim","Sim","","","","","","","","",""   ,{"Se (Sim) Imprimi os Produtos das Notas"})

If !Pergunte(cPerg,.T.)
   Return
EndIf
   
MsgRun(OemToAnsi("Aguarde, Consultando Notas de Entrada......"),, {|| U_RELIMP() })

RestArea(aAreaSF1)
RestArea(aArea)

Return

User Function RELIMP()
PRIVATE cDirDocs   	:= MsDocPath()
PRIVATE cPath	   	:= AllTrim(GetTempPath())  
Private cArqTmp := ""

cQuery := "SELECT *  "
cQuery += "FROM "   + RetSqlName( 'SF1' )+" SF1, "+ RetSqlName( 'SA2' )+" SA2 "
cQuery += " WHERE "
cQuery += "F1_FILIAL='"    	+ xFilial( 'SF1' )	+ "' AND "
cQuery += "F1_EMISSAO>='"  	+ DTOS(MV_PAR01)	+ "' AND "
cQuery += "F1_EMISSAO<='"  	+ DTOS(MV_PAR02)	+ "' AND "
///////////////////////////////////////////////////////
If (!Empty(MV_PAR03) .And. !Empty(MV_PAR04) .And. Dtos(MV_PAR03)<=Dtos(MV_PAR04))
   cQuery += "  EXISTS ("                
   cQuery += "SELECT * "
   cQuery += "FROM "+RetSqlName("SE2")+" SE2 "
   cQuery += "WHERE "
   cQuery += "	SE2.E2_FORNECE = SF1.F1_FORNECE AND "
   cQuery += "	SE2.E2_LOJA    = SF1.F1_LOJA    AND "
   cQuery += "	SE2.E2_PREFIXO = SF1.F1_PREFIXO AND "
   cQuery += "	SE2.E2_NUM     = SF1.F1_DOC     AND "  
   cQuery += "  SE2.E2_BAIXA BETWEEN '"+DTOS(mv_par03)+"' AND '"+DTOS(mv_par04)+"' AND "
   cQuery += "  SE2.D_E_L_E_T_<>'*') AND "
ElseIf ((!Empty(MV_PAR03) .And. Empty(MV_PAR04)) .Or. (Dtos(MV_PAR03)>Dtos(MV_PAR04)))
   MsgAlert("Data de Pagamento Invalido! Verifique os parametros.","Atencao!")
   Return 
EndIf
If (!Empty(MV_PAR05) .And. !Empty(MV_PAR06) .And. Dtos(MV_PAR05)<=Dtos(MV_PAR06))
   cQuery += "  EXISTS ("
   cQuery += "SELECT * "
   cQuery += "FROM "+RetSqlName("SE2")+" SE2 "
   cQuery += "WHERE "
   cQuery += "	SE2.E2_FORNECE = SF1.F1_FORNECE AND "
   cQuery += "	SE2.E2_LOJA    = SF1.F1_LOJA    AND "
   cQuery += "	SE2.E2_PREFIXO = SF1.F1_PREFIXO AND "
   cQuery += "	SE2.E2_NUM     = SF1.F1_DOC     AND "        
   cQuery += "  SE2.E2_VENCREA BETWEEN '"+DTOS(mv_par05)+"' AND '"+DTOS(mv_par06)+"' AND "
   cQuery += "  SE2.D_E_L_E_T_<>'*') AND "   
ElseIf ((!Empty(MV_PAR05) .And. Empty(MV_PAR06)) .Or. (Dtos(MV_PAR05)>Dtos(MV_PAR06)))
   MsgAlert("Data de Vencimento Invalido! Verifique os parametros.","Atencao!")
   Return 
EndIf
/////////////////////////////////////////////////////////
If Empty(MV_PAR08) .Or. MV_PAR08<MV_PAR07
   MV_PAR08:="999999"
EndIf                        
cQuery += "SF1.F1_FORNECE>='" 	+ MV_PAR07	+ "' AND "
cQuery += "SF1.F1_FORNECE<='" 	+ MV_PAR08	+ "' AND "		
cQuery += "SF1.D_E_L_E_T_<>'*' AND "     
cQuery += "SF1.F1_TIPO ='N' AND "
cQuery += "SA2.A2_COD = SF1.F1_FORNECE AND "
cQuery += "SA2.A2_LOJA = SF1.F1_LOJA "      
cQuery += " ORDER BY  SF1.F1_FILIAL,SF1.F1_FORNECE,SF1.F1_LOJA,SF1.F1_DOC "
cQuery := ChangeQuery(cQuery)

cAliasSF1 := "QRYSF1"
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), 'QRYSF1', .F., .T.)
aEval(SF1->(dbStruct()),{|x| If(x[2]!="C",TcSetField("QRYSF1",AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

_chistmp:=Space(20)
_chisnfe:=Space(20)
_cArqTRB:=CriaTrab(,.F.)
cArquivo	:= _cArqTRB + ".XLS"
cHTML		:= ""
Ferase(cArquivo)
nHdl := fCreate(cArquivo)
If nHdl == -1
   MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
   Return Nil
Endif
cHtml := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> '
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml"> '
cHtml += '<head> '
cHtml += '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> '
cHtml += '<title>Untitled Document</title> '
cHtml += '</head> '
cHtml += '<body> '
cHtml += '<table width="700" border="1"> '
cHtml += '  <tr> '                 

cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Prefixo'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Nota'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Serie'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Especie'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Emissao'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.Mercadorias'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.Bruto'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.Desconto'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.ICM'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.IPI'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.IRRF'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.INSS'+"</b></TD>"   
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.ISS'+"</b></TD>"     
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.COFINS'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.PIS'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.Titulos Aberto'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.Titulos Pago'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.IR Ret.'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.INSS Ret.'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.ISS Ret.'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.COFINS Ret.'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.PIS Ret.'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.CSLL Ret.'+"</b></TD>"    
cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'Vl.CSS Ret.'+"</b></TD>"    
cHtml += '  </tr> '
fWrite(nHdl,cHTML,Len(cHTML))
cHtml := ''

_nVALMERCG:=0
_nVALBRUTG:=0
_nDESCONTG:=0
_nVALICMG :=0
_nVALIPIG :=0
_nIRRFG   :=0
_nINSSG   :=0
_nISSG    :=0
_nVALIMP5G:=0
_nVALIMP6G:=0  
_nTitabetg:=0
_nTitbaixg:=0
_nIRvalg  :=0
_nINSSvalg:=0
_nISSvalg :=0
_nCOFvalg :=0
_nPISvalg :=0
_nCSLLvalg:=0
_nCSSvalg :=0
_lflimpg :=.F.
_limp    :=Iif(MV_PAR09=2,.T.,.F.) 
(cAliasSF1)->(dbGoTop()) 
alert(Alltrim((cAliasSF1)->F1_DOC))
(cAliasSF1)->(DbSkip())	
alert(Alltrim((cAliasSF1)->F1_DOC))
While  (cAliasSF1)->(!Eof())
	
	_cForn:=(cAliasSF1)->F1_FORNECE
    _cLoja:=(cAliasSF1)->F1_LOJA  
    _cNomFor:=Substr(Posicione("SA2",1 ,xFilial("SA1")+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA,"A2_NOME"),1,30)
	cHtml := '    <tr> '
	cHtml += "<TD rowspan='2' style='Background: #FFFFC0; font-style: Bold;'><b>"+"Codigo : "+_cForn+'-'+_cLoja+"<br>"+"C.G.C :"+Alltrim(SA2->A2_CGC)+"</b></TD>"+ CRLF
    cHtml += "<TD rowspan='2' style='Background: #FFFFC0; font-style: Bold;'><b>"+chr(160)+"Forn.:"+_cNomFor+"<br>"+"End.:"+;
    (cAliasSF1)->A2_END+"<br>"+"Bairro:"+(cAliasSF1)->A2_BAIRRO+"<br>"+"Cidade :"+(cAliasSF1)->A2_MUN+"</b></TD>"+ CRLF    
    cHtml += "<TD rowspan='2' style='Background: #FFFFC0; font-style: Bold;'><b>"+chr(160)+"Numero: "+(cAliasSF1)->A2_NR_END+"<br>"+"CEP:"+(cAliasSF1)->A2_CEP+"<br>"+"UF: "+(cAliasSF1)->A2_EST+"</b></TD>"+ CRLF    
	cHtml += '    </tr> '        
    fWrite(nHdl,cHTML,Len(cHTML))
    _cForn:=(cAliasSF1)->F1_FORNECE
    _cLoja:=(cAliasSF1)->F1_LOJA                    
    
    _nVALMERC:=0
	_nVALBRUT:=0
	_nDESCONT:=0
	_nVALICM :=0
	_nVALIPI :=0
	_nIRRF   :=0
	_nINSS   :=0
	_nISS    :=0
	_nVALIMP5:=0
	_nVALIMP6:=0  
    _nTitabett:=0
    _nTitbaixt:=0
	_nIRvalt  :=0
	_nINSSvalt:=0
	_nISSvalt :=0
	_nCOFvalt :=0
	_nPISvalt :=0
    _nCSLLvalt:=0
	_nCSSvalt :=0
	_nNotFor  :=0
	_lflimp   :=.F.                          
    While (cAliasSF1)->(!Eof()) .And. (cAliasSF1)->F1_FORNECE=_cForn  .And. (cAliasSF1)->F1_LOJA=_cLoja
            _nIRval   :=0
            _nINSSval :=0
            _nISSval  :=0
            _nCOFval  :=0
            _nPISval  :=0
            _nCSLLval :=0
            _nCSSval  :=0
            _nTitbaix :=0
            _nTitaber :=0
           
            fImpos(@_nTitbaix,@_nTitaber,@_nIRval,@_nINSSval,@_nISSval,@_nCOFval,@_nPISval,@_nCSLLval,@_nCSSval,.F.)
            cHtml := '    <tr> '         
			cHtml += '    </tr> '     
			fWrite(nHdl,cHTML,Len(cHTML))
            
    	    cHtml := '    <tr> '
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ (cAliasSF1)->F1_PREFIXO +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSF1)->F1_DOC +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSF1)->F1_SERIE +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSF1)->F1_ESPECIE +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Dtoc((cAliasSF1)->F1_EMISSAO) +'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_VALMERC),(cAliasSF1)->F1_VALMERC,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_VALBRUT),(cAliasSF1)->F1_VALBRUT,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_DESCONT),(cAliasSF1)->F1_DESCONT,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_VALICM),(cAliasSF1)->F1_VALICM,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_VALIPI),(cAliasSF1)->F1_VALIPI,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_IRRF),(cAliasSF1)->F1_IRRF,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_INSS),(cAliasSF1)->F1_INSS,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_ISS),(cAliasSF1)->F1_ISS,0),"@E 9,999,999,999.99")+'</font></td>'
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_VALIMP5),(cAliasSF1)->F1_VALIMP5,0),"@E 9,999,999,999.99")+'</font></td>'  // cofins
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSF1)->F1_VALIMP6),(cAliasSF1)->F1_VALIMP6,0),"@E 9,999,999,999.99")+'</font></td>'  // pis
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nTitaber),_nTitaber,0),"@E 9,999,999,999.99")+'</font></td>'                                    
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nTitbaix),_nTitbaix,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nIRval),_nIRval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nINSSval),_nINSSval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nISSval),_nISSval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCOFval),_nCOFval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nPISval),_nPISval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCSLLval),_nCSLLval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCSSval),_nCSSval,0),"@E 9,999,999,999.99")+'</font></td>'  
			cHtml += '    </tr> '        
			fWrite(nHdl,cHTML,Len(cHTML))
			If MV_PAR09=1 .And. MV_PAR10=1
               cHtml := '    <tr> '         
			   cHtml += '    </tr> '     
			   fWrite(nHdl,cHTML,Len(cHTML))   
			EndIf   
            
            If MV_PAR10=2
               cQuery := "SELECT *  "
               cQuery += "FROM "	    + RetSqlName( 'SD1' )
               cQuery += " WHERE "
               cQuery += "D1_FILIAL ='"+ (cAliasSF1)->F1_FILIAL+ "' AND "
               cQuery += "D1_DOC ='"+ (cAliasSF1)->F1_DOC+ "' AND "
               cQuery += "D1_FORNECE ='"+ (cAliasSF1)->F1_FORNECE+ "' AND "
               cQuery += "D1_LOJA    ='"+ (cAliasSF1)->F1_LOJA+ "' AND "
               cQuery += "D1_TIPO    ='"+ (cAliasSF1)->F1_TIPO+ "' AND "
               cQuery += "D1_SERIE   ='"+ (cAliasSF1)->F1_SERIE+ "' AND "
               cQuery += "D_E_L_E_T_<>'*'  "     
               cQuery += " ORDER BY  D1_FILIAL,D1_ITEM "
               cQuery := ChangeQuery(cQuery)
               cAliasSD1 := 'QRYSD1'
               DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), 'QRYSD1', .F., .T.)
               aEval(SD1->(dbStruct()),{|x| If(x[2]!="C",TcSetField("QRYSD1",AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
               (cAliasSD1)->(dbGoTop())  
               If (cAliasSD1)->(!Eof())     
                  cHtml := '    <tr> '         
                  cHtml += '    <td </td>'
                  cHtml += '    <td </td>'
                  cHtml += '    <td </td>'
                  cHtml += '    <td </td>'
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'ITEM'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'CODIGO'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'DESCRIÇÃO'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'UN'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'QUANTIDADE'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'VL.UNITARIO'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'TOTAL'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'TES'+"</b></TD>"    
                  cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'COD.FISCAL'+"</b></TD>"    
			      cHtml += '    </tr> '        
			      fWrite(nHdl,cHTML,Len(cHTML))
			   EndIf   
			   While (cAliasSD1)->(!Eof())     
			      cHtml := '    <tr> '    
			      cHtml += '    <td </td>'
                  cHtml += '    <td </td>'
                  cHtml += '    <td </td>'
                  cHtml += '    <td </td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSD1)->D1_ITEM +'</font></td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSD1)->D1_COD +'</font></td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Posicione("SB1",1,xFilial("SB1")+(cAliasSD1)->D1_COD,"B1_DESC") +'</font></td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ (cAliasSD1)->D1_UM +'</font></td>'                                   
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSD1)->D1_QUANT),(cAliasSD1)->D1_QUANT,0),"@E 9,999,999,999.99")+'</font></td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSD1)->D1_VUNIT),(cAliasSD1)->D1_VUNIT,0),"@E 9,999,999,999.99")+'</font></td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty((cAliasSD1)->D1_TOTAL),(cAliasSD1)->D1_TOTAL,0),"@E 9,999,999,999.99")+'</font></td>'
        		  cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSD1)->D1_TES +'</font></td>'
			      cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+(cAliasSD1)->D1_CF +'</font></td>'
			      cHtml += '    </tr> '        
			      fWrite(nHdl,cHTML,Len(cHTML))
                  (cAliasSD1)->(DbSkip())	
               End-While                 
               (cAliasSD1)->(DbCloseArea())
            EndIf
            
            fImpos(@_nTitbaix,@_nTitaber,@_nIRval,@_nINSSval,@_nISSval,@_nCOFval,@_nPISval,@_nCSLLval,@_nCSSval,_limp)
            
            _nVALMERC+=(cAliasSF1)->F1_VALMERC
	        _nVALBRUT+=(cAliasSF1)->F1_VALBRUT
	        _nDESCONT+=(cAliasSF1)->F1_DESCONT
	        _nVALICM +=(cAliasSF1)->F1_VALICM
	        _nVALIPI +=(cAliasSF1)->F1_VALIPI
	        _nIRRF   +=(cAliasSF1)->F1_IRRF
	        _nINSS   +=(cAliasSF1)->F1_INSS
	        _nISS    +=(cAliasSF1)->F1_ISS
	        _nVALIMP5+=(cAliasSF1)->F1_VALIMP5
	        _nVALIMP6+=(cAliasSF1)->F1_VALIMP6
	        _nTitabett+=_nTitaber
            _nTitbaixt+=_nTitbaix
        	_nIRvalt  +=_nIRval
        	_nINSSvalt+=_nINSSval
        	_nISSvalt +=_nISSval
        	_nCOFvalt +=_nCOFval
        	_nPISvalt +=_nPISval
            _nCSLLvalt+=_nCSLLval
        	_nCSSvalt +=_nCSSval
        	
        	_nVALMERCG+=(cAliasSF1)->F1_VALMERC
	        _nVALBRUTG+=(cAliasSF1)->F1_VALBRUT
	        _nDESCONTG+=(cAliasSF1)->F1_DESCONT
	        _nVALICMG +=(cAliasSF1)->F1_VALICM
	        _nVALIPIG +=(cAliasSF1)->F1_VALIPI
	        _nIRRFG   +=(cAliasSF1)->F1_IRRF
	        _nINSSG   +=(cAliasSF1)->F1_INSS
	        _nISSG    +=(cAliasSF1)->F1_ISS
	        _nVALIMP5G+=(cAliasSF1)->F1_VALIMP5
	        _nVALIMP6G+=(cAliasSF1)->F1_VALIMP6
	        _nTitabetg+=_nTitaber
            _nTitbaixg+=_nTitbaix
        	_nIRvalg  +=_nIRval
        	_nINSSvalg+=_nINSSval
        	_nISSvalg +=_nISSval
        	_nCOFvalg +=_nCOFval
        	_nPISvalg +=_nPISval
            _nCSLLvalg+=_nCSLLval
        	_nCSSvalg +=_nCSSval
	        _nNotFor++
	        _lflimp  :=.T.
	        _lflimpg :=.T.
	        (cAliasSF1)->(DbSkip())	
    End-While   
    
    If _lflimp 
       subtotne()
    EndIf
	  
   (cAliasSF1)->(DbSkip())	
	
End-While
(cAliasSF1)->(DbCloseArea())	  

If _lflimpg
   Gertotne() 
EndIf

cHtml := '</table> '
cHtml += '</body> '                                                                 
cHtml += '</html> '     
		
fWrite(nHdl,cHTML,Len(cHTML))
fClose(nHdl)

If _lflimpg
   CpyS2T( GetSrvProfString("StartPath","",GetAdv97()) + cArquivo, cPath, .T. )
   ShellExecute("OPEN",cPath + cArquivo,"","",5)
Else 
   MsgAlert("Não Existe Dados para a Geração da Planilha! Verifique os parametros.","Atencao!")
EndIf

Return





Static Function subtotne()
cHtml := '    <tr>'                                                                                         
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ "Total Fornecedor - " + Substr(_cNomFor,1,09) +'</font></td>'

cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ " ("+ALLTRIM(STR(_nNotFor))+" - "+IiF(_nNotFor > 1,"Notas","Nota")+")" +'</font></td>'

cHtml += '    <td </td>'
cHtml += '    <td </td>'
cHtml += '    <td </td>'


cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALMERC),_nVALMERC,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALBRUT),_nVALBRUT,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nDESCONT),_nDESCONT,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALICM),_nVALICM,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALIPI),_nVALIPI,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nIRRF),_nIRRF,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nINSS),_nINSS,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nISS),_nISS,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALIMP5),_nVALIMP5,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALIMP6),_nVALIMP6,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nTitabett),_nTitabett,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nTitbaixt),_nTitbaixt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nIRvalt),_nIRvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nINSSvalt),_nINSSvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nISSvalt),_nISSvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCOFvalt),_nCOFvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nPISvalt),_nPISvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCSLLvalt),_nCSLLvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCSSvalt),_nCSSvalt,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    </tr> '        
fWrite(nHdl,cHTML,Len(cHTML))

cHtml := '    <tr>'                                                                                         
cHtml += '    </tr> '        
fWrite(nHdl,cHTML,Len(cHTML))
Return 


Static Function Gertotne()
cHtml := '    <tr>'                                                                                         
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ "T o t a l  G e r a l  " +'</font></td>'



cHtml += '    <td </td>'
cHtml += '    <td </td>'
cHtml += '    <td </td>'
cHtml += '    <td </td>'


cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALMERCG),_nVALMERCG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALBRUTG),_nVALBRUTG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nDESCONTG),_nDESCONTG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALICMG),_nVALICMG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALIPIG),_nVALIPIG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nIRRFG),_nIRRFG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nINSSG),_nINSSG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nISSG),_nISSG,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALIMP5G),_nVALIMP5G,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nVALIMP6G),_nVALIMP6G,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nTitabetg),_nTitabetg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nTitbaixg),_nTitbaixg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nIRvalg),_nIRvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nINSSvalg),_nINSSvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nISSvalg),_nISSvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCOFvalg),_nCOFvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nPISvalg),_nPISvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCSLLvalg),_nCSLLvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(_nCSSvalg),_nCSSvalg,0),"@E 9,999,999,999.99") +'</font></td>'
cHtml += '    </tr> '        
fWrite(nHdl,cHTML,Len(cHTML))

cHtml := '    <tr>'                                                                                         
cHtml += '    </tr> '        
fWrite(nHdl,cHTML,Len(cHTML))
Return 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime desdobramento de Duplicatas.                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fImpos(_nTitbaix,_nTitaber,_nIRval,_nINSSval,_nISSval,_nCOFval,_nPISval,_nCSLLval,_nCSSval,_limpi)
aFornece := {{(cAliasSF1)->F1_FORNECE,(cAliasSF1)->F1_LOJA,PadR(MVNOTAFIS,Len(SE2->E2_TIPO))},;
{PadR(GetMv('MV_UNIAO') ,Len(SE2->E2_FORNECE)),PadR('00',Len(SE2->E2_LOJA)),PadR(MVTAXA,Len(SE2->E2_TIPO)) },;
{PadR(GetMv('MV_FORINSS'),Len(SE2->E2_FORNECE)),PadR('00',Len(SE2->E2_LOJA)),PadR(MVINSS,Len(SE2->E2_TIPO))},;
{PadR(GetMv('MV_MUNIC'),Len(SE2->E2_FORNECE)),PadR('00',Len(SE2->E2_LOJA)),PadR(MVISS,Len(SE2->E2_TIPO))} }
			
cPrefixo 		:= (cAliasSF1)->F1_PREFIXO  //If(Empty((cAliasSF1)->F1_PREFIXO),&(GetMV("MV_2DUPREF")),(cAliasSF1)->F1_PREFIXO)
dbSelectArea("SE2")
dbSetOrder(6)
dbSeek(xFilial("SE2")+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA+cPrefixo+(cAliasSF1)->F1_DOC)
If Found()
   DbSelectArea('SE2')
   DbSetOrder(6)
   dbSeek(xFilial()+aFornece[1][1]+aFornece[1][2]+cPrefixo+(cAliasSF1)->F1_DOC)
	
   If Found() .And. _limpi
   	  cHtml := '    <tr>'                                                                                         
      cHtml += '    <td </td>'
      cHtml += '    <td </td>'
      cHtml += '    <td </td>'
      cHtml += '    <td </td>'
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'PREFIXO'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'TITULO'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'PARCELA'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'VENCIMENTO'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'PAGAMENTO'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'VALOR'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'COD.RETENÇÃO'+"</b></TD>"    
      cHtml += "<TD style='Background: #B4CDCD; font-style: Bold;'><b>"+'NATUREZA'+"</b></TD>"    
      cHtml += '    </tr> '        
	  fWrite(nHdl,cHTML,Len(cHTML))
   EndIf
   
   _lflagfec:=.F.
   While !Eof() .And. xFilial()+aFornece[1][1]+aFornece[1][2]+cPrefixo+(cAliasSF1)->F1_DOC==;
		E2_FILIAL+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM
		
		If SE2->E2_TIPO == aFornece[1,3]
		   
		   If _limpi
              Fimpimp(@cHtml,_limpi)
           EndIf   
						
		   If Empty(E2_BAIXA)
		      _nTitaber+=SE2->E2_VALOR
		   Else 
		      _nTitbaix+=SE2->E2_VALOR
		   EndIf   
		   cParcCSS := SE2->E2_PARCCSS
		   cParcIR  := SE2->E2_PARCIR
		   cParcINSS:= SE2->E2_PARCINS
		   cParcISS := SE2->E2_PARCISS

		   If SE2->(FieldPos("E2_PARCCOF")) > 0 
			  cParcCof := SE2->E2_PARCCOF
		   EndIf
		   
		   If SE2->(FieldPos("E2_PARCPIS")) > 0 
		      cParcPis := SE2->E2_PARCPIS
		   EndIf 
		   
		   If SE2->(FieldPos("E2_PARCSLL")) > 0 
			  cParcCsll:= SE2->E2_PARCSLL
		   EndIf
		
		   nRecno   := SE2->(Recno())
						
		   dbSelectArea('SE2')
		   dbSetOrder(1)
		   If (!Empty(cParcIR)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcIR+aFornece[2,3])
			  If Empty(SE2->E2_BAIXA)
		         _nTitaber+=SE2->E2_VALOR
		      Else 
		        _nTitbaix+=SE2->E2_VALOR
		      EndIf   
		      _nIRval+=SE2->E2_VALOR
		      Fimpimp(@cHtml,_limpi)
		   Endif
		   
		   If (!Empty(cParcINSS)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcINSS+aFornece[3,3])
			  If Empty(SE2->E2_BAIXA)
		         _nTitaber+=SE2->E2_VALOR
		      Else 
		        _nTitbaix+=SE2->E2_VALOR
		      EndIf   
		      _nINSSval+=SE2->E2_VALOR
              Fimpimp(@cHtml,_limpi)
		   Endif
		   
		   If (!Empty(cParcISS)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcISS+aFornece[4,3])
			  If Empty(SE2->E2_BAIXA)
		         _nTitaber+=SE2->E2_VALOR
		      Else 
		        _nTitbaix+=SE2->E2_VALOR
		      EndIf   
		      _nISSval+=SE2->E2_VALOR  
		      Fimpimp(@cHtml,_limpi)
		   EndIf

		   If SE2->(FieldPos("E2_PARCCOF")) > 0 
			  If (!Empty(cParcCof)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcCof+aFornece[2,3])
				 If Empty(SE2->E2_BAIXA)
		            _nTitaber+=SE2->E2_VALOR
		         Else 
		           _nTitbaix+=SE2->E2_VALOR
		         EndIf   
		         _nCOFval+=SE2->E2_VALOR
		         Fimpimp(@cHtml,_limpi)
              Endif
           EndIf
		
		   If SE2->(FieldPos("E2_PARCPIS")) > 0 
		       If (!Empty(cParcPis)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcPis+aFornece[2,3])
					If Empty(SE2->E2_BAIXA)
		               _nTitaber+=SE2->E2_VALOR
		            Else 
		              _nTitbaix+=SE2->E2_VALOR
		            EndIf   
		            _nPISval+=SE2->E2_VALOR
		            Fimpimp(@cHtml,_limpi)
		       Endif
		   EndIf
		                   
		   If SE2->(FieldPos("E2_PARCSLL")) > 0 
				If (!Empty(cParcCsll)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcCsll+aFornece[2,3])
				    If Empty(SE2->E2_BAIXA)
		               _nTitaber+=SE2->E2_VALOR
		            Else 
		              _nTitbaix+=SE2->E2_VALOR
		            EndIf   
		            _nCSLLval+=SE2->E2_VALOR
		            Fimpimp(@cHtml,_limpi)
				Endif
		   EndIf

		   If (!Empty(cParcCSS)).And.dbSeek(xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcCSS+aFornece[2,3])
				While !Eof() .And. xFilial()+cPrefixo+(cAliasSF1)->F1_DOC+cParcCSS+aFornece[2,3] ==; 
					SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO

					If PadR(GetMv('MV_CSS'),Len(SE2->E2_NATUREZ)) == SE2->E2_NATUREZ
					   If Empty(SE2->E2_BAIXA)
		                  _nTitaber+=SE2->E2_VALOR
		               Else 
		                  _nTitbaix+=SE2->E2_VALOR
		               EndIf   
		               _nCSSval+=SE2->E2_VALOR
		               Fimpimp(@cHtml,_limpi)
					EndIf
					            
					dbSelectArea('SE2')
					dbSetOrder(1)
					dbSkip()
                EndDo
           Endif

           SE2->(dbGoto(nRecno))
						
        EndIf
        
        dbSelectArea('SE2')
        dbSetOrder(6)
        dbSkip()
   EndDo                    
EndIf

static Function Fimpimp(cHtml,_limp)
If _limp
   cHtml := '    <tr>'                                                                                         
   cHtml += '    <td </td>'
   cHtml += '    <td </td>'
   cHtml += '    <td </td>'
   cHtml += '    <td </td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+SE2->E2_PREFIXO +'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+SE2->E2_NUM +'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+SE2->E2_PARCELA +'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ dtoc(SE2->E2_VENCREA) +'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ dtoc(SE2->E2_BAIXA) +'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ Transform(Iif(!Empty(SE2->E2_VALOR),SE2->E2_VALOR,0),"@E 9,999,999,999.99")+'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+SE2->E2_CODRET+"/"+Alltrim(Posicione("SX5",1,xFilial("SX5")+"37"+SE2->E2_CODRET+Space(02),"SX5->X5_DESCRI"))+'</font></td>'
   cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ chr(160)+SE2->E2_NATUREZ+"/"+Alltrim(Posicione("SED",1,xFilial("SED")+SE2->E2_NATUREZ,"ED_DESCRIC"))+'</font></td>'
   cHtml += '    </tr> '        
   fWrite(nHdl,cHTML,Len(cHTML))						
EndIf