*&---------------------------------------------------------------------*
*& Report ZPRG6_INHERITANCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg6_inheritance.

DATA: lo_object1 TYPE REF TO zcl_inherit1. " Parent Class
DATA: lo_object2 TYPE REF TO zcl_inherit2. " Child Class

lo_object1 = NEW zcl_inherit1( ).
lo_object2 = NEW zcl_inherit2( ).


lo_object2->m1( ).
*lo_object2->m2( ).
lo_object2->m4( ).
