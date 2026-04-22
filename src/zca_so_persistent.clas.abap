class ZCA_SO_PERSISTENT definition
  public
  inheriting from ZCB_SO_PERSISTENT
  final
  create private .

public section.

  class-data AGENT type ref to ZCA_SO_PERSISTENT read-only .

  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCA_SO_PERSISTENT IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
***BUILD 090501
************************************************************************
* Purpose        : Initialize the 'class'.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Singleton is created.
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 1999-09-20   : (OS) Initial Version
* - 2000-03-06   : (BGR) 2.0 modified REGISTER_CLASS_AGENT
************************************************************************
* GENERATED: Do not modify
************************************************************************

  create object AGENT.

  call method AGENT->REGISTER_CLASS_AGENT
    exporting
      I_CLASS_NAME          = 'ZCL_SO_PERSISTENT'
      I_CLASS_AGENT_NAME    = 'ZCA_SO_PERSISTENT'
      I_CLASS_GUID          = '0800270087501FE08CE4742D7D76B1A4'
      I_CLASS_AGENT_GUID    = '0800270087501FE08CE4746765CA71A4'
      I_AGENT               = AGENT
      I_STORAGE_LOCATION    = 'ZSALES_INFO'
      I_CLASS_AGENT_VERSION = '2.0'.

           "CLASS_CONSTRUCTOR
  endmethod.
ENDCLASS.
