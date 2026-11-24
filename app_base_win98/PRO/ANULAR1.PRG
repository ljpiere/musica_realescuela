*PROGRAMA PARA ELIMINAR UN TITULO DEL ARCHIVO
*PROGRAMA ANULAR
TAG1=.T.
REVISOR=.T.
SALIR=0
USE DISCOS INDEX DCODIGO
DO WHILE TAG1
 IF SALIR>3
  EXIT
 ENDIF
 CLEAR
 TCODIGO=SPACE (8)
 @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO PICTURE "@!"
 @  8, 24  TO 12, 53    DOUBLE
 READ
 CLEAR
 FIND &TCODIGO
 IF EOF()
  @ 23,1 SAY "El Codigo Digitado no Existe, Presione ENTER"
  WAIT " " TO W
  @ 23,1 SAY "                                             "
  SALIR=SALIR+1
 ELSE
  CLEAR
  @  9, 15  TO 19, 63    DOUBLE
  @  5, 15  TO  7, 63
  @  6, 30  SAY "ANULACION DE TITULOS"
  @ 10, 18  SAY "Codigo......"
  @ 10, 30  GET  DISCOS->CODIGO  PICTURE "@!"
  @ 12, 18  SAY "Titulo......"
  @ 12, 30  GET  DISCOS->TITULO  PICTURE "@!"
  @ 14, 18  SAY "Interprete.."
  @ 14, 30  GET  DISCOS->INTERPRETE PICTURE "@!"
  @ 16, 18  SAY "Autor......."
  @ 16, 30  GET DISCOS->AUTOR   PICTURE "@!"
  @ 18, 18  SAY "Orquesta...."
  @ 18, 30  GET DISCOS->ORQUESTA PICTURE "@!"
  CLEAR GETS
  CORRECTO=" "
  @ 20,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE "A"
  READ
  @ 20,30 SAY "                 "
  IF UPPER(CORRECTO)="S"
   DELETE
   WAIT "El Titulo ha Sido Borrado, Presione ENTER" TO W
   @ 19,0 SAY "                                          "
   MAS=" "
   @ 20,30 SAY "CONTINUA (S/N):" GET MAS PICTURE "A"
   READ
   @ 20,30 SAY "                  "
   IF UPPER(MAS)<>"S"
    CLEAR
    @ 20, 5 SAY "Un momento por favor..."
    CLOSE INDEX
    PACK
    EXIT
   ENDIF
  ELSE
   EXIT
  ENDIF
 ENDIF
ENDDO
RETURN
