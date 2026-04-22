*&---------------------------------------------------------------------*
*& Report ZPRG13_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg13_interfaces.

DATA: lo_obj TYPE REF TO zcl_test_intf1.

lo_obj = NEW zcl_test_intf1( ).

lo_obj->m1( ).
lo_obj->item_info( ).
lo_obj->sales_info( ).

CALL METHOD lo_obj->bill_info( ).
CALL METHOD lo_obj->order_info( ).
