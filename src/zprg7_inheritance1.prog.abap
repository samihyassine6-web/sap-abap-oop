*&---------------------------------------------------------------------*
*& Report ZPRG7_INHERITANCE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg7_inheritance1.

CLASS lcl_class1 DEFINITION.
  PUBLIC SECTION.
    METHODS: m1.
  PROTECTED SECTION.
    METHODS: m2.
  PRIVATE SECTION.
    METHODS: m3.
ENDCLASS.

CLASS lcl_class1 IMPLEMENTATION.
  METHOD m1.
    WRITE: / 'Method m1 calling from lcl_class1'.
  ENDMETHOD.

  METHOD m2.
    WRITE: / 'Method m2 calling from lcl_class1'.
  ENDMETHOD.

  METHOD m3.
    WRITE: / 'Method m3 calling from lcl_class1'.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA: lo_obj TYPE REF TO zcl_class1_imp. " Global Class of local Class lcl_class1

  lo_obj = NEW zcl_class1_imp( ).

  lo_obj->m1( ).
*  lo_obj->m2( ).
