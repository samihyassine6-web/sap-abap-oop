# ABAP Object-Oriented Programming (OOP) Demos

## Overview

This repository contains a set of examples demonstrating **object-oriented programming in ABAP**.
It covers basic class definitions to advanced concepts such as polymorphism, inheritance, and CRUD operations.

---

## Topics Covered

* Local and Global Classes
* Encapsulation
* Inheritance
* Polymorphism
* Interfaces
* Method Overriding
* Factory Pattern (basic)
* CRUD Operations using ABAP OO

---

## Examples

### Local Class

```abap
CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.
    METHODS: display.
ENDCLASS.
```

### Inheritance

```abap
CLASS lcl_parent DEFINITION.
  PUBLIC SECTION.
    METHODS: display.
ENDCLASS.

CLASS lcl_child DEFINITION INHERITING FROM lcl_parent.
ENDCLASS.
```

### Polymorphism

```abap
DATA: lo_parent TYPE REF TO lcl_parent,
      lo_child  TYPE REF TO lcl_child.

lo_parent = lo_child.
lo_parent->display( ).
```

---

## CRUD Operations (OO-based)

* Create: Insert records via class methods
* Read: Select data into internal tables
* Update: Modify existing entries
* Delete: Remove records

---

## ALV with OOP

* Encapsulated ALV display
* Dynamic data handling
* Reusable class-based design

---

## Technologies

* ABAP Objects
* Internal Tables
* ALV Grid

---

## Purpose

To demonstrate structured, reusable, and scalable ABAP development using object-oriented principles.

---

## System

SAP NetWeaver AS ABAP 7.52 Developer Edition

---

## Author

Yassine
