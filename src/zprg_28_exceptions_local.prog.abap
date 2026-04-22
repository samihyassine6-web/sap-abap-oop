*&---------------------------------------------------------------------*
*& Report ZPRG_28_EXCEPTIONS_LOCAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_28_exceptions_local.



PARAMETERS: pa1 TYPE i DEFAULT 100.
PARAMETERS: pa2 TYPE i.


CLASS cx_my_exception DEFINITION
      INHERITING FROM cx_static_check.
  PUBLIC SECTION.

*    DATA: lv_text TYPE sotr_conc.
    METHODS: get_msg.
    METHODS: get_txt .

    DATA: lv_message TYPE string.
    CONSTANTS: lv_text TYPE sotr_conc VALUE  ' zero divide error '.
ENDCLASS.

CLASS cx_my_exception IMPLEMENTATION.
  METHOD get_msg.
    lv_message = | my exception caught both parameters are equal | & | { pa1 } | & | and | & | { pa2 } |   .
    WRITE: / lv_message.
  ENDMETHOD.

  METHOD get_txt.
*    WRITE: / lv_text.
    MESSAGE i000(i8) WITH | { lv_text } | .
  ENDMETHOD.
ENDCLASS.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    DATA: a, b TYPE i.
    METHODS: m1 RAISING cx_my_exception.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
  METHOD m1.
    DATA: output TYPE p DECIMALS 2.
    IF pa1 = pa2.
      RAISE EXCEPTION TYPE cx_my_exception.
    ENDIF.
    IF
      pa2 = 0.
      RAISE EXCEPTION TYPE cx_my_exception
        EXPORTING
          textid = cx_my_exception=>lv_text.
*          previous
      .
    ELSE.
      output = pa1 / pa2.
      WRITE: / | The division of | & | { pa1 } | &  | and  | & | { pa2 } | & | is equal to: |, output.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

at SELECTION-SCREEN OUTPUT.

START-OF-SELECTION.
  DATA : o1 TYPE REF TO c1.
  DATA : o_exc TYPE REF TO cx_my_exception.

  TRY .
      IF o1 IS NOT BOUND.
        o1 = NEW c1( ).
      ENDIF.
      IF o_exc IS NOT BOUND.
        o_exc = NEW cx_my_exception(
          textid   = cx_my_exception=>lv_text
*        previous =
        ).
      ENDIF.
      o1->m1( ).
    CATCH cx_my_exception INTO o_exc.
      IF pa2 <> 0.
        o_exc->get_msg( ).
      ELSE.
        o_exc->get_txt( )..
      ENDIF.

  ENDTRY.
