*&---------------------------------------------------------------------*
*& Report ZPRG25_INTERFACES_CONCEPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg25_interfaces_concept.

INTERFACE if1.
  METHODS: m1, m2.
ENDINTERFACE.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if1.
    METHODS m1.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
  METHOD if1~m1.
    WRITE: / 'I am M1 from IF1'.
  ENDMETHOD.

  METHOD if1~m2.
    WRITE:/ 'I am M2 from IF1'.
  ENDMETHOD.

  METHOD m1.
    WRITE: / 'I am M1 from C1'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(o1) = NEW c1( ).

  o1->if1~m1( ).
  o1->if1~m2( ).
  o1->m1( ).
