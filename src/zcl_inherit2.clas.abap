class ZCL_INHERIT2 definition
  public
  inheriting from ZCL_INHERIT1
  final
  create public .

public section.

  methods M4 .

  methods M1
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_INHERIT2 IMPLEMENTATION.


  METHOD m1.
    CALL METHOD super->m1.
    ULINE.
    WRITE: / 'Method M1 calling from zcl__inherit2'.
  ENDMETHOD.


  METHOD m4.
    CALL METHOD me->m2.
  ENDMETHOD.
ENDCLASS.
