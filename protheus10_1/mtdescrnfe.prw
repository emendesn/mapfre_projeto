#Include "RWMAKE.CH"

USER Function MTDescrNFE()

Local cRetorno  := ''
Local aArea     := GetArea()
Local aAreaSF2  := SF2->( GetArea() )
Local aAreaSD2  := SD2->( GetArea() )
Local aAreaSE1  := SE1->( GetArea() )

dbSelectArea("SF2")
dbSetOrder(1)  //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL
dbSeek(xFilial('SF2')+SF3->F3_NFISCAL+SF3->F3_SERIE)

DbSelectArea("SD2")
DbSetOrder(3)  //D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
DbSeek(xFilial('SD2')+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)

Do	While !( Eof() ) .And. D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA == SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA
	cRetorno += POSICIONE("SB1",1,XFILIAL("SB1")+SD2->D2_COD,"B1_DESC") + ' | '
	DbSkip()
EndDo

cRetorno += ' | '

//-- Busca vencimentos dos titulos para sair na nota
dbSelectArea("SE1")
dbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
dbSeek(xFilial('SE1')+SF2->F2_SERIE+SF2->F2_DOC)
Do While ! eof() .and. SE1->(E1_PREFIXO+E1_NUM) == SF2->F2_SERIE+SF2->F2_DOC
	If ALLTRIM(SE1->E1_TIPO) == 'NF'
		nAliqIr := POSICIONE("SED",1,XFILIAL("SED")+SE1->E1_NATUREZ,"ED_PERCIRF")
		nAliqPi := POSICIONE("SED",1,XFILIAL("SED")+SE1->E1_NATUREZ,"ED_PERCPIS")
		nAliqCo := POSICIONE("SED",1,XFILIAL("SED")+SE1->E1_NATUREZ,"ED_PERCCOF")
		nAliqCs := POSICIONE("SED",1,XFILIAL("SED")+SE1->E1_NATUREZ,"ED_PERCCSL")
		nAliqIn := POSICIONE("SED",1,XFILIAL("SED")+SE1->E1_NATUREZ,"ED_PERCINS")
		nAbatimento := SumAbatRec(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_MOEDA,"V")
		
		cRetorno += "Vencimento "
		cRetorno += TransForm(SE1->E1_VENCREA, PesqPict("SE1","E1_VENCTO",8)) + ' | '   
/*
		if SE1->E1_ISS > 0
			cRetorno += "ISS "
			cRetorno += TransForm(SE1->E1_ISS, PesqPict("SE1","E1_ISS",17)) + ' | '
		EndIf
*/		
		if SE1->(E1_PIS+E1_COFINS+E1_CSLL) > 0 .AND. SE1->(E1_SABTPIS+E1_SABTCOF+E1_SABTCSL) == 0
			cRetorno += "PIS " + TransForm(nAliqPi,"@E 99.99") + "% : R$ "
			cRetorno += TransForm(SE1->E1_PIS, PesqPict("SE1","E1_PIS",17)) + ' | '
			cRetorno += "COFINS " + TransForm(nAliqCo,"@E 99.99") + "% : R$ "
			cRetorno += TransForm(SE1->E1_COFINS, PesqPict("SE1","E1_COFINS",17)) + ' | '
			cRetorno += "CSLL " + TransForm(nAliqCs,"@E 99.99") + "% : R$ "
			cRetorno += TransForm(SE1->E1_CSLL, PesqPict("SE1","E1_CSLL",17)) + ' | '
		EndIf
		if SE1->E1_IRRF > 0
			cRetorno += "IRRF " + TransForm(nAliqIr,"@E 99.99") + "% : R$ "
			cRetorno += TransForm(SE1->E1_IRRF, PesqPict("SE1","E1_IRRF",17)) + ' | '
		EndIf
		if SE1->E1_INSS > 0
			cRetorno += "INSS " + TransForm(nAliqIn,"@E 99.99") + "% : R$ "
			cRetorno += TransForm(SE1->E1_INSS, PesqPict("SE1","E1_INSS",17)) + ' | '
		EndIf

		cRetorno += "Valor liquido para pagamento : R$ "
		cRetorno += TransForm((SE1->E1_VALOR - nAbatimento), PesqPict("SE1","E1_IRRF",17)) + ' | '
	
	EndiF
	SE1->(DbSkip())
EndDo

RestArea( aAreaSE1 )
RestArea( aAreaSD2 )
RestArea( aAreaSF2 )
RestArea( aArea )

Return cRetorno