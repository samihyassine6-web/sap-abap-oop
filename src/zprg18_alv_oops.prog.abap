*&---------------------------------------------------------------------*
*& Report ZPRG18_ALV_OOPS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg18_alv_oops.



TYPES: BEGIN OF lty_ordh,
         ono    TYPE zdeono_28,
         odate  TYPE zdeodate_28,
         creaby TYPE zdecrby_28,
         dno    TYPE zdedn_28,
         ddate  TYPE zdeddate_28,
         pm     TYPE zdepm_28,
         ta     TYPE zdeta_28,
         curr   TYPE zdecurr_28,
         dloc   TYPE zdedloc_28,
       END OF lty_ordh.

DATA: it_ordh TYPE TABLE OF lty_ordh.
DATA: ls_ordh TYPE lty_ordh.



DATA: lv_ono TYPE zdeono_28.
DATA: lv_count TYPE i.
DATA: lo_cont TYPE REF TO cl_gui_custom_container.
DATA: lo_cont_item TYPE REF TO cl_gui_custom_container.
DATA: lo_grid TYPE REF TO cl_gui_alv_grid.
DATA: lo_grid_item TYPE REF TO cl_gui_alv_grid.
DATA: it_fcat TYPE lvc_t_fcat.
DATA: ls_fcat LIKE LINE OF it_fcat.
DATA: it_fcat_item TYPE lvc_t_fcat.
DATA: ls_fcat_item LIKE LINE OF it_fcat_item.
DATA: it_ordi TYPE TABLE OF zordi_28.


SELECT-OPTIONS: s_ono FOR lv_ono.

CLASS lcl_item DEFINITION.
  PUBLIC SECTION.
    METHODS: handl_item FOR EVENT double_click OF cl_gui_alv_grid IMPORTING e_row e_column.

ENDCLASS.

CLASS lcl_item IMPLEMENTATION.
  METHOD handl_item.
    IF e_column-fieldname = 'ONO'.
      READ TABLE it_ordh INTO ls_ordh INDEX e_row-index.
      SELECT * FROM zordi_28 INTO TABLE @it_ordi
        WHERE ono = @ls_ordh-ono.
      IF it_ordi IS INITIAL.
        MESSAGE: | Item Data for the Order Number | & | < | & | { ls_ordh-ono } | & | > | & |  still not created  | TYPE 'I'.
      ELSE.
        CALL SCREEN 2223.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(lo_item) = NEW lcl_item( ).

  CALL SCREEN 2222.
*&---------------------------------------------------------------------*
*& Module STATUS_2222 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2222 OUTPUT.
  SET PF-STATUS 'PF'.
  SET TITLEBAR 'TTL'.

  IF lo_cont IS NOT BOUND.
    lo_cont = NEW cl_gui_custom_container(
*    parent                  =
      container_name          = 'CUST_CTRL'
*    style                   =
*    lifetime                = lifetime_default
*    repid                   =
*    dynnr                   =
*    no_autodef_progid_dynnr =
    ).
  ENDIF.

  IF lo_grid IS NOT BOUND.
    lo_grid = NEW cl_gui_alv_grid(
*     i_shellstyle     = 0
*     i_lifetime       =
      i_parent         = lo_cont
*     i_appl_events    = space
*     i_parentdbg      =
*     i_applogparent   =
*     i_graphicsparent =
*     i_name           =
*     i_fcat_complete  = space
    ).
  ENDIF.

  SELECT  ono, odate, creaby, dno, ddate, pm, ta, curr, dloc FROM zordh_28 INTO TABLE @it_ordh
    WHERE ono IN @s_ono.
  IF it_ordh IS NOT INITIAL.
    CLEAR lv_count.
* fieldcatalog
    PERFORM fill_fcat USING 'ONO'    'Order Number'.
    PERFORM fill_fcat USING 'ODATE'  'Order Date'.
    PERFORM fill_fcat USING 'CREABY' 'Created By'.
    PERFORM fill_fcat USING 'DNO'    'Order Number'.
    PERFORM fill_fcat USING 'DDATE'  'Order Item Number'.
    PERFORM fill_fcat USING 'PM'     'Payment Mode'.
    PERFORM fill_fcat USING 'TA'     'Total Amount'.
    PERFORM fill_fcat USING 'CURR'   'Currency'.
    PERFORM fill_fcat USING 'DLOC'   'Delivery Location'.

    SET HANDLER lo_item->handl_item FOR lo_grid.  " Register the event

    lo_grid->set_table_for_first_display(
      CHANGING
        it_outtab                     =  it_ordh                " Ausgabetabelle
        it_fieldcatalog               =  it_fcat                " Feldkatalog
*          it_sort                       =                  " Sortierkriterien
*          it_filter                     =                  " Filterkriterien
      EXCEPTIONS
        invalid_parameter_combination = 1                " Parameter falsch
        program_error                 = 2                " Programmfehler
        too_many_lines                = 3                " Zu viele Zeilen in eingabebereitem Grid.
        OTHERS                        = 4
    ).
    IF sy-subrc <> 0.
*       MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.


ENDMODULE.
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
  ls_fcat-col_pos  = lv_count.
  ls_fcat-coltext  = p_value.
  APPEND ls_fcat TO it_fcat.
  CLEAR ls_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2222  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2222 INPUT.
  IF sy-ucomm = 'BACK'.
    LEAVE PROGRAM.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_2223 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2223 OUTPUT.
  SET PF-STATUS 'PF1'.
  SET TITLEBAR 'TXT'.

  IF lo_cont_item IS NOT BOUND.
    lo_cont_item = NEW cl_gui_custom_container(
*      parent                  =
      container_name          = 'CUST_ITEM'
*      style                   =
*      lifetime                = lifetime_default
*      repid                   =
*      dynnr                   =
*      no_autodef_progid_dynnr =
    ).
  ENDIF.

  IF lo_grid_item IS NOT BOUND.
    lo_grid_item = NEW cl_gui_alv_grid(

      i_parent         = lo_cont_item

    ).
  ENDIF.

  CLEAR lv_count.
* fill fieldcatalog
  CLEAR it_fcat_item.
  PERFORM fill_fcat_item USING 'ONO'    'Order Number'.
  PERFORM fill_fcat_item USING 'OIN'    'Order Item Number'.
  PERFORM fill_fcat_item USING 'ITEMID' 'Item ID'.
  PERFORM fill_fcat_item USING 'ODESC'  'Item Description'.
  PERFORM fill_fcat_item USING 'MENG'   'Order Quantity'.
  PERFORM fill_fcat_item USING 'ICOST'  'Item Costs'.

  CALL METHOD lo_grid_item->set_table_for_first_display
    CHANGING
      it_outtab                     = it_ordi
      it_fieldcatalog               = it_fcat_item
*     it_sort                       =
*     it_filter                     =
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*    Implement suitable error handling here
  ENDIF.
  CALL METHOD lo_grid_item->refresh_table_display.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form FILL_FCAT_ITEM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM fill_fcat_item  USING    VALUE(p_fname)
                              VALUE(p_value).
  lv_count = lv_count + 1.
  ls_fcat_item-fieldname = p_fname.
  ls_fcat_item-col_pos = lv_count.
  ls_fcat_item-coltext = p_value.
  APPEND ls_fcat_item TO it_fcat_item.
  CLEAR ls_fcat_item.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2223  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2223 INPUT.
  IF sy-ucomm = 'BACK'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.
