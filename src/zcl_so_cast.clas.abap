class ZCL_SO_CAST definition
  public
  create public .

public section.

  methods SO_INFO .
  methods M1 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SO_CAST IMPLEMENTATION.


  METHOD m1.
    WRITE: / 'Calling method M1 from super class zcl_so_cast '.
  ENDMETHOD.


  METHOD so_info.
    WRITE: / 'Calling method so_info from super class zcl_so_cast '.
  ENDMETHOD.
ENDCLASS.
