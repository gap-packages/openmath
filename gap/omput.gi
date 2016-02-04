#######################################################################
##
#W  omput.gi                OpenMath Package           Andrew Solomon
#W                                                     Marco Costantini
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  Writes a GAP object to an output stream, as an OpenMath object
## 

Revision.("openmath/gap/omput.gi") := 
    "@(#)$Id$";



# The Gap function AppendTo (used by OMWriteLine) uses
# PrintFormattingStatus and, before Gap 4.4.7, PrintFormattingStatus was
# defined only for text streams.

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
## Basic OpenMath objects and main functionality



#######################################################################
##
#F  OMPutVar( <stream>, <name> )
##
##  Input : name as string
##  Output: <OMV name="<name>" />
##
InstallGlobalFunction(OMPutVar,
function(stream, name)
  OMWriteLine(stream, ["<OMV name=\"", name, "\"/>"]);
end);



#######################################################################
##
#F  OMPutSymbol( <stream>, <cd>, <name> )
##
##  Input : cd, name as strings
##  Output: <OMS cd="<cd>" name="<name>" />
##
InstallGlobalFunction(OMPutSymbol,
function(stream, cd, name)
    OMWriteLine(stream, ["<OMS cd=\"", cd, "\" name=\"", name, "\"/>"]);
end);



#######################################################################
##
#M  OMPutApplication( <stream>, <cd>, <name>, <list> )
##
##  Input : cd, name as strings, list as a list
##  Output:
##        <OMA>
##                <OMS cd=<cd> name=<name>/>
##                OMPut(<stream>, <list>[1])
##                OMPut(<stream>, <list>[2])
##                ...
##        </OMA>
##


InstallGlobalFunction(OMPutApplication,
function ( stream, cd, name, list )
    local  obj;
    OMWriteLine( stream, [ "<OMA>" ] );
    OMIndent := OMIndent + 1;
    OMPutSymbol( stream, cd, name );
    for obj  in list  do
        OMPut( stream, obj );
    od;
    OMIndent := OMIndent - 1;
    OMWriteLine( stream, [ "</OMA>" ] );
end);




#######################################################################
##
#F  OMPutObject( <stream>, <obj> ) 
##
##
InstallGlobalFunction(OMPutObject,
function(stream, x)

	if IsClosedStream( stream )  then
		Error( "closed stream" );
	fi;

	if IsOutputTextStream( stream )  then
		SetPrintFormattingStatus( stream, false );
	fi;

	OMIndent := 0;
	OMWriteLine(stream, ["<OMOBJ>"]);
	OMIndent:= OMIndent+1;
	OMPut(stream, x);
	OMIndent:=OMIndent-1;
	OMWriteLine(stream, ["</OMOBJ>"]);
end);



#######################################################################
##
#F  OMPrint( <obj> ) .......   Print <obj> as OpenMath object
##
##
InstallGlobalFunction(OMPrint,
function(x)
	local str, outstream;

	str := "";
	outstream := OutputTextString(str, true);
	OMPutObject(outstream, x);
	CloseStream(outstream);
	Print(str);
end);




#############################################################################
## Various methods for OMPut


#######################################################################
##
#M  OMPut( <stream>, <int> )  
##
##  Printing for integers: specified in the standard
## 
InstallMethod(OMPut, "for an integer", true,
[IsOutputStream, IsInt],0,
function(stream, x)
	OMWriteLine(stream, ["<OMI> ", x, "</OMI>"]);
end);


#######################################################################
##
#M  OMPut( <stream>, <string> )  
##
##  specified in the standard
## 
InstallMethod(OMPut, "for a string", true,
[IsOutputStream, IsString],0,
function(stream, x)
	if IsEmpty(x) and not IsEmptyString(x) then
		TryNextMethod();
	fi;

  # convert XML escaped chars
  x := ReplacedString( x, "&", "&amp;" );
  x := ReplacedString( x, "<", "&lt;" );

	OMWriteLine(stream, ["<OMSTR>",x,"</OMSTR>"]);
end);


#######################################################################
##
#M  OMPut( <stream>, <float> )
##
##  Printing for floats: specified in the standard
##
if IsBound( IsFloat )  then
InstallMethod(OMPut, "for a float", true,
[IsOutputStream, IsFloat],0,
function(stream, x)
    local  string;
    string := String( x );
    # the OpenMath standard requires floats encoded in this way, see
    # section 3.1.2
    string := ReplacedString( string, "e+", "e" );
    string := ReplacedString( string, "inf", "INF" );
    string := ReplacedString( string, "nan", "NaN" );
    OMWriteLine( stream, [ "<OMF dec=\"", string, "\"/>" ] );
end);
fi;


#######################################################################
##
#M  OMPut( <stream>, <bool> )  
##
##  Printing for booleans: specified in CD nums # now logic1
## 
InstallMethod(OMPut, "for a boolean", true,
[IsOutputStream, IsBool],0,
function(stream, x)
    if not x in [ true, false]  then
        TryNextMethod();
    fi;
    OMPutSymbol( stream, "logic1", x );
end);


#######################################################################
##
#M  OMPut( <stream>, <rat> )  
##
##  Printing for rationals
## 
InstallMethod(OMPut, "for a rational", true,
[IsOutputStream, IsRat],0,
function(stream, x)
	OMPutApplication( stream, "nums1", "rational",
		[ NumeratorRat(x), DenominatorRat(x)] );
end);


#######################################################################
##
#M  OMPut( <stream>, <cyc> )  
##
##  Printing for cyclotomics
## 
InstallMethod(OMPut, "for a proper cyclotomic", true,
[IsOutputStream, IsCyc],0,
function(stream, x)
	local
                real,
                imaginary,

		n, # Length(powlist)
		i,
		clist; # x = Sum_i clist[i]*E(n)^(i-1)

    if IsGaussRat( x )  then

        real := x -> (x + ComplexConjugate( x )) / 2;
        imaginary := x -> (x - ComplexConjugate( x )) * -1 / 2 * E( 4 );

        OMPutApplication( stream, "complex1", "complex_cartesian", 
            [ real(x), imaginary(x)] );

    else

	n := Conductor(x);
	clist := CoeffsCyc(x, n);

	OMWriteLine(stream, ["<OMA>"]);
	OMIndent := OMIndent+1;
	OMPutSymbol( stream, "arith1", "plus" );
	for i in [1 .. n] do
		if clist[i] <> 0 then

			OMWriteLine(stream, ["<OMA>"]); # times
			OMIndent := OMIndent+1;
			OMPutSymbol( stream, "arith1", "times" );
			OMPut(stream, clist[i]);

			OMPutApplication( stream, "algnums", "NthRootOfUnity", [ n, i-1 ] );

			OMIndent := OMIndent-1;
			OMWriteLine(stream, ["</OMA>"]); #times
		fi;
	od;
	OMIndent := OMIndent-1;
	OMWriteLine(stream, ["</OMA>"]);

    fi;
end);



#######################################################################
##
#M  OMPut( <stream>, <infinity> )
##
##  Printing for infinity: specified in nums1.ocd
##

InstallMethod(OMPut, "for infinity", true,
[IsOutputStream, IsInfinity],0,
function(stream, x)
        OMPutSymbol( stream, "nums1", x );
end);




#######################################################################
##
#M  OMPut( <stream>,  <vector> )  
##
##  Printing for vectors: specified in linalg2.ocd
##
InstallMethod(OMPut, "for a row vector", true,
[IsOutputStream, IsRowVector],0,
function(stream, x)

  OMPutApplication( stream, "linalg2", "vector", x );

end);



#######################################################################
##
#M  OMPut( <stream>, <matrix> )  
##
##  Printing for matrices: specified in linalg2.ocd
##
InstallMethod(OMPut, "for a matrix", true,
[IsOutputStream, IsMatrix],0,
function(stream, x)
    local  r;

    OMWriteLine( stream, [ "<OMA>" ] );
    OMIndent := OMIndent + 1;

    OMPutSymbol( stream, "linalg2", "matrix" );
    for r  in x  do

        OMPutApplication( stream, "linalg2", "matrixrow", r );

    od;

    OMIndent := OMIndent - 1;
    OMWriteLine( stream, [ "</OMA>" ] );

end);



#######################################################################
##
#M  OMPut( <stream>, NonnegativeIntegers )
##
##  Printing for the set N
##
InstallMethod(OMPut, "for NonnegativeIntegers", true,
[IsOutputStream, IsNonnegativeIntegers],0,
function(stream, x)
        OMPutSymbol( stream, "setname1", "N" );
end);



#######################################################################
##
#M  OMPut( <stream>, Integers )
##
##  Printing for the set Z
##
InstallMethod(OMPut, "for Integers", true,
[IsOutputStream, IsIntegers],0,
function(stream, x)
        OMPutSymbol( stream, "setname1", "Z" );
end);


#######################################################################
##
#M  OMPut( <stream>, Rationals )
##
##  Printing for the set Q
##
InstallMethod(OMPut, "for Rationals", true,
[IsOutputStream, IsRationals],0,
function(stream, x)
        OMPutSymbol( stream, "setname1", "Q" );
end);




#######################################################################
##
#M  OMPut( <stream>, <list> )  
##
##  Printing for finite lists or collection. Prints them as lists.
##
## 

InstallMethod(OMPut, "for a finite list or collection", true,
[IsOutputStream, IsListOrCollection and IsFinite], 0,
function(stream, x)

  OMPutApplication( stream, "list1", "list", x );

end);


#######################################################################
##
#M  OMPut( <stream>, <set> )  
##
##  Printing for finite set: specified in set1.ocd
##
InstallMethod(OMPut, "for a finite set", true,
[IsOutputStream, IsDuplicateFreeList and IsFinite],0,
function(stream, x)

  if IsString(x) and Length(x)>0 or IsEmptyString(x)  then 
  # this doesn't include the empty list
    TryNextMethod();
  fi;

  if IsEmpty(x) then
    OMPutSymbol( stream, "set1", "emptyset" );
  else
    OMPutApplication( stream, "set1", "set", x );
  fi;

end);




#######################################################################
##
#M  OMPut( <stream>, <range> )
##
##  Printing for ranges: specified in interval1.ocd
##

InstallMethod(OMPut, "for a range", true,
[IsOutputStream, IsRange and IsRangeRep],0,
function ( stream, x )

    if not x[2] - x[1] = 1  then
        TryNextMethod();
    fi;

    OMPutApplication( stream, "interval1", "integer_interval",
        [ x[1], x[Length( x )] ] );

end);



#######################################################################
##
#M  OMPut( <stream>, <perm> )  
##
##  Printing for permutations: specified in permut1.ocd 
## 
InstallMethod(OMPut, "for a permutation", true,
[IsOutputStream, IsPerm],0,
function(stream, x)

	OMPutApplication( stream, "permut1", "permutation", ListPerm(x) );
end);



#######################################################################
##
#M  OMPut( <stream>, <group> )  
##
##  Printing for groups: specified in group1.ocd 
## 
InstallMethod(OMPut, "for a group", true,
[IsOutputStream, IsGroup],0,
function(stream, x)

	OMPutApplication( stream, "group1", "Group", 
		GeneratorsOfGroup(x) );
end);



#InstallMethod(OMPut, "for a function", true,
#[IsOutputStream, IsFunction],0,
#function ( stream, x )
#    local i, ii;
#    for i  in OMsymTable  do
#        for ii  in i[2]  do
#            if x = ii[2]  then
#                OMPutSymbol( stream, i[1], ii[1] );
#                return;
#            fi;
#        od;
#    od;
#    TryNextMethod();
#end);



#############################################################################
## Method OMPut, "for a character table"


#######################################################################
##
#M  OMPutList( <stream>, <list> )  
##
##
InstallMethod(OMPutList, "for a list of any type", true,
[IsOutputStream, IsList],0,
function(stream, x)
  local i;

  OMWriteLine(stream, ["<OMA>"]);
  OMIndent := OMIndent +1;

	OMPutSymbol( stream, "list1", "list" );
	for i in x do
		if IsString(i) then
			OMPut(stream, i); # no such thing as characters in OpenMath
		else
			OMPutList(stream, i);
		fi;
	od;

	OMIndent := OMIndent -1;
	OMWriteLine(stream, ["</OMA>"]);
end);


#######################################################################
##
#M  OMPutList( <stream>, <list> )  
##
##
InstallMethod(OMPutList, "when we can find no way of regarding it as a list", 
true, [IsOutputStream, IsObject],0,
function(stream, x)
	OMPut(stream, x);
end);



#######################################################################
##
#F  OMIrredMatEntryPut( <stream>, <entry>, <data> )
##
##  <entry> is a (possibly unknown) cyclotomic
##  <data> is the record of information about names and values
##  used to substitute for complicated irreducible expressions.
##
##  This borrows heavily from Thomas Breuer's 
##  CharacterTableDisplayStringEntryDefault
##
BindGlobal("OMIrredMatEntryPut",
function(stream, entry, data)
	local val, irrstack, irrnames, name, ll, i, letters, n;

  # OMPut(stream,entry);
	if IsCyc( entry ) and not IsInt( entry ) then
      # find shorthand for cyclo
      irrstack:= data.irrstack;
      irrnames:= data.irrnames;
      for i in [ 1 .. Length( irrstack ) ] do
        if entry = irrstack[i] then
          OMPutVar(stream, irrnames[i]);
					return;
        elif entry = -irrstack[i] then
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "arith1", "unary_minus");
          OMPutVar(stream, irrnames[i]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					return;
        fi;
        val:= GaloisCyc( irrstack[i], -1 );
        if entry = val then
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "complex1", "conjugate");
          OMPutVar(stream, irrnames[i]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					return;
        elif entry = -val then
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "arith1", "unary_minus");
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "complex1", "conjugate");
          OMPutVar(stream, irrnames[i]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					return;
        fi;
        val:= StarCyc( irrstack[i] );
        if entry = val then
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "algnums", "star");
          OMPutVar(stream, irrnames[i]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					return;
        elif -entry = val then
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "arith1", "unary_minus");
					OMWriteLine(stream, ["<OMA>"]);
					OMIndent := OMIndent +1;
					OMPutSymbol(stream, "algnums", "star");
          OMPutVar(stream, irrnames[i]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					OMIndent := OMIndent -1;
					OMWriteLine(stream, ["</OMA>"]);
					return;
        fi;
        i:= i+1;
      od;
      Add( irrstack, entry );

      # Create a new name for the irrationality.
      name:= "";
      n:= Length( irrstack );
      letters:= data.letters;
      ll:= Length( letters );
      while 0 < n do
        name:= Concatenation( letters[(n-1) mod ll + 1], name );
        n:= QuoInt(n-1, ll);
      od;
      Add( irrnames, name );
      OMPutVar(stream, irrnames[ Length( irrnames ) ]);
			return;

		elif IsUnknown( entry ) then
			OMPutVar(stream, "?"); 
			return;
		else
			OMPut(stream, entry);
			return;
		fi;

end);

#######################################################################
##
#F  OMPutIrredMat( <stream>, <x> )
##
##  <x> is a character table
##
##  This borrows heavily from Thomas Breuer's 
##  character table Display routines -- see lib/ctbl.gi
##
BindGlobal("OMPutIrredMat",
function(stream, x)
	local r,i, irredmat, data;

	data := CharacterTableDisplayStringEntryDataDefault( x );
  # irreducibles matrix
  irredmat :=  List(Irr(x), ValuesOfClassFunction);

	# OMPut(stream,irredmat);

  OMWriteLine(stream, ["<OMA>"]);
  OMIndent := OMIndent +1;

  OMPutSymbol( stream, "linalg2", "matrix" );
  for r in irredmat do
    OMWriteLine(stream, ["<OMA>"]);
    OMIndent := OMIndent +1;

      OMPutSymbol( stream, "linalg2", "matrixrow" );

    for i in r do
      OMIrredMatEntryPut(stream, i, data);
    od;

    OMIndent := OMIndent -1;
    OMWriteLine(stream, ["</OMA>"]);


  od;

  OMIndent := OMIndent -1;
  OMWriteLine(stream, ["</OMA>"]);

	# Now output the list of (variable = value) pairs
	OMWriteLine(stream, ["<OMA>"]);
	OMIndent := OMIndent +1;
	OMPutSymbol(stream, "list1", "list");
	for i in [1 .. Length(data.irrstack)] do
		OMWriteLine(stream, ["<OMA>"]);
		OMIndent := OMIndent +1;
		OMPutSymbol(stream, "relation1", "eq");
		OMPutVar(stream, data.irrnames[i]);
		OMPut(stream, data.irrstack[i]);
		OMIndent := OMIndent -1;
		OMWriteLine(stream, ["</OMA>"]);
	od;
	OMIndent := OMIndent -1;
	OMWriteLine(stream, ["</OMA>"]);

end);



#######################################################################
##
#M  OMPut( <stream>, <character table> )  
##
##
InstallMethod(OMPut, "for a character table", true,
[IsOutputStream, IsCharacterTable],0,
function(stream, c)
	local
		centralizersizes,
		centralizerindices,
		centralizerprimes,
		ordersclassreps,
		sizesconjugacyclasses,
		classnames,
		powmap;



  # the centralizer primes
  centralizersizes := SizesCentralizers(c);
  centralizerprimes := AsSSortedList(Factors(Product(centralizersizes)));

  # the indices which define the factorisation of the
  # centralizer orders
  centralizerindices := List(centralizersizes, z->
    List(centralizerprimes, x->Size(Filtered(Factors(z), y->y=x))));

	# ordersclassreps - every element of a conjugacy class has
	# the same order.
  ordersclassreps := OrdersClassRepresentatives( c );

	# SizesConjugacyClasses
	sizesconjugacyclasses := SizesConjugacyClasses( c );

  # the classnames
  classnames := ClassNames(c);

  # the powermap
  powmap := List(centralizerprimes,
    x->List(PowerMap(c, x),z->ClassNames(c)[z]));

  # irreducibles matrix
  # irredmat :=  List(Irr(c), ValuesOfClassFunction);



  OMWriteLine(stream, ["<OMA>"]);
  OMIndent := OMIndent +1;
    OMPutSymbol( stream, "group1", "CharacterTable" );
		OMPutList(stream, classnames);
		OMPutList(stream, centralizersizes);
		OMPutList(stream, centralizerprimes);
		OMPutList(stream, centralizerindices); 
		OMPutList(stream, powmap);
		OMPutList(stream, sizesconjugacyclasses);
		OMPutList(stream, ordersclassreps);
		# OMPut(stream, irredmat); # previous cd version
		OMPutIrredMat(stream, c);
	OMIndent := OMIndent -1;
	OMWriteLine(stream, ["</OMA>"]);
end);




#############################################################################
#E
