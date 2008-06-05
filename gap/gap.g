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
##  Semantic mappings for symbols from algnums.cd
## 
BindGlobal("OMgapNthRootOfUnity", 
	x-> OMgapId([OMgap2ARGS(x), E(x[1])^x[2]])[2]);
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

######################################################################
##
##  The Symbol Table proper
##
##  Maps a pair ["cd", "name"] to the corresponding OMgap... function
##  defined above.
##

BindGlobal("OMsymTable", [
["arith1", # see more symbols in new.g
	[[ "plus", OMgapPlus],
	[ "times", OMgapTimes],
	[ "divide", OMgapDivide],
	[ "power", OMgapPower]]],
["nums",   # there is no nums cd now, see nums1 entry in new.g
	[[ "rational", OMgapDivide]]],
["algnums",# see this CD in openmath/cds directory
	[[ "NthRootOfUnity", OMgapNthRootOfUnity]]], # outdated?
["relation1",
	[[ "eq", OMgapEq],
	[ "neq", OMgapNeq],
	[ "lt", OMgapLt],
	[ "leq", OMgapLe],
	[ "gt", OMgapGt],
	[ "geq", OMgapGe]]],
["integer", # there is no integer cd now, there is integer1, see new.g
	[[ "quotient", OMgapQuotient],
	[ "rem", OMgapRem],    # changed name to "remainder" in integer1
	[ "gcd", OMgapGcd]]],  # now in arith1, see new.g
["logic1",
	[ ["not", OMgapNot],
	["or", OMgapOr],     # should be made n-ary (see logic1 cd)
	["xor", OMgapXor],   # should be made n-ary (see logic1 cd)
	["and", OMgapAnd]]], # should be made n-ary (see logic1 cd)
["list1",
	[["list", OMgapList]]],
["set1",
	[["set", OMgapSet],
	["in", OMgapIn],
	["union", OMgapUnion],         # should be made n-ary (see set1 cd)
	["intersect", OMgapIntersect], # should be made n-ary (see set1 cd)
	["setdiff", OMgapSetDiff]]],
["linalg1",
	[["matrixrow", OMgapMatrixRow], # now in linalg2, see new.g
	["matrix", OMgapMatrix]]],      # now in linalg2, see new.g
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
["permgroup", # now permgp1 CD, with different spelling, see new.g
	[["IsPrimitive", OMgapIsPrimitive],                     # permgp1 (is_primitive)
	["Orbit", OMgapOrbit],                                  # permgp1 (orbit)
	["Stabilizer", OMgapStabilizer],                        # permgp1 (stabilizer)
	["IsTransitive", OMgapIsTransitive]]],                  # permgp1 (is_transitive)
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
					return sym[2]; # return the function
				fi;
			od;
			# if we got here, we found the cd but not the symbol
			Error("unknown OpenMath symbol, cd=", symbol[1], " name=", symbol[2]);
		fi;
	od;
	# we didn't even find the cd
	Error("unknown OpenMath cd, cd=", symbol[1], " name=", symbol[2]);
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

	if cd = "fns" then     # now the name of CD is "fns1"
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
		elif name = "false" then return false; # there is no 'false' in nums1
		elif name = "true" then return true;   # there is no 'true'  in nums1
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
