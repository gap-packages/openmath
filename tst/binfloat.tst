gap> START_TEST( "floats in the binary encoding" );

# OpenMath 2.0, section 3.2.2: tag 0x03 followed by the eight bytes of
# the IEEE 754 double, most significant byte first (see issue #32).
gap> FloatBin := function( x )
>   local str, s;
>   str := "";
>   s := OutputTextString( str, false );
>   SetPrintFormattingStatus( s, false );
>   OMPutObject( OpenMathBinaryWriter( s ), x );
>   CloseStream( s );
>   return LowercaseString( Concatenation( List( str,
>            c -> HexStringInt( IntChar( c ) + 256 ){ [ 2, 3 ] } ) ) );
> end;;

# the example of the standard
gap> FloatBin( Float( "1.0e-10" ) );
"18033ddb7cdfd9d7bdbb19"
gap> FloatBin( Float( "1.5" ) );
"18033ff800000000000019"
gap> FloatBin( Float( "-1.5" ) );
"1803bff800000000000019"
gap> FloatBin( Float( "0.1" ) );
"18033fb999999999999a19"
gap> FloatBin( Float( "1.0e300" ) );
"18037e37e43c8800759c19"
gap> FloatBin( Float( "1.7976931348623157e308" ) );
"18037fefffffffffffff19"

# zeros, subnormals and infinities
gap> FloatBin( Float( "0" ) );
"1803000000000000000019"
gap> FloatBin( -Float( "0" ) );
"1803800000000000000019"
gap> FloatBin( Float( "5.0e-324" ) );
"1803000000000000000119"
gap> FloatBin( Float( "2.2250738585072014e-308" ) );
"1803001000000000000019"
gap> FloatBin( Float( "1" ) / Float( "0" ) );
"18037ff000000000000019"
gap> FloatBin( -Float( "1" ) / Float( "0" ) );
"1803fff000000000000019"

# round trip of normal values through the binary reader
gap> ForAll( [ "1.5", "-1.5", "1.0e-10", "1.0e300", "0.1", "3", "-123456.789" ],
>      function( t )
>        local x, str, s;
>        x := Float( t );
>        str := "";
>        s := OutputTextString( str, false );
>        SetPrintFormattingStatus( s, false );
>        OMPutObject( OpenMathBinaryWriter( s ), x );
>        CloseStream( s );
>        return OMGetObject( InputTextString( str ) ) = x;
>      end );
true
gap> STOP_TEST( "binfloat.tst", 1 );
