*&---------------------------------------------------------------------*
*& Report ZPRG21_SO_BILL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg21_so_bill.

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

TYPES: BEGIN OF lty_final,
         ono    TYPE zdeono_28,
         oin    TYPE zdeoin_28,
         itemid TYPE zdeitemid_28,
         odesc  TYPE zdeodesc_28,
         meng   TYPE zdemeng_28,
         odate  TYPE zdeodate_28,
         ta     TYPE zdeta_28,
         curr   TYPE zdecurr_28,
         bdate  TYPE zdbdate_28,
         btype  TYPE zdebtyp_28,
         bact   TYPE zdeact_28,
         col    TYPE lvc_t_scol,
       END OF lty_final.

DATA: it_final TYPE TABLE OF lty_final.
DATA: ls_final TYPE lty_final.

DATA: it_ordi TYPE TABLE OF zordi_28.
DATA: ls_ordi LIKE LINE OF it_ordi.
DATA: it_fcat TYPE lvc_t_fcat.
DATA: ls_fcat LIKE LINE OF it_fcat.
DATA: it_fcat1 TYPE lvc_t_fcat.
DATA: ls_fcat1 LIKE LINE OF it_fcat.
DATA: lv_ono TYPE zdeono_28.
DATA: lv_count TYPE i.
DATA: lo_cont TYPE REF TO cl_gui_custom_container.
DATA: lo_grid TYPE REF TO cl_gui_alv_grid.
DATA: lo_cont1 TYPE REF TO cl_gui_custom_container.
DATA: lo_grid1 TYPE REF TO cl_gui_alv_grid.
DATA: flag TYPE i.

DATA: ls_layo TYPE lvc_s_layo.
DATA: ls_scol TYPE lvc_s_scol.
DATA: it_toolbar TYPE ui_functions.
DATA: ls_toolbar LIKE LINE OF it_toolbar.

SELECT-OPTIONS: s_ono FOR lv_ono.

CLASS lcl_class DEFINITION.
  PUBLIC SECTION.
    METHODS: get_bill FOR EVENT hotspot_click OF cl_gui_alv_grid IMPORTING e_row_id es_row_no e_column_id.
ENDCLASS.

CLASS lcl_class IMPLEMENTATION.
  METHOD get_bill.
    IF e_column_id-fieldname = 'ONO'.
      READ TABLE it_ordh INTO ls_ordh INDEX e_row_id-index.
      IF sy-subrc = 0.
        SELECT FROM zordi_28 AS a INNER JOIN zbill_28 AS b
            ON a~ono = b~ono
            FIELDS a~ono, a~oin, a~itemid, a~odesc, a~meng,
                   b~odate, b~ta, b~curr, b~bdate, b~btype, b~bact
             WHERE a~ono = @ls_ordh-ono
          INTO CORRESPONDING FIELDS OF TABLE @it_final.
        IF it_final IS INITIAL.
          MESSAGE i000(i8) WITH | No Billing Details for Order Number | & | { ls_ordh-ono } |.
        ELSE.
          CLEAR: it_fcat1.
          CLEAR: lv_count.
          PERFORM fill_fcat_bill USING 'ONO'     'Order Number'.
          PERFORM fill_fcat_bill USING 'OIN'     'Order Item Number'.
          PERFORM fill_fcat_bill USING 'ITEMID' 'Item ID'.
          PERFORM fill_fcat_bill USING 'ODESC'   'Item Description'.
          PERFORM fill_fcat_bill USING 'MENG'    'Quantity'.
          PERFORM fill_fcat_bill USING 'ODATE'   'Order Date'.
          PERFORM fill_fcat_bill USING 'TA'      'Total Amount'.
          PERFORM fill_fcat_bill USING 'CURR'    'Currency'.
          PERFORM fill_fcat_bill USING 'BDATE'   'Billing Date'.
          PERFORM fill_fcat_bill USING 'BTYPE'   'Billing Type'.
          PERFORM fill_fcat_bill USING 'BACT'    'Accounting Document Number'.

          ls_layo-zebra = 'X'.
*    ls_layo-info_fname = 'COL'.
          ls_layo-ctab_fname = 'COL'.

          IF lo_cont1 IS NOT BOUND.
            lo_cont1 = NEW cl_gui_custom_container(
              container_name          =  'CUST_BILL'
            ).
          ENDIF.

          IF lo_grid1 IS NOT BOUND.
            lo_grid1 = NEW cl_gui_alv_grid(
              i_parent         = lo_cont1
            ).
          ENDIF.
          PERFORM add_color.
          lo_grid1->set_table_for_first_display(
            EXPORTING
              is_layout                     =  ls_layo                " Layout
            CHANGING
              it_outtab                     =   it_final               " Ausgabetabelle
              it_fieldcatalog               =   it_fcat1               " Feldkatalog
            EXCEPTIONS
              invalid_parameter_combination = 1                " Parameter falsch
              program_error                 = 2                " Programmfehler
              too_many_lines                = 3                " Zu viele Zeilen in eingabebereitem Grid.
              OTHERS                        = 4
          ).
          IF sy-subrc <> 0.
*           MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
    CALL METHOD lo_grid1->refresh_table_display.
  ENDMETHOD.

ENDCLASS.


AT SELECTION-SCREEN.
  SELECT FROM zordh_28 FIELDS ono
    WHERE ono IN @s_ono
    INTO TABLE @DATA(it_ono).
  IF sy-subrc <> 0.
    MESSAGE e000(e8) WITH |Order Number { s_ono-low } does not exist|.
  ENDIF.


START-OF-SELECTION.

  DATA: lo_bill TYPE REF TO lcl_class.

  lo_bill = NEW lcl_class( ).

  SELECT FROM zordh_28
    FIELDS ono, odate, creaby, dno, ddate, pm, ta, curr, dloc
    WHERE ono IN @s_ono
    INTO  TABLE @it_ordh.
* fieldcatalog
    CLEAR: it_fcat.
    CLEAR: lv_count.
    PERFORM fill_fcat USING 'ONO'    'Order Number'.
    PERFORM fill_fcat USING 'ODATE'  'Order Date'.
    PERFORM fill_fcat USING 'CREABY' 'Createtd By'.
    PERFORM fill_fcat USING 'DNO'    'Delivery Number'.
    PERFORM fill_fcat USING 'DDATE'  'Delivery Date'.
    PERFORM fill_fcat USING 'PM'     'Payment Mode'.
    PERFORM fill_fcat USING 'TA'     'Tota Amoount'.
    PERFORM fill_fcat USING 'CURR'   'Currency'.
    PERFORM fill_fcat USING 'DLOC'   'Delivery Location'.
* custom container
    IF lo_cont IS NOT BOUND.
      lo_cont = NEW cl_gui_custom_container(
        container_name          =  'CUST_SO'
     ).
    ENDIF.
    IF lo_grid IS NOT BOUND.
      lo_grid = NEW cl_gui_alv_grid(
        i_parent         = lo_cont
      ).
    ENDIF.
    ls_toolbar = cl_gui_alv_grid=>mc_fc_sort_asc. " disable the asc function icon
    APPEND ls_toolbar TO it_toolbar.


    lo_grid->set_table_for_first_display(
      EXPORTING
*        i_buffer_active               =                  " Pufferung aktiv
*        i_bypassing_buffer            =                  " Puffer ausschalten
*        i_consistency_check           =                  " Starte Konsistenzverprobung für Schnittstellefehlererkennung
*        i_structure_name              =                  " Strukturname der internen Ausgabetabelle
*        is_variant                    =                  " Anzeigevariante
*        i_save                        =                  " Anzeigevariante sichern
*        i_default                     = 'X'              " Defaultanzeigevariante
*        is_layout                     =                  " Layout
*        is_print                      =                  " Drucksteuerung
*        it_special_groups             =                  " Feldgruppen
        it_toolbar_excluding          =   it_toolbar               " excludierte Toolbarstandardfunktionen
*        it_hyperlink                  =                  " Hyperlinks
*        it_alv_graphics               =                  " Tabelle von der Struktur DTC_S_TC
*        it_except_qinfo               =                  " Tabelle für die Exception Quickinfo
*        ir_salv_adapter               =                  " Interface ALV Adapter
      CHANGING
        it_outtab                     =  it_ordh                " Ausgabetabelle
        it_fieldcatalog               =  it_fcat                " Feldkatalog
*        it_sort                       =                  " Sortierkriterien
*        it_filter                     =                  " Filterkriterien
*      EXCEPTIONS
*        invalid_parameter_combination = 1                " Parameter falsch
*        program_error                 = 2                " Programmfehler
*        too_many_lines                = 3                " Zu viele Zeilen in eingabebereitem Grid.
*        others                        = 4
    ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*    ENDIF.
  ENDIF.
  SET HANDLER lo_bill->get_bill FOR lo_grid.   " Register the event           " SET HANDLER lo_item->handl_item FOR lo_grid.  " Register the event
  CALL SCREEN 3333.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_3333  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_3333 INPUT.
  IF sy-ucomm = 'BACK'.
    LEAVE TO SCREEN 0.
  ELSEIF
    sy-ucomm = 'GOBACK'.
    LEAVE PROGRAM.
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
  ls_fcat-col_pos = lv_count.
  ls_fcat-coltext = p_value.
  IF ls_fcat-fieldname = 'ONO'.
    ls_fcat-hotspot = 'X'.
  ENDIF.
  APPEND ls_fcat TO it_fcat.
  CLEAR ls_fcat.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form FILL_FCAT_BILL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM fill_fcat_bill  USING    VALUE(p_fname)
                              VALUE(p_value).
  lv_count = lv_count + 1.
  ls_fcat1-fieldname = p_fname.
  ls_fcat1-col_pos   = lv_count.
  ls_fcat1-coltext   = p_value.
  APPEND ls_fcat1 TO it_fcat1.
  CLEAR ls_fcat1.
ENDFORM.

*&---------------------------------------------------------------------*
*& Module STATUS_3333 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_3333 OUTPUT.
  SET PF-STATUS 'STAT1'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form ADD_COLOR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM add_color .
  LOOP AT it_final ASSIGNING FIELD-SYMBOL(<fs_so>).
    CASE <fs_so>-curr.
      WHEN 'USD' .
        ls_scol-fname = 'ONO'.
        ls_scol-color-col = '7'.
        ls_scol-color-int = '1'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO  <fs_so>-col.
        ls_scol-fname = 'CURR'.
        ls_scol-color-col = '3'.
        ls_scol-color-int = '1'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO  <fs_so>-col.
      WHEN 'MAD' .
        ls_scol-fname = 'ONO'.
        ls_scol-color-col = '7'.
        ls_scol-color-int = '1'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO  <fs_so>-col.
        ls_scol-fname = 'CURR'.
        ls_scol-color-col = '1'.
        ls_scol-color-int = '1'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO  <fs_so>-col.
      WHEN 'EUR'.
        ls_scol-fname = 'ONO'.
        ls_scol-color-col = '7'.
        ls_scol-color-int = '1'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO  <fs_so>-col.
        ls_scol-fname = 'CURR'.
        ls_scol-color-col = '1'.
        ls_scol-color-int = '1'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO  <fs_so>-col.
    ENDCASE.
    IF <fs_so>-ta > 10000.
      ls_scol-fname = 'TA'.
      ls_scol-color-col = '5'.
      ls_scol-color-int = '1'.
      ls_scol-color-inv = '1'.
      APPEND ls_scol TO <fs_so>-col.
    ELSEIF
    <fs_so>-ta BETWEEN 2000 AND 10000.
      ls_scol-fname = 'TA'.
      ls_scol-color-col = '5'.
      ls_scol-color-int = '0'.
      ls_scol-color-inv = '0'.
      APPEND ls_scol TO <fs_so>-col.
    ELSEIF
    <fs_so>-ta < 2000.
      ls_scol-fname = 'TA'.
      ls_scol-color-col = '6'.
      ls_scol-color-int = '0'.
      ls_scol-color-inv = '1'.
      APPEND ls_scol TO <fs_so>-col.
    ENDIF.
  ENDLOOP.

ENDFORM.
