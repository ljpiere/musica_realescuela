*PASO()
CLEAR
*FILE = 'C:\DOS\DG.BAT'
*IF .NOT. FILE('&FILE')
*   @ 08,22 say 'C O P I A    N O   A U T O R I Z A D A'
*   SET COLOR TO W/r
*   @ 10,16 TO 16,65 DOUBLE
*   set color to g/n
*   @ 11,17 SAY 'DGESTIONplus ( Sistecontry ) Versi¢n 5.10.     '
*   @ 12,17 say 'Sistecontry - Programador: Rodolfo Rojas Garz¢n'
*   @ 13,17 SAY 'Manzana C Casa 55  B/ San Luis Gonzaga - Ibagu‚'
*   @ 14,17 say 'Compilado (c) 1996 por Sistecontry Corporaci¢n '
*   @ 15,17 say 'Todos los Derechos Reservados.                 '
*   @ 18,19 SAY 'Por favor solicite informaci¢n para su uso     '
*   @ 19,19 say 'Tels. (982) 698595   -   Celular  (93) 3195944 '
*   @ 22,19 SAY ' '
*   @ 23,10 SAY 'ERROR 1, CON ESTA COPIA NO PUDISTE PRUEBA CON OTRA !!!!'
*   tone (20,1/18)
*   tone (33,1/18)
*   tone (20,1/18)
*   tone (719,1/18)
*   tone (685,1/18)
*   tone (579,1/18)
*   tone (179,1/18)
*   tone (185,1/18)
*   tone (379,1/18)
*   tone (579,1/18)
*   tone (885,1/18)
*   tone (979,1/18)
*   tone (1202,1/18)
*   tone (1353,1/18)
*   tone (2520,1/18)
*   tone (1719,1/18)
*   tone (3685,1/18)
*   tone (9579,1/18)
*   tone (2179,1/18)
*   tone (5185,1/18)
*   tone (8379,1/18)
*   tone (9999,1/18)
*   tone (8885,1/18)
*   tone (5979,1/18)
*   QUIT
*ENDIF
CLEAR
CLOSE ALL
SET STATUS OFF
SET CONFIRM ON
SET BELL OFF
SET ECHO OFF
SET TALK OFF
SET SCOREBOARD OFF
SET ESCAPE OFF
SET SAFETY OFF
SET EXACT ON
PUBLIC ALL
I=0
DO WHILE I<6
 @ I,0 SAY REPLICATE(CHR(176),80)
 I=I+1
ENDDO
@  6, 0   SAY REPLICATE(CHR(176),21)
@  6, 60  SAY REPLICATE(CHR(176),20)
@  7, 0   SAY REPLICATE(CHR(176),21)
@  7, 60  SAY REPLICATE(CHR(176),20)
@  8, 0   SAY REPLICATE(CHR(176),21)
@  8, 60  SAY REPLICATE(CHR(176),20)
@  9, 0   SAY REPLICATE(CHR(176),21)
@  9, 60  SAY REPLICATE(CHR(176),20)
@ 10, 0   SAY REPLICATE(CHR(176),21)
@ 10, 60  SAY REPLICATE(CHR(176),20)
@ 11, 0   SAY REPLICATE(CHR(176),21)
@ 11, 60  SAY REPLICATE(CHR(176),20)
@ 12, 0   SAY REPLICATE(CHR(176),21)
@ 12, 60  SAY REPLICATE(CHR(176),20)
@  5, 21  TO 12, 59
@  6, 23  SAY "BIENVENIDOS AL SISTEMA INTEGRADO DE"
@  8, 31  SAY "INFORMACION MUSICAL"
@ 11, 23  SAY "Armando Polanco Urue¤a-Ibagu‚-1996"
I=13
DO WHILE I<22
   @ I,0 SAY REPLICATE(CHR(176),80)
   I=I+1
ENDDO
@ 22,0 SAY REPLICATE(CHR(176),45)
*@ 22,45 SAY "Dise¤o: Miguel Eduardo Perdomo M."
WAIT "ENTER para continuar..." TO W
T=.T.
DO P0
CLOSE DATABASES
QUIT
