class ZCL_FRIEND2 definition
  public
  final
  create public .

public section.

  methods M4
    importing
      !INPUT1 type INT4
      !INPUT2 type INT4 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FRIEND2 IMPLEMENTATION.


  METHOD m4.
    DATA: lv_result TYPE i.
    DATA: lo_object TYPE REF TO cx_sy_zerodivide.
    lo_object = NEW cx_sy_zerodivide( ).
    TRY .
        lv_result = input1 / input2.
        WRITE: lv_result.
      CATCH cx_sy_zerodivide INTO lo_object.
        CALL METHOD lo_object->if_message~get_longtext
*           EXPORTING
*             preserve_newlines =
          RECEIVING
            result = DATA(lv_data).
        MESSAGE lv_data TYPE 'I'.

        lo_object->get_text(
          RECEIVING
           result = DATA(lv_string)
           ).
        MESSAGE: lv_string TYPE 'I'.

        CALL METHOD lo_object->get_source_position
          IMPORTING
            program_name = DATA(lv_prog)
            include_name = DATA(lv_inc)
            source_line  = DATA(lv_line).
        MESSAGE: | Program: | & | { lv_prog } | & | Include: | & | { lv_inc } | & |  Line Position: | & | { lv_line } | TYPE 'I'.

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
