class ZCL_SO_CAST_ITEM definition
  public
  inheriting from ZCL_SO_CAST
  create public .

public section.

  methods CUST_INFO .

  methods SO_INFO
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SO_CAST_ITEM IMPLEMENTATION.


  METHOD cust_info.
    WRITE: / 'Calling method cust_info from sub class zcl_so_cast_item '.
  ENDMETHOD.


  METHOD so_info.
*CALL METHOD SUPER->SO_INFO
*    .
    WRITE: / 'Calling method so_info from  sub class zcl_so_cast_item '.
  ENDMETHOD.
ENDCLASS.
