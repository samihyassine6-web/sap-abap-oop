*&---------------------------------------------------------------------*
*& Report ZPRG22_OOPS_ADVANCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg22_oops_advance.



CLASS c1 DEFINITION.
  PUBLIC SECTION.
    DATA: n1 TYPE i VALUE 5.
    METHODS: m1.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
  METHOD m1.
    DATA: n1 TYPE i VALUE 2.
    WRITE: /55 me->n1 .
    WRITE: /55     n1.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: n1 TYPE i.

  DATA: o1 TYPE REF TO c1.

  CREATE OBJECT o1.

  CALL METHOD o1->m1.
