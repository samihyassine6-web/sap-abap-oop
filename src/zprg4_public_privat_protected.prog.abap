*&---------------------------------------------------------------------*
*& Report ZPRG4_PUBLIC_PRIVAT_PROTECTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg4_public_privat_protected.

CLASS lcl_class DEFINITION.
  PUBLIC SECTION.
    DATA: a TYPE i.                " Instance Attribute
    CLASS-DATA: b TYPE i.          " Static Attribute
    CONSTANTS: c TYPE i VALUE 25.   " Constant

    METHODS get_data.              " Instance Method
    CLASS-METHODS display_data.    " Static Method
ENDCLASS.

CLASS lcl_class IMPLEMENTATION.
  METHOD get_data.
    WRITE: / 'Instance Method calling'.
*     a = 10.
*     b = 20.
  ENDMETHOD.

  METHOD display_data.
    WRITE: / 'Static Method calling'.
  ENDMETHOD.
ENDCLASS.

DATA: lo_object1 TYPE REF TO lcl_class.

START-OF-SELECTION.

  lo_object1 = NEW lcl_class( ) .

  lo_object1->get_data( ).

  lo_object1->a = 10.
  lo_object1->b = 20.
  WRITE: / lo_object1->a, lo_object1->b, lo_object1->c.
  ULINE.

  lo_object1->display_data( ).
