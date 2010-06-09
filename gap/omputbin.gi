#######################################################################
##
#W  omputbin.gi          OpenMath Package           Alexander Konovalov
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  Low-level methods for output in the OpenMath binary format
## 

Revision.("openmath/gap/omputbin.gi") := 
    "@(#)$Id$";

#######################################################################
##
#O  OMPutOMOBJ( <stream> ) 
#O  OMPutEndOMOBJ( <stream> ) 
##

InstallMethod(OMPutOMOBJ, "to write OMOBJ in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 24 );
end);

InstallMethod(OMPutEndOMOBJ, "to write /OMOBJ in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 25 );
end);

#######################################################################
##
#M  OMPut( <OMWriter>, <int> )  
##
##  Printing for integers: specified in the standard
## 
InstallMethod(OMPut, "for an integer to binary OpenMath", true,
[ IsOpenMathBinaryWriter, IsInt ],0,
function( writer, x )
# do things
end);

#############################################################################
#E
