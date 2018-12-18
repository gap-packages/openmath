LoadPackage("openmath");


########################################################
## Bruhat order on permutations
########################################################

# return {(i,j) | i < j and p(i) > p(j)}
inv := function(p)
	local n, i, j, res;

	res := [];
	n := Length(ListPerm(p));

	for j in [1 .. n] do
		for i in [1 .. j-1] do
			if i^p > j^p then
				Append(res, [[i,j]]);
			fi;
		od;
	od;
	return res;
end;

le := function(p,t)
	return IsSubset(inv(t), inv(p));
end;

s := SymmetricGroup(4);
l := AsList(s);
h := CreateHasseDiagram(l,le);
DrawHasse(h);



########################################################
## Divisor lattice of a natural number
########################################################

leq := function(x,y) return y mod x = 0; end;
N := 102;
h := CreateHasseDiagram(Filtered([1..N],i->N mod i = 0), leq);
DrawHasse(h);

#try these numbers N := 102, 2618, 282387;
# the number lattice is basically boring, just a concatenation of cubes...



#########################################################################
## Some semigroups examples #############################################
#########################################################################
s1 := Transformation([1,1,3,4]);
s2 := Transformation([1,2,2,4]);
s3 := Transformation([1,2,3,3]);
t1 := Transformation([2,2,3,4]);
t2 := Transformation([1,3,3,4]);
t3 := Transformation([1,2,4,4]);
o4 := Semigroup([s1,s2,s3,t1,t2,t3]);
rcl := GreensRClasses( o4 );                                
h := CreateHasseDiagram(rcl, IsGreensLessThanOrEqual);
DrawHasse(h);



lcl := GreensRClasses( o4 );                                
h := CreateHasseDiagram(lcl, IsGreensLessThanOrEqual);
DrawHasse(h);

###################################################################
## Some basic Hasse Diagrams - for when everything else is broken
###################################################################
d := Domain(["0","a","b","c","1"]);
Elements(d);
Size(d);

r := BinaryRelationByElements(d,
[ DirectProductElement(["0","a"]),
DirectProductElement(["0","b"]),
DirectProductElement(["0","c"]),
DirectProductElement(["a","1"]),
DirectProductElement(["b","1"]),
DirectProductElement(["c","1"])]);

SetIsHasseDiagram(r, true);
DrawHasse(r);



########################################################
## Partitions of a Natural Number
##
## problematic? - writing matrices?
########################################################

# this identifies the holes where the spacers go
sumrep := function(p)
	return List([1 .. Length(p)], i->Sum([1 .. i], j->p[j]));
end;

# a refines b iff sumrep(b) is a subset of sumrep(a)
refines := function(a,b)
	return IsSubset(sumrep(a), sumrep(b));
end;

p := Partitions(5);
h := CreateHasseDiagram(p, refines);
DrawHasse(h);


