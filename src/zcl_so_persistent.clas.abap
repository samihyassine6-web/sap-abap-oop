class ZCL_SO_PERSISTENT definition
  public
  create protected

  global friends ZCB_SO_PERSISTENT .

public section.

  interfaces IF_OS_STATE .

  methods GET_KUNNR
    returning
      value(RESULT) type KUNNR
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_VBELN
    returning
      value(RESULT) type VBELN_VA
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_VBTYP
    returning
      value(RESULT) type VBTYP
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_KUNNR
    importing
      !I_KUNNR type KUNNR
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_VBTYP
    importing
      !I_VBTYP type VBTYP
    raising
      CX_OS_OBJECT_NOT_FOUND .
protected section.

  data VBELN type VBELN_VA .
  data KUNNR type KUNNR .
  data VBTYP type VBTYP .
private section.
ENDCLASS.



CLASS ZCL_SO_PERSISTENT IMPLEMENTATION.


  method GET_KUNNR.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute KUNNR
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = KUNNR.

           " GET_KUNNR
  endmethod.


  method GET_VBELN.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute VBELN
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = VBELN.

           " GET_VBELN
  endmethod.


  method GET_VBTYP.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute VBTYP
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = VBTYP.

           " GET_VBTYP
  endmethod.


  method IF_OS_STATE~GET.
***BUILD 090501
     " returning result type ref to object
************************************************************************
* Purpose        : Get state.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* GENERATED: Do not modify
************************************************************************

  data: STATE_OBJECT type ref to CL_OS_STATE.

  create object STATE_OBJECT.
  call method STATE_OBJECT->SET_STATE_FROM_OBJECT( ME ).
  result = STATE_OBJECT.

  endmethod.


  method IF_OS_STATE~HANDLE_EXCEPTION.
***BUILD 090501
     " importing I_EXCEPTION type ref to IF_OS_EXCEPTION_INFO optional
     " importing I_EX_OS type ref to CX_OS_OBJECT_NOT_FOUND optional
************************************************************************
* Purpose        : Handles exceptions during attribute access.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : If an exception is raised during attribut access,
*                  this method is called and the exception is passed
*                  as a paramater. The default is to raise the exception
*                  again, so that the caller can handle the exception.
*                  But it is also possible to handle the exception
*                  here in the callee.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
* - 2000-08-02   : (SB)  OO Exceptions
************************************************************************
* Modify if you like
************************************************************************

  if i_ex_os is not initial.
    raise exception i_ex_os.
  endif.

  endmethod.


  method IF_OS_STATE~INIT.
***BUILD 090501
"#EC NEEDED
************************************************************************
* Purpose        : Initialisation of the transient state partition.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Transient state is initial.
*
* OO Exceptions  : -
*
* Implementation : Caution!: Avoid Throwing ACCESS Events.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

  endmethod.


  method IF_OS_STATE~INVALIDATE.
***BUILD 090501
"#EC NEEDED
************************************************************************
* Purpose        : Do something before all persistent attributes are
*                  cleared.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : -
*
* Implementation : Whatever you like to do.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

  endmethod.


  method IF_OS_STATE~SET.
***BUILD 090501
     " importing I_STATE type ref to object
************************************************************************
* Purpose        : Set state.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* GENERATED: Do not modify
************************************************************************

  data: STATE_OBJECT type ref to CL_OS_STATE.

  STATE_OBJECT ?= I_STATE.
  call method STATE_OBJECT->SET_OBJECT_FROM_STATE( ME ).

  endmethod.


  method SET_KUNNR.
***BUILD 090501
     " importing I_KUNNR
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute KUNNR
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_KUNNR <> KUNNR ).

    KUNNR = I_KUNNR.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_KUNNR <> KUNNR )

           " GET_KUNNR
  endmethod.


  method SET_VBTYP.
***BUILD 090501
     " importing I_VBTYP
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute VBTYP
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_VBTYP <> VBTYP ).

    VBTYP = I_VBTYP.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_VBTYP <> VBTYP )

           " GET_VBTYP
  endmethod.
ENDCLASS.
