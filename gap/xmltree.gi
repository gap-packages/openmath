#############################################################################
##
#W  xmltree.gi          OpenMath Package              Andrew Solomon
#W                                                    Marco Costantini
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  The main function in this file converts an XML document that is encoded
##  as a GAP record (as output by ParseTreeXMLString) into a GAP Object.
##

## TODO: Move this function to xmltree.g?
## One must not reset OMTempVars in this function, because it is called
## from code in xmltree.g while parsing objects.
InstallGlobalFunction( OMParseXmlObj, function ( node )
    local obj;

    if not IsBound( OMObjects.(node.name) )  then
        Error( "unknown OpenMath object ", node.name );
    fi;

    if IsBound( node.content ) and IsList( node.content ) and
       not (node.name = "OMSTR" or node.name = "OMI" or node.name = "OMB")  then
        node.content := Filtered( node.content, OMIsNotDummyLeaf );
    fi;
    obj := OMObjects.(node.name)( node );

    if IsBound( node.attributes.id )  then
        OMTempVars.OMREF.( node.attributes.id ) := obj;
    fi;

    return obj;
end );

#############################################################################
#E
