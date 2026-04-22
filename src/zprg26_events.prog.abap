*&---------------------------------------------------------------------*
*& Report ZPRG26_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg26_events.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    EVENTS: e1.
    METHODS: m1.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
  METHOD m1.
    WRITE: /5 'I am M1 from C1 raising e1'.
    RAISE EVENT e1.
  ENDMETHOD.
ENDCLASS.

CLASS c2 DEFINITION.
  PUBLIC SECTION.
    METHODS tm FOR EVENT e1 OF c1.
ENDCLASS.

CLASS c2 IMPLEMENTATION.
  METHOD tm.
    WRITE: /5 'I am triggering Method TM in C2 for Event E1 in C1'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(o1) = NEW c1( ).
  DATA(o2) = NEW c2( ).

  SET HANDLER o2->tm FOR o1.

  o1->m1( ).
