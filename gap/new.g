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
## From OpenMath to Gap

# CDs already in OMsymTable:
#  [ "arith1", "cas", "group1", "integer", "linalg1", "list1", "logic1", "nums", 
#    "permgroup", "permut1", "relation1", "set1" ]


OMsymTable_new := [

# official CDs

[ "arith1", [
    # now these two symbols correspond to the definition from CD. 
    # the problem is that x[2] is a function, and this is not supported yet
    [ "product", x -> Product( List( x[1], i -> x[2](i) ) ) ],  
    [ "sum", x -> Sum( List( x[1], i -> x[2](i) ) ) ],
  ],
],

[ "calculus1", [
    [ "partialdiff", 
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
      end ]]],	

[ "complex1", [
    [ "complex_cartesian", x-> OMgapId([OMgap2ARGS(x), x[1]+E(4)*x[2]])[2]],
    [ "real", x-> OMgapId([OMgap1ARGS(x), x -> (x[1] + ComplexConjugate( x[1] )) / 2])[2]], # check this!!!
    [ "imaginary", x-> OMgapId([OMgap1ARGS(x), x -> (x[1] - ComplexConjugate( x[1] )) / 2]* -1/2 *E(4))[2]], # check this!!!
    [ "conjugate", x-> OMgapId([OMgap1ARGS(x), x -> ComplexConjugate( x[1] )])[2]], # check this!!!
  ]
],


[ "fns1", [
    [ "identity", x -> IdFunc(x[1]) ], # check this
  ]
],


[ "integer1", [
    [ "factorof",  x -> IsZero( EuclideanRemainder( x[2], x[1] ) ) ],
    [ "factorial", x -> Factorial( x[1] ) ],
    [ "remainder", x -> EuclideanRemainder( x[1], x[2] ) ],
    [ "quotient", x -> EuclideanQuotient( x[1], x[2] ) ],
  ]
],


[ "interval1", [
    [ "integer_interval", x -> [ x[1] .. x[2] ] ]
  ]
],


[ "linalg1", [
    [ "determinant", x -> DeterminantMat(x[1]) ],
    [ "matrix_selector", x -> x[3][x[1]][x[2]] ],
    [ "outerproduct", x -> TransposedMat([x[1]])*[x[2]] ],    
    [ "transpose", x -> TransposedMat(x[1]) ],
    [ "vector_selector", x -> x[2][x[1]] ],
    [ "vectorproduct", x -> x[1]*x[2] ] # this is scalar product, not vector !!!
    # scalar product also to be implemented, it is in the same CD
  ]
],


[ "linalg2", [
    [ "matrixrow", OMgapMatrixRow],
    [ "vector", OMgapMatrixRow],
    [ "matrix", OMgapMatrix]
  ]
],


[ "logic1", [
    [ "equivalent", x -> x[1] and x[2] or not x[1] and not x[2] ],
    [ "implies", x -> not x[1] or x[2] ],
  ]
],


[ "minmax1", [
    [ "min", x -> Minimum(x[1]) ],
    [ "max", x-> Maximum(x[1]) ]
  ]
],


[ "nums1", [
    [ "rational", OMgapDivide ]
  ]
],


[ "relation3", [  # TO BE TESTED 
    [ "equivalence_closure", x -> TransitiveClosureBinaryRelation( SymmetricClosureBinaryRelation(
ReflexiveClosureBinaryRelation( x[1] ) ) ) ],
    [ "transitive_closure", x ->TransitiveClosureBinaryRelation( x[1] ) ],
    [ "reflexive_closure", x ->ReflexiveClosureBinaryRelation( x[1] ) ],
    [ "symmetric_closure", x ->SymmetricClosureBinaryRelation( x[1] ) ],
    [ "is_transitive", x ->IsTransitiveBinaryRelation( x[1] ) ],
    [ "is_reflexive", x ->IsReflexiveBinaryRelation( x[1] ) ],
    [ "is_symmetric", x ->IsSymmetricBinaryRelation( x[1] ) ],
    [ "is_equivalence", x ->IsEquivalenceRelation( x[1] ) ],
  ]
],


[ "set1", [
    [ "cartesian_product", Cartesian ],
    [ "map", x -> List( x[2], x[1] ) ],      # needs test!!! now also defined in list1
    [ "size", x -> Size( x[1] ) ],
    [ "suchthat", x->Filtered(x[1], x[2]) ], # needs test!!! now also defined in list1
    [ "subset", x -> IsSubset( x[2], x[1] ) ],
    [ "notin", x -> not x[1] in x[2] ],
    [ "prsubset", x -> IsSubset( x[2], x[1] ) and not IsEqualSet( x[2], x[1] ) ],
    [ "notsubset", x -> not IsSubset( x[2], x[1] ) ],
    [ "notprsubset", x -> not IsSubset( x[2], x[1] ) or IsEqualSet( x[2], x[1] ) ],
  ]
],


# experimental CDs

["algnums",# see this CD in openmath/cds directory
	[[ "NthRootOfUnity", OMgapNthRootOfUnity]]], 

[ "permgp1", [
    [ "group", OMgapGroup ], # n-ary function in permgp1 cd, test with >1 generators
    [ "is_primitive", OMgapIsPrimitive ],
    [ "orbit", OMgapOrbit ],
    [ "stabilizer", OMgapStabilizer ], # n-ary function in permgp1 cd
    [ "is_transitive", OMgapIsTransitive ]
  ]
],




];




OM_append := function (  )
    local  i, j, found;
    MakeReadWriteGlobal( "OMsymTable" );
    for i  in OMsymTable_new  do
        found := false;
        for j  in OMsymTable  do
            if j[1] = i[1]  then
                Append( j[2], i[2] );
                found := true;
                break;
            fi;
        od;
        if not found  then
            Add( OMsymTable, i );
        fi;
    od;
    MakeReadOnlyGlobal( "OMsymTable" );
end;

OM_append();

Unbind( OM_append );



#############################################################################
#E

