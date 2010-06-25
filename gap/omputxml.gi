#######################################################################
##
#W  omput.gi                OpenMath Package             Andrew Solomon
#W                                                     Marco Costantini
#W                                                  Alexander Konovalov
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  Low-level methods for output in the OpenMath XML format
## 

Revision.("openmath/gap/omput.gi") := 
    "@(#)$Id$";


#######################################################################
#
# The Gap function AppendTo (used by OMWriteLine) uses
# PrintFormattingStatus and, before Gap 4.4.7, PrintFormattingStatus was
# defined only for text streams.
#
if not CompareVersionNumbers( VERSION, "4.4.7" )  then
    InstallOtherMethod( PrintFormattingStatus, "for non-text output stream",
      true, [IsOutputStream], 0,
      function ( str )
        if IsOutputTextStream( str )  then
            TryNextMethod();
        fi;
        return false;
    end);
fi;
    
    
#######################################################################
##  
#F  OMWriteLine( <stream>, <list> )
##
##  Input : List of arguments to print
##  Output: \t ^ OMIndent, arguments
##
InstallGlobalFunction(OMWriteLine,
function(stream, alist)
	local i;

	# do the indentation
	AppendTo( stream, ListWithIdenticalEntries( OMIndent, '\t' ) );

	for i in alist do
		AppendTo(stream, i);
	od;
	AppendTo(stream, "\n");
end);


#######################################################################
## 
## Basic OpenMath objects and tags
##
#######################################################################


#######################################################################
##
#F  OMPutVar( <stream>, <name> )
##
##  Input : name as string
##  Output: <OMV name="<name>" />
##
InstallMethod( OMPutVar, "to write OMV in XML OpenMath", true,
[ IsOpenMathXMLWriter, IsObject ],0,
function( writer, name )
  OMWriteLine( writer![1], ["<OMV name=\"", String(name), "\"/>"] );
end);


#######################################################################
##
#F  OMPutSymbol( <stream>, <cd>, <name> )
##
##  Input : cd, name as strings
##  Output: <OMS cd="<cd>" name="<name>" />
##
InstallMethod( OMPutSymbol, "to write OMS in XML OpenMath", true,
[ IsOpenMathXMLWriter, IsString, IsString ],0,
function( writer, cd, name )
  OMWriteLine( writer![1], ["<OMS cd=\"", cd, "\" name=\"", name, "\"/>"] );
end);


#######################################################################
##
#M  OMPutOMA
#M  OMPutEndOMA
##
InstallMethod(OMPutOMA, "to write OMA in XML OpenMath", true,
[IsOpenMathXMLWriter],0,
function( writer )
	OMWriteLine( writer![1], [ "<OMA>" ] );
    OMIndent := OMIndent + 1;
end);

InstallMethod(OMPutEndOMA, "to write /OMA in XML OpenMath", true,
[IsOpenMathXMLWriter],0,
function( writer )
    OMIndent := OMIndent - 1;
	OMWriteLine( writer![1], [ "</OMA>" ] );
end);


#######################################################################
##
#M  OMPutOMOBJ
#M  OMPutEndOMOBJ
##
InstallMethod(OMPutOMOBJ, "to write OMOBJ in XML OpenMath", true,
[IsOpenMathXMLWriter],0,
function( writer )
	OMIndent := 0;
	OMWriteLine( writer![1], [ "<OMOBJ>" ] );
    OMIndent := 1;
end);

InstallMethod(OMPutEndOMOBJ, "to write /OMOBJ in XML OpenMath", true,
[IsOpenMathXMLWriter],0,
function( writer )
    OMIndent := OMIndent - 1;
	OMWriteLine( writer![1], [ "</OMOBJ>" ] );
end);


#############################################################################
## 
## Various methods for OMPut
## 

BindGlobal( "OMINT_LIMIT", 2^15936 );

#######################################################################
##
#M  OMPut( <OMWriter>, <int> )  
##
##  Printing for integers: specified in the standard
## 
InstallMethod(OMPut, "for an integer to XML OpenMath", true,
[IsOpenMathXMLWriter, IsInt],0,
function(writer, x)
    if x >= OMINT_LIMIT then
  		OMWriteLine( writer![1], ["<OMI>", String(x), "</OMI>"] );
	else
  		OMWriteLine( writer![1], ["<OMI>", x, "</OMI>"] );
	fi;
end);


#######################################################################
##
#M  OMPut( <OMWriter>, <string> )  
##
##  specified in the standard
## 
InstallMethod(OMPut, "for a string to XML OpenMath", true,
[IsOpenMathXMLWriter, IsString],0,
function(writer, x)
	if IsEmpty(x) and not IsEmptyString(x) then
		TryNextMethod();
	fi;

  # convert XML escaped chars
  x := ReplacedString( x, "&", "&amp;" );
  x := ReplacedString( x, "<", "&lt;" );

	OMWriteLine(writer![1], ["<OMSTR>",x,"</OMSTR>"]);
end);


#######################################################################
##
#M  OMPut( <stream>, <float> )
##
##  Printing for floats: specified in the standard
##
if IsBound( IsFloat )  then
InstallMethod(OMPut, "for a float", true,
[IsOpenMathXMLWriter, IsFloat],0,
function(writer, x)
    local  string;
    # treatment of x=0 separately was added when discovered
    # that Float("-0") returns -0, but it is also faster.
    if IsZero(x) then
    	OMWriteLine( writer![1], [ "<OMF dec=\"0\"/>" ] );
    else
    	string := String( x );
    	# the OpenMath standard requires floats encoded in this way, see
    	# section 3.1.2
    	string := ReplacedString( string, "e+", "e" );
    	string := ReplacedString( string, "inf", "INF" );
    	string := ReplacedString( string, "nan", "NaN" );
    	OMWriteLine( writer![1], [ "<OMF dec=\"", string, "\"/>" ] );
	fi;
end);
fi;


#######################################################################
##
#M  OMPut( <stream>, <float> )
##
##  Printing for floats: specified in the standard
##
if IsBound( IS_MACFLOAT )  then
InstallMethod(OMPut, "for a float", true,
[IsOpenMathXMLWriter, IS_MACFLOAT],0,
function(writer, x)
    local  string;
    # treatment of x=0 separately was added when discovered
    # that Float("-0") returns -0, but it is also faster.
    if IsZero(x) then
    	OMWriteLine( writer![1], [ "<OMF dec=\"0\"/>" ] );
    else
    	string := String( x );
    	# the OpenMath standard requires floats encoded in this way, see
    	# section 3.1.2
    	string := ReplacedString( string, "e+", "e" );
    	string := ReplacedString( string, "inf", "INF" );
    	string := ReplacedString( string, "nan", "NaN" );
    	OMWriteLine( writer![1], [ "<OMF dec=\"", string, "\"/>" ] );
	fi;
end);
fi;


#############################################################################
#
# Functions and methods for OMPlainString
#
InstallGlobalFunction( OMPlainString,
function( string )
if IsString( string ) then
    # note that we do not validate the string!
    return Objectify( OMPlainStringDefaultType, [ string ] );
else
    Error( "The argument of OMPlainString must be a string" );
fi;                    
end);


#############################################################################
##
#M  PrintObj( <IsOMPlainString> )
##
InstallMethod( PrintObj, "for IsOMPlainString",
[ IsOMPlainStringRep and IsOMPlainString ],
function( obj )
    Print( obj![1] );
end);


#############################################################################
##
#M  OMPut( <IsOMPlainString> )
##
InstallMethod( OMPut, "for IsOMPlainString",
true,
[ IsOpenMathXMLWriter, IsOMPlainString ],
0,
function( writer, s )
    OMWriteLine( writer![1], [ s ] );
end); 


#############################################################################
#E
