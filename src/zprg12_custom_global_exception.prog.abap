*&---------------------------------------------------------------------*
*& Report ZPRG12_CUSTOM_GLOBAL_EXCEPTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg12_custom_global_exception.

DATA: lo_obj TYPE REF TO zcl_so.
DATA: lo_obj_exc TYPE REF TO zcx_excp_so1.
DATA: lv_flag TYPE boolean.

PARAMETERS: p_ono TYPE zdeono_28.

START-OF-SELECTION.

  lo_obj = NEW zcl_so(  ).

  TRY.
      lo_obj->m1(
        EXPORTING
          i_ono   =   p_ono               " Order Number
        IMPORTING
          et_ordi =   DATA(it_ordi)
      ).
    CATCH zcx_excp_so1 INTO lo_obj_exc.

      CALL METHOD lo_obj_exc->if_message~get_longtext
        RECEIVING
          result = DATA(lv_result).
      MESSAGE lv_result TYPE 'I'.
      EXIT.
  ENDTRY.

  cl_demo_output=>display(
    EXPORTING
      data =  it_ordi                " Text  oder Daten
      name =  | Item Details for Sales Order number | & | { p_ono } |
  ).
