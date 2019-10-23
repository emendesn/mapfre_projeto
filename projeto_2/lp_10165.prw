#include "rwmake.ch"   

User Function LP_10165 
Local _nPis := 0, _nCof := 0, _nCsl := 0
Local _nValPis := 0, _nValCof := 0, _nValCsl := 0
Local _nValIss := 0
Local _retorno := 0

If SED->ED_CALCPIS == "S" .AND. SED->ED_PERCPIS > 0 .AND. SD1->D1_TOTAL > 5000
   _nPis := 0.0065
   _nValPis := Round(SD1->D1_TOTAL * _nPis,2)
EndIf

If SED->ED_CALCCOF == "S" .AND. SED->ED_PERCCOF > 0 .AND. SD1->D1_TOTAL > 5000
   _nCof := 0.03
   _nValCof := Round(SD1->D1_TOTAL * _nCof,2)
EndIf

If SED->ED_CALCCSL == "S" .AND. SED->ED_PERCCSL > 0 .AND. SD1->D1_TOTAL > 5000
   _nCsl := 0.01
   _nValCsl := Round(SD1->D1_TOTAL * _nCsl,2)                   
EndIf                                   

If SA2->A2_RECISS == "N"            
	_nValIss := SD1->D1_VALISS
EndIf

If SD1->D1_VALIRR >= 10
	_retorno += SD1->D1_TOTAL - (_nValIss+SD1->D1_VALIRR+SD1->D1_VALINS+_nValPis+_nValCof+_nValCsl)
Else
	_retorno += SD1->D1_TOTAL - (_nValIss+SD1->D1_VALINS+_nValPis+_nValCof+_nValCsl)
EndIf

Return(_retorno)