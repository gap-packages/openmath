#############################################################################
##
#W  gap.g               OpenMath Package               Andrew Solomon
#W                                                     Marco Costantini
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  This file contains the semantic mappings from parsed openmath
##  symbols to GAP objects.
##

Revision.("openmath/gap/gap.g") :=
    "@(#)$Id$";


######################################################################
##
#F  OMgapId( <obj> )
##
##  Forces GAP to evaluate its argument.
##
BindGlobal("OMgapId",  x->x);


######################################################################
##
#F  OMgap1ARGS( <obj> )
#F  OMgap2ARGS( <obj> )
##
##  OMgapnARGS Throws an error if the argument is not of length n.
##
BindGlobal("OMgap1ARGS",
function(x)
  if Length(x) <> 1 then
    Error("argument list of length 1 expected");
  fi;
	return true;
end);

BindGlobal("OMgap2ARGS", 
function(x)
  if Length(x) <> 2 then
    Error("argument list of length 2 expected");
  fi;
	return true;
end);


######################################################################
##
##  Semantic mappings for symbols from arith1.cd
## 
BindGlobal("OMgapPlus", Sum);
BindGlobal("OMgapTimes", Product);
BindGlobal("OMgapDivide", x-> OMgapId([OMgap2ARGS(x), x[1]/x[2]])[2]);
BindGlobal("OMgapPower", x-> OMgapId([OMgap2ARGS(x), x[1]^x[2]])[2]);


######################################################################
##
##  Semantic mappings for symbols from field3.cd
##
BindGlobal("OMgap_field_by_poly",
    # The 1st argument of field_by_poly is a univariate polynomial 
    # ring R over a field, and the second argument is an irreducible    # polynomial f in this polynomial ring R. So, when applied to R
    # and f, the value of field_by_poly is value the quotient ring R/(f).
	function( x )
	return AlgebraicExtension( x[1], x[2] );;
	end);	
	
	
######################################################################
##
##  Semantic mappings for symbols from field4.cd
##
BindGlobal("OMgap_field_by_poly_vector",
    # The symbol field_by_poly_vector has two arguments, the 1st 
    # should be a field_by_poly(R,f). The 2nd argument should be a     # list L of elements of F, the coefficient field of the univariate 
    # polynomial ring R = F[X]. The length of the list L should be equal 
    # to the degree d of f. When applied to R and L, it represents the 
    # element L[0] + L[1] x + L[2] x^2 + ... + L[d-1] ^(d-1) of R/(f),
    # where x stands for the image of x under the natural map R -> R/(f).
	function( x )
	return ObjByExtRep( FamilyObj( One( x[1] ) ), x[2] );
	end);
	
	
######################################################################
##
##  Semantic mappings for symbols from relation.cd
## 
BindGlobal("OMgapEq", x-> OMgapId([OMgap2ARGS(x), x[1]=x[2]])[2]);
BindGlobal("OMgapNeq", x-> not OMgapEq(x));
BindGlobal("OMgapLt", x-> OMgapId([OMgap2ARGS(x), x[1]<x[2]])[2]);
BindGlobal("OMgapLe",x-> OMgapId([OMgap2ARGS(x), x[1]<=x[2]])[2]);
BindGlobal("OMgapGt", x-> OMgapId([OMgap2ARGS(x), x[1]>x[2]])[2]);
BindGlobal("OMgapGe", x-> OMgapId([OMgap2ARGS(x), x[1]>=x[2]])[2]);

######################################################################
##
##  Semantic mappings for symbols from integer.cd
## 
BindGlobal("OMgapQuotient", 
	x-> OMgapId([OMgap2ARGS(x), EuclideanQuotient(x[1],x[2])])[2]);
BindGlobal("OMgapRem", 
	x-> OMgapId([OMgap2ARGS(x), EuclideanRemainder(x[1],x[2])])[2]);
BindGlobal("OMgapGcd", Gcd);

######################################################################
##
##  Semantic mappings for symbols from logic1.cd
## 
BindGlobal("OMgapNot", x-> OMgapId([OMgap1ARGS(x), not x[1]])[2]);
BindGlobal("OMgapOr", x-> OMgapId([OMgap2ARGS(x), x[1] or x[2]])[2]);
BindGlobal("OMgapXor", 
	x-> OMgapId([OMgap2ARGS(x), (x[1] or x[2]) and not (x[1] and x[2])])[2]);
BindGlobal("OMgapAnd", x-> OMgapId([OMgap2ARGS(x), x[1] and x[2]])[2]);

######################################################################
##
##  Semantic mappings for symbols from list1.cd
## 
BindGlobal("OMgapList", List);

######################################################################
##
##  Semantic mappings for symbols from set1.cd
## 
BindGlobal("OMgapSet", Set);
BindGlobal("OMgapIn", x-> OMgapId([OMgap2ARGS(x), x[1] in x[2]])[2]);
BindGlobal("OMgapUnion", x-> OMgapId([OMgap2ARGS(x), Union(x[1],x[2])])[2]);
BindGlobal("OMgapIntersect", 
	x-> OMgapId([OMgap2ARGS(x), Intersection(x[1], x[2])])[2]);
BindGlobal("OMgapSetDiff", 
	x-> OMgapId([OMgap2ARGS(x), Difference(x[1], x[2])])[2]);

######################################################################
##
##  Semantic mappings for symbols from linalg1.cd
## 
BindGlobal("OMgapMatrixRow", OMgapId);
BindGlobal("OMgapMatrix", OMgapId);

######################################################################
##
##  Semantic mappings for symbols from permut1.cd
## 
BindGlobal("OMgapPermutation", PermList);

######################################################################
##
##  Semantic mappings for symbols from group1.cd
## 
BindGlobal("OMgapCharacterTableOfGroup",
	x->OMgapId([OMgap1ARGS(x), CharacterTable(x[1])])[2]);
BindGlobal("OMgapConjugacyClass",
	x->OMgapId([OMgap2ARGS(x), ConjugacyClass(x[1], x[2])])[2]);
BindGlobal("OMgapDerivedSubgroup",
	x->OMgapId([OMgap1ARGS(x), DerivedSubgroup(x[1])])[2]);
BindGlobal("OMgapElementSet",
	x->OMgapId([OMgap1ARGS(x), Elements(x[1])])[2]);
BindGlobal("OMgapGroup", Group);
BindGlobal("OMgapIsAbelian", 
	x->OMgapId([OMgap1ARGS(x), IsAbelian(x[1])])[2]);
BindGlobal("OMgapIsNormal", 
	x->OMgapId([OMgap2ARGS(x), IsNormal(x[1], x[2])])[2]);
BindGlobal("OMgapIsSubgroup",
	x->OMgapId([OMgap2ARGS(x), IsSubgroup(x[1], x[2])])[2]);
BindGlobal("OMgapNormalClosure",
	x->OMgapId([OMgap2ARGS(x), NormalClosure(x[1], x[2])])[2]);
BindGlobal("OMgapQuotientGroup",  
	x->OMgapId([OMgap2ARGS(x), x[1]/ x[2]])[2]);
BindGlobal("OMgapSylowSubgroup", 
	x->OMgapId([OMgap2ARGS(x), SylowSubgroup(x[1], x[2])])[2]);

######################################################################
##
##  Semantic mappings for symbols from permgrp.cd
## 
BindGlobal("OMgapIsPrimitive",
	x->OMgapId([OMgap1ARGS(x), IsPrimitive(x[1])])[2]);
BindGlobal("OMgapOrbit", x->OMgapId([OMgap2ARGS(x), Orbit(x[1], x[2])])[2]);
BindGlobal("OMgapStabilizer", 
	x->OMgapId([OMgap2ARGS(x), Stabilizer(x[1], x[2])])[2]);
BindGlobal("OMgapIsTransitive", 
	x->OMgapId([OMgap1ARGS(x), IsTransitive(x[1])])[2]);


######################################################################
##
##  Semantic mappings for symbols from polyd1.cd
##
BindGlobal("OMgap_poly_ring_d_named",
    # poly_ring_d_named is the constructor of polynomial ring. 
    # The first argument is a ring (the ring of the coefficients), 
    # the remaining arguments are the names of the variables.
	function( x )
	local coeffring, indetnames, indets, name;
	coeffring := x[1];
	indetnames := x{[2..Length(x)]};
	# We call Indeterminate with the 'old' option to enforce 
	# the usage of existing indeterminates when applicable
	indets := List( indetnames, name -> Indeterminate( coeffring, name : old ) );
	return PolynomialRing( coeffring, indets );
	end);
	
	
BindGlobal("OMgap_poly_ring_d",
    # poly_ring_d is the constructor of polynomial ring.
    # The first argument is a ring (the ring of the coefficients), 
    # the second is the number of variables as an integer. 
	function( x )
	local coeffring, rank;
	coeffring := x[1];
	rank := x[2];
	return PolynomialRing( coeffring, rank );
	end);
		

BindGlobal("OMgap_SDMP",
    # SDMP is the constructor for multivariate polynomials without    # any indication of variables or domain for the coefficients.	# Its arguments are just *monomials*. No monomials should differ only by    # the coefficient (i.e it is not permitted to have both 2*x*y and x*y 
    # as monomials in a SDMP). 
	function( x )
	# we just pass the list of monomials (represented as lists containing
	# coefficients and powers and indeterminates) as the 2nd argument in 
	# the DMP symbol, which will construct the polynomial in the polynomial 
	# ring given as the 1st argument of the DMP symbol
	return x;
	end);
	
	
BindGlobal("OMgap_DMP",
    # DMP is the constructor of Distributed Multivariate Polynomials. 
    # The first argument is the polynomial ring containing the polynomial 
    # and the second is a "SDMP"
	function( x )
	local polyring, terms, fam, ext, t, term, i, poly;
	polyring := x[1];
	terms := x[2];
	fam:=RationalFunctionsFamily( FamilyObj( One( CoefficientsRing( polyring ))));
	ext := [];
	for t in terms do
	  term := [];
	  for i in [2..Length(t)] do
	    if t[i]<>0 then
	      Append( term, [i-1,t[i]] );
	    fi;
	  od;
	  Add( ext, term );
	  Add( ext, t[1] );
	od;
    poly := PolynomialByExtRep( fam, ext );	
	return poly;
	end);


######################################################################
##
##  Semantic mappings for symbols from polyu.cd
##
BindGlobal("OMgap_poly_u_rep",
	function( x )
	local indetname, rep, coeffs, r, i, indet, fam, nr;
	indetname := x[1];
	rep := x{[2..Length(x)]};
	coeffs:=[];
	for r in rep do
      coeffs[r[1]+1]:=r[2];
    od;  
    for i in [1..Length(coeffs)] do
      if not IsBound(coeffs[i]) then
        coeffs[i]:=0;
      fi;  
    od;
    indet := Indeterminate( Rationals, indetname : old );
	fam := FamilyObj( 1 );
    nr := IndeterminateNumberOfLaurentPolynomial( indet ); 
	return LaurentPolynomialByCoefficients( fam, coeffs, 0, nr );
	end );
	
BindGlobal("OMgap_term",
	x->x );
		

######################################################################
##
##  Semantic mappings for symbols from cas.cd
## 

## quit
BindGlobal("OMgapQuitFunc",
function()
	return fail;
end);

BindGlobal("OMgapQuit",
	x->OMgapQuitFunc());


## assign
BindGlobal("OMgapAssignFunc",
function(varname, obj)
	if IsBoundGlobal(varname) then
		UnbindGlobal(varname);
	fi;

	BindGlobal(varname, obj);
	MakeReadWriteGlobal(varname);
	return "";
end);

BindGlobal("OMgapAssign",
	x->OMgapId([OMgap2ARGS(x), OMgapAssignFunc(x[1],x[2])])[2]);

## retrieve
BindGlobal("OMgapRetrieveFunc",
function(varname)
	if ValueGlobal(varname) = fail then
		return false;
	else
		return ValueGlobal(varname);
	fi;
end);

BindGlobal("OMgapRetrieve",
	x->OMgapId([OMgap1ARGS(x), OMgapRetrieveFunc(x[1])])[2]);

## native_statement and error
OM_GAP_OUTPUT_STR := "";
OM_GAP_ERROR_STR := "";
BindGlobal("OMgapNativeStatementFunc",
function(statement)
	local i, result;

	OM_GAP_ERROR_STR := "";

	# if statement has READ, Read, WRITE or Write then it's invalid
	if (PositionSublist(statement, "READ") <> fail) or
		(PositionSublist(statement, "Read") <> fail) or
		(PositionSublist(statement, "WRITE") <> fail) or
		(PositionSublist(statement, "Write") <> fail) then

		OM_GAP_ERROR_STR := "Invalid Statement";
		return false;
	fi;

	i := InputTextString(statement);
	# want to catch standard out.
	result := READ_COMMAND(i,false);
	CloseStream(i);
	
	OM_GAP_OUTPUT_STR :=  ViewString(result);
	# this is the way of indicating an error condition...
	if (result = fail) then
		OM_GAP_ERROR_STR := "Unknown Error";
		return false;
	fi;

 	return true; 
end);

BindGlobal("OMgapNativeStatement",
	x->OMgapId([OMgap1ARGS(x), OMgapNativeStatementFunc(x[1])])[2]);

BindGlobal("OMgapNativeErrorFunc",
function()
	return OM_GAP_ERROR_STR; # near as possible to the empty object
end);

BindGlobal("OMgapNativeError",
	x->OMgapId(OMgapNativeErrorFunc()));

BindGlobal("OMgapNativeOutputFunc",
function()
	return OM_GAP_OUTPUT_STR; # near as possible to the empty object
end);

BindGlobal("OMgapNativeOutput",
	x->OMgapId(OMgapNativeOutputFunc()));
	

#####################################################################
##
##  The Symbol Table for supported symbols from official OpenMath CDs
##
##  Maps a pair ["cd", "name"] to the corresponding OMgap... function
##  defined above or immediately in the table
##
InstallValue( OMsymTable, [
["arith1", [
    [ "abs", x -> AbsoluteValue(x[1]) ],
    [ "divide", OMgapDivide],
    [ "gcd", Gcd ],
 	[ "lcm", Lcm ],
 	[ "minus", x -> x[1]-x[2] ],   
  	[ "plus", OMgapPlus],
  	[ "power", OMgapPower],
    [ "product", x -> Product( List( x[1], i -> x[2](i) ) ) ],  
    [ "root", 
        function(x) 
        if x[2]=2 then 
          return Sqrt(x[1]);
        elif x[1]=1 then 
          return E(x[2]);
        else
          Error("OpenMath package: the symbol arith1.root \n", 
                "is supported only for square roots and roots of unity!\n");  
        fi;  
        end ],
    [ "sum", x -> Sum( List( x[1], i -> x[2](i) ) ) ], 	
	[ "times", OMgapTimes],
	[ "unary_minus", x -> -x[1] ]]],
	
["arith2", [
	[ "inverse", x -> Inverse(x[1]) ],
	[ "times", OMgapTimes ]]],   	
	
["arith3", [
	[ "extended_gcd",
		function(x)
		local r;
		if Length(x)=2 then
			r := Gcdex( x[1], x[2] );
			return [ r.gcd, r.coeff1, r.coeff2 ];
		else
          Error("OpenMath package: the symbol arith3.extended_gcd \n", 
                "for more than two arguments is not implemented yet!\n");  
		fi;
		end ]]],   	

[ "calculus1", [
	[ "defint", ],
    [ "diff", x -> Derivative(x[1]) ], 
	[ "int", ],
    [ "nthdiff", 
    	function(x)
        local n, f, i;
        n := x[1];
        f := x[2];
        for i in [ 1 .. n ] do
          f := Derivative( f );
          if IsZero(f) then
            return f;
          fi;
        od;
        return f;
        end ],
    [ "partialdiff", ]]],
      
["combinat1", [
	[ "Bell", x ->Bell(x[1]) ],
	[ "binomial", x -> Binomial(x[1],x[2]) ],
	[ "Fibonacci", x -> Fibonacci(x[1]) ],
	[ "multinomial", x -> Factorial(x[1]) / Product( List( x{[ 2 .. Length(x) ]}, Factorial ) ) ],
	[ "Stirling1", x -> Stirling1(x[1],x[2]) ],
	[ "Stirling2", x -> Stirling2(x[1],x[2]) ]]],        

[ "field3", [
    ["field_by_poly", OMgap_field_by_poly]]],
    
[ "field4", [
     ["field_by_poly_vector", OMgap_field_by_poly_vector]]],
     
[ "integer1", [
    [ "factorial", x -> Factorial( x[1] ) ],
    [ "factorof",  x -> IsInt( x[2]/ x[1] ) ],
    [ "quotient", x -> QuoInt( x[1], x[2] ) ], # is OMgapQuotient now obsolete?
    [ "remainder", x -> RemInt( x[1], x[2] ) ]]], # is OMgapRem now obsolete?
	  
["integer2", [
	[ "class", x -> ZmodnZObj(x[1],x[2]) ],
	[ "divides", x -> IsInt( x[2]/ x[1] ) ],
	[ "eqmod", x -> IsInt( (x[1]-x[2])/x[3] ) ],
	[ "euler", x -> Phi(x[1]) ],
	[ "modulo_relation", x -> function(a,b) return IsInt( (a-b)/x[1] ); end ],
	[ "neqmod", x -> not IsInt( (x[1]-x[2])/x[3] ) ],
	[ "ord", 
		function(x)
		local i;
		if not IsInt(x[2]/x[1]) then
			return 0;
		else
			return Number( FactorsInt(x[2]), i -> i=x[1]);
		fi;	 
		end ]]],

["interval1", 
	[[ "integer_interval", x -> [ x[1] .. x[2] ] ]]],

["logic1",
	[ ["not", OMgapNot],
	["or", OMgapOr],     # should be made n-ary (see logic1 cd)
	["xor", OMgapXor],   # should be made n-ary (see logic1 cd)
	["and", OMgapAnd]]], # should be made n-ary (see logic1 cd)
	
["list1", [
	[ "list", OMgapList ],
	[ "map", x -> List( x[2], x[1] ) ],
	[ "suchthat",  x -> Filtered( x[1], x[2] ) ]]],
	
["set1",
	[["set", OMgapSet],
	["in", OMgapIn],
	["union", OMgapUnion],         # should be made n-ary (see set1 cd)
	["intersect", OMgapIntersect], # should be made n-ary (see set1 cd)
	["setdiff", OMgapSetDiff]]],
["permut1",
	[["permutation", OMgapPermutation]]], # no capital letter
["group1", # experimental version, mix from various CDs, names differ from CDs
	[["CharacterTableOfGroup", OMgapCharacterTableOfGroup], # cd?
	["CharacterTable", OMgapCharacterTableOfGroup],         # cd?
	["ConjugacyClass", OMgapConjugacyClass],                # cf.group4
	["DerivedSubgroup", OMgapDerivedSubgroup],              # cf.group3
	["ElementSet", OMgapElementSet],                        # cd?
	["Group", OMgapGroup],                                  # group1
	["IsAbelian", OMgapIsAbelian],                          # group1 (is_commutative)
	["IsNormal", OMgapIsNormal],                            # group1 (is_normal)
	["IsSubgroup", OMgapIsSubgroup],                        # group1 (is_subgroup)
	["NormalClosure", OMgapNormalClosure],                  # group1 (normal_closure)
	["QuotientGroup", OMgapQuotientGroup],                  # group3 (quotient_group)
	["RightTransversal", OMgapQuotientGroup],               # group4 (right_transversal)
	["SylowSubgroup", OMgapSylowSubgroup]]],                # group3 (sylow_subgroup)

[ "polyd1", [
     ["DMP", OMgap_DMP],
     ["poly_ring_d", OMgap_poly_ring_d],
     ["poly_ring_d_named", OMgap_poly_ring_d_named],
     ["SDMP", OMgap_SDMP],
	 ["term", OMgap_term]]],

[ "polyu", [
     ["poly_u_rep", OMgap_poly_u_rep], 
	 ["term", OMgap_term]]],
	 
["relation1", [
	[ "eq", OMgapEq],
	[ "neq", OMgapNeq],
	[ "lt", OMgapLt],
	[ "leq", OMgapLe],
	[ "gt", OMgapGt],
	[ "geq", OMgapGe]]],	 
     	
["cas", # see this CD in openmath/cds directory
	[["quit", OMgapQuit],
	["assign", OMgapAssign],
	["retrieve",OMgapRetrieve],
	["native_statement", OMgapNativeStatement],
	["native_error", OMgapNativeError],
	["native_output", OMgapNativeOutput]]]]);
	
	     
######################################################################
##
#F  OMsymLookup( [<cd>, <name>] )
##
##  Maps a pair [<cd>, <name>] to the corresponding OMgap... function
##  defined above by looking up the symbol table.
##
BindGlobal("OMsymLookup", 
function(symbol)
	local cd, sym;

	for cd in OMsymTable do
		if cd[1] = symbol[1] then	# the cd names are the same
			for sym in cd[2] do
				if sym[1] = symbol[2] then
					if IsBound( sym[2] ) then
						return sym[2]; # return the function
					else
						# a symbol is present in the CD but not implemented
						# The number, format and sequence of arguments for the three error messages
						# below is strongly fixed as it is needed in the SCSCP package to return
						# standard OpenMath errors to the client
						Error("OpenMathError: ", "unhandled_symbol", " cd=", symbol[1], " name=", symbol[2]);
					fi;	
				fi;
			od;
			# if we got here, a symbol is not present in the mentioned content dictionary.
			Error("OpenMathError: ", "unexpected_symbol", " cd=", symbol[1], " name=", symbol[2]);
		fi;
	od;
	# we didn't even find the cd
	Error("OpenMathError: ", "unsupported_CD", " cd=", symbol[1], " name=", symbol[2]);
end);


######################################################################
##
#F  OMnullarySymbolToGAP( [<cd>, <name>] )
##
##  Maps the OM symbol to the GAP value.
##
BindGlobal("OMnullarySymbolToGAP",
function(symbol)
	local cd, name;

	cd := symbol[1];
	name := symbol[2];
	if cd = "alg1" then
		if name = "zero" then return 0;
		elif name = "one" then return 1;
		fi;
	elif cd = "fns1" then    
		if name = "lambda" then return "LAMBDA";
		fi;
        elif cd = "logic1" then
                if name = "false" then return false;
                elif name = "true" then return true;
                fi;
	elif cd = "nums1" or cd = "nums" then 
		if name = "i" then return Sqrt(-1);
		elif name = "infinity" then return infinity;
		elif name = "NaN" then return Float( "NaN" );
		fi;
        elif cd = "set1" then
                if name = "emptyset" then return [];
                fi;
        elif cd = "setname1" then
                if name = "Z" then return Integers;
                elif name = "N" then return NonnegativeIntegers;
                elif name = "Q" then return Rationals;
                fi;
        elif cd = "fieldname1" then      
                if name = "Q" then return Rationals;   
                fi;
	fi;
	return OMsymLookup( [ cd, name ] );
end);


#############################################################################
#E
