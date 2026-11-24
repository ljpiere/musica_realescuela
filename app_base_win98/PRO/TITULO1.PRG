*PROGRAMA TITULO1
*PROGRAMA PARA LA LOCALIZACION E INFORMACION SOBRE TITULOS
SET EXACT OFF
TAG1=.T.
SW=.T.
REVISOR=.T.
SALIR=0
OPCION1=0
SELECT 2
USE WORK
SELECT 1
USE DISCOS
DO WHILE TAG1
 SELECT 1
 OPCION1=0
 CLEAR
 @  3, 29  TO  6, 49 DOUBLE
 @  7, 29  TO 19, 49 DOUBLE
 @  1, 27  TO 21, 51 DOUBLE
 @  4, 31  SAY "SELECCIONE OPCION"
 @  5, 34  SAY "DE CONSULTA DISCOS"
 @  9, 31  SAY "1. POR TITULO"
 @ 11, 31  SAY "2. POR INTERPRETE"
 @ 13, 31  SAY "3. POR ORQUESTA"
 @ 15, 31  SAY "4. MENU PRINCIPAL"
 @ 18, 34  SAY "OPCION:" GET OPCION1 PICTURE "9" RANGE 1,4
 READ
DO CASE
   CASE OPCION1=1
        CLEAR
        TTITULO=SPACE(32)
        @ 13, 13  SAY " TITULO DESEADO: " GET TTITULO PICTURE "@!"
        @ 11, 11  TO 15, 69    DOUBLE
        READ
        DO WHILE .T.
           X=' '
           @ 24,2 SAY 'BUSQUEDA EXACTA (S/N): [ ]'
           @ 24,26 GET X
           READ
           IF UPPER(X)='S'.OR.UPPER(X)='N'
              EXIT
           ENDIF
        ENDDO
        IF UPPER(X)='S'
           SET EXACT ON
        ELSE
           SET EXACT OFF
        ENDIF
        IF TTITULO=SPACE(32)
           LOOP
        ENDIF
        STORE "titulo" TO LITERAL
        SET INDEX TO DCANCION
        STORE TRIM(TTITULO) TO TTITULO
        @ 16, 27 SAY "Un momento por favor..."
        FIND  &TTITULO
        IF .NOT. EOF()
           OPCION2=0
           @ 18, 15  SAY ":1: Pantalla de Detalle     :2: Pantalla de Resumen"
           @ 20, 35  SAY "OPCION : :"
           @ 20, 43  GET OPCION2 PICTURE "9" RANGE 1,2
           @ 17, 13  TO 21, 67    DOUBLE
           @ 19, 14  TO 19, 66
           READ
           IF OPCION2=2
              CLEAR
              SW1=.T.
              CONTLIN=0
              FILA=4
              CUANTOS=0
              @  1,  1  TO 22, 79    DOUBLE
              @  3,  2  TO  3, 78
              @  2,  9  SAY "         INTERPRETE                     ORQUESTA             GV  DI TM"
              COL=0
              COL=INT((74-(LEN(RTRIM(TTITULO))+8))/2)
              ENCABEZA="TITULO: "+RTRIM(DISCOS->TITULO)
              @ 0, COL GET ENCABEZA
              CLEAR GETS
              *SET EXACT OFF
              SELECT 2
              ZAP
              SELECT 1
              DO WHILE SW1
                 STORE TITULO     TO TEMA
                 STORE INTERPRETE TO TINTERPRETE
                 STORE ORQUESTA   TO TORQUESTA
                 STORE CODIGO     TO TCODIGO
                 SELECT 2
                 APPEND BLANK
                 REPLACE TITULO     WITH TEMA
                 REPLACE INTERPRETE WITH TINTERPRETE
                 REPLACE ORQUESTA   WITH TORQUESTA
                 REPLACE CODIGO     WITH TCODIGO
                 SELECT 1
                 IF .NOT. EOF()
                    SKIP
                 ELSE
                    EXIT
                 ENDIF
                 IF TITULO<>TTITULO
                    SW1=.F.
                 ENDIF
              ENDDO
              SELECT 2
              IF OPCION1=1
                 INDEX ON INTERPRETE TO WORK
              ELSE
                 INDEX ON TITULO TO WORK
              ENDIF
              DO WHILE .NOT. EOF()
                 IF CONTLIN>16
                    MAS=" "
                    @ 23,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "A"
                    READ
                    @ 23,2 SAY "                                            "
                    IF UPPER(MAS)="N"
                       EXIT
                    ENDIF
                    @ 4,0 CLEAR
                    @  1,1 TO 22,79    DOUBLE
                    CONTLIN=0
                    FILA=4
                 ENDIF
                 IF INTERPRETE<>SPACE(32)
                    @ FILA,3 SAY INTERPRETE
                 ELSE
                    @ FILA,3 SAY "NO REGISTRADO"
                 ENDIF
                 IF ORQUESTA<>SPACE(32)
                    @ FILA,37 SAY ORQUESTA
                 ELSE
                    @ FILA,37 SAY "NO REGISTRADO"
                 ENDIF
                 @ FILA,70 SAY SUBSTR(CODIGO,1,2)
                 @ FILA,74 SAY SUBSTR(CODIGO,4,2)
                 @ FILA,77 SAY SUBSTR(CODIGO,7,2)
                 CONTLIN=CONTLIN+1
                 CUANTOS=CUANTOS+1
                 FILA=FILA+1
                 SKIP
                 IF EOF()
                    @ 23,2 SAY "Total titulos registrados..."
                    @ 23,30 SAY LTRIM(STR(CUANTOS,4,0))
                    @ 23,35 SAY "Presione ENTER."
                    WAIT " " TO W
                    @ 23,2 SAY "                                                           "
                 ENDIF
              ENDDO
           ELSE
              SW1=.T.
              DO WHILE SW1
                 CLEAR
                 STORE SPACE(32) TO TIT
                 STORE SPACE(32) TO INT
                 STORE SPACE(32) TO ORQ
                 STORE SPACE(32) TO AUT
                 STORE SPACE(2)  TO GAVETA
                 STORE SPACE(2)  TO DISCO
                 STORE SPACE(2)  TO TEMA
                 STORE "NO REGISTRADO" TO NADA
                 IF DISCOS->TITULO=" "
                    TIT=NADA
                 ELSE
                    TIT=DISCOS->TITULO
                 ENDIF
                 IF DISCOS->INTERPRETE=" "
                    INT=NADA
                 ELSE
                    INT=DISCOS->INTERPRETE
                 ENDIF
                 IF DISCOS->ORQUESTA=" "
                    ORQ=NADA
                 ELSE
                    ORQ=DISCOS->ORQUESTA
                 ENDIF
                 IF DISCOS->AUTOR=" "
                    AUT=NADA
                 ELSE
                    AUT=DISCOS->AUTOR
                 ENDIF
                 GAVETA=SUBSTR(DISCOS->CODIGO,1,2)
                 DISCO=SUBSTR(DISCOS->CODIGO,4,2)
                 TEMA=SUBSTR(DISCOS->CODIGO,7,2)
                 CLEAR
                 @  5, 13  TO 20, 66    DOUBLE
                 @ 13, 16  TO 18, 63
                 @ 15, 17  TO 15, 62
                 @  3, 24  SAY "REGISTRO Y LOCALIZACION DE DISCOS"
                 @  6, 16  SAY "Titulo.........."
                 @  6, 32  GET  TIT
                 CLEAR GETS
                 @  8, 16  SAY "Interprete......"
                 @  8, 32  SAY  INT
                 @ 10, 16  SAY "Orquesta........"
                 @ 10, 32  SAY  ORQ
                 @ 12, 16  SAY "Autor..........."
                 @ 12, 32  SAY  AUT
                 @ 14, 34  SAY "LOCALIZACION"
                 @ 17, 18  SAY "Gaveta No:       Disco No:       Tema No:   "
                 @ 17, 28  SAY GAVETA
                 @ 17, 45  SAY DISCO
                 @ 17, 60  SAY TEMA
                 MAS=" "
                 @ 22,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "!"
                 READ
                 @ 22,2 SAY "                                "
                 IF MAS="S"
                    SKIP
                    IF DISCOS->TITULO<>TTITULO.OR.EOF()
                       SW1=.F.
                    ENDIF
                 ELSE
                    SW=.F.
                    EXIT
                 ENDIF
              ENDDO
           IF SW
              @ 22,2 SAY "No hay mas titulos registrados..."
              WAIT " " TO W
              @ 22,2 SAY "                                  "
           ENDIF
        ENDIF
     ELSE
        CLEAR
        @ 22, 2 SAY "El "
        ?? LITERAL+" "+"solicitado no se encuentra registrado... Presione ENTER."
        WAIT " " TO W
        @ 22, 2 CLEAR
     ENDIF
     MAS=" "
     @ 23,2 SAY "Continua (S/N):" GET MAS PICTURE  "A"
     READ
     @ 23,2 SAY "                  "
     IF UPPER(MAS)<>"S"
        EXIT
     ENDIF



CASE OPCION1=2
 CLEAR
 TCANTA=SPACE(32)
 @ 13, 13  SAY "INTERPRETE DESEADO: " GET TCANTA PICTURE  "@!"
 @ 11, 11  TO 15, 69    DOUBLE
 READ

 DO WHILE .T.
    X=' '
    @ 24,2 SAY 'BUSQUEDA EXACTA (S/N): [ ]'
    @ 24,26 GET X
    READ
    IF UPPER(X)='S'.OR.UPPER(X)='N'
       EXIT
    ENDIF
 ENDDO

 IF UPPER(X)='S'
    SET EXACT ON
 ELSE
    SET EXACT OFF
 ENDIF




 IF TCANTA=SPACE(32)
  LOOP
 ENDIF
 STORE "interprete" TO LITERAL
 SET INDEX TO DCANTA
 STORE TRIM(TCANTA) TO TCANTA
 @ 16, 27 SAY "Un momento por favor..."
 FIND  &TCANTA
 IF .NOT. EOF()
  OPCION2=0
  @ 18, 15  SAY ":1: Pantalla de Detalle     :2: Pantalla de Resumen"
  @ 20, 35  SAY "OPCION : :"
  @ 20, 43  GET OPCION2 PICTURE "9" RANGE 1,2
  @ 17, 13  TO 21, 67    DOUBLE
  @ 19, 14  TO 19, 66
  READ
  IF OPCION2=2
   CLEAR
   SW1=.T.
   CONTLIN=0
   FILA=4
   CUANTOS=0
   @  1,1 TO 22,79    DOUBLE
   @  3,  2  TO  3, 78
   @  2,  9  SAY "           TITULO                       ORQUESTA             GV  DI TM"
   COL=0
   COL=INT((76-(LEN(RTRIM(INTERPRETE))+12))/2)
   ENCABEZA="INTERPRETE: "+RTRIM(DISCOS->INTERPRETE)
   @ 0, COL GET ENCABEZA
   CLEAR GETS
   SELECT 2
   ZAP
   SELECT 1
   DO WHILE SW1
    STORE TITULO     TO TTITULO
    STORE INTERPRETE TO TINTERPRETE
    STORE ORQUESTA   TO TORQUESTA
    STORE CODIGO     TO TCODIGO
    SELECT 2
    APPEND BLANK
    REPLACE TITULO     WITH TTITULO
    REPLACE INTERPRETE WITH TINTERPRETE
    REPLACE ORQUESTA   WITH TORQUESTA
    REPLACE CODIGO     WITH TCODIGO
    SELECT 1
    IF .NOT. EOF()
     SKIP
    ELSE
     EXIT
    ENDIF
    IF INTERPRETE<>TCANTA
     SW1=.F.
    ENDIF
   ENDDO
   SELECT 2
   IF OPCION1=1
    INDEX ON INTERPRETE TO WORK
   ELSE
    INDEX ON TITULO TO WORK
   ENDIF
   DO WHILE .NOT. EOF()
    IF CONTLIN>16
     MAS=" "
     @ 23,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "A"
     READ
     @ 23,2 SAY "                                            "
     IF UPPER(MAS)="N"
      EXIT
     ENDIF
     @ 4,0 CLEAR
     @  1,  1  TO 22, 79    DOUBLE
     CONTLIN=0
     FILA=4
    ENDIF
    IF TITULO<>SPACE(32)
     @ FILA,3 SAY TITULO
    ELSE
     @ FILA,3 SAY "NO REGISTRADO"
    ENDIF
    IF ORQUESTA<>SPACE(32)
     @ FILA,37 SAY ORQUESTA
    ELSE
     @ FILA,37 SAY "NO REGISTRADO"
    ENDIF
    @ FILA,70 SAY SUBSTR(CODIGO,1,2)
    @ FILA,74 SAY SUBSTR(CODIGO,4,2)
    @ FILA,77 SAY SUBSTR(CODIGO,7,2)
    CONTLIN=CONTLIN+1
    CUANTOS=CUANTOS+1
    FILA=FILA+1
    SKIP
    IF EOF()
     @ 23,2 SAY "Total titulos registrados..."
     @ 23,30 SAY LTRIM(STR(CUANTOS,4,0))
     @ 23,35 SAY "Presione ENTER."
     WAIT " " TO W
     @ 23,2 SAY "                                                           "
    ENDIF
   ENDDO
  ELSE
   SW1=.T.
   DO WHILE SW1
    CLEAR
    STORE SPACE(32) TO TIT
    STORE SPACE(32) TO INT
    STORE SPACE(32) TO ORQ
    STORE SPACE(32) TO AUT
    STORE SPACE(2)  TO GAVETA
    STORE SPACE(2)  TO DISCO
    STORE SPACE(2)  TO TEMA
    STORE "NO REGISTRADO" TO NADA
    IF  DISCOS->TITULO=" "
     TIT=NADA
    ELSE
     TIT=DISCOS->TITULO
    ENDIF
    IF  DISCOS->INTERPRETE=" "
     INT=NADA
    ELSE
     INT=DISCOS->INTERPRETE
    ENDIF
    IF  DISCOS->ORQUESTA=" "
     ORQ=NADA
    ELSE
     ORQ=DISCOS->ORQUESTA
    ENDIF
    IF  DISCOS->AUTOR=" "
     AUT=NADA
    ELSE
     AUT=DISCOS->AUTOR
    ENDIF
    GAVETA=SUBSTR(DISCOS->CODIGO,1,2)
    DISCO=SUBSTR(DISCOS->CODIGO,4,2)
    TEMA=SUBSTR(DISCOS->CODIGO,7,2)
    CLEAR
    @  5, 13  TO 20, 66    DOUBLE
    @ 13, 16  TO 18, 63
    @ 15, 17  TO 15, 62
    @  3, 24  SAY "REGISTRO Y LOCALIZACION DE DISCOS"
    @  6, 16  SAY "Titulo.........."
    @  6, 32  GET  TIT
    @  8, 16  SAY "Interprete......"
    @  8, 32  SAY  INT
    CLEAR GETS
    @ 10, 16  SAY "Orquesta........"
    @ 10, 32  SAY  ORQ
    @ 12, 16  SAY "Autor..........."
    @ 12, 32  SAY  AUT
    @ 14, 34  SAY "LOCALIZACION"
    @ 17, 18  SAY "Gaveta No:       Disco No:       Tema No:   "
    @ 17, 28  SAY GAVETA
    @ 17, 45  SAY DISCO
    @ 17, 60  SAY TEMA
    MAS=" "
    @ 22,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "!"
    READ
    @ 22,2 SAY "                                "
    IF MAS="S"
     SKIP
     IF DISCOS->INTERPRETE<>TTITULO.OR.EOF()
      SW1=.F.
     ENDIF
    ELSE
     SW=.F.
     EXIT
    ENDIF
   ENDDO
   IF SW
    @ 22,2 SAY "No hay mas titulos registrados..."
    WAIT " " TO W
    @ 22,2 SAY "                                  "
   ENDIF
  ENDIF
 ELSE
  CLEAR
  @ 22, 2 SAY "El "
  ?? LITERAL+" "+"solicitado no se encuentra registrado... Presione ENTER."
  WAIT " " TO W
  @ 22, 2 CLEAR
 ENDIF
 MAS=" "
 @ 23,2 SAY "Continua (S/N):" GET MAS PICTURE "A"
 READ
 @ 23,2 SAY "                  "
 IF UPPER(MAS)<>"S"
  EXIT
 ENDIF


CASE OPCION1=3
 CLEAR
 TORQUESTA=SPACE(32)
 @ 13, 13  SAY "ORQUESTA DESEADA: " GET TORQUESTA  PICTURE  "@!"
 @ 11, 11  TO 15, 69    DOUBLE
 READ


 DO WHILE .T.
    X=' '
    @ 24,2 SAY 'BUSQUEDA EXACTA (S/N): [ ]'
    @ 24,26 GET X
    READ
    IF UPPER(X)='S'.OR.UPPER(X)='N'
       EXIT
    ENDIF
 ENDDO      
 
 IF UPPER(X)='S'
    SET EXACT ON
 ELSE
    SET EXACT OFF
 ENDIF
 
 




 IF TORQUESTA=SPACE(32)
  LOOP
 ENDIF
 STORE "orquesta" TO LITERAL
 SET INDEX TO DTOCA
 STORE TRIM(TORQUESTA) TO TORQUESTA
 @ 16, 27 SAY "Un momento por favor..."
 FIND  &TORQUESTA
 IF .NOT. EOF()
  OPCION2=0
  @ 18, 15  SAY ":1: Pantalla de Detalle     :2: Pantalla de Resumen"
  @ 20, 35  SAY "OPCION : :"
  @ 20, 43  GET OPCION2 PICTURE "9" RANGE 1,2
  @ 17, 13  TO 21, 67    DOUBLE
  @ 19, 14  TO 19, 66
  READ
  IF OPCION2=2
   CLEAR
   SW1=.T.
   CONTLIN=0
   FILA=4
   CUANTOS=0
   @  1,1 TO 22,79    DOUBLE
   @  3,  2  TO  3, 78
   @  2,  9  SAY "         TITULO                       INTERPRETE             GV  DI TM"
   COL=0
   COL=INT((76-(LEN(RTRIM(TORQUESTA))+10))/2)
   ENCABEZA="ORQUESTA: "+RTRIM(DISCOS->ORQUESTA)
   @ 0, COL GET ENCABEZA
   CLEAR GETS
   SELECT 2
   ZAP
   SELECT 1
   DO WHILE SW1
    STORE TITULO     TO TTITULO
    STORE INTERPRETE TO TINTERPRETE
    STORE ORQUESTA   TO TTOCA
    STORE CODIGO     TO TCODIGO
    SELECT 2
    APPEND BLANK
    REPLACE TITULO     WITH TTITULO
    REPLACE INTERPRETE WITH TINTERPRETE
    REPLACE ORQUESTA   WITH TTOCA
    REPLACE CODIGO     WITH TCODIGO
    SELECT 1
    IF .NOT. EOF()
     SKIP
    ELSE
     EXIT
    ENDIF
    IF ORQUESTA<>TORQUESTA
     SW1=.F.
    ENDIF
   ENDDO
   SELECT 2
   IF OPCION1=1
    INDEX ON INTERPRETE TO WORK
   ELSE
    INDEX ON TITULO TO WORK
   ENDIF
   DO WHILE .NOT. EOF()
    IF CONTLIN>16
     MAS=" "
     @ 23,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE "A"
     READ
     @ 23,2 SAY "                                            "
     IF UPPER(MAS)="N"
      EXIT
     ENDIF
     @ 4,0 CLEAR
     @  1,  1  TO 22, 79    DOUBLE
     CONTLIN=0
     FILA=4
    ENDIF
    IF TITULO<>SPACE(32)
     @ FILA,3 SAY TITULO
    ELSE
     @ FILA,3 SAY "NO REGISTRADO"
    ENDIF
    IF INTERPRETE<>SPACE(32)
     @ FILA,37 SAY INTERPRETE
    ELSE
     @ FILA,37 SAY "NO REGISTRADO"
    ENDIF
    @ FILA,70 SAY SUBSTR(CODIGO,1,2)
    @ FILA,74 SAY SUBSTR(CODIGO,4,2)
    @ FILA,77 SAY SUBSTR(CODIGO,7,2)
    CONTLIN=CONTLIN+1
    CUANTOS=CUANTOS+1
    FILA=FILA+1
    SKIP
    IF EOF()
     @ 23,2 SAY "Total titulos registrados..."
     @ 23,30 SAY LTRIM(STR(CUANTOS,4,0))
     @ 23,35 SAY "Presione ENTER."
     WAIT " " TO W
     @ 23,2 SAY "                                                           "
    ENDIF
   ENDDO
  ELSE 
   SW1=.T.
   DO WHILE SW1
    CLEAR
    STORE SPACE(32) TO TIT
    STORE SPACE(32) TO INT
    STORE SPACE(32) TO ORQ
    STORE SPACE(32) TO AUT
    STORE SPACE(2)  TO GAVETA
    STORE SPACE(2)  TO DISCO
    STORE SPACE(2)  TO TEMA
    STORE "NO REGISTRADO" TO NADA
    IF  DISCOS->TITULO=" "
     TIT=NADA
    ELSE
     TIT=DISCOS->TITULO
    ENDIF
    IF  DISCOS->INTERPRETE=" "
     INT=NADA
    ELSE
     INT=DISCOS->INTERPRETE
    ENDIF
    IF  DISCOS->ORQUESTA=" "
     ORQ=NADA
    ELSE
     ORQ=DISCOS->ORQUESTA
    ENDIF
    GAVETA=SUBSTR(DISCOS->CODIGO,1,2)
    DISCO=SUBSTR(DISCOS->CODIGO,4,2)
    TEMA=SUBSTR(DISCOS->CODIGO,7,2)
    CLEAR
    @  5, 13  TO 20, 66    DOUBLE
    @ 13, 16  TO 18, 63
    @ 15, 17  TO 15, 62
    @  3, 24  SAY "REGISTRO Y LOCALIZACION DE DISCOS"
    @  6, 16  SAY "Titulo.........."
    @  6, 32  GET  TIT
    @  8, 16  SAY "Interprete......"
    @  8, 32  SAY  INT
    @ 10, 16  SAY "Orquesta........"
    @ 10, 32  SAY  ORQ
    @ 12, 16  SAY "Autor..........."
    @ 12, 32  SAY  AUT
    CLEAR GETS
    @ 14, 34  SAY "LOCALIZACION"
    @ 17, 18  SAY "Gaveta No:       Disco No:       Tema No:   "
    @ 17, 28  SAY GAVETA
    @ 17, 45  SAY DISCO
    @ 17, 60  SAY TEMA
    MAS=" "
    @ 22,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE "!"
    READ
    @ 22,2 SAY "                                "
    IF MAS="S"
     SKIP
     IF DISCOS->ORQUESTA<>TORQUESTA.OR.EOF()
      SW1=.F.
     ENDIF
    ELSE
     SW=.F.
     EXIT
    ENDIF
   ENDDO
   IF SW
    @ 22,2 SAY "No hay mas titulos registrados..."
    WAIT " " TO W
    @ 22,2 SAY "                                  "
   ENDIF
  ENDIF
 ELSE
  CLEAR
  @ 22, 2 SAY "El "
  ?? LITERAL+" "+"solicitado no se encuentra registrado... Presione ENTER."
  WAIT " " TO W
  @ 22, 2 CLEAR
 ENDIF
 MAS=" "
 @ 23,2 SAY "Continua (S/N):" GET MAS PICTURE  "A"
 READ
 @ 23,2 SAY "                  "
 IF UPPER(MAS)<>"S"
  EXIT
 ENDIF
 OTHERWISE
  EXIT
 ENDCASE
ENDDO
CLOSE DATABASES
SET EXACT ON
RETURN
