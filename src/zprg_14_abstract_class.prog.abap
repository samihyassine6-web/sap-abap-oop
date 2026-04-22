*&---------------------------------------------------------------------*
*& Report ZPRG_14_ABSTRACT_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_14_abstract_class.

DATA: lo_obj TYPE REF TO zcl_abstract1_bill. " child class from the abstract class
DATA: lo_obj_sup TYPE REF TO zcl_abstract.   " abstract class as super class
DATA: lo_card TYPE REF TO zcl_ccard.

START-OF-SELECTION.

  lo_obj = NEW zcl_abstract1_bill( ).
*  lo_obj_sup = NEW zcl_abstract( ).  " Creating Instance for a abstract class is not allowed.
  lo_card = NEW zcl_ccard( ).

*  lo_obj_sup = lo_obj.  " Narrow Casting



  lo_obj->so_info( ).
  lo_obj->payment( ).

  lo_obj->m1( ).

  lo_card->payment( ).
