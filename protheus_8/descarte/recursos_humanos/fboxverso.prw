User Function fBoxVerso()
#INCLUDE "rwmake.ch"
#INCLUDE  "avprint.ch"
AVPRINT oPrn NAME "BOX VERSO"
oPrn:SetPortrait()       
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
AvNewPage
oSend(oPrn,"SayBitmap", 0280,0030,"CESVI.BMP",0250,0200 ) // Logotipo
oPrn:Say(0280,0400,"DEMONSTRATIVO DE PAGAMENTO MENSAL",oFont9,,,,3)
// Box da Primeira Linha de dados - Empresa
oPrn:Box(0430,0020,0530,1165)
oPrn:Box(0430,1165,0530,1555)
oPrn:Box(0430,1555,0530,1940)
oPrn:Box(0430,1940,0530,2350) 
oPrn:Say(0435,0025,"Empresa" ,oFont3,,,,3)
oPrn:Say(0435,1170,"CNPJ"    ,oFont3,,,,3)
oPrn:Say(0435,1560,"Mes Ref.",oFont3,,,,3)
oPrn:Say(0435,1945,"Seq."    ,oFont3,,,,3)

// Box da Segunda Linha de dados - Matricula
oPrn:Box(0580,0020,0680,0420)
oPrn:Box(0580,0420,0680,1930)
oPrn:Box(0580,1930,0680,2350)
oPrn:Say(0585,0025,"Matricula"   ,oFont3,,,,3)
oPrn:Say(0585,0425,"Nome"        ,oFont3,,,,3)
oPrn:Say(0585,1935,"Salario Base",oFont3,,,,3)

//Box da Terceira Linha de dados - Centro de Custo
oPrn:Box(0690,0020,0790,0600)
oPrn:Box(0690,0600,0790,1200)
oPrn:Box(0690,1200,0790,2350)
oPrn:Say(0695,0025,"Centro de Custo",oFont3,,,,3)
oPrn:Say(0695,0605,"Secao"          ,oFont3,,,,3)
oPrn:Say(0695,1205,"Funcao"         ,oFont3,,,,3)

//Box com cabecalho das verbas
oPrn:Box(0800,0020,0900,0220)
oPrn:Box(0800,0220,0900,0970)
oPrn:Box(0800,0970,0900,1170)
oPrn:Box(0800,1170,0900,1760)
oPrn:Box(0800,1760,0900,2350)
oPrn:Say(0805,0025,"Evento"   ,oFont3,,,,3)
oPrn:Say(0805,0225,"Descricao",oFont3,,,,3)
oPrn:Say(0805,0975,"Ref"      ,oFont3,,,,3)
oPrn:Say(0805,1175,"Proventos",oFont3,,,,3)
oPrn:Say(0805,1765,"Descontos",oFont3,,,,3)


//Box para preenchimento das verbas
oPrn:Box(0900,0020,2250,0220)
oPrn:Box(0900,0220,2250,0970)
oPrn:Box(0900,0970,2250,1170)
oPrn:Box(0900,1170,2250,1760)
oPrn:Box(0900,1760,2250,2350)

//Rodade para as bases
oPrn:Box(2250,0020,2350,0577)
oPrn:Box(2250,0577,2350,1134)
oPrn:Box(2250,1134,2350,1690)
oPrn:Box(2250,1690,2350,2350)

oPrn:Say(2255,0025,"Base para FGTS"      ,oFont3,,,,3)
oPrn:Say(2255,0582,"Sal.Cont.Inss"       ,oFont3,,,,3)
oPrn:Say(2255,1139,"Total de Vencimentos",oFont3,,,,3)
oPrn:Say(2255,1695,"Total de Descontos"  ,oFont3,,,,3)

oPrn:Box(2350,0020,2450,0577)
oPrn:Box(2350,0577,2450,1134)
oPrn:Box(2350,1134,2450,1690)
oPrn:Box(2350,1690,2450,2350)
oPrn:Say(2355,0025,"Fgts do Mes"     ,oFont3,,,,3)
oPrn:Say(2355,0582,"Base Ir"         ,oFont3,,,,3)
oPrn:Say(2355,1139,"Dep Ir"          ,oFont3,,,,3)
oPrn:Say(2355,1695,"Liquido a Recebe",oFont3,,,,3)

oPrn:Box(2450,0020,2550,0577)
oPrn:Box(2450,0577,2550,1134)
oPrn:Box(2450,1134,2550,1690)
oPrn:Box(2450,1690,2550,2350)
oPrn:Say(2455,0025,"Saldo FGTS Banco"   ,oFont3,,,,3)
oPrn:Say(2455,0582,"Cap.Seg.Vida-Func"  ,oFont3,,,,3)
oPrn:Say(2455,1139,"Cap.Seg.Vida-Conj"  ,oFont3,,,,3)
oPrn:Say(2455,1695,"Adto.13 Sal. no Ano",oFont3,,,,3)

oPrn:Box(2550,0020,2650,0577)
oPrn:Box(2550,0577,2650,1134)
oPrn:Box(2550,1134,2650,1690)
oPrn:Box(2550,1690,2650,2350)
oPrn:Say(2555,0025,"Banco Pagamento"   ,oFont3,,,,3)
oPrn:Say(2555,0582,"Agencia Bancaria"  ,oFont3,,,,3)
oPrn:Say(2555,1139,"Conta Corrente"    ,oFont3,,,,3)
oPrn:Say(2555,1695,"Data do Credito"   ,oFont3,,,,3)

//Box da mensagem
oPrn:Say(2660,0020,"Observações:",oFont3,,,,3)
oPrn:Box(2660,0220,2860,2350)

AvEndPage                        
AvEndPrint
Return