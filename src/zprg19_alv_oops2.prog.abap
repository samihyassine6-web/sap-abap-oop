*&---------------------------------------------------------------------*
*& Report ZPRG19_ALV_OOPS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg19_alv_oops2.

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
         col    TYPE lvc_t_scol,
       END OF lty_ordh.

DATA: it_ordh TYPE TABLE OF lty_ordh.
DATA: ls_ordh TYPE lty_ordh.

DATA: it_ordi TYPE TABLE OF zordi_28.
DATA: ls_ordi LIKE LINE OF it_ordi.
DATA: it_fcat TYPE lvc_t_fcat.
DATA: ls_fcat LIKE LINE OF it_fcat.
DATA: lv_ono TYPE zdeono_28.
DATA: lv_count TYPE i.
DATA: lo_cont TYPE REF TO cl_gui_custom_container.
DATA: lo_grid TYPE REF TO cl_gui_alv_grid.
DATA: ls_layo TYPE lvc_s_layo.
DATA: ls_scol TYPE lvc_s_scol.
*DATA: it_scol TYPE lvc_t_scol.

SELECT-OPTIONS: s_ono FOR lv_ono.

START-OF-SELECTION.
  CALL SCREEN 1111.
*&---------------------------------------------------------------------*
*& Module STATUS_1111 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_1111 OUTPUT.
  SET PF-STATUS 'PF'.
  SET TITLEBAR 'TXT'.

  IF lo_cont IS NOT BOUND.
    lo_cont = NEW cl_gui_custom_container(
      container_name          = 'CUST_CTR_SO'
    ).
  ENDIF.

  IF lo_grid IS NOT BOUND.
    lo_grid = NEW cl_gui_alv_grid(
      i_parent         = lo_cont
    ).

    SELECT FROM zordh_28
       FIELDS ono, odate, creaby, dno, ddate, pm, ta, curr, dloc
        WHERE ono IN @s_ono
      INTO CORRESPONDING FIELDS OF TABLE @it_ordh.  " for not confusing the system, fetch into corresponding fields

    LOOP AT it_ordh ASSIGNING FIELD-SYMBOL(<fs_so>).
      CASE <fs_so>-pm.
        WHEN 'C' .
          ls_scol-fname = 'ONO'.
          ls_scol-color-col = '3'.
          ls_scol-color-int = '1'.
          ls_scol-color-inv = '0'.
          APPEND ls_scol TO  <fs_so>-col.
          ls_scol-fname = 'PM'.
          ls_scol-color-col = '3'.
          ls_scol-color-int = '1'.
          ls_scol-color-inv = '0'.
          APPEND ls_scol TO  <fs_so>-col.
        WHEN 'D' .
          ls_scol-fname = 'ONO'.
          ls_scol-color-col = '4'.
          ls_scol-color-int = '1'.
          ls_scol-color-inv = '0'.
          APPEND ls_scol TO  <fs_so>-col.
          ls_scol-fname = 'PM'.
          ls_scol-color-col = '4'.
          ls_scol-color-int = '1'.
          ls_scol-color-inv = '0'.
          APPEND ls_scol TO  <fs_so>-col.

        WHEN 'N'.
          ls_scol-fname = 'ONO'.
          ls_scol-color-col = '5'.
          ls_scol-color-int = '1'.
          ls_scol-color-inv = '0'.
          APPEND ls_scol TO  <fs_so>-col.
          ls_scol-fname = 'PM'.
          ls_scol-color-col = '5'.
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
      <fs_so>-ta BETWEEN 5000 AND 10000.
        ls_scol-fname = 'TA'.
        ls_scol-color-col = '5'.
        ls_scol-color-int = '0'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO <fs_so>-col.
      ELSEIF
      <fs_so>-ta < 5000.
        ls_scol-fname = 'TA'.
        ls_scol-color-col = '3'.
        ls_scol-color-int = '0'.
        ls_scol-color-inv = '0'.
        APPEND ls_scol TO <fs_so>-col.

      ENDIF.

    ENDLOOP.

* fill fieldcatalog
    PERFORM fill_fcat USING 'ONO'    'Order Number'.
    PERFORM fill_fcat USING 'ODATE'  'Order Date'.
    PERFORM fill_fcat USING 'CREABY' 'Createtd By'.
    PERFORM fill_fcat USING 'DNO'    'Delivery Number'.
    PERFORM fill_fcat USING 'DDATE'  'Delivery Date'.
    PERFORM fill_fcat USING 'PM'     'Payment Mode'.
    PERFORM fill_fcat USING 'TA'     'Tota Amoount'.
    PERFORM fill_fcat USING 'CURR'   'Currency'.
    PERFORM fill_fcat USING 'DLOC'   'Delivery Location'.

* fill layout
    ls_layo-zebra = 'X'.
*    ls_layo-info_fname = 'COL'.
    ls_layo-ctab_fname = 'COL'.
* display alv

    lo_grid->set_table_for_first_display(
      EXPORTING
*        i_buffer_active               =                  " Pufferung aktiv
*        i_bypassing_buffer            =                  " Puffer ausschalten
*        i_consistency_check           =                  " Starte Konsistenzverprobung für Schnittstellefehlererkennung
*        i_structure_name              =                  " Strukturname der internen Ausgabetabelle
*        is_variant                    =                  " Anzeigevariante
*        i_save                        =                  " Anzeigevariante sichern
*        i_default                     = 'X'              " Defaultanzeigevariante
        is_layout                     =  ls_layo               " Layout
*        is_print                      =                  " Drucksteuerung
*        it_special_groups             =                  " Feldgruppen
*        it_toolbar_excluding          =                  " excludierte Toolbarstandardfunktionen
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
*&      Module  USER_COMMAND_1111  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1111 INPUT.
  IF sy-ucomm = 'BACK'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.
