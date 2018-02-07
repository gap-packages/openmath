#############################################################################
##
#W  omget.g             OpenMath Package               Andrew Solomon
#W                                                     Marco Costantini
##
#Y  Copyright (C) 1999, 2000, 2001, 2006
#Y  School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y  Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  OMGetObject reads an OpenMath object from an input stream and returns
##  a GAP object. EvalOMString is an analog of EvalString for a string which
##  contains an OpenMath object.
##


#############################################################################
##
#F  OMGetObject( <stream> )
##
##  <stream> is an input stream with an OpenMath object on it.
##  Takes precisely one object off <stream> (using PipeOpenMathObject)
##  and puts it into a string.
##  From there the OpenMath object is turned into a GAP object
##  by an appropriate function.
##

#! @Description
#!   Get the XML tree representation of an object from the input
#!   stream.
#!   This will also return the attributes needed in the SCSCP
#!   package
#
# FIXME: can representations be mixed in the same stream?
#
InstallGlobalFunction(OMGetTree,
function(stream)
    local firstbyte, xml, success, result;

    if IsClosedStream(stream) then
        Error("<stream> is closed");
    elif IsEndOfStream(stream)  then
        Error("<stream> is in state end-of-stream");
    fi;

    # FIXME: This is parser state and should not be global
    # Reset temporary variables.
    OMTempVars.OMBIND := rec(  );
    OMTempVars.OMREF := rec(  );

    firstbyte := ReadByte(stream);
    if firstbyte = 24 then
        # Binary encoding
        # FIXME: How does this fail?
        # FIXME: Test/check that this actually returns what we expect
        result := GetNextObject( stream, firstbyte );
    else
        # XML encoding

        # Get one OpenMath object from 'stream' and put into 'xml',
        # using PipeOpenMathObject
        # FIXME: The XML Parser should support getting one object
        #        from a stream, since PipeObject is a bit of a hack
        xml := "";
        success := PipeOpenMathObject( stream, xml, firstbyte );
        if success <> true  then
            return fail;
        fi;
        # FIXME: The rather bizarre looking (and not error checked)
        #        .content[1] is due to the fact that GAPDoc's XML
        #        parser on which we are relying here wraps our XML
        #        in a <WHOLEDOCUMENT></WHOLEDOCUMENT> block
        result := ParseTreeXMLString(xml).content[1];
        # FIXME: Why?
        result.content := Filtered(result.content, OMIsNotDummyLeaf );
    fi;
    return result;
end);

InstallGlobalFunction(OMGetObject,
function( stream )
    local tree;

    tree := OMGetTree(stream);

    # FIXME: Check why OMgetObjectXMLTree resets OMBIND/OMREF,
    #        hence the two ways of parsing objects used
    #        in the previous version of this function were
    #        inconsistent?
    return OMParseXmlObj( tree.content[1] );
end);


#############################################################################
##
#F  EvalOMString( <omstr> )
##
##  This function is an analog of EvalString for a string which contains an 
##  OpenMath object.
##
InstallGlobalFunction( EvalOMString, function( omstr )
local s, obj;
    s := InputTextString( omstr );
    obj := OMGetObject( s );
    CloseStream( s );
    return obj;
end);


#############################################################################
#E
