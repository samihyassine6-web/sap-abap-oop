class ZCL_TESTEX definition
  public
  create public .

public section.

  methods M1
    importing
      !INPUT1 type INT4
      !INPUT2 type STRING
    exporting
      !ES_RES type STRING
    raising
      CX_SY_ZERODIVIDE
      CX_SY_CONVERSION_NO_NUMBER .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TESTEX IMPLEMENTATION.


  METHOD m1.
    es_res = input1 / input2.
  ENDMETHOD.
ENDCLASS.
