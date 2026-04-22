class ZCL_TEST_INTF1 definition
  public
  create public .

public section.

  interfaces ZIF__TEST .
  interfaces ZIF__TEST1 .

  aliases I_ONO
    for ZIF__TEST~I_ONO .
  aliases BILL_INFO
    for ZIF__TEST1~BILL_INFO .
  aliases ITEM_INFO
    for ZIF__TEST~ITEM_INFO .
  aliases ORDER_INFO
    for ZIF__TEST1~ORDER_INFO .
  aliases SALES_INFO
    for ZIF__TEST~SALES_INFO .

  methods M1 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TEST_INTF1 IMPLEMENTATION.


  METHOD m1.
    zif__test~i_ono = '0000000012'.
    WRITE: / 'Method M1 is passing value to Order as ', ZIF__TEST~i_ono.
  ENDMETHOD.


  method ZIF__TEST1~BILL_INFO.
    WRITE: / 'Bill_info method calling from zcl_test_intf1'.
  endmethod.


  METHOD zif__test1~order_info.
    WRITE: / 'order_info method calling from zcl_test_intf1'.
  ENDMETHOD.


  method ZIF__TEST~ITEM_INFO.
       WRITE: / 'Method item_info calling from zcl_test_inf1'.
  endmethod.


  METHOD zif__test~sales_info.
    WRITE: / 'Method sales_info calling from zcl_test_inf1'.
  ENDMETHOD.
ENDCLASS.
