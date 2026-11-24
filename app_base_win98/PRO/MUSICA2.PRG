*PROGRAMA MUSICA
TAG=.T.
sTORE "ARCHIVO MAESTRO DE CASSETTES" TO HEADING
STORE 26 TO LIN
DO WHILE TAG
   OPCION=0
   CLEAR
   @  2, 26  SAY "OPCIONES  PARA EL MANEJO DEL"
   @  3, LIN SAY HEADING
   @  6, 30  SAY "1.NUEVOS TITULOS"
   @  8, 30  SAY "2.MODIFICAR TITULOS"
   @ 10, 30  SAY "3.ELIMINAR TITULOS"
   @ 12, 30  SAY "4.MENU PRINCIPAL"
   @ 15, 35  SAY "OPCION:" GET OPCION PICTURE "#" RANGE 1,5
   @ 14, 25  TO 14, 55
   @  0, 21  TO 17, 59    DOUBLE
   @  1, 24  TO  4, 56    DOUBLE
   @  5, 24  TO 16, 56    DOUBLE
   READ
   DO CASE
      CASE OPCION=1
           DO NUEVO
      CASE OPCION=2
           DO EDITAR
      CASE OPCION=3
           DO ANULAR
      OTHERWISE
      CLEAR
      STORE " " TO ORDEN
      @ 12,26 SAY "Ordenar Archivos (S/N):  ( )"
      @ 12,52 GET ORDEN PICTURE "!"
      READ
      @ 12,1 SAY SPACE(60)
      IF ORDEN="S"
         @ 20,5 SAY "El proceso de salida toma aproximadamente 5 minutos..."
         USE CASSETTE
         SET INDEX TO CANCION
         REINDEX
         SET INDEX TO CANTA
         REINDEX
         SET INDEX TO TOCA
         REINDEX
         set index to compone
         reindex
         SET INDEX TO CODIGO
         REINDEX
      ENDIF
      TAG=.F.
ENDCASE
ENDDO
CLOSE DATABASES
SET EXACT OFF
RETURN

