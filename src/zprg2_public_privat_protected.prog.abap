*&---------------------------------------------------------------------*
*& Report ZPRG2_PUBLIC_PRIVAT_PROTECTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg2_public_privat_protected.

CLASS lcl_class DEFINITION.
  PUBLIC SECTION.
    DATA: a TYPE i.
    CLASS-DATA: b TYPE i.
    METHODS get_data IMPORTING i_a TYPE i
                               i_b TYPE i.
*  PROTECTED SECTION.
*  PRIVATE SECTION.
    METHODS display_data.
ENDCLASS.

CLASS lcl_class IMPLEMENTATION.
  METHOD get_data.
    a = i_a.
    b = i_b.
*    CALL METHOD me->display_data.  " privat section
  ENDMETHOD.

  METHOD display_data.
    WRITE: / a , b.
  ENDMETHOD.
ENDCLASS.

DATA: lo_object1 TYPE REF TO lcl_class.
DATA: lo_object2 TYPE REF TO lcl_class.

START-OF-SELECTION.

PARAMETERS: p_a TYPE i, p_b TYPE i.

  lo_object1 = NEW lcl_class( ) .
  lo_object2 = NEW lcl_class( ) .

  lo_object1->get_data(
    EXPORTING
      i_a = p_a
      i_b = p_b
  )..
  lo_object1->display_data( ).
  lo_object2 ?= lo_object1.
  lo_object2->display_data( ).
