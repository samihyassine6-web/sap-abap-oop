class ZCL_ABSTRACT definition
  public
  abstract
  create public .

public section.

  data SO_NUM type ZDEONO_28 .
  data BILL_NUM type ZDEBNO_28 .

  methods SO_INFO .
  methods PAYMENT
  abstract .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ABSTRACT IMPLEMENTATION.


  METHOD so_info.
    so_num = '1'.
    bill_num = '1'.
    WRITE: / 'Sales Order = ', so_num.
    WRITE: 'Billing Number = ', bill_num.
  ENDMETHOD.
ENDCLASS.
