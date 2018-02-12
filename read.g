###########################################################################
##
#W    read.g              OpenMath Package             Andrew Solomon
#W                                                     Marco Costantini
##
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##    read.g file
##


# Module 1.2.b
# This module converts the OpenMath XML into a tree and parses it;
# requires the function OMsymLookup and the function ParseTreeXMLString from
# package GapDoc and provides the function OMgetObjectXMLTree
ReadPackage("openmath", "gap/xmltree.gi");

#
# Module 2: conversion from GAP to OpenMath
# (Modules 1 and 2 are independent)
#

# Module 2.1
# This module is concerned with outputting OpenMath; provides
# OMPutObject and OMPrint

ReadPackage("openmath", "gap/omputxml.gi");
ReadPackage("openmath", "gap/omputbin.gi");
ReadPackage("openmath", "gap/omput.gi");

# Read private CDs if available
# Note that this does *not* error if the file private/private.gi
# is not available.
ReadPackage("openmath", "private/private.gi");

###########################################################################
#E
