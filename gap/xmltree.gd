#############################################################################
##
#W  xmltree.gd          OpenMath Package              Andrew Solomon
#W                                                    Marco Costantini
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  The main function in this file converts the OpenMath XML into a tree
##  (using the function ParseTreeXMLString from package GapDoc) and
##  parses it.
##

Revision.("openmath/gap/xmltree.gd") :=
    "@(#)$Id$";



DeclareGlobalFunction("OMParseXmlObj");
DeclareGlobalFunction("OMgetObjectXMLTree");



#############################################################################
#E
