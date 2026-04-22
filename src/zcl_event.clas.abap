class ZCL_EVENT definition
  public
  create public .

public section.

  events NO_HEADER_DATA
    exporting
      value(IV_ONO) type ZDEONO_28 optional .

  methods GET_ORDER
    importing
      !I_ONO type ZDEONO_28
    exporting
      !ES_ORDER type ZORDH_28 .
  methods NO_DATA
    for event NO_HEADER_DATA of ZCL_EVENT
    importing
      !IV_ONO .
protected section.
private section.
ENDCLASS.



CLASS ZCL_EVENT IMPLEMENTATION.


  METHOD get_order.
    SELECT SINGLE * FROM zordh_28 INTO es_order WHERE ono = i_ono.
    IF es_order IS INITIAL.
      RAISE EVENT no_header_data EXPORTING iv_ono = i_ono.
    ENDIF.
  ENDMETHOD.


  METHOD no_data.
    WRITE: / | Data is not available for given input: | & | { iv_ono } | .
  ENDMETHOD.
ENDCLASS.
