class ZCX_EXCP_SO1 definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of INVALID_ORDER,
      msgid type symsgid value 'ZMESSAGE',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'LV_ONO',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INVALID_ORDER .
  constants:
    begin of NO_DATA,
      msgid type symsgid value 'ZMESSAGE',
      msgno type symsgno value '013',
      attr1 type scx_attrname value 'LV_ONO',
      attr2 type scx_attrname value 'LV_CLIENT',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NO_DATA .
  constants:
    begin of ENTER_VAL_O,
      msgid type symsgid value 'ZMESSAGE',
      msgno type symsgno value '011',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ENTER_VAL_O .
  class-data LV_ONO type ZDEONO_28 .
  class-data LV_CLIENT type MANDT .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !LV_ONO type ZDEONO_28 optional
      !LV_CLIENT type MANDT optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_EXCP_SO1 IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->LV_ONO = LV_ONO .
me->LV_CLIENT = LV_CLIENT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
