gap> START_TEST( "base-256 big integers in the binary encoding" );

# OpenMath 2.0, section 3.2.2: tag 0x02, digit count, sign/base byte,
# then the digits. 171 (0xab) is '+' with the base-256 mask, 173 (0xad)
# is '-'. Digit bytes below 16 (0x10) used to be decoded without zero
# padding (see issue #31).
gap> BigIntBin256 := function( signbyte, digits )
>   local s, n;
>   s := InputTextString( List( Concatenation( [ 24, 2, Length( digits ),
>          signbyte ], digits, [ 25 ] ), CHAR_INT ) );
>   n := OMGetObject( s );
>   CloseStream( s );
>   return n;
> end;;

# ff ff ff f1 (the example of the standard)
gap> BigIntBin256( 171, [ 255, 255, 255, 241 ] );
4294967281

# ff 01 ff
gap> BigIntBin256( 171, [ 255, 1, 255 ] );
16712191

# ff 00 ff
gap> BigIntBin256( 171, [ 255, 0, 255 ] );
16711935

# 01 00
gap> BigIntBin256( 171, [ 1, 0 ] );
256

# 10 00
gap> BigIntBin256( 171, [ 16, 0 ] );
4096

# 0f ff
gap> BigIntBin256( 171, [ 15, 255 ] );
4095

# negative: 01 00 00
gap> BigIntBin256( 173, [ 1, 0, 0 ] );
-65536

# a longer integer
gap> n := 2^200 + 3;;
gap> BigIntBin256( 171, Reversed( CoefficientsQadic( n, 256 ) ) ) = n;
true
gap> STOP_TEST( "binint256.tst", 1 );
