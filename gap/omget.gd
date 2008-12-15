#############################################################################
##
#W  omget.gd           OpenMath Package         Andrew Solomon
#W                                                     Marco Costantini
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  Reads an OpenMath object from an input stream and returns
##  a GAP object.
##

Revision.("openmath/gap/omget.gd") :=
    "@(#)$Id$";

#############################################################################
##
#F  OMGetObject( <stream> )
##
##  <stream> is an input stream (see "ref: InputTextFile", "ref:
##  InputTextUser", "ref: InputTextString", 
##  "ref: InputOutputLocalProcess" ) with an OpenMath object on it.
##  OMGetObject takes precisely one object off <stream> 
##  and returns it as a GAP object.
##  Both XML and binary OpenMath encoding are supported: autodetection
##  is used.
##  This function requires either that the {\GAP} package `GapDoc' is
##  available (for XML OpenMath), or that the external program `gpipe',
##  included in this package, has been compiled (for both XML and binary
##  OpenMath).

DeclareGlobalFunction("OMGetObject");

#####################################################################
##
##  The Symbol Table for supported symbols from official OpenMath CDs
##
##  Maps a pair ["cd", "name"] to the corresponding OMgap... function
##  defined above or immediately in the table
##
DeclareGlobalVariable("OMsymTable");

#############################################################################
#E
