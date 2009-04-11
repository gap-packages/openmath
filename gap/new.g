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
##    This file contains update to function OMsymTable, according to the
##    current OpenMath CDs (for converting from OpenMath to GAP),
##

Revision.("openmath/gap/new.g") :=
    "@(#)$Id$";
    
## The content of this file is not exhaustively tested!

######################################################################
##
##  Semantic mappings for symbols from algnums.cd
## 
BindGlobal("OMgapNthRootOfUnity", 
	x-> OMgapId([OMgap2ARGS(x), E(x[1])^x[2]])[2]);
	

#######################################################################
## 
## From OpenMath to Gap
##

OMsymTable_new := rec(

calculus1 := rec(
	partialdiff :=
      	# the code is correct, but the problem is to match variables 
      	# during OpenMath encoding/decoding - check handling of polyd1.DMP
      	function(x)
      	local ind, f, i;
      	ind := x[1];
      	f := x[2];
      	for i in ind do
        	Print( "Derivative of ", f, " by ", i, " = \c" );
        	f := Derivative( f, i );
        	Print( f, "\n" );
        	if IsZero(f) then
          		return f;
        	fi;
      	od;
      	return f;
      	end
),

complex1 := rec(
	complex_cartesian := x -> OMgapId([OMgap2ARGS(x), x[1]+E(4)*x[2]])[2],
    real := x -> OMgapId([OMgap1ARGS(x), x -> (x[1] + ComplexConjugate( x[1] )) / 2])[2], # check this!!!
    imaginary := x -> OMgapId([OMgap1ARGS(x), x -> (x[1] - ComplexConjugate( x[1] )) / 2]* -1/2 *E(4))[2], # check this!!!
    conjugate := x -> OMgapId([OMgap1ARGS(x), x -> ComplexConjugate( x[1] )])[2] # check this!!!
),

fns1 := rec(
	identity := x -> IdFunc(x[1]) # check this
),

linalg1 := rec(
	determinant := x -> DeterminantMat(x[1]),
    matrix_selector := x -> x[3][x[1]][x[2]],
    outerproduct := x -> TransposedMat([x[1]])*[x[2]],    
    scalarproduct := x -> x[1]*x[2],
    transpose := x -> TransposedMat(x[1]),
    vector_selector := x -> x[2][x[1]],
    vectorproduct := 
    	function( x )
		local z1, z2, z3;
		z1 := x[1][2]*x[2][3] - x[1][3]*x[2][2];
		z2 := x[1][3]*x[2][1] - x[1][1]*x[2][3];
		z3 := x[1][1]*x[2][2] - x[1][2]*x[2][1];
		return [ z1, z2, z3 ];
    	end 	
),

linalg2 := rec(
	matrixrow := OMgapMatrixRow,
    vector := OMgapMatrixRow,
    matrix := OMgapMatrix
),

minmax1 := rec(
	min := x -> Minimum(x[1]),
    max := x-> Maximum(x[1])
),

nums1 := rec( 
	rational := OMgapDivide
),

relation3 := rec( # TO BE TESTED 
    equivalence_closure := x -> TransitiveClosureBinaryRelation( 
                                  SymmetricClosureBinaryRelation(
                                    ReflexiveClosureBinaryRelation( x[1] ) ) ),
    transitive_closure := x ->TransitiveClosureBinaryRelation( x[1] ),
    reflexive_closure := x ->ReflexiveClosureBinaryRelation( x[1] ),
    symmetric_closure := x ->SymmetricClosureBinaryRelation( x[1] ),
    is_transitive := x ->IsTransitiveBinaryRelation( x[1] ),
    is_reflexive := x ->IsReflexiveBinaryRelation( x[1] ),
    is_symmetric := x ->IsSymmetricBinaryRelation( x[1] ),
    is_equivalence := x ->IsEquivalenceRelation( x[1] )
),

# experimental CDs and symbols

algnums := rec( # see this CD in openmath/cds directory
	NthRootOfUnity := OMgapNthRootOfUnity
),
	
cas := rec( # see this CD in openmath/cds directory
	("quit") := OMgapQuit,
	assign := OMgapAssign,
	retrieve := OMgapRetrieve,
	native_statement := OMgapNativeStatement,
	native_error := OMgapNativeError,
	native_output := OMgapNativeOutput
),

group1 := rec( # experimental symbols
	CharacterTableOfGroup := OMgapCharacterTableOfGroup,  
	CharacterTable := OMgapCharacterTableOfGroup
)

);


OM_append := function (  )
    local cd, name;
    MakeReadWriteGlobal( "OMsymTable" );
    for cd in RecNames( OMsymTable_new )  do
    	if IsBound( OMsymTable.(cd) ) then
    		for name in RecNames( OMsymTable_new.(cd) ) do
    	    	OMsymTable.(cd).(name) := OMsymTable_new.(cd).(name);
    	  	od;
    	else
    	  	OMsymTable.(cd) := OMsymTable_new.(cd);     
    	fi;
    od;	   
    MakeReadOnlyGlobal( "OMsymTable" );
end;

OM_append();

Unbind( OM_append );


#############################################################################
#E

