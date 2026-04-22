class ZCL_ORDER definition
  public
  final
  create public .

public section.

  methods GET_DATA
    importing
      !IM_PM type ZDEPM_28
    exporting
      !ET_ORDER type ZTT_ORDER
    changing
      !C_PM type ZDEPM_28 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ORDER IMPLEMENTATION.


  METHOD get_data.
    DATA: lv_ono TYPE zdeono_28.
    DATA: lv_pm TYPE zdepm_28.
    SELECT SINGLE ono FROM zordh_28 INTO lv_ono WHERE pm = im_pm.
    IF lv_ono IS INITIAL.
      c_pm = 'C'.
    ENDIF.
    SELECT  * FROM zordh_28 INTO TABLE et_order
      WHERE pm = c_pm.
  ENDMETHOD.
ENDCLASS.
