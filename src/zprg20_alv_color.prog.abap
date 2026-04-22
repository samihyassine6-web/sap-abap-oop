*&---------------------------------------------------------------------*
*& Report ZPRG20_ALV_COLOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg20_alv_color.

DATA: w_idx TYPE i.

*Adding a color table of type LVC_T_SCOL to the output table.
DATA:
BEGIN OF t_itab OCCURS 0.
DATA box TYPE c.
DATA icon TYPE c.
INCLUDE STRUCTURE sflight.
DATA linecolor(4) TYPE c.              " for coloring rows
DATA tabcolor TYPE lvc_t_scol.
DATA END OF t_itab.

**Table for cell coloring**
DATA: tabcolor TYPE lvc_t_scol.
DATA: fs TYPE lvc_s_scol.

**declaring the container & grid for output table display**
DATA:
  r_container TYPE REF TO cl_gui_custom_container,
  r_grid      TYPE REF TO cl_gui_alv_grid.
**structure of layout**
DATA:
  fs_lay TYPE lvc_s_layo.

**Field Catalog**
DATA:
  t_fcat  TYPE lvc_t_fcat,
  fs_fcat TYPE lvc_s_fcat.

CLEAR fs_fcat.
fs_fcat-fieldname = 'PRICE'.
fs_fcat-emphasize = 'C600'.            " coloring the complete column airfare



APPEND fs_fcat TO t_fcat.


SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE t_itab.

*--------------------------------------------------------------------------------
fs_lay-info_fname = 'LINECOLOR'."for coloring rows
fs_lay-ctab_fname = 'TABCOLOR'. " for coloring cells

*------------------------------------------------------------------------------
*coloring rows where price < 500.(yellow)
t_itab-linecolor = 'C510'.
MODIFY t_itab TRANSPORTING linecolor WHERE price LT 500.
*------------------------------------------------------------------------------
*coloring cells where connid = 17. overwrites the previously colored rows

LOOP AT t_itab.
  w_idx = sy-tabix.
  REFRESH tabcolor.

  IF t_itab-connid = 17.
    fs-fname = 'PRICE'.
    fs-color-col = 7.
    fs-nokeycol = 'X'.
    APPEND fs TO tabcolor.
  ENDIF.

  INSERT LINES OF tabcolor INTO TABLE t_itab-tabcolor ."index w_idx.
  MODIFY t_itab INDEX w_idx.

ENDLOOP.
CALL SCREEN 100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN1'.
  IF r_container IS NOT BOUND.
    CREATE OBJECT r_container
      EXPORTING
        container_name = 'CONTAINER'.
  ENDIF.
  IF r_grid IS NOT BOUND.
    CREATE OBJECT r_grid
      EXPORTING
        i_parent = r_container.
  ENDIF.
*passing the layout structure, fieldcatalog and output table for display*
  CALL METHOD r_grid->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SFLIGHT'
      is_layout        = fs_lay
    CHANGING
      it_fieldcatalog  = t_fcat
      it_outtab        = t_itab[].

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  LIST  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE list OUTPUT.
*  IF r_container IS NOT BOUND.
*    CREATE OBJECT r_container
*      EXPORTING
*        container_name = 'CONTAINER'.
*  ENDIF.
*  IF r_grid IS NOT BOUND.
*    CREATE OBJECT r_grid
*      EXPORTING
*        i_parent = r_container.
*  ENDIF.
**passing the layout structure, fieldcatalog and output table for display*
*  CALL METHOD r_grid->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SFLIGHT'
*      is_layout        = fs_lay
*    CHANGING
*      it_fieldcatalog  = t_fcat
*      it_outtab        = t_itab[].
*
*
*
*ENDMODULE.                 " LIST  OUTPU
