#############################################################################
##
#W    init.g               OpenMath Package            Andrew Solomon
#W                                                     Marco Costantini
##
#H    @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##    init.g file
##

Revision.("openmath/init.g") :=
    "@(#)$Id$";


# For backward compatibility

if not IsBound( Float )  then
    Float := ReturnFail;
fi;

if not CompareVersionNumbers( VERSION, "4.4" )  then

    # announce the package version and test for the existence of the binary
    DeclarePackage( "openmath", "06.03.02", ReturnTrue );

    # install the documentation
    DeclarePackageDocumentation( "openmath", "doc" );

    ReadPackage := ReadPkg;
    LoadPackage := RequirePackage;

    LoadPackage( "gapdoc" );


  InstallMethod( String,
    "record", true,
    [ IsRecord ], 0,
    function( record )
    local   str,  nam,  com;

    str := "rec( ";
    com := false;
    for nam in RecNames( record ) do
      if com then
        Append( str, ", " );
      else
        com := true;
      fi;
      Append( str, nam );
      Append( str, " := " );
      if IsStringRep( record.( nam ) )
         or ( IsString( record.( nam ) )
              and not IsEmpty( record.( nam ) ) ) then
        Append( str, "\"" );
        Append( str, String( record.(nam) ) );
        Append( str, "\"" );
      else
        Append( str, String( record.(nam) ) );
      fi;
    od;
    Append( str, " )" );
    ConvertToStringRep( str );
    return str;
  end );


 if not CompareVersionNumbers( VERSION, "4.3" )  then

  MakeReadWriteGlobal("ListWithIdenticalEntries");
  ListWithIdenticalEntries := function ( n, obj )
    local  list, i, c;
    if n > 0 and IS_FFE( obj ) and IsZero( obj )  then
        c := Characteristic( obj );
        if c = 2  then
            return ZERO_GF2VEC_2( n );
        elif c <= 256  then
            return ZERO_VEC8BIT_2( c, n );
        fi;
    fi;
    if IsChar( obj )  then
        list := "";
        for i  in [ 1 .. n ]  do
            list[i] := obj;
        od;
    else
        list := [  ];
        for i  in [ n, n - 1 .. 1 ]  do
            list[i] := obj;
        od;
    fi;
    return list;
  end;
  MakeReadOnlyGlobal("ListWithIdenticalEntries");

 fi;

fi;





ReadPackage("openmath", "/gap/parse.gd");
ReadPackage("openmath", "/gap/xmltree.gd");
ReadPackage("openmath", "/gap/omget.gd");
ReadPackage("openmath", "/gap/omput.gd");
ReadPackage("openmath", "/gap/test.gd");


#############################################################################
#E
