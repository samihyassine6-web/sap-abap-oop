*&---------------------------------------------------------------------*
*& Report ZPRG11_FRIEND_EXCEPTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg11_friend_exception.

DATA: lo_object TYPE REF TO zcl_testex.
DATA: lo_objexc TYPE REF TO cx_sy_zerodivide.
DATA: lo_objexc1 TYPE REF TO cx_sy_conversion_no_number.

PARAMETERS: p_input1 TYPE int4.
PARAMETERS: p_input2 TYPE string.

START-OF-SELECTION.

  lo_object = NEW zcl_testex( ).
  lo_objexc = NEW cx_sy_zerodivide( ).
  lo_objexc1 = NEW cx_sy_conversion_no_number( ).

  TRY.
      CALL METHOD lo_object->m1
        EXPORTING
          input1 = p_input1
          input2 = p_input2
        IMPORTING
          es_res = DATA(lv_result).

      WRITE: lv_result.

    CATCH cx_sy_zerodivide INTO lo_objexc .

      CALL METHOD lo_objexc->if_message~get_longtext
        RECEIVING
          result = DATA(lv_data).

      MESSAGE: lv_data TYPE 'I'.

      CALL METHOD lo_objexc->if_message~get_text
        RECEIVING
          result = DATA(lv_data1).

      MESSAGE: lv_data1 TYPE 'I'.

      CALL METHOD lo_objexc->get_source_position
        IMPORTING
          program_name = DATA(lv_prog)
          include_name = DATA(lv_inc)
          source_line  = DATA(lv_line).
      MESSAGE: | Program: | & | { lv_prog } | & | Include: | & | { lv_inc } | & | Source Line: | & | { lv_line } | TYPE 'I' .


    CATCH cx_sy_conversion_no_number .

      CALL METHOD lo_objexc1->if_message~get_longtext
        RECEIVING
          result = DATA(lv_data2).

      MESSAGE: lv_data2 TYPE 'I'.

      CALL METHOD lo_objexc1->if_message~get_text
        RECEIVING
          result = DATA(lv_data3).

      MESSAGE: lv_data3 TYPE 'I'.

      CALL METHOD lo_objexc1->get_source_position
        IMPORTING
          program_name = DATA(lv_prog1)
          include_name = DATA(lv_inc1)
          source_line  = DATA(lv_line1).
      MESSAGE: | Program: | & | { lv_prog1 } | & | Include: | & | { lv_inc1 } | & | Source Line: | & | { lv_line1 } | TYPE 'I' .


  ENDTRY.
