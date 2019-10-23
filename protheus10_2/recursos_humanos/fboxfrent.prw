User Function fBoxFrent()
#INCLUDE "rwmake.ch"
#INCLUDE  "avprint.ch"
AVPRINT oPrn NAME "BOX FRENTE"
oPrn:SetPortrait()       
oFont1 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont2 := oSend(TFont(),"New","Verdana"          ,0,12,,.T.,,,,,,,,,,,oPrn)  
oFont3 := oSend(TFont(),"New","Verdana"          ,0,09,,.T.,,,,,,,,,,,oPrn)  
oFont4 := oSend(TFont(),"New","Verdana"          ,0,08,,.T.,,,,,,,,,,,oPrn)  
oFont5 := oSend(TFont(),"New","Verdana"          ,0,08,,.F.,,,,,,,,,,,oPrn)  
oFont6 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  
oFont7 := oSend(TFont(),"New","Verdana"          ,0,14,,.T.,,,,,,,,,,,oPrn)  
oFont8 := oSend(TFont(),"New","Verdana"          ,0,14,,.F.,,,,,,,,,,,oPrn)  
oFont9 := oSend(TFont(),"New","Verdana"          ,0,25,,.T.,,,,,,,,,,,oPrn)  

aFontes := { oFont1, oFont2, oFont3, oFont4, oFont5, oFont6, oFont7, oFont8, oFont9 } 
AvNewPage
oPrn:Say(0020,0900,"CONFIDENCIAL",oFont9,,,,3)
oSend(oPrn,"SayBitmap", 0050,0030,"CESVI.BMP",0300,0100 ) // Logotipo
oPrn:Say(0380,1170,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont7,,,,3)
// Box para colar a etiqueta
oPrn:Box(0430,0020,1030,2350)
oPrn:Box(1040,0020,3100,2350)

// Preenchimento do achurado com confidencial                        
_nCont := 1045
For iaCont := 1 to 41
    oPrn:Say(_nCont,0020,Replicate("CONFIDENCIAL ",6)+"CONFIDE",oFont2,,,,3)
    _nCont += 50
Next iaCont
AvEndPage                        
AvEndPrint
Return