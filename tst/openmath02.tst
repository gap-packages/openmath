# openmath, chapter 2

# [ "doc/../gap/omput.gd", 159, 174 ]

gap> OMPrint( [ 1, 1/2 ] );     
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMI>1</OMI>
		<OMA>
			<OMS cd="nums1" name="rational"/>
			<OMI>1</OMI>
			<OMI>2</OMI>
		</OMA>
	</OMA>
</OMOBJ>


# [ "doc/../gap/omput.gd", 176, 183 ]

gap> OMPrint( "This is a string" );
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>This is a string</OMSTR>
</OMOBJ>


# [ "doc/../gap/omput.gd", 185, 211 ]

gap> OMPrint( 1-2*E(4) );      
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="complex1" name="complex_cartesian"/>
		<OMI>1</OMI>
		<OMI>-2</OMI>
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


# [ "doc/../gap/omput.gd", 213, 254 ]

gap> OMPrint( Group( (1,2) ) );
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="permgp1" name="group"/>
		<OMS cd="permutation1" name="right_compose"/>
		<OMA>
			<OMS cd="permut1" name="permutation"/>
			<OMI>2</OMI>
			<OMI>1</OMI>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMPrint( Group( [ [ [ 1, 2 ],[ 0, 1 ] ] ] ) );
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="group1" name="group_by_generators"/>
		<OMA>
			<OMS cd="linalg2" name="matrix"/>
			<OMA>
				<OMS cd="linalg2" name="matrixrow"/>
				<OMI>1</OMI>
				<OMI>2</OMI>
			</OMA>
			<OMA>
				<OMS cd="linalg2" name="matrixrow"/>
				<OMI>0</OMI>
				<OMI>1</OMI>
			</OMA>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMPrint( FreeGroup( 2 ) );                      
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="fpgroup1" name="free_groupn"/>
		<OMI>2</OMI>
	</OMA>
</OMOBJ>


# [ "doc/../gap/omput.gd", 274, 281 ]

gap> OMString(42);
"<OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\"2.0\"> <OMI>42</OMI> </OMOBJ>"
gap> OMString([1,2]:noomobj);    
"<OMA> <OMS cd=\"list1\" name=\"list\"/> <OMI>1</OMI> <OMI>2</OMI> </OMA>"


# [ "doc/../gap/omget.gd", 41, 54 ]

gap> txml:=Filename(DirectoriesPackageLibrary("openmath","tst"),"test3.omt");;   
gap> tbin:=Filename(DirectoriesPackageLibrary("openmath","tst"),"test3.bin");;   
gap> xstream := InputTextFile( txml );; bstream := InputTextFile( tbin );;   
gap> x:=OMGetObject(xstream); y:=OMGetObject(bstream);
912873912381273891
912873912381273891
gap> x:=OMGetObject(xstream); y:=OMGetObject(bstream);
E(4)
E(4)
gap> CloseStream(xstream);CloseStream(bstream);


# [ "doc/../gap/omget.gd", 85, 93 ]

gap> s:="<OMOBJ><OMS cd=\"setname1\" name=\"Z\"/></OMOBJ>";;
gap> EvalOMString(s);
Integers
gap> G:=SL(2,5);; G=EvalOMString(OMString(G));
true


# [ "doc/../gap/omput.gd", 96, 123 ]

gap> g := [[1,2],[1,0]];;
gap> t := "";
""
gap> s := OutputTextString(t, true);;
gap> w:=OpenMathXMLWriter( s );
<OpenMath XML writer to OutputTextString(0)>
gap> OMPutObject(w, g);
gap> CloseStream(s);
gap> Print(t);
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
			<OMI>1</OMI>
			<OMI>0</OMI>
		</OMA>
	</OMA>
</OMOBJ>


# [ "doc/../gap/omput.gd", 451, 460 ]

gap> s:=OMPlainString("<OMS cd=\"nums1\" name=\"pi\"/>");
<OMS cd="nums1" name="pi"/>
gap> OMPrint(s);                                       
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="nums1" name="pi"/>
</OMOBJ>


# [ "doc/../gap/testing.gd", 28, 33 ]

gap> OMTestXML([[1..10],[1/2,2+E(4)],ZmodnZObj(2,6),(1,2),true,"string"]);     
true


# [ "doc/../gap/testing.gd", 58, 63 ]

gap> OMTestBinary([[1..10],[1/2,2+E(4)],ZmodnZObj(2,6),(1,2),true,"string"]);     
true

