*&---------------------------------------------------------------------*
*& Report ZPRG9_CONSTRUCTOR2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg9_constructor2.

DATA: obj TYPE REF TO zcl_const2.
data: obj1 TYPE REF TO zcl_const2.

obj = NEW zcl_const2( ).
obj1 = NEW zcl_const2( ).

zcl_const2=>own_num = '123456789'.

WRITE: / zcl_const2=>own_num.
WRITE: / obj->own_num.
WRITE:  / obj1->own_num.
