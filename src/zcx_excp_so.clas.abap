class ZCX_EXCP_SO definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  constants INVALID_ORDER type SOTR_CONC value '0800270087501FD08BB0B69A8B21458D' ##NO_TEXT.
  constants NO_DATA type SOTR_CONC value '0800270087501FD08BB0D72683E04599' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_EXCP_SO IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
  endmethod.
ENDCLASS.
