#############################################################################
##
#W    read.g              OpenMath Package             Andrew Solomon
#W                                                     Marco Costantini
##
#H    @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##    read.g file
##

Revision.("openmath/read.g") :=
    "@(#)$Id$";

## the *.gd and *.g files are read by init.g


#################################################################
## Module 1.2.b
## This module converts the OpenMath XML into a tree and parses it;
## requires the function OMsymLookup (and the function 
## ParseTreeXMLString from package GapDoc) and provides 
## the function OMgetObjectXMLTree

if IsBound( ParseTreeXMLString )  then
    ReadPackage("openmath", "/gap/xmltree.gi");
else
    MakeReadWriteGlobal( "OMgetObjectXMLTree" );
    OMgetObjectXMLTree := ReturnFail;
fi;


#############################################################################
## Module 2: conversion from Gap to OpenMath
## (Modules 1 and 2 are independent)


#################################################################
## Module 2.1
## This module is concerned with outputting OpenMath; provides
## OMPutObject and OMPrint

ReadPackage("openmath", "/gap/omput.gi");
ReadPackage("openmath", "/private/private.gi");


#############################################################################
#E
