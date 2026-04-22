*&---------------------------------------------------------------------*
*& Report ZPRG8_CONSTRUCTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg8_constructor.

*DATA: lo_obj1 TYPE REF TO zcl_const.
*DATA: lo_obj2 TYPE REF TO zcl_const.
*
PARAMETERS: p_number TYPE lifnr.
PARAMETERS: p_name TYPE name1.

START-OF-SELECTION.

  WRITE: 'lo_obj calling Constructor'.
  data(lo_obj1) = NEW zcl_const( i_own_num = p_number i_own_name = p_name ).

  ULINE.

  lo_obj1->m1( ).

  data(lo_obj2) = NEW zcl_const( i_own_num = p_number i_own_name = p_name ).
  ULINE.
**********************************************************************

  DATA: lo_obj3 TYPE REF TO zcl_inh_const. " Child Class from zcl_const

  lo_obj3 = NEW zcl_inh_const(  i_own_num = p_number i_own_name = p_name  ).
*
*  lo_obj3->m2( ).
*  lo_obj3->m1( ).
