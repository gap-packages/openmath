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


## the *.gd files are now read by init.g


#############################################################################
## Module 1: conversion from OpenMath to Gap



#################################################################
## Module 1.1 
## This module contains the semantic mappings from parsed openmath
## symbols to GAP objects; provides the functions OMsymLookup and
## OMnullarySymbolToGAP


# Frank Luebeck's utility for obtaining view strings.
ReadPackage("openmath", "/gap/printutil.g");

ReadPackage("openmath", "/gap/gap.g");

# file containing updates
ReadPackage("openmath", "/gap/new.g");



#################################################################
## Module 1.2.a
## This module reads token/values off the stream and builds GAP objects;
## uses the external binary gpipe, 
## requires the functions OMsymLookup and OMnullarySymbolToGAP and
## provides OMpipeObject
## Directories bin, include, OMCv1.3c, src belongs to this module.


ReadPackage("openmath", "/gap/lex.g");
# ReadPackage("openmath", "/gap/parse.gd");
ReadPackage("openmath", "/gap/parse.gi");


# test for existence of the compiled binary
if Filename(DirectoriesPackagePrograms("openmath"), "gpipe") = fail  then
    Info( InfoWarning, 1,
     "Warning: package openmath, the program `gpipe' is not compiled." );
fi;



#################################################################
## Module 1.2.b
## This module converts the OpenMath XML into a tree and parses it;
## requires the functions OMsymLookup and OMnullarySymbolToGAP
## (and the function ParseTreeXMLString from package GapDoc) and
## provides OMgetObjectXMLTree

if IsBound( ParseTreeXMLString )  then
    # ReadPackage("openmath", "/gap/xmltree.gd");
    ReadPackage("openmath", "/gap/xmltree.gi");
else
    MakeReadWriteGlobal( "OMgetObjectXMLTree" );
    OMgetObjectXMLTree := ReturnFail;
fi;


#################################################################
## Module 1.3
## This module gets exactly one OpenMath object from <input stream>;
## provides the function PipeOpenMathObject


ReadPackage("openmath", "/gap/pipeobj.g");



#################################################################
## Module 1.4
## This module converts one OpenMath object to a Gap object; requires
## PipeOpenMathObject and one of the functions OMpipeObject or
## OMgetObjectXMLTree and provides OMGetObject


# ReadPackage("openmath", "/gap/omget.gd");
ReadPackage("openmath", "/gap/omget.g");




#############################################################################
## Module 2: conversion from Gap to OpenMath
## (Modules 1 and 2 are independent)



#################################################################
## Module 2.1
## This module is concerned with outputting OpenMath; provides
## OMPutObject and OMPrint

# ReadPackage("openmath", "/gap/omput.gd");
ReadPackage("openmath", "/gap/omput.gi");


#################################################################
## Module 2.2
## This module is concerned with viewing Hasse diagrams;
## requires the variables defined in gap/omput.gd

ReadPackage("openmath", "/hasse/config.g");
ReadPackage("openmath", "/hasse/hasse.g");



#############################################################################
## Module 3: test
## Provides the function OMTest for testing OMGetObject.OMPutObject = id
## requires OMGetObject and OMPutObject

# ReadPackage("openmath", "/gap/test.gd");
ReadPackage("openmath", "/gap/test.g");



#############################################################################
#E
