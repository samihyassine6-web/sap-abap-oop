*&---------------------------------------------------------------------*
*& Report ZPRG_23_POINTER_CONCEPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_23_pointer_concept.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    METHODS: m1.
    CLASS-DATA: n1 TYPE i.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
  METHOD m1.
    n1 = n1 + 5.
    WRITE: /5 n1.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: o1 TYPE REF TO c1.
  DATA: it_o1 TYPE TABLE OF REF TO c1.

  DO 5 TIMES.
    CREATE OBJECT o1.
    APPEND o1 TO it_o1.
  ENDDO.

  LOOP AT it_o1 INTO o1.
    CALL METHOD o1->m1.
  ENDLOOP.
