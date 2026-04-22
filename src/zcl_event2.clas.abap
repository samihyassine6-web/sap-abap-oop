class ZCL_EVENT2 definition
  public
  create public .

public section.

  methods NO_DATA1
    for event NO_HEADER_DATA of ZCL_EVENT .
  methods NO_DATA2
    for event NO_HEADER_DATA of ZCL_EVENT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_EVENT2 IMPLEMENTATION.


  METHOD NO_DATA1.
    WRITE: / 'Data not foound'.
  ENDMETHOD.


  METHOD no_data2.
    WRITE: / 'Please maintain correct Input'.
  ENDMETHOD.
ENDCLASS.
