class ZCL_CCARD definition
  public
  inheriting from ZCL_ABSTRACT1_BILL
  create public .

public section.

  methods PAYMENT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CCARD IMPLEMENTATION.


  METHOD payment.
    DATA(lv_cr_card_num) = '1245 1256 1247 3569'.
    DATA(lv_paid_amount) = '1200000'.
    WRITE: / 'Credit Card Number :', lv_cr_card_num.
    WRITE: / 'Paid Amount :', lv_paid_amount.
  ENDMETHOD.
ENDCLASS.
