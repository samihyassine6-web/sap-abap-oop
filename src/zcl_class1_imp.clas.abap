class ZCL_CLASS1_IMP definition
  public
  create public .

public section.

  methods M1 .
protected section.

  methods M2 .
private section.

  methods M3 .
ENDCLASS.



CLASS ZCL_CLASS1_IMP IMPLEMENTATION.


  method M1.

    WRITE: / 'Method m1 calling from lcl_class1'.

  endmethod.


  method M2.

    WRITE: / 'Method m2 calling from lcl_class1'.

  endmethod.


  method M3.

    WRITE: / 'Method m3 calling from lcl_class1'.

  endmethod.
ENDCLASS.
