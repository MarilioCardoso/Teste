      ******************************************************************
      * Author: Bob Reselman
      * Date: 1-10-2017
      * Purpose: Demo of COBOL
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RESEL-WORLD.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
      * A record that describes a USER
       01  WS-USER.
           05 WS-FIRST-NAME    PIC a(10).
           05 WS-MIDDLE-NAME   PIC a(10).
           05 WS-LAST-NAME     PIC a(10).
           05 WS-AGE           PIC 9(2).
       01  WS-FULL-NAME        PIC a(30).
       01  WS-CLOSE            PIC a(1).
       01  WS-NEW-AGE          PIC 9(2).
       01  WS-AGE-DELTA        PIC 9(2) VALUE 10.
       77  TAMANHO1            PIC 99.
       77  TAMANHO2            PIC 99.
       77  TAMANHO3            PIC 99.
       PROCEDURE DIVISION.
      * Run the code as performed paragraphs
           PERFORM GET-DATA
           PERFORM CALC-DATA
           PERFORM SHOW-DATA
           PERFORM FINISH-UP
           GOBACK.

      * A performed paragraph to get user input
       GET-DATA.
           MOVE SPACE TO WS-USER WS-FULL-NAME
           DISPLAY "What is your first name?"
           ACCEPT WS-FIRST-NAME OF WS-USER
           DISPLAY "What is your middle name?"
           ACCEPT WS-MIDDLE-NAME OF WS-USER
           DISPLAY "What is your last name?"
           ACCEPT WS-LAST-NAME OF WS-USER
           DISPLAY "What is your age?"
           ACCEPT WS-AGE OF WS-USER
           MOVE ZEROES TO TAMANHO1 TAMANHO2 TAMANHO3.
           INSPECT FUNCTION REVERSE ( WS-FIRST-NAME )
                 TALLYING TAMANHO1 FOR LEADING SPACE
           SUBTRACT TAMANHO1 FROM LENGTH OF  WS-FIRST-NAME
                     GIVING TAMANHO1.
           INSPECT FUNCTION REVERSE ( WS-MIDDLE-NAME )
                 TALLYING TAMANHO2 FOR LEADING SPACE
           SUBTRACT TAMANHO2 FROM LENGTH OF  WS-MIDDLE-NAME
                     GIVING TAMANHO2.
           INSPECT FUNCTION REVERSE ( WS-LAST-NAME )
                 TALLYING TAMANHO3 FOR LEADING SPACE
           SUBTRACT TAMANHO3 FROM LENGTH OF  WS-LAST-NAME
                     GIVING TAMANHO3.
           STRING
               WS-FIRST-NAME(1:TAMANHO1) DELIMITED BY SPACE
               SPACE DELIMITED BY SIZE
               WS-MIDDLE-NAME(1:TAMANHO2) DELIMITED BY SPACE
               SPACE DELIMITED BY SIZE
               WS-LAST-NAME(1:TAMANHO3) DELIMITED BY SPACE
               SPACE DELIMITED BY SIZE
               INTO WS-FULL-NAME
               ON OVERFLOW
               DISPLAY "SORRY, YOUR DATA WAS TRUNCATED"
           END-STRING.

      * a performed paragraph for doing calculation
       CALC-DATA.
      * Sample addition statement
           ADD WS-AGE-DELTA WS-AGE OF WS-USER TO WS-NEW-AGE.

      * A performed paragraph to display output
       SHOW-DATA.
           MOVE ZEROES TO TAMANHO1.
           INSPECT FUNCTION REVERSE ( WS-FULL-NAME )
                 TALLYING TAMANHO1 FOR LEADING SPACE
           SUBTRACT TAMANHO1 FROM LENGTH OF  WS-FULL-NAME
                     GIVING TAMANHO1.
           DISPLAY "Welcome " WS-FULL-NAME(1:TAMANHO1) ". In ten years
      -    "you will be: " WS-NEW-AGE " years old".

      * A performed paragraph to end the program
       FINISH-UP.
           DISPLAY "Strike any key to continue".
           ACCEPT WS-CLOSE
           DISPLAY "Good bye".
       END PROGRAM RESEL-WORLD.
