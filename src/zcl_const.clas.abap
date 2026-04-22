class ZCL_CONST definition
  public
  create public .

public section.

  data OWN_NUMBER type LIFNR .
  data OWN_NAME type NAME1 .

  methods CONSTRUCTOR
    importing
      !I_OWN_NUM type LIFNR
      !I_OWN_NAME type NAME1 .
  methods M1 .
  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CONST IMPLEMENTATION.


  METHOD class_constructor.
    WRITE: / 'Static Constructor from the Class'.
  ENDMETHOD.


  METHOD constructor.
    own_number = i_own_num.
    own_name   = i_own_name.
    WRITE: / own_number, own_name.
  ENDMETHOD.


  METHOD m1.
    WRITE: / 'Method M1 will Display'.
  ENDMETHOD.
ENDCLASS.
