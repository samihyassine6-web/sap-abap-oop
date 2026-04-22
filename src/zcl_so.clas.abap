class ZCL_SO definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_ordi,
             ono    TYPE zdeono_28,
             oin    TYPE zdeoin_28,
             itemid TYPE zdeitemid_28,
             odesc  TYPE zdeodesc_28,
             meng   TYPE zdemeng_28,
             icost  TYPE zdeicost_28,
           END OF ty_ordi .
  types:
    tt_ordi TYPE TABLE OF ty_ordi .

  methods M1
    importing
      !I_ONO type ZDEONO_28
    exporting
      !ET_ORDI type TT_ORDI
    raising
      ZCX_EXCP_SO1 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SO IMPLEMENTATION.


  METHOD m1.
    SELECT SINGLE ono FROM zordh_28 INTO @DATA(lv_ono) WHERE ono = @i_ono.
    IF i_ono IS INITIAL.
      RAISE EXCEPTION TYPE zcx_excp_so1
        EXPORTING
          textid = zcx_excp_so1=>enter_val_o
          lv_ono = i_ono.

    ELSEIF
      i_ono IS NOT INITIAL AND lv_ono IS INITIAL.
      RAISE EXCEPTION TYPE zcx_excp_so1
        EXPORTING
          textid = zcx_excp_so1=>invalid_order
          lv_ono = i_ono.
    ELSE.
      SELECT FROM zordh_28 AS a INNER JOIN zordi_28 AS b ON a~ono = b~ono
        FIELDS a~ono, b~oin, b~itemid, b~odesc, b~meng, b~icost
        WHERE a~ono = @i_ono
        INTO TABLE @et_ordi.
      IF et_ordi IS INITIAL.
        RAISE EXCEPTION TYPE zcx_excp_so1
          EXPORTING
            textid    = zcx_excp_so1=>no_data
            lv_ono    = i_ono
            lv_client = sy-mandt.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
