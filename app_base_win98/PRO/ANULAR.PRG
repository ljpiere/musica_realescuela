*PROGRAMA PARA ELIMINAR UN TITULO DEL ARCHIVO
*PROGRAMA ANULAR
TAG1=.T.
REVISOR=.T.
SALIR=0
USE CASSETTE INDEX CODIGO
DO WHILE TAG1
 IF SALIR>3
  EXIT
 ENDIF
 CLEAR
 TCODIGO=SPACE (9)
 @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO picture "@!"
 @  8, 24  TO 12, 53    DOUBLE
 READ
 CLEAR
 SET ORDER TO 1
 FIND &TCODIGO
 IF EOF()
  @ 23,1 SAY "El Codigo Digitado no Existe, Presione ENTER"
  WAIT " " TO W
  @ 23,1 SAY "                                             "
  SALIR=SALIR+1
 ELSE
  CLEAR
  @  2, 27  SAY "ANULACION DE TITULOS"
  @  7, 18  SAY "Titulo......"
  @  7, 30  SAY  CASSETTE->TITULO  picture "@!"
  @  9, 18  SAY "Interprete.."
  @  9, 30  SAY  CASSETTE->INTERPRETE  picture  "@!"
  @ 11, 18  SAY "Autor......."
  @ 11, 30  SAY  CASSETTE->AUTOR  picture  "@!"
  @ 13, 18  SAY "Orquesta...."
  @ 13, 30  SAY  CASSETTE->ORQUESTA  picture  "@!"
  @ 15, 18  SAY "Cassette...."
  @ 15, 30  SAY  CASSETTE->CASETE  picture  "@!"
  @  5, 15  TO 17, 63    DOUBLE
  @  1, 15  TO  3, 63
  CORRECTO=" "
  @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO picture  "A"
  READ
  @ 18,30 SAY "                 "
  IF UPPER(CORRECTO)="S"
   DELETE
   WAIT "El Titulo ha Sido Borrado, Presione ENTER" TO W
   @ 19,0 SAY "                                          "
   MAS=" "
   @ 18,30 SAY "CONTINUA (S/N):" GET MAS picture  "A"
   READ
   @ 18,30 SAY "                  "
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