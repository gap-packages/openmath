#######################################################################
##
#W  omputbin.gi          OpenMath Package           Alexander Konovalov
##
#H  @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##  Low-level methods for output in the OpenMath binary format
## 

Revision.("openmath/gap/omputbin.gi") := 
    "@(#)$Id$";

########################################################################
##
#M  BigIntToListofInts( <integer> )
##
##  Returns a list of 4 integers as to represent the number over 4 bytes
##
BindGlobal ( "BigIntToListofInts", 
function(int)
	local hexValue, hexValueLength, finalHexString, lengthDiff, listofInts;
	listofInts:=[];
	finalHexString := "";
	hexValue := HexStringInt(int);
	hexValueLength := Length(hexValue);
	if (hexValueLength < 8) then
		lengthDiff := 8 - hexValueLength;
		while lengthDiff > 0 do 
			Append(finalHexString,"0");
			lengthDiff := lengthDiff - 1; 
		od;
	fi;
	Append(finalHexString, hexValue);
	Add(listofInts, IntHexString(finalHexString{[1..2]}));
	Add(listofInts, IntHexString(finalHexString{[3..4]}));
	Add(listofInts, IntHexString(finalHexString{[5..6]}));
	Add(listofInts, IntHexString(finalHexString{[7..8]}));	
	return listofInts;
end);

#######################################################################
#
#  Checks whethere it is a real float
BindGlobal( "IsIntFloat",
function(x) 
	return Float(0) = x-Float(Int(x));
end);

#######################################################################
#
#  Writes 4 bytes given
BindGlobal( "WriteIntasBytes",
function( stream, listofInts )
	WriteByte(stream, listofInts[1]);
	WriteByte(stream, listofInts[2]);
	WriteByte(stream, listofInts[3]);
	WriteByte(stream, listofInts[4]);
end);

#######################################################################
#
#  Obtains position of first 1 in binary string
BindGlobal( "FindFirst1BinaryString",
function( binStri )
local i, binStriLen;
binStriLen := Length(binStri);
i := 1;
while binStri[i] <> '1' and i <= binStriLen do
i := i +1;
od;

return i;
end);

#######################################################################
##
#M 
#
BindGlobal( "WriteDecasHex",
function( decPart )
local intPart, resultHex, number, i, zeroF;
	i := 0;
	resultHex := "";
	zeroF := Float("0.0");
	while decPart <> zeroF do
		if i > 10 then
			break;
		fi;
		number := decPart * 16;
		intPart := Int(number);
		decPart := number - intPart;
		Append(resultHex, HexStringInt(intPart));
	
		i := i +1;
	od;
	return resultHex;
	
end);

#######################################################################
##
#M 
BindGlobal( "WriteHexAsBin",
function( hexNum, withLeadingZeroes )
local hexNumLen, binStri, num, charStri, counter, binArrayWithZeroes, binArrayNoLeadingZeroes;
hexNumLen := Length(hexNum);
binStri := "";
counter:= 1;
binArrayWithZeroes := ["0000", "0001" ,"0010", "0011",	"0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"];
binArrayNoLeadingZeroes := ["", "1" ,"10", "11", "100", "101", "110", "111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"];
charStri := hexNum{[counter]};
num := IntHexString(charStri);
if withLeadingZeroes then
	Append(binStri, binArrayWithZeroes[num+1]);
else
	Append(binStri, binArrayNoLeadingZeroes[num+1]);
fi;
counter := counter +1;
while counter <= hexNumLen do
	charStri := hexNum{[counter]};
	num := IntHexString(charStri);
	Append(binStri, binArrayWithZeroes[num+1]);
	counter := counter +1;
od;
return binStri;
end);

#######################################################################
##
#M 
BindGlobal( "WriteBinAsHex",
function( binStri )
local binStriLen, hexStri, counter, binArray,hexArray, limit, upper, lower;
binStriLen := Length(binStri);
hexStri := "";
counter:= 1;
binArray := ["0000", "0001" ,"0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"];
hexArray := ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
#limit := binStriLen /4;
upper := 4;
lower := 1;
while upper <= binStriLen do
	for counter in [1..16] do
		if binStri{[lower..upper]} = binArray[counter] then
			Append(hexStri, hexArray[counter]);
			break;
		fi;
		counter := counter + 1;
	od;
	upper := upper +4;
	lower := lower + 4;
od;
return hexStri;
end);

########################################################################
###
##M 
## removes all falses at the start of the list.
#BindGlobal( "NormaliseBlist", 
#function( list )
#local i, listLen, finalList;
#i:= 1;
#listLen := Length(list);
#while  i <= listLen and list[i] = false do
#	i := i +1;
#od;
#if i >= listLen then
#	finalList := [list[listLen]];
#else
#	finalList := list{[i..listLen]};
#fi;
#list := finalList;
#return i;
#end);

#######################################################################
##
#M 
BindGlobal( "WriteHexStriAsBytes",
function( hexStri, stream )
local hexStriLen, intValue, upper, lower;
upper := 2;
lower := 1;
intValue := 0;
hexStriLen := Length(hexStri);
while upper <= hexStriLen do
	intValue := IntHexString(hexStri{[lower..upper]});
	WriteByte(stream, intValue);
	upper := upper +2;
	lower := lower +2;
od;
end);

#######################################################################
##
#M 
BindGlobal( "WriteBinStringsAsBytes",
function( sign, exponent, mantissa , stream)
local  exponentLen, mantissaLen, firstPart, secondPart, numbZeroes, hexStri;
exponentLen := Length(exponent);
mantissaLen := Length(mantissa);
firstPart := "";
secondPart := mantissa;
if sign then 
	Append(firstPart, "1" );
else 
	Append(firstPart, "0" );
fi;
if exponentLen < 11 then 
	numbZeroes := 11 - exponentLen ;
	while numbZeroes <> 0 do 
		Append(firstPart, "0");
	numbZeroes := numbZeroes - 1;
	od;
fi;
Append(firstPart, exponent);
if mantissaLen < 52 then 
	numbZeroes := 52 - mantissaLen;
	while numbZeroes <> 0 do 
		Append(secondPart, "0");
	numbZeroes := numbZeroes -1;
	od;
fi;
Append(firstPart,secondPart);
hexStri := WriteBinAsHex(firstPart);
WriteHexStriAsBytes(hexStri, stream);
end);




#######################################################################
##
#O  OMPutOMOBJ( <stream> ) 
#O  OMPutEndOMOBJ( <stream> ) 
##

InstallMethod(OMPutOMOBJ, "to write OMOBJ in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 24 );
end);

InstallMethod(OMPutEndOMOBJ, "to write /OMOBJ in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 25 );
end);


#######################################################################
##
#M  OMPut( <OMWriter>, <int> )  
##
##  Printing for integers: specified in the standard
## 
InstallMethod(OMPut, "for an integer to binary OpenMath", true,
[ IsOpenMathBinaryWriter, IsInt ],0,
function( writer, int )
local intStri, intLength, intListLength;
intStri := String(int);
intLength := Length(intStri);

if int >= -128 and int <= 127 then
	WriteByte( writer![1], 1);
	WriteByte(writer![1], int);

	
elif int >= -2^31 and int <= 2^31-1 then
	WriteByte( writer![1], 129); #1+128
	intListLength := BigIntToListofInts(int);
	WriteIntasBytes(writer![1], intListLength);

elif intLength >= 0 and intLength <= 255 then
	WriteByte( writer![1], 2);	
	WriteByte(writer![1], intLength);
	WriteByte(writer![1], 43); #base 10 | sign +
	WriteAll(writer![1], intStri);
elif intLength > 255 then
	WriteByte( writer![1], 130);#2+128
	if int < 0 then
		WriteByte(writer![1], 45); #base 10 | sign -
	else
		WriteByte(writer![1], 43); #base 10 | sign +	
	fi;
	intListLength := BigIntToListofInts(intLength);
	WriteIntasBytes(writer![1], intListLength);
	WriteAll(writer![1], intStri);
fi;

end);

########################################################################
##
#M  OMPut( <OMWriter>, <float> )
##
##
##
InstallMethod(OMPut, "for a float to binary OpenMath", true,
[ IsOpenMathBinaryWriter, IS_MACFLOAT ],0,
function(writer, f)
	local intPart, decPart, sign, decHex, decBin, decBinLen, exponent, pos, mantissa, intBin, absIntPart;
	WriteByte( writer![1], 3);
	if f > 0 then
		sign := false;
	else
		sign := true;
	fi;
	intPart := Int(f);
	if IsIntFloat(f) then 
		decPart := 0;
	else
		decPart := f - intPart;
	fi;
	decHex := WriteDecasHex(decPart);
	decBin := WriteHexAsBin(decHex, true);
	decBinLen := Length(decBin);
	absIntPart := AbsInt(intPart);
	if absIntPart = 0 then
		pos := FindFirst1BinaryString(decBin);
		exponent := 1023 - pos;
		exponent := WriteHexAsBin(HexStringInt(exponent), false);
		mantissa := decBin{[pos+1..decBinLen]};
	else
		intBin := WriteHexAsBin(HexStringInt(absIntPart),false);
		pos := Length(intBin) -1;
		exponent := 1023 + pos;
		exponent := WriteHexAsBin(HexStringInt(exponent), false);
		Append(intBin, decBin);
		mantissa := intBin{[2..Length(intBin)]};
	fi;
	if Length(mantissa) > 52 then
		mantissa := mantissa{[1..52]};
	fi;
	WriteBinStringsAsBytes( sign, exponent, mantissa , writer![1]);

end);

########################################################################
##
#M  OMPutVar( <OMWriter>, <variable> )
##
##
##
InstallMethod(OMPutVar, "for a variable to binary OpenMath", true,
[ IsOpenMathBinaryWriter, IsObject ],0,
function(writer, var)
	local varLength, varStri, varLengthList;
	varStri := String(var);
	varLength := Length(varStri);
	if varLength >= 256 then
		WriteByte( writer![1], 133); #5+128
		varLengthList := BigIntToListofInts(varLength);
		WriteIntasBytes(writer![1], varLengthList);
	else
		WriteByte( writer![1], 5);
		WriteByte(writer![1], varLength);
	fi;
	WriteAll(writer![1], varStri);

end);


########################################################################
##
#M  OMPut( <OMWriter>, <symbol> )
##
##
##
InstallMethod( OMPutSymbol, "for a symbol to binary OpenMath", true,
[IsOpenMathBinaryWriter, IsString, IsString ],0,
function( writer, cd, name )	
	local cdLength, nameLength, cdListInt, nameListInt;

	nameListInt := [];
	cdLength := Length(cd);
	nameLength := Length(name);
	if (cdLength > 255 or nameLength > 255) then
		WriteByte( writer![1], 136); #128+8
		cdListInt := BigIntToListofInts(cdLength);
		nameListInt := BigIntToListofInts(nameLength);
		#writing the cd length as 4 bytes
		WriteIntasBytes(writer![1], cdListInt);
		#writing the name length as 4 bytes
		WriteIntasBytes(writer![1], nameListInt);	
	else
		WriteByte(writer![1], 8);
		WriteByte(writer![1], cdLength);
		WriteByte(writer![1], nameLength);
	fi;
	WriteAll(writer![1], cd);
	WriteAll(writer![1], name);

end);



#######################################################################
##
#M  OMPutOMATTR
#M  OMPutEndOMATTR
##
InstallMethod(OMPutOMATTR, "to write OMATTR in Binary OpenMath", true,
[IsOpenMathBinaryWriter],0,
function( writer )
	WriteByte( writer![1], 18 );
end);

InstallMethod(OMPutEndOMATTR, "to write /OMATTR in Binary OpenMath", true,
[IsOpenMathBinaryWriter],0,
function( writer )
    OMIndent := OMIndent - 1;
	WriteByte( writer![1], 19 );
end);

InstallMethod(OMPutOMATP, "to write OMATP in Binary OpenMath", true,
[IsOpenMathBinaryWriter],0,
function( writer )
	WriteByte( writer![1], 20);
end);

InstallMethod(OMPutEndOMATP, "to write /OMATP in Binary OpenMath", true,
[IsOpenMathBinaryWriter],0,
function( writer )
	WriteByte( writer![1], 21 );
end);


########################################################################
##
#M  OMPut( <OMWriter>, <string> )
##
##
##
InstallMethod(OMPut, "for a string to binary OpenMath", true,
[IsOpenMathBinaryWriter, IsString ],0,
function( writer, string )	
	local strLength, strListLength;
	strLength := Length(string);
	if strLength > 255 then
		strListLength := BigIntToListofInts(strLength);	
		WriteByte(writer![1], 134); # 6+128
		#writing the string length as 4 bytes
		WriteIntasBytes(writer![1], strListLength);
	else
		WriteByte(writer![1], 6);
		WriteByte(writer![1], strLength);
	fi;
	WriteAll(writer![1],string);
end);


########################################################################
##
#M  OMPut( <OMWriter>, <cdbase> )
##
##
##

########################################################################
##
#M  OMPut( <OMWriter>, <foreign> )
##
##
##
InstallMethod( OMPutForeign, "for a foreign object to binary OpenMath", true,
[IsOpenMathBinaryWriter, IsString, IsString ],0,
function( writer, encString, objString )	
	local encStrLength, encStrListLength, objStrLength, objStrListLength;
	encStrLength := Length(encString);
	objStrLength := Length(objString);
	if encStrLength > 255 or objStrLength > 255 then
		WriteByte(writer![1], 140);#12+128
		encStrListLength := BigIntToListofInts(encStrLength);
		objStrListLength := BigIntToListofInts(objStrLength);
		WriteIntasBytes(writer![1], encStrListLength);
		WriteIntasBytes(writer![1], objStrListLength);
	else
		WriteByte(writer![1], 12);
		WriteByte(writer![1], encStrLength);
		WriteByte(writer![1], objStrLength);
	fi;
	WriteAll(writer![1], encString);
	WriteAll(writer![1], objString);
end);

########################################################################
##
#M  OMPutOMAWithId( <OMWriter>, <reference> )
##
##
##
InstallMethod( OMPutOMAWithId, "to put Applications with Ids", true,
[IsOpenMathBinaryWriter , IsObject],0,
function(writer, reference)
	local referenceList, referenceLen;
	referenceLen := Length(reference);
	if referenceLen > 255 then
		referenceList := BigIntToListofInts(referenceLen);	
		WriteByte(writer![1], 208); # 16+64+128
		#writing the reference length as 4 bytes
		WriteIntasBytes(writer![1], referenceList);
	else
		WriteByte(writer![1], 80); #16+64
		WriteByte(writer![1], referenceLen);
	fi;
	WriteAll(writer![1], reference);
end);


########################################################################
##
#O  OMPutOMA( <OMWriter> );
#O  OMPutEndOMA( <OMWriter> );
##
##
InstallMethod(OMPutOMA, "to write OMA in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 16 );
end);

InstallMethod(OMPutEndOMA, "to write /OMA in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 17 );
end);

    
########################################################################
##
#M  OMPut( <OMWriter>, <attribution> )
##
##
##

########################################################################
##
#M  OMPut( <OMWriter>, <binding> )
##
##
##




########################################################################
##
#O  OMPutOME( <OMWriter> );
#O  OMPutEndOME( <OMWriter> );
##
##
InstallMethod(OMPutOME, "to write OME in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 22 );
end);

InstallMethod(OMPutEndOME, "to write /OME in binary OpenMath", true,
[ IsOpenMathBinaryWriter ], 0,
function( writer )
	WriteByte( writer![1], 23 );
end);


########################################################################
##
#M  OMPut( <OMWriter>, <reference> )
##
##	deals with external references for now
##
InstallMethod( OMPutReference, 
"for a stream and an object with reference",
true,
[ IsOpenMathBinaryWriter, IsObject ],
0,
function( writer, x )
local refStri, refLength, lengthList;
if HasOMReference( x ) and not SuppressOpenMathReferences then
   refStri := OMReference( x );
   refLength := Length(refStri); 
   if refLength > 255 then
   	WriteByte (writer![1], 159); #31+128
   	lengthList := BigIntToListofInts(refLength);
	WriteIntasBytes(writer![1], lengthList);
   else 
   	WriteByte (writer![1], 31);
   	WriteByte (writer![1], refLength);
   fi;
   WriteAll(writer![1], refStri);
else   
   OMPut( writer, x );
fi;
end);





















#############################################################################
#E
