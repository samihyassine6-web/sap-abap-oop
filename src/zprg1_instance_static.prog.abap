*&---------------------------------------------------------------------*
*& Report ZPRG1_INSTANCE_STATIC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg1_instance_static.

CLASS lcl_class DEFINITION.
  PUBLIC SECTION.
    DATA: a TYPE i.
    CLASS-DATA: b TYPE i.
    CONSTANTS: c TYPE i VALUE 10.
ENDCLASS.

DATA: lo_object1 TYPE REF TO lcl_class.
DATA: lo_object2 TYPE REF TO lcl_class.
lo_object1 = NEW lcl_class( ) .
lo_object2 = NEW lcl_class( ) .

WRITE: / lcl_class=>b.

WRITE: / lo_object1->a. " Instance attribut
WRITE: / lo_object1->b. " Static Attribut
WRITE: / lo_object1->c. " Constant

ULINE.
lo_object1->a = 10.
lo_object1->b = 20.
WRITE: / 'assign values to a, b from lo_object1'.
WRITE: / lo_object1->a, lo_object1->b. " a = 10 and b = 20
ULINE.

**********************************************************************

WRITE: / 'not assigning value to a, b from lo_object2'.
WRITE: / lo_object2->a, lo_object2->b.  " a = 0 and b = 20

ULINE.

lo_object2->a = 89.
lo_object2->b = 90.
WRITE: / 'assign values to a, b from lo_object2'.
WRITE: / lo_object2->a, lo_object2->b.
ULINE.

WRITE: / 'Display a, b from lo_object1'.
WRITE: / lo_object1->a, lo_object1->b. " a = 10 and b = 90
ULINE.
