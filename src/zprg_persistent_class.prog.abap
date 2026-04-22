*&---------------------------------------------------------------------*
*& Report ZPRG_PERSISTENT_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_persistent_class.

DATA: obj_actor TYPE REF TO zca_so_persistent.
DATA: obj_pers TYPE REF TO zcl_so_persistent.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_vbeln TYPE vbeln_va,
            p_cust  TYPE kunnr,
            p_dt    TYPE vbtyp.
SELECTION-SCREEN END OF BLOCK b1.
SKIP.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_cr RADIOBUTTON GROUP m,
            p_dl RADIOBUTTON GROUP m,
            p_ch RADIOBUTTON GROUP m.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.

  obj_actor = zca_so_persistent=>agent.


  IF p_cr = 'X'.

    TRY.
        CALL METHOD obj_actor->create_persistent
          EXPORTING
            i_vbeln = p_vbeln                " Betriebswirtschaftlicher Schlüssel
          RECEIVING
            result  = obj_pers.                " Neu erzeugtes persistentes Objekt
      CATCH cx_os_object_existing. " Object Services: Objekt existiert
    ENDTRY.

    TRY.
        CALL METHOD obj_pers->set_kunnr
          EXPORTING
            i_kunnr = p_cust.                " Attributwert
      CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden
    ENDTRY.

    TRY.
        CALL METHOD obj_pers->set_vbtyp
          EXPORTING
            i_vbtyp = p_dt.                  " Attributwert

      CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden
    ENDTRY.
    COMMIT WORK.
    IF sy-subrc = 0.
      MESSAGE: s004(zmessage) WITH p_vbeln.
    ENDIF.
  ENDIF.



  IF p_ch = 'X'.
    TRY.
        CALL METHOD obj_actor->get_persistent
          EXPORTING
            i_vbeln = p_vbeln               " Betriebswirtschaftlicher Schlüssel
          RECEIVING
            result  = obj_pers.               " Persistentes Objekt
        IF  obj_pers IS BOUND.  " Not initial
          TRY.
              CALL METHOD obj_pers->set_vbtyp
                EXPORTING
                  i_vbtyp = p_dt.                " Attributwert
            CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden
          ENDTRY.
        ENDIF.
      CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden
    ENDTRY.





  ENDIF.
