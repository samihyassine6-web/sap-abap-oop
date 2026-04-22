*&---------------------------------------------------------------------*
*& Report ZPRG10_FRIEND_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg10_friend_class.

DATA: obj TYPE REF TO zcl_friend2.
*DATA: obj1 TYPE REF TO zcl_friend.

PARAMETERS: p_input1 TYPE int4.
PARAMETERS: p_input2 TYPE int4.

START-OF-SELECTION.

  obj = NEW zcl_friend2( ).
*  obj1 = NEW zcl_friend( ).

  obj->m4(
    EXPORTING
      input1 =  p_input1                " Natürliche Zahl
      input2 =  p_input2                " Natürliche Zahl
  ).
