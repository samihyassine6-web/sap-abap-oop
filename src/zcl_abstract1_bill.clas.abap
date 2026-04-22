class ZCL_ABSTRACT1_BILL definition
  public
  inheriting from ZCL_ABSTRACT
  create public .

public section.

  methods M1 .

  methods PAYMENT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ABSTRACT1_BILL IMPLEMENTATION.


  METHOD m1.
    WRITE: / 'Methode M1 calling from zcl_abstract1_bill .'.
  ENDMETHOD.


  METHOD payment.
    DATA(lv_pm_num) = '0001258'.
    DATA(lv_amount) = '2000'.
    DATA(lv_date) = sy-datum.
    WRITE: / 'Transaction Number: ', lv_pm_num.
    WRITE: / 'Payed Amount :', lv_amount, 'on', lv_date.
  ENDMETHOD.
ENDCLASS.
