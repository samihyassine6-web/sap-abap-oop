class ZCL_CONST2 definition
  public
  final
  create public .

public section.

  class-data OWN_NUM type LIFNR .

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CONST2 IMPLEMENTATION.


  METHOD class_constructor.
    WRITE: / 'Inside static constructor'.
  ENDMETHOD.


  METHOD constructor.
    WRITE: / 'Inside Instance constructor'.
  ENDMETHOD.
ENDCLASS.
