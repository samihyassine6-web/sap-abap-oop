class ZCL_INH_CONST definition
  public
  inheriting from ZCL_CONST
  final
  create public .

public section.

  methods M2 .
  methods CONSTRUCTOR
    importing
      !I_OWN_NUM type LIFNR
      !I_OWN_NAME type NAME1 .
  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_INH_CONST IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
    WRITE: 'Static constructor from zcl_inh_const'.
  endmethod.


  METHOD constructor.
    WRITE: / 'Instance constructor from zcl_inh_const'.
    CALL METHOD super->constructor
      EXPORTING
        i_own_num  =  i_own_num               " Kontonummer des Lieferanten bzw. Kreditors
        i_own_name =  i_own_name                " Name
      ..

  ENDMETHOD.


  METHOD m2.
    WRITE: / 'Methode M2 calling from zcl_inh_const'.
  ENDMETHOD.
ENDCLASS.
