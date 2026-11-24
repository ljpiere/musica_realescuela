*PROGRAMA EDITAR
*PROGRAMA PARA LA EDICION DE TITULOS
TAG1=.T.
REVISOR=.T.
SALIR=0
USE CINTAS
DO WHILE TAG1
 IF SALIR>3
  EXIT
 ENDIF
 IF REVISOR
  OPCION1=0
  CLEAR
  @  4, 31  SAY "SELECCIONE OPCION"
  @  5, 34  SAY "BUSQUEDA CINTAS"
  @  9, 31  SAY "1. POR CODIGO"
  @ 11, 31  SAY "2. POR TITULO"
  @ 14, 34  SAY "OPCION:" GET OPCION1 PICTURE "9" RANGE 1,2
  @ 13, 30  TO 13, 48
  @  3, 29  TO  6, 49 DOUBLE
  @  7, 29  TO 15, 49 DOUBLE
  @  1, 27  TO 17, 51 DOUBLE
  READ
  IF OPCION1=0
     RETURN
  ENDIF
  CLOSE FORMAT
  CLEAR
 ENDIF
  DO CASE
   CASE OPCION1=1
    TCODIGO=SPACE (9)
    @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO PICTURE "@!"
    @  8, 24  TO 12, 53    DOUBLE
    READ
    CLEAR
    SET INDEX TO CCODIGO
    FIND &TCODIGO
    IF EOF()
       @ 24,1 SAY "El Codigo Digitado no Existe, Presione ENTER"
       WAIT " " TO W
       @ 24,1 SAY "                                             "
       SALIR=SALIR+1
    ELSE
       TAG2=.T.
       DO WHILE TAG
      CLEAR
      @  2, 29  SAY "MODIFICACION DE CINTAS"
      @  7, 18  SAY "Titulo......"
      @  7, 30  GET  CINTAS->TITULO  PICTURE  "@!"
      @  9, 18  SAY "Interprete.."
      @  9, 30  GET  CINTAS->INTERPRETE  PICTURE  "@!"
      @ 11, 18  SAY "Autor......."
      @ 11, 30  GET  CINTAS->AUTOR  PICTURE  "@!"
      @ 13, 18  SAY "Orquesta...."
      @ 13, 30  GET  CINTAS->ORQUESTA  PICTURE  "@!"
      @ 15, 18  SAY "Cassette...."
      @ 15, 30  SAY  CINTAS->CASETE  PICTURE  "@!"
      @  5, 15  TO 17, 63    DOUBLE
      @  1, 15  TO  3, 63
      READ
      CLOSE FORMAT
      CORRECTO=" "
      @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE "A"
      READ
      @ 18,30 SAY "                 "
      IF UPPER(CORRECTO)="S"
       MAS=" "
       @ 18,30 SAY "CONTINUA (S/N):" GET MAS PICTURE "A"
       READ
       @ 18,30 SAY "                  "
       IF UPPER(MAS)="S"
        REVISOR=.T.
        EXIT
       ELSE
        TAG1=.F.
        EXIT
       ENDIF
      ELSE
       LOOP
      ENDIF
     ENDDO
    ENDIF
   CASE OPCION1=2
    TTITULO=SPACE(32)
    @ 16, 16  SAY "TITULO DESEADO:" GET TTITULO PICTURE "@!"
    @ 14, 14  TO 18, 65    DOUBLE
    READ
    CLEAR
    SET INDEX TO CCANCION
    FIND &TTITULO
    IF EOF()
     @ 24,1 SAY "El Titulo Digitado no Existe, Presione ENTER"
     WAIT " " TO W
     @ 24,1 SAY "                                             "
     SALIR=SALIR+1
    ELSE
    TAG2=.T.
    DO WHILE TAG
     CLEAR
     @  2, 29  SAY "MODIFICACION DE CINTAS"
     @  7, 18  SAY "Titulo......"
     @  7, 30  GET  CINTAS->TITULO  PICTURE  "@!"
     @  9, 18  SAY "Interprete.."
     @  9, 30  GET  CINTAS->INTERPRETE  PICTURE  "@!"
     @ 11, 18  SAY "Autor......."
     @ 11, 30  GET  CINTAS->AUTOR  PICTURE  "@!"
     @ 13, 18  SAY "Orquesta...."
     @ 13, 30  GET  CINTAS->ORQUESTA  PICTURE  "@!"
     @ 15, 18  SAY "Cassette...."
     @ 15, 30  SAY  CINTAS->CASETE  PICTURE  "@!"
     @  5, 15  TO 17, 63    DOUBLE
     @  1, 15  TO  3, 63
     READ
     CLOSE FORMAT
     CORRECTO=" "
     @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE "A"
     READ
     @ 18,30 SAY "                 "
     IF UPPER(CORRECTO)="S"
      MAS=" "
      @ 18,30 SAY "CONTINUA (S/N):" GET MAS PICTURE "A"
      READ
      @ 18,30 SAY "                  "
      IF UPPER(MAS)="S"
       REVISOR=.T.
       EXIT
      ELSE
       TAG1=.F.
       EXIT
      ENDIF
     ELSE
      LOOP
     ENDIF
    ENDDO
   ENDIF
  ENDCASE
ENDDO
RETURN
