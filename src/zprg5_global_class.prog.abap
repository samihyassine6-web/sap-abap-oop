*&---------------------------------------------------------------------*
*& Report ZPRG5_GLOBAL_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg5_global_class.

DATA: lo_object TYPE REF TO zcl_order.

PARAMETERS: p_pm TYPE zdepm_28.

*START-OF-SELECTION.

lo_object = NEW zcl_order( ).

lo_object->get_data(
  EXPORTING
    im_pm    =   p_pm               " Payment Mode
  IMPORTING
    et_order =   data(it_order)               " Order header table type
  CHANGING
    c_pm     =   p_pm               " Payment Mode
).


cl_demo_output=>display(
  EXPORTING
    data =   it_order               " Text  oder Daten
    name =  | { TEXT-001 } | & |{ p_pm }|  ).
