dbSelectArea("SIA")
COPY TO SIA

dbSelectArea("SI3")
COPY TO SI3

dbSelectArea("SI1")
COPY TO SI1

ALERT("FIM DA EXPORTACAO")

RETURN
