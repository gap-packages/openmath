gap> START_TEST( "Test of the 'openmath' package" );

# Some examples from file openmath/examples
gap> 
gap> stream := InputTextFile(Filename(
>         DirectoriesPackageLibrary("openmath","tst"),"test3.omt"));;
gap> OMGetObject(stream);
912873912381273891
gap> OMGetObject(stream);
E(4)
gap> OMGetObject(stream);
true
gap> OMGetObject(stream);
false
gap> OMGetObject(stream);
"LAMBDA"
gap> OMGetObject(stream);
"dummy1"
gap> OMGetObject(stream);
"string1"
gap> OMGetObject(stream);
(1,2,3)
gap> OMGetObject(stream);
Group([ (1,2,3) ])
gap> OMGetObject(stream);
(1,2,3)
gap> CloseStream( stream );

# similar, for file tst/test3.bin: binary encoding
gap> stream := InputTextFile(Filename(
>         DirectoriesPackageLibrary("openmath","tst"),"test3.bin"));;
gap> OMGetObject(stream);
912873912381273891
gap> OMGetObject(stream);
E(4)
gap> OMGetObject(stream);
true
gap> OMGetObject(stream);
false
gap> OMGetObject(stream);
"LAMBDA"
gap> OMGetObject(stream);
"dummy1"
gap> OMGetObject(stream);
"string1"
gap> OMGetObject(stream);
(1,2,3)
gap> OMGetObject(stream);
Group([ (1,2,3) ])
gap> OMGetObject(stream);
(1,2,3)
gap> CloseStream( stream );

# similar, for file tst/test4.out: gpipe encoding
gap> stream := InputTextFile(Filename(
>         DirectoriesPackageLibrary("openmath","tst"),"test4.out"));;
gap> OMgetObjectByteStream(stream);
912873912381273891
gap> OMgetObjectByteStream(stream);
E(4)
gap> CloseStream( stream );

# similar, for file tst/test5.omt
gap> stream := InputTextFile(Filename(DirectoriesPackageLibrary("openmath","tst"),"test5.omt"));;
gap> OMGetObject(stream);
CharacterTable( Alt( [ 1 .. 3 ] ) )
gap> CloseStream( stream );

# similar, for file tst/test6.omt
gap> 
gap> stream := InputTextFile(Filename(DirectoriesPackageLibrary("openmath","tst"),"test6.omt"));;
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR;
""
""
""
gap> a;
1
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR;
1
""
""
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR; OM_GAP_OUTPUT_STR := "";;
true
"3"
""
gap> a;
3
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR;
true
"3"
""
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR; OM_GAP_OUTPUT_STR := "";; OM_GAP_ERROR_STR := "";;
true
""
""
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR;
""
""
""
gap> OMGetObject(stream); OM_GAP_OUTPUT_STR; OM_GAP_ERROR_STR;
""
""
""

# there are some objects left on stream, but they are character table examples
gap> CloseStream( stream );

# similar, for file tst/test_new.omt
gap> stream := InputTextFile(Filename(DirectoriesPackageLibrary("openmath","tst"),"test_new.omt"));;
gap> OMGetObject(stream);
true
gap> OMGetObject(stream);
[ [ 19, 22 ], [ 43, 50 ] ]
gap> OMGetObject(stream);
6
gap> OMGetObject(stream);
9
gap> OMGetObject(stream);
1
gap> OMGetObject(stream);
E(4)
gap> OMGetObject(stream);
infinity
gap> OMGetObject(stream);
[ 3, 6, 9 ]
gap> OMGetObject(stream);
[ 3, 6, 9 ]
gap> OMGetObject(stream);
[ 3, 6, 9 ]
gap> OMGetObject(stream);
0
gap> OMGetObject(stream);
true
gap> OMGetObject(stream);
true
gap> OMGetObject(stream);
10/9
gap> CloseStream( stream );

# Tests of conversion from GAP to OpenMath
gap> g := SymmetricGroup(5);
Sym( [ 1 .. 5 ] )
gap> t := "";
""
gap> s := OutputTextString(t, true);
OutputTextString(0)
gap> w := OpenMathXMLWriter( s );
<OpenMath XML writer to OutputTextString(0)>
gap> OMPutObject(w, g);
gap> CloseStream(s);
gap> 
gap> s := InputTextString(t);
InputTextString(0,400)
gap> g2 := OMGetObject(s);
Group([ (1,2,3,4,5), (1,2) ])
gap> CloseStream(s);
gap> g2 = g;
true
gap> 
gap> g := SymmetricGroup(5);
Sym( [ 1 .. 5 ] )
gap> OMPrint(g);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="permgp1" name="group"/>
		<OMS cd="permutation1" name="right_compose"/>
		<OMA>
			<OMS cd="permut1" name="permutation"/>
			<OMI>2</OMI>
			<OMI>3</OMI>
			<OMI>4</OMI>
			<OMI>5</OMI>
			<OMI>1</OMI>
		</OMA>
		<OMA>
			<OMS cd="permut1" name="permutation"/>
			<OMI>2</OMI>
			<OMI>1</OMI>
		</OMA>
	</OMA>
</OMOBJ>

# test with the different kinds of stream
# OutputTextFile, InputTextFile
gap> s := OutputTextFile( Filename( OMDirectoryTemporary, "test" ), false );;
gap> w := OpenMathXMLWriter( s );;
gap> OMPutObject( w, 123 );
gap> OMPutObject( w, false );
gap> OMPutObject( w, "OutputTextFile, InputTextFile" );
gap> CloseStream( s );
gap> 
gap> s := InputTextFile( Filename( OMDirectoryTemporary, "test" ) );;
gap> OMGetObject( s );
123
gap> OMGetObject( s );
false
gap> OMGetObject( s );
"OutputTextFile, InputTextFile"
gap> CloseStream( s );
gap> 
gap> RemoveFile( Filename( OMDirectoryTemporary, "test" ) );
true

## OutputTextUser,  InputTextUser
# how do one tests OutputTextUser?
# how do one tests InputTextUser?
## OutputTextString, InputTextString
gap> test_string := "";
""
gap> s := OutputTextString( test_string, false );
OutputTextString(0)
gap> w := OpenMathXMLWriter( s );;
gap> OMPutObject( w, 123 );
gap> OMPutObject( w, false );
gap> OMPutObject( w, "OutputTextString, InputTextString" );
gap> CloseStream( s );
gap> test_string;
"<OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\"2.0\">\n\t<OMI>12\
3</OMI>\n</OMOBJ>\n<OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\
\"2.0\">\n\t<OMS cd=\"logic1\" name=\"false\"/>\n</OMOBJ>\n<OMOBJ xmlns=\"http\
://www.openmath.org/OpenMath\" version=\"2.0\">\n\t<OMSTR>OutputTextString, In\
putTextString</OMSTR>\n</OMOBJ>\n"
gap> s := InputTextString( test_string );
InputTextString(0,315)
gap> OMGetObject( s );
123
gap> OMGetObject( s );
false
gap> OMGetObject( s );
"OutputTextString, InputTextString"
gap> CloseStream( s );

# OutputTextNone
gap> s := OutputTextNone(  );
OutputTextNone()
gap> w := OpenMathXMLWriter( s );;
gap> OMPutObject( w, 123 );
gap> OMPutObject( w, false );
gap> OMPutObject( w, "OutputTextNone" );
gap> CloseStream( s );
gap> 

# miscellaneous tests
# test with binary encoding and InputTextString
gap> s := InputTextString( "\030\020\b\007\cminmax1max\020\b\004\cset1set\>\>\>\t\>\005\021\021\031" );
InputTextString(0,35)
gap> OMGetObject(s);
9
gap> CloseStream(s);

# test with gpipe encoding and InputTextString
gap> gpipe_string := List( [ 24, 16, 8, 109, 105, 110, 109, 97, 120, 49, 255, 109, 97, 120, 255, 16, 8, 115, 
> 101, 116, 49, 255, 115, 101, 116, 255, 2, 49, 255, 2, 57, 255, 2, 53, 255, 17, 17, 25 ], CHAR_INT );;
gap> s := InputTextString( gpipe_string );
InputTextString(0,38)
gap> OMgetObjectByteStream(s);
9
gap> CloseStream(s);

# test of a long object
gap> OMTest(10^4000);
true

# test of a hexadecimal encoded integer
gap> s := InputTextString( "<OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\"2.0\"><OMI>x10ab2937fed2837a028374</OMI></OMOBJ>" );
InputTextString(0,104)
gap> OMGetObject(s);
20151098133805576518534004
gap> CloseStream(s);

# test of escaped XML chars
gap> s := InputTextString( "<OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\"2.0\"> <OMSTR>&lt;&amp;&gt;&quot;&apos;</OMSTR> </OMOBJ>" );
InputTextString(0,112)
gap> OMGetObject(s);
"<&>\"'"
gap> CloseStream(s);

# test of a strings with all the chars
gap> OMTest( List( [4..127], CHAR_INT ) );
true

# test that the strings are returned in string representation
gap> stream := InputTextString( "<OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\"2.0\"><OMSTR></OMSTR></OMOBJ> <OMOBJ xmlns=\"http://www.openmath.org/OpenMath\" version=\"2.0\"><OMSTR>ciao</OMSTR></OMOBJ>" );;
gap> IsStringRep( OMGetObject( stream ) );
true
gap> IsStringRep( OMGetObject( stream ) );
true
gap> CloseStream(stream);

### test of Hasse
gap> d := Domain(["0","a","b","c","1"]);
<object>
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
> DirectProductElement(["c","1"])]);
<general mapping: <object> -> <object> >
gap> p := TransitiveClosureBinaryRelation(ReflexiveClosureBinaryRelation(r));
<general mapping: <object> -> <object> >
gap> IsPartialOrderBinaryRelation(p);
true
gap> h := HasseDiagram(p);
<general mapping: <object> -> <object> >

# the bug was here.
gap> Elements(UnderlyingRelation(h));
[ DirectProductElement( [ "0", "a" ] ), DirectProductElement( [ "0", "b" ] ), 
  DirectProductElement( [ "0", "c" ] ), DirectProductElement( [ "a", "1" ] ), 
  DirectProductElement( [ "b", "1" ] ), DirectProductElement( [ "c", "1" ] ) ]

### test for the various supported objects
gap> OMPrint(Rationals);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="setname1" name="Q"/>
</OMOBJ>
gap> OMTest(Rationals);
true
gap> OMPrint(Integers);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="setname1" name="Z"/>
</OMOBJ>
gap> OMTest(Integers);
true
gap> OMPrint([3..10]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="interval1" name="integer_interval"/>
		<OMI>3</OMI>
		<OMI>10</OMI>
	</OMA>
</OMOBJ>
gap> OMTest([3..10]);
true
gap> OMPrint([[11,12],[21,22]]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="linalg2" name="matrix"/>
		<OMA>
			<OMS cd="linalg2" name="matrixrow"/>
			<OMI>11</OMI>
			<OMI>12</OMI>
		</OMA>
		<OMA>
			<OMS cd="linalg2" name="matrixrow"/>
			<OMI>21</OMI>
			<OMI>22</OMI>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMTest([[11,12],[21,22]]);
true
gap> OMPrint(NonnegativeIntegers);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="setname1" name="N"/>
</OMOBJ>
gap> OMTest(NonnegativeIntegers);
true
gap> OMPrint(AlternatingGroup(6));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="permgp1" name="group"/>
		<OMS cd="permutation1" name="right_compose"/>
		<OMA>
			<OMS cd="permut1" name="permutation"/>
			<OMI>2</OMI>
			<OMI>3</OMI>
			<OMI>4</OMI>
			<OMI>5</OMI>
			<OMI>1</OMI>
		</OMA>
		<OMA>
			<OMS cd="permut1" name="permutation"/>
			<OMI>1</OMI>
			<OMI>2</OMI>
			<OMI>3</OMI>
			<OMI>5</OMI>
			<OMI>6</OMI>
			<OMI>4</OMI>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMTest(AlternatingGroup(6));
true
gap> OMPrint( Group( [[0,1],[-1,0]],[[1,1],[0,1]] ) );
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="group1" name="group_by_generators"/>
		<OMA>
			<OMS cd="linalg2" name="matrix"/>
			<OMA>
				<OMS cd="linalg2" name="matrixrow"/>
				<OMI>0</OMI>
				<OMI>1</OMI>
			</OMA>
			<OMA>
				<OMS cd="linalg2" name="matrixrow"/>
				<OMI>-1</OMI>
				<OMI>0</OMI>
			</OMA>
		</OMA>
		<OMA>
			<OMS cd="linalg2" name="matrix"/>
			<OMA>
				<OMS cd="linalg2" name="matrixrow"/>
				<OMI>1</OMI>
				<OMI>1</OMI>
			</OMA>
			<OMA>
				<OMS cd="linalg2" name="matrixrow"/>
				<OMI>0</OMI>
				<OMI>1</OMI>
			</OMA>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMTest( Group( [[0,1],[-1,0]],[[1,1],[0,1]] ) );
true
gap> OMPrint(10^72);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMI>100000000000000000000000000000000000000000000000000000000000000000000000\
0</OMI>
</OMOBJ>
gap> OMTest(10^72);
true
gap> OMPrint(10/72);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="nums1" name="rational"/>
		<OMI>5</OMI>
		<OMI>36</OMI>
	</OMA>
</OMOBJ>
gap> OMTest(10/72);
true
gap> OMPrint(infinity);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="nums1" name="infinity"/>
</OMOBJ>
gap> OMTest(infinity);
true
gap> OMPrint(2/3+5/4*E(4));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="complex1" name="complex_cartesian"/>
		<OMA>
			<OMS cd="nums1" name="rational"/>
			<OMI>2</OMI>
			<OMI>3</OMI>
		</OMA>
		<OMA>
			<OMS cd="nums1" name="rational"/>
			<OMI>5</OMI>
			<OMI>4</OMI>
		</OMA>
	</OMA>
</OMOBJ>
gap> OMTest(2/3+5/4*E(4));
true
gap> OMPrint([1,2,3]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMI>1</OMI>
		<OMI>2</OMI>
		<OMI>3</OMI>
	</OMA>
</OMOBJ>
gap> OMTest([1,2,3]);
true
gap> OMPrint(h);
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
gap> OMPrint([]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="set1" name="emptyset"/>
</OMOBJ>
gap> OMTest([]);
true
gap> OMPrint(Set([true,false]));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="set1" name="set"/>
		<OMS cd="logic1" name="true"/>
		<OMS cd="logic1" name="false"/>
	</OMA>
</OMOBJ>
gap> OMTest(Set([true,false]));
true
gap> OMPrint((1,3,5));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="permut1" name="permutation"/>
		<OMI>3</OMI>
		<OMI>2</OMI>
		<OMI>5</OMI>
		<OMI>4</OMI>
		<OMI>1</OMI>
	</OMA>
</OMOBJ>
gap> OMTest((1,3,5));
true
gap> OMPrint("OMPut: for a string");
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>OMPut: for a string</OMSTR>
</OMOBJ>
gap> OMTest("OMPut: for a string");
true
gap> OMPrint(Set(['a','b']));
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>ab</OMSTR>
</OMOBJ>
gap> OMTest(Set(['a','b']));
true
gap> OMPrint("");
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR></OMSTR>
</OMOBJ>
gap> OMTest("");
true

# also the escaped XML chars
gap> OMPrint("&");
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>&amp;</OMSTR>
</OMOBJ>
gap> OMTest("&");
true
gap> OMPrint("<");
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>&lt;</OMSTR>
</OMOBJ>
gap> OMTest("<");
true
gap> OMPrint("<&>\"'");
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>&lt;&amp;>"'</OMSTR>
</OMOBJ>
gap> OMTest("<&>\"'");
true
gap> OMPrint("&lt;&amp;");
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMSTR>&amp;lt;&amp;amp;</OMSTR>
</OMOBJ>
gap> OMTest("&lt;&amp;");
true
gap> OMPrint([ [ 1 .. 10 ], Rationals, false, true, infinity, 1, 0 ]);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMA>
			<OMS cd="interval1" name="integer_interval"/>
			<OMI>1</OMI>
			<OMI>10</OMI>
		</OMA>
		<OMS cd="setname1" name="Q"/>
		<OMS cd="logic1" name="false"/>
		<OMS cd="logic1" name="true"/>
		<OMS cd="nums1" name="infinity"/>
		<OMI>1</OMI>
		<OMI>0</OMI>
	</OMA>
</OMOBJ>
gap> OMTest([ [ 1 .. 10 ], Rationals, false, true, infinity, 1, 0 ]);
true
gap> OMPrint(false);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMS cd="logic1" name="false"/>
</OMOBJ>
gap> OMTest(false);
true
gap> floats := List( [ 0, "-0", 1, 1/2, -1, "inf", "-inf" ], Float );
[ 0., -0., 1., 0.5, -1., inf, -inf ]
gap> OMPrint(floats);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMF dec="0"/>
		<OMF dec="0"/>
		<OMF dec="1."/>
		<OMF dec="0.5"/>
		<OMF dec="-1."/>
		<OMF dec="INF"/>
		<OMF dec="-INF"/>
	</OMA>
</OMOBJ>
gap> OMTest(floats);
true
gap> floats := List( [ 11^7, 11^-7, -11^7, -11^-7, "nan" ], Float );
[ 1.94872e+07, 5.13158e-08, -1.94872e+07, -5.13158e-08, nan ]
gap> OMPrint(floats);
<OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
	<OMA>
		<OMS cd="list1" name="list"/>
		<OMF dec="19487171."/>
		<OMF dec="5.1315811823070673e-08"/>
		<OMF dec="-19487171."/>
		<OMF dec="-5.1315811823070673e-08"/>
		<OMF dec="NaN"/>
	</OMA>
</OMOBJ>
gap> STOP_TEST( "test", 10000 );
