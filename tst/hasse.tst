gap> START_TEST("omput.tst");

########################################################
## May also call `DrawHasse(diagram)` to produce html
########################################################
## Bruhat order on permutations
########################################################
# return {(i,j) | i < j and p(i) > p(j)}
gap> inv := function(p)
>       local n, i, j, res;
> 
>       res := [];
>       n := Length(ListPerm(p));
> 
>       for j in [1 .. n] do
>               for i in [1 .. j-1] do
>                       if i^p > j^p then
>                               Append(res, [[i,j]]);
>                       fi;
>               od;
>       od;
>       return res;
> end;
function( p ) ... end
gap> 
gap> le := function(p,t)
>       return IsSubset(inv(t), inv(p));
> end;
function( p, t ) ... end
gap> 
gap> s := SymmetricGroup(4);
Sym( [ 1 .. 4 ] )
gap> l := AsSet(s);
[ (), (3,4), (2,3), (2,3,4), (2,4,3), (2,4), (1,2), (1,2)(3,4), (1,2,3), 
  (1,2,3,4), (1,2,4,3), (1,2,4), (1,3,2), (1,3,4,2), (1,3), (1,3,4), 
  (1,3)(2,4), (1,3,2,4), (1,4,3,2), (1,4,2), (1,4,3), (1,4), (1,4,2,3), 
  (1,4)(2,3) ]
gap> h := CreateHasseDiagram(l,le);;
gap> OMPrint(h);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMBIND>
			<OMS cd="fns2" name="constant"/>
			<OMBVAR>
					<OMV name="()"/>
					<OMV name="(3,4)"/>
					<OMV name="(2,3)"/>
					<OMV name="(2,3,4)"/>
					<OMV name="(2,4,3)"/>
					<OMV name="(2,4)"/>
					<OMV name="(1,2)"/>
					<OMV name="(1,2)(3,4)"/>
					<OMV name="(1,2,3)"/>
					<OMV name="(1,2,3,4)"/>
					<OMV name="(1,2,4,3)"/>
					<OMV name="(1,2,4)"/>
					<OMV name="(1,3,2)"/>
					<OMV name="(1,3,4,2)"/>
					<OMV name="(1,3)"/>
					<OMV name="(1,3,4)"/>
					<OMV name="(1,3)(2,4)"/>
					<OMV name="(1,3,2,4)"/>
					<OMV name="(1,4,3,2)"/>
					<OMV name="(1,4,2)"/>
					<OMV name="(1,4,3)"/>
					<OMV name="(1,4)"/>
					<OMV name="(1,4,2,3)"/>
					<OMV name="(1,4)(2,3)"/>
			</OMBVAR>
			<OMA>
				<OMS cd="relation2" name="hasse_diagram"/>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="()"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(3,4)"/>
						<OMV name="(2,3)"/>
						<OMV name="(1,2)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(3,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(2,3,4)"/>
						<OMV name="(1,2)(3,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(2,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(2,4,3)"/>
						<OMV name="(1,2,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(2,3,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(2,4)"/>
						<OMV name="(1,2,3,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(2,4,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(2,4)"/>
						<OMV name="(1,2,4,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(2,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,2,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,2)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,2)(3,4)"/>
						<OMV name="(1,3,2)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,2)(3,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,3,4,2)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,2,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,2,4,3)"/>
						<OMV name="(1,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,2,3,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,2,4)"/>
						<OMV name="(1,3,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,2,4,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,3)(2,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,2,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,3,2,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,3,2)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,3)"/>
						<OMV name="(1,4,3,2)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,3,4,2)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,3,4)"/>
						<OMV name="(1,4,2)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,3,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,3)(2,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,3,2,4)"/>
						<OMV name="(1,4,2,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,3,2,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4)(2,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,4,3,2)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4,2)"/>
						<OMV name="(1,4,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,4,2)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,4,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4,2,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,4)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4)(2,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,4,2,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="(1,4)(2,3)"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="(1,4)(2,3)"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
			</OMA>
	</OMBIND>
</OMOBJ>
gap> 

########################################################
## Divisor lattice of a natural number
########################################################
# try these numbers N := 102, 2618, 282387;
# the number lattice is basically boring, just a concatenation of cubes...
gap> leq := function(x,y) return y mod x = 0; end;
function( x, y ) ... end
gap> N := 102;
102
gap> h := CreateHasseDiagram(Filtered([1..N],i->N mod i = 0), leq);;
gap> OMPrint(h);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMBIND>
			<OMS cd="fns2" name="constant"/>
			<OMBVAR>
					<OMV name="1"/>
					<OMV name="2"/>
					<OMV name="3"/>
					<OMV name="6"/>
					<OMV name="17"/>
					<OMV name="34"/>
					<OMV name="51"/>
					<OMV name="102"/>
			</OMBVAR>
			<OMA>
				<OMS cd="relation2" name="hasse_diagram"/>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="1"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="2"/>
						<OMV name="3"/>
						<OMV name="17"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="2"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="6"/>
						<OMV name="34"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="3"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="6"/>
						<OMV name="51"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="6"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="102"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="17"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="34"/>
						<OMV name="51"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="34"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="102"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="51"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="102"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="102"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
			</OMA>
	</OMBIND>
</OMOBJ>
gap> 

#########################################################################
## Some semigroups examples #############################################
#########################################################################
gap> s1 := Transformation([1,1,3,4]);
Transformation( [ 1, 1 ] )
gap> s2 := Transformation([1,2,2,4]);
Transformation( [ 1, 2, 2 ] )
gap> s3 := Transformation([1,2,3,3]);
Transformation( [ 1, 2, 3, 3 ] )
gap> t1 := Transformation([2,2,3,4]);
Transformation( [ 2, 2 ] )
gap> t2 := Transformation([1,3,3,4]);
Transformation( [ 1, 3, 3 ] )
gap> t3 := Transformation([1,2,4,4]);
Transformation( [ 1, 2, 4, 4 ] )
gap> o4 := Semigroup([s1,s2,s3,t1,t2,t3]);
<transformation semigroup of degree 4 with 6 generators>
gap> rcl := GreensRClasses( o4 );                                
[ <Green's R-class: Transformation( [ 1, 1, 1, 1 ] )>, 
  <Green's R-class: Transformation( [ 1, 1, 1, 2 ] )>, 
  <Green's R-class: Transformation( [ 1, 1, 2, 2 ] )>, 
  <Green's R-class: Transformation( [ 1, 1, 2, 3 ] )>, 
  <Green's R-class: Transformation( [ 1, 2, 2, 2 ] )>, 
  <Green's R-class: Transformation( [ 1, 2, 2, 3 ] )>, 
  <Green's R-class: Transformation( [ 1, 2, 3, 3 ] )> ]
gap> h := CreateHasseDiagram(rcl, IsGreensLessThanOrEqual);;
gap> OMPrint(h);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMBIND>
			<OMS cd="fns2" name="constant"/>
			<OMBVAR>
					<OMV name="<object>"/>
					<OMV name="<object>"/>
					<OMV name="<object>"/>
					<OMV name="<object>"/>
					<OMV name="<object>"/>
					<OMV name="<object>"/>
					<OMV name="<object>"/>
			</OMBVAR>
			<OMA>
				<OMS cd="relation2" name="hasse_diagram"/>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="<object>"/>
						<OMV name="<object>"/>
						<OMV name="<object>"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="<object>"/>
						<OMV name="<object>"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="<object>"/>
						<OMV name="<object>"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="<object>"/>
						<OMV name="<object>"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="<object>"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
			</OMA>
	</OMBIND>
</OMOBJ>
gap> 

###################################################################
## Some basic Hasse Diagrams - for when everything else is broken
###################################################################
gap> d := Domain(["0","a","b","c","1"]);;
gap> Elements(d);
[ "0", "1", "a", "b", "c" ]
gap> Size(d);
5
gap> r := BinaryRelationByElements(d,
> [ DirectProductElement(["0","a"]),
> DirectProductElement(["0","b"]),
> DirectProductElement(["0","c"]),
> DirectProductElement(["a","1"]),
> DirectProductElement(["b","1"]),
> DirectProductElement(["c","1"])]);;
gap> SetIsHasseDiagram(r, true);
gap> OMPrint(r);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMBIND>
			<OMS cd="fns2" name="constant"/>
			<OMBVAR>
					<OMV name="0"/>
					<OMV name="a"/>
					<OMV name="b"/>
					<OMV name="c"/>
					<OMV name="1"/>
			</OMBVAR>
			<OMA>
				<OMS cd="relation2" name="hasse_diagram"/>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="0"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="a"/>
						<OMV name="b"/>
						<OMV name="c"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="a"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="1"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="b"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="1"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="c"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="1"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="1"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
			</OMA>
	</OMBIND>
</OMOBJ>
gap> 

########################################################
## Partitions of a Natural Number
##
## problematic? - writing matrices?
########################################################

# this identifies the holes where the spacers go
gap> sumrep := function(p)
>       return List([1 .. Length(p)], i->Sum([1 .. i], j->p[j]));
> end;
function( p ) ... end

# a refines b iff sumrep(b) is a subset of sumrep(a)
gap> refines := function(a,b)
>       return IsSubset(sumrep(a), sumrep(b));
> end;
function( a, b ) ... end
gap> 
gap> p := Partitions(5);
[ [ 1, 1, 1, 1, 1 ], [ 2, 1, 1, 1 ], [ 2, 2, 1 ], [ 3, 1, 1 ], [ 3, 2 ], 
  [ 4, 1 ], [ 5 ] ]
gap> h := CreateHasseDiagram(p, refines);;
gap> OMPrint(h);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMBIND>
			<OMS cd="fns2" name="constant"/>
			<OMBVAR>
					<OMV name="[ 1, 1, 1, 1, 1 ]"/>
					<OMV name="[ 2, 1, 1, 1 ]"/>
					<OMV name="[ 2, 2, 1 ]"/>
					<OMV name="[ 3, 1, 1 ]"/>
					<OMV name="[ 3, 2 ]"/>
					<OMV name="[ 4, 1 ]"/>
					<OMV name="[ 5 ]"/>
			</OMBVAR>
			<OMA>
				<OMS cd="relation2" name="hasse_diagram"/>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 1, 1, 1, 1, 1 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="[ 2, 1, 1, 1 ]"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 2, 1, 1, 1 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="[ 2, 2, 1 ]"/>
						<OMV name="[ 3, 1, 1 ]"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 2, 2, 1 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="[ 4, 1 ]"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 3, 1, 1 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="[ 3, 2 ]"/>
						<OMV name="[ 4, 1 ]"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 3, 2 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="[ 5 ]"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 4, 1 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
						<OMV name="[ 5 ]"/>
					</OMA>
				</OMA>
				<OMA>
					<OMS cd="list1" name="list"/>
					<OMV name="[ 5 ]"/>
					<OMA>
						<OMS cd="list1" name="list"/>
					</OMA>
				</OMA>
			</OMA>
	</OMBIND>
</OMOBJ>

#
gap> STOP_TEST("omput.tst");