nFobGeral:=SW2->W2_FOB_TOT + SW2->W2_INLAND + SW2->W2_PACKING + SW2->W2_FRETEIN - SW2->W2_DESCONT
If Inclui .OR. Altera
   nFobGeral:=M->W2_FOB_TOT + M->W2_INLAND + M->W2_PACKING + M->W2_FRETEIN - M->W2_DESCONT
Endif
__Return(nFobGeral)



