*&---------------------------------------------------------------------*
*& Report ZPRG17_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg17_alv.

DATA: lv_ono TYPE zdeono_28.
DATA: lv_count TYPE i.
DATA: it_fcat TYPE slis_t_fieldcat_alv.
DATA: ls_fcat LIKE LINE OF it_fcat.
DATA: it_fcat1 TYPE slis_t_fieldcat_alv.
DATA: ls_fcat1 LIKE LINE OF it_fcat.
DATA: it_events TYPE slis_t_event.
DATA: ls_events LIKE LINE OF it_events.

SELECT-OPTIONS: s_ono FOR lv_ono.



SELECT * FROM zordh_28 INTO TABLE @DATA(it_ordh)
  WHERE ono IN @s_ono.

IF it_ordh IS NOT INITIAL.
  CLEAR: lv_count.
* filling fieldcat internal table.
  PERFORM fill_fcat USING 'ONO'    'Order Number'.
  PERFORM fill_fcat USING 'ODATE'  'Order Date'.
  PERFORM fill_fcat USING 'CREABY' 'Created By'.
  PERFORM fill_fcat USING 'DNO'    'Order Number'.
  PERFORM fill_fcat USING 'DDATE'  'Order Item Number'.
  PERFORM fill_fcat USING 'PM'     'Payment Mode'.
  PERFORM fill_fcat USING 'TA'     'Total Amount'.
  PERFORM fill_fcat USING 'CURR'   'Currency'.
  PERFORM fill_fcat USING 'DLOC'   'Delivery Location'.
* filling event internal table.
  ls_events-name = 'USER_COMMAND'.
  ls_events-form = 'UC'.
  APPEND ls_events TO it_events.
  CLEAR ls_events.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-cprog
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
*     IS_LAYOUT          =
      it_fieldcat        = it_fcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
*     IS_VARIANT         =
      it_events          = it_events
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  = 0
*     I_HTML_HEIGHT_END  = 0
*     IT_ALV_GRAPHICS    =
*     IT_HYPERLINK       =
*     IT_ADD_FIELDCAT    =
*     IT_EXCEPT_QINFO    =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = it_ordh
*   EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDIF.


*&---------------------------------------------------------------------*
*& Form FILL_FCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM fill_fcat  USING    VALUE(p_fname)
                         VALUE(p_value).
  lv_count = lv_count + 1.
  ls_fcat-fieldname = p_fname.
  ls_fcat-col_pos   = lv_count.
  ls_fcat-seltext_m = p_value.
  APPEND ls_fcat TO it_fcat.
  CLEAR ls_fcat.

ENDFORM.

FORM uc USING ucomm LIKE sy-ucomm
              selfield TYPE slis_selfield.
  IF selfield-fieldname = 'ONO'.
    SELECT * FROM zordi_28 INTO TABLE @DATA(it_ordi) WHERE ono = @selfield-value.
    IF it_ordi IS NOT INITIAL.
      CLEAR: lv_count.
      REFRESH:it_fcat1.
      PERFORM fill_fcat1 USING 'ONO'    'Order Number'.
      PERFORM fill_fcat1 USING 'OIN'    'Order Item Number'.
      PERFORM fill_fcat1 USING 'ITEMID' 'Item ID'.
      PERFORM fill_fcat1 USING 'ODESC'  'Order Description'.
      PERFORM fill_fcat1 USING 'MENG'   'Quantity'.
      PERFORM fill_fcat1 USING 'ICOST'  'Item Costs'.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          it_fieldcat   = it_fcat1
        TABLES
          t_outtab      = it_ordi
        EXCEPTIONS
          program_error = 1
          OTHERS        = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    ELSE.
      MESSAGE: | Item Data for the Order Number | & | < | & | { selfield-value } | & | > | & |  still not created  | TYPE 'I'.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form FILL_FCAT1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM fill_fcat1  USING    VALUE(p_fname)
                          VALUE(p_value).
  lv_count = lv_count + 1.
  ls_fcat1-fieldname = p_fname.
  ls_fcat1-col_pos   = lv_count.
  ls_fcat1-seltext_m = p_value.
  APPEND ls_fcat1 TO it_fcat1.
  CLEAR ls_fcat1.

ENDFORM.
