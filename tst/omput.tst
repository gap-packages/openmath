gap> START_TEST("omput.tst");

# RandomString
gap> ForAll([1..64],n->Length(RandomString(n))=n);
true

# OMPut method for a proper cyclotomic
gap> OMPrint(E(4));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="complex1" name="complex_cartesian"/>
		<OMI>0</OMI>
		<OMI>1</OMI>
	</OMA>
</OMOBJ>
gap> OMPrint(E(3));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="arith1" name="plus"/>
		<OMA>
			<OMS cd="arith1" name="times"/>
			<OMI>1</OMI>
			<OMA>
				<OMS cd="algnums" name="NthRootOfUnity"/>
				<OMI>3</OMI>
				<OMI>1</OMI>
			</OMA>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMTest(E(4));
true
gap> OMTest(E(3));
true

# OMPut method for a matrix
gap> OMPrint([[1,2],[3,4]]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="linalg2" name="matrix"/>
		<OMA>
			<OMS cd="linalg2" name="matrixrow"/>
			<OMI>1</OMI>
			<OMI>2</OMI>
		</OMA>
		<OMA>
			<OMS cd="linalg2" name="matrixrow"/>
			<OMI>3</OMI>
			<OMI>4</OMI>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMPrint([[1,2],[3,4]]:OMignoreMatrices);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMA>
			<OMS cd="list1" name="list"/>
			<OMI>1</OMI>
			<OMI>2</OMI>
		</OMA>
		<OMA>
			<OMS cd="list1" name="list"/>
			<OMI>3</OMI>
			<OMI>4</OMI>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMTest([[1,2],[3,4]]);
true

# OMPut method for a finite set
gap> OMPrint(Set([1,2,3]));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="set1" name="set"/>
		<OMI>1</OMI>
		<OMI>2</OMI>
		<OMI>3</OMI>
	</OMA>
</OMOBJ>
gap> OMPrint(Set([1,2,3]):OMignoreSets);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMI>1</OMI>
		<OMI>2</OMI>
		<OMI>3</OMI>
	</OMA>
</OMOBJ>
gap> OMTest(Set([1,2,3]));
true

# OMPut method for a range
gap> OMPrint([1..5]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="interval1" name="integer_interval"/>
		<OMI>1</OMI>
		<OMI>5</OMI>
	</OMA>
</OMOBJ>
gap> OMPrint([1,3..5]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="set1" name="set"/>
		<OMI>1</OMI>
		<OMI>3</OMI>
		<OMI>5</OMI>
	</OMA>
</OMOBJ>
gap> OMTest([1..5]);
true
gap> OMTest([1,3..5]);
true

# Testing polynomial ring (polyd1.poly_ring_d_named or polyd1.poly_ring_d)
# We do not display XML in the next test since it contains random
# strings with OpenMath IDs, e.g. <OMA id="polyringEOTOMyeragCgSa4k" >
gap> SuppressOpenMathReferencesOLD:=SuppressOpenMathReferences;;
gap> SuppressOpenMathReferences:=true;;
gap> x:=Indeterminate(Rationals,"x");;
gap> y:=Indeterminate(Rationals,"y");;
gap> ring1:=PolynomialRing(Rationals,[x]);;
gap> ring2:=PolynomialRing(Rationals,[x,y]);;
gap> OMTest(ring1);
true
gap> SetOpenMathDefaultPolynomialRing(ring1);
gap> OMTest(2*x^2+x+1);
true
gap> SetOpenMathDefaultPolynomialRing(ring2);
gap> OMTest(ring2);
true
gap> OMTest(2*x^2+x*y+x+2*y+1);
true
gap> SuppressOpenMathReferences:=SuppressOpenMathReferencesOLD;;

# OMPut method for a finite field using setname2.GFp or setname2.GFpn
gap> OMPrint(GF(2));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="setname2" name="GFp"/>
		<OMI>2</OMI>
	</OMA>
</OMOBJ>
gap> OMPrint(GF(9));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="setname2" name="GFpn"/>
		<OMI>3</OMI>
		<OMI>2</OMI>
	</OMA>
</OMOBJ>
gap> OMTest(GF(2));
true
gap> OMTest(GF(9));
true

#
gap> STOP_TEST("omput.tst");