*&---------------------------------------------------------------------*
*& Report ZLOTTO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlotto.

TYPES: BEGIN OF ty_lottozahl,
         zahl TYPE i,
       END OF ty_lottozahl.

DATA: it_lottozahl TYPE STANDARD TABLE OF ty_lottozahl .
DATA: wa_lottozahl TYPE ty_lottozahl.
DATA: lv_zufallzahl TYPE i.

DO 6 TIMES.
  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max   = 49
      ran_int_min   = 1
    IMPORTING
      ran_int       = lv_zufallzahl
    EXCEPTIONS
      invalid_input = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    MESSAGE: e000(e8) WITH | Fehler bei der Generierung |.
  ENDIF.


  READ TABLE it_lottozahl INTO wa_lottozahl WITH KEY zahl = lv_zufallzahl.
  IF  sy-subrc <> 0.
    wa_lottozahl-zahl = lv_zufallzahl.
    APPEND wa_lottozahl TO it_lottozahl.
  ELSE.
    DO.
      CALL FUNCTION 'QF05_RANDOM_INTEGER'
        EXPORTING
          ran_int_max   = 49
          ran_int_min   = 1
        IMPORTING
          ran_int       = lv_zufallzahl
        EXCEPTIONS
          invalid_input = 1
          OTHERS        = 2.
      IF sy-subrc <> 0.
        MESSAGE: e000(e8) WITH | Fehler bei der Generierung |.
      ENDIF.
      READ TABLE it_lottozahl INTO wa_lottozahl WITH KEY zahl = lv_zufallzahl.
      IF sy-subrc <> 0.
        wa_lottozahl-zahl = lv_zufallzahl.
        APPEND wa_lottozahl TO it_lottozahl.
        EXIT.
      ENDIF.

    ENDDO.
  ENDIF.
ENDDO.


SORT it_lottozahl BY zahl.
LOOP AT  it_lottozahl INTO wa_lottozahl.
WRITE: wa_lottozahl-zahl.
ENDLOOP.
