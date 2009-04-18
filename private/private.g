#############################################################################
##
#W    new.g               OpenMath Package             Marco Costantini
##
#H    @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##    This file contains update to the record OMsymRecord, according to the
##    current OpenMath CDs (for converting from OpenMath to GAP),
##

Revision.("openmath/gap/new.g") :=
    "@(#)$Id$";

######################################################################
##
##  Semantic mappings for symbols from private CD algnums.ocd
## 
BindGlobal("OMgapNthRootOfUnity", 
	x -> OMgapId( [ OMgap2ARGS(x), E(x[1])^x[2] ] )[2] );
	
######################################################################
##
##  Semantic mappings for symbols from private CD cas.ocd
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
##  Semantic mappings for private symbols from group1.cd
## 
## Our versions of group1.group and permgp1.group take list
## of generators unlike defined in official CDs.

BindGlobal("OMgapCharacterTableOfGroup",
	x->OMgapId([OMgap1ARGS(x), CharacterTable(x[1])])[2]);
	

#######################################################################
## 
## Conversion from OpenMath to GAP for private CDs and symbols
##

OMsymRecord_private := rec(

algnums := rec( # see this CD in openmath/cds directory
	NthRootOfUnity := OMgapNthRootOfUnity,
	star := fail
),
	
cas := rec( # see this CD in openmath/cds directory
	assign := OMgapAssign,
	native_error := OMgapNativeError,
	native_output := OMgapNativeOutput,
	native_statement := OMgapNativeStatement,
	referent := fail,
	retrieve := OMgapRetrieve,
	("quit") := OMgapQuit,
),

group1 := rec(           # experimental symbols, see openmath/cds/group1
	group := Group,      # we take just list of generators unlike 
	                     # in the official group1 CDs
	character_table_of_group := OMgapCharacterTableOfGroup,  
	character_table := OMgapCharacterTableOfGroup
),

);

#############################################################################
#E

