class ZCL_FRIEND definition
  public
  final
  create public

  global friends ZCL_FRIEND2 .

public section.

  methods M1 .
protected section.

  methods M2 .
private section.

  methods M3 .
ENDCLASS.



CLASS ZCL_FRIEND IMPLEMENTATION.


  method M1.
    WRITE: / 'Inside method M1, class zcl_friend'.
  endmethod.


  method M2.
    WRITE: / 'Inside method M2, class zcl_friend'.
  endmethod.


  method M3.
     WRITE: / 'Inside method M3, class zcl_friend'.
  endmethod.
ENDCLASS.
