class ZCL_INHERIT1 definition
  public
  create public .

public section.

  methods M1 .
protected section.

  methods M2 .
private section.

  methods M3 .
ENDCLASS.



CLASS ZCL_INHERIT1 IMPLEMENTATION.


  METHOD m1.
    WRITE: / 'Method M1 calling from zcl_inherit1'.
    CALL METHOD me->m3.
  ENDMETHOD.


  method M2.
    WRITE: / 'Method M2 calling from zcl_inherit1'.
  endmethod.


  METHOD m3.
    WRITE: / 'Method M3 calling from zcl_inherit1'.
  ENDMETHOD.
ENDCLASS.
