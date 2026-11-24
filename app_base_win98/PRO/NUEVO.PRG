*PROGRAMA NUEVO
*PROGRAMA PARA EL REGISTRO DE NUEVAS CANCIONES
TAG1=.T.
REVISOR=.T.
USE CASSETTE INDEX CODIGO
DO WHILE TAG1
   IF REVISOR
      CLEAR
      TCASETE=SPACE(9)
      @  5, 15  TO 17, 63    DOUBLE
      @  1, 15  TO  3, 63
      @  2, 27  SAY "CREACION DE NUEVOS TITULOS"
      @  7, 18  SAY "Cassette...."
      @  7, 30  GET  TCASETE  picture  "@!"
      READ
      CORRECTO=" "
      @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO picture  "A"
      READ
      @ 18,30 SAY "                 "
      IF UPPER(CORRECTO)<>"S"
         LOOP
      ENDIF
      FIND &TCASETE
      IF .NOT. EOF()
         @ 18,1 SAY "El Codigo Digitado ya Existe !"
         WAIT " " TO W
         @ 18,1 SAY "                               "
         LOOP
      ENDIF
      APPEND BLANK
      REPLACE CASSETTE->CASETE WITH TCASETE
   ENDIF
   @  7, 18  SAY "Cassette...."
   @  7, 30  GET  CASSETTE->CASETE  picture  "@!"
   CLEAR GETS
   @  9, 18  SAY "Titulo......"
   @  9, 30  GET  CASSETTE->TITULO  picture  "@!"
   @ 11, 18  SAY "Interprete.."
   @ 11, 30  GET  CASSETTE->INTERPRETE  picture  "@!"
   @ 13, 18  SAY "Autor......."
   @ 13, 30  GET  CASSETTE->AUTOR  picture  "@!"
   @ 15, 18  SAY "Orquesta...."
   @ 15, 30  GET  CASSETTE->ORQUESTA  picture  "@!"
   READ
   CORRECTO=" "
   @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO picture  "A"
   READ
   @ 18,30 SAY "                 "
   IF UPPER(CORRECTO)="S"
      MAS=" "
      @ 18,30 SAY "CONTINUA (S/N):" GET MAS picture  "A"
      READ
      @ 18,30 SAY "                  "
      IF UPPER(MAS)="S"
         REVISOR=.T.
      ELSE
         EXIT
      ENDIF
   ELSE
      REVISOR=.F.
   ENDIF
ENDDO
RETURN

