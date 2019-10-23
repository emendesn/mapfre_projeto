#include "rwmake.ch" 

User Function PFINA012()  

SetPrvt("CCADASTRO,AROTINA,_CFILTRASE2") 

PERGUNTE("LJR170",.t.)

//_cFiltraSE2 := "E2_TIPO2 == 'COB' .AND. E2_NUMBOR == '" + MV_PAR01 + "'" 
_cFiltraSE2 := "E2_NUMBOR == '" + MV_PAR01 + "'" 
SE2->(dbSetFilter({|| &_cFiltraSE2 }, _cFiltraSE2 ))

cCadastro := "Inclusao do Codigo de Barra "
                                          
aRotina := {{"Pesquisar"   ,"AxPesqui" , 0 , 1},;  
			{"Visualizar"  ,"FA050Visua", 0 , 2},;
            {"Cod.de Barra","U_APFINA12()" , 0, 4}} 
 
SE2->(dbSetOrder(4))
mBrowse(06,01,22,75,"SE2")
      
SE2->(dbSetFilter({|| .T. }, ".T." ))

Return

User Function APFINA12()          
Private _cCodBar := space(44)
Private _cLdig1  := space(05)
Private _cLdig2  := space(05)
Private _cLdig3  := space(05)
Private _cLdig4  := space(06)
Private _cLdig5  := space(05)
Private _cLdig6  := space(06)
Private _cLdig7  := space(01)
Private _cLdig8  := space(14)

@ 000,000 TO 150,625 DIALOG oDlg1 TITLE "Manutencao do Codigo de Barra - Cobranca" //450
@ 060,010 BMPBUTTON TYPE 1 ACTION GPFINA12()
@ 060,040 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
@ 005,010 say 'Titulo : ' + SE2->E2_PREFIXO+"/"+SE2->E2_NUM+"/"+SE2->E2_PARCELA+"/"+SE2->E2_TIPO
@ 015,010 say 'Fornecedor : ' + SE2->E2_NOMFOR
@ 025,010 say 'Cod.Barra '
@ 025,040 get _cCodBar Picture "@!" Size 136,10
@ 040,010 say 'L.Digitavel '
@ 040,040 get _cLdig1 Picture "@!" Size 22,10 VALID IIF(!EMPTY(_cLdig1),CPFINA12(),.T.)
@ 040,073 get _cLdig2 Picture "@!" Size 22,10 VALID IIF(!EMPTY(_cLdig2),CPFINA12(),.T.)
@ 040,110 get _cLdig3 Picture "@!" Size 22,10 VALID IIF(!EMPTY(_cLdig3),CPFINA12(),.T.)
@ 040,143 get _cLdig4 Picture "@!" Size 22,10 VALID IIF(!EMPTY(_cLdig4),CPFINA12(),.T.)
@ 040,176 get _cLdig5 Picture "@!" Size 22,10 VALID IIF(!EMPTY(_cLdig5),CPFINA12(),.T.)
@ 040,209 get _cLdig6 Picture "@!" Size 22,10 VALID IIF(!EMPTY(_cLdig6),CPFINA12(),.T.)
@ 040,242 get _cLdig7 Picture "@!" Size 7,10  VALID IIF(!EMPTY(_cLdig7),CPFINA12(),.T.)
@ 040,256 get _cLdig8 Picture "@!" Size 47,10 VALID IIF(!EMPTY(_cLdig8),CPFINA12(),.T.)

ACTIVATE DIALOG oDlg1 CENTER

Return                    
/***************************************************************/        
Static Function GPFINA12()

If VPFINA12()
	Close(oDlg1) 
	RecLock("SE2",.f.)
	replace E2_CODBAR with _cCodBar
	MsUnlock()                                                             
Else
	MSGBOX("Codigo de Barra Incorreto !","Atencao...","INFO")	
Endif

Return
/***************************************************************/	 
Static Function CPFINA12()
Local _cCodigo := alltrim(_cLdig1) + alltrim(_cLdig2) + alltrim(_cLdig3) + alltrim(_cLdig4) + alltrim(_cLdig5)
_cCodigo := _cCodigo + alltrim(_cLdig6) + alltrim(_cLdig7) + alltrim(_cLdig8)

If Len(alltrim(_cCodigo)) == 47
	_cCodBar := substr(_cCodigo,1,4) + substr(_cCodigo,33,1)
	_cCodBar :=	_cCodBar + substr(_cCodigo,34,14)
	_cCodBar :=	_cCodBar + substr(_cCodigo,5,5) + substr(_cCodigo,11,10) + substr(_cCodigo,22,10)
	_cRet := VPFINA12()
ElseIf Len(alltrim(_cCodigo)) == 36
	_cCodBar := substr(_cCodigo,1,4)+substr(_cCodigo,33,1)
	_cCodBar :=	_cCodBar + strzero(0,14-Len(alltrim(substr(_cCodigo,34,14))))+alltrim(substr(_cCodigo,34,14))
	_cCodBar :=	_cCodBar + substr(_cCodigo,5,5) + substr(_cCodigo,11,10) + substr(_cCodigo,22,10)
	_cRet := VPFINA12()
EndIf                          

Return(.t.)               
/***************************************************************/
Static Function VPFINA12()
Local _cMult := '4329876543298765432987654329876543298765432'
Local _cDig := val(substr(_cCodBar,5,1))
Local _vDig := substr(_cCodBar,1,4)+substr(_cCodBar,6,39)
Local _pDig := 0

for i := 1 to len(_vDig)
	_pDig += val(substr(_vDig,i,1)) * val(substr(_cMult,i,1))
next	
	    
_pDig := _pDig % 11
if _pDig == 0
	_pDig := 1
ElseIf _pDig == 1
	_pDig := 1	 
ElseIf _pDig > 9
	_pDig := 1	
Else
	_pDig := 11 - _pDig
Endif

Return(iif(_pDig==_cDig,.t.,.f.))