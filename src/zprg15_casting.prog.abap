*&---------------------------------------------------------------------*
*& Report ZPRG15_CASTING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg15_casting.

DATA: super_obj TYPE REF TO zcl_so_cast.
DATA: super_obj2 TYPE REF TO zcl_so_cast.
DATA: sub_obj TYPE REF TO zcl_so_cast_item." Sub class

START-OF-SELECTION.

  super_obj = NEW zcl_so_cast( ).
  super_obj2 = NEW zcl_so_cast( ).
  sub_obj = NEW zcl_so_cast_item( ).



*  super_obj->so_info( ).  " Super Class
*  sub_obj->so_info( ).    " Sub Class redefined method so_info
*  sub_obj->cust_info( ).
*  sub_obj->m1( ).

  super_obj = sub_obj.  " Narrow Casting-> from more info to less info reference

  super_obj->so_info( ).
* super_obj->cust_info( ).  '" syntax error method does not exist
  CALL METHOD super_obj->('CUST_INFO'). " Dynamic Calling to call sub class method with super class object doing narrow casting
  CALL METHOD super_obj->m1.

  super_obj = super_obj2.  " wide casting-> from less to more details

  CALL METHOD super_obj->m1.
