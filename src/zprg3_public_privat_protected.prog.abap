*&---------------------------------------------------------------------*
*& Report ZPRG3_PUBLIC_PRIVAT_PROTECTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg3_public_privat_protected.


CLASS lcl_class DEFINITION.
  PUBLIC SECTION.
    DATA: a TYPE i.
    DATA: b TYPE i.
    CONSTANTS: c TYPE i VALUE 25.

    METHODS get_data.
    METHODS display_data.
ENDCLASS.

CLASS lcl_class IMPLEMENTATION.
  METHOD get_data.
    a = 10.
    b = 20.
  ENDMETHOD.

  METHOD display_data.
    WRITE: / a, b.
  ENDMETHOD.
ENDCLASS.

DATA: lo_object1 TYPE REF TO lcl_class.
DATA: lo_object2 TYPE REF TO lcl_class.

START-OF-SELECTION.

  lo_object1 = NEW lcl_class( ) .
  lo_object2 = NEW lcl_class( ) .

  lo_object1->get_data( ).
  lo_object1->display_data( ).

  WRITE: / 'display data from lo_object2'.
  lo_object2 = lo_object1.
  WRITE: / lo_object2->a, lo_object2->b, lo_object2->c. " a = 10, b = 20, c = 25.
