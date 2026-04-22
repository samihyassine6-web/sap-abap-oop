*&---------------------------------------------------------------------*
*& Report ZPRG16_EVENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg16_event.

PARAMETERS: p_ono TYPE zdeono_28.



DATA(lo_obj) = NEW zcl_event( ).
DATA(lo_obj2) = NEW zcl_event2( ).

START-OF-SELECTION.

  SET HANDLER lo_obj2->no_data1 FOR lo_obj.
  SET HANDLER lo_obj->no_data FOR lo_obj.
  SET HANDLER lo_obj2->no_data2 FOR lo_obj.

  lo_obj->get_order(
    EXPORTING
      i_ono    =  p_ono                " Order Number
    IMPORTING
      es_order =  DATA(ls_order)                " Order Header Table
  ).
  IF ls_order IS NOT INITIAL.
    WRITE:/ ls_order-ono, ls_order-odate.
  ENDIF.
