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
	finalHexString := "";
	hexValue := HexStringInt(int);
	hexValueLength := Length(hexValue);
	if (hexValueLength < 8) then
		lengthDiff := 8 - hexValueLength;
		while lengthDiff > 0 do 
			Append(finalHexString,"0");
			lengthDiff := lengthDiff - 1; 
		od;
		Append(finalHexString, hexValue);
	fi;
	Add(listofInts, IntHexString(finalHexString{[1..2]}));
	Add(listofInts, IntHexString(finalHexString{[3..4]}));
	Add(listofInts, IntHexString(finalHexString{[5..6]}));
	Add(listofInts, IntHexString(finalHexString{[7..8]}));	
	return listofInts;
end);

#######################################################################
#
#  Writes 4 bytes given
BindGlobal( "WriteIntasBytes",
function( writer, listofInts )
	WriteByte(writer![1], listofInts[1]);
	WriteByte(writer![1], listofInts[2]);
	WriteByte(writer![1], listofInts[3]);
	WriteByte(writer![1], listofInts[4]);
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
		if i > 51 then
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
# removes all falses at the start of the list.
BindGlobal( "NormaliseBlist", 
function( list )
local i, listLen, finalList;
i:= 1;
listLen := Length(list);
while  i <= listLen and list[i] = false do
	i := i +1;
od;
if i >= listLen then
	finalList := [list[listLen]];
else
	finalList := list{[i..listLen]};
fi;
list := finalList;
return i;
end);


#######################################################################
##
#M 
#FIXME: this is horribly inefficient !!!!!!!!!!!!!!
BindGlobal( "WriteHexAsBin",
function( hexNum )
local hexNumLen, binStri, num, charStri, counter;
hexNumLen := Length(hexNum);
binStri := "";
counter:= 1;
while counter <= hexNumLen do
	charStri := String(hexNum[counter]);
	RemoveCharacters(charStri,"\'");
	num := IntHexString(charStri);
	if num = 0 then
		Append(binStri,"0000");
	elif num = 1 then
		Append(binStri,"0001");
	elif num = 2 then
		Append(binStri,"0010");
	elif num = 3 then
		Append(binStri,"0011");
	elif num = 4 then
		Append(binStri,"0100");
	elif num = 5 then
		Append(binStri,"0101");
	elif num = 6 then
		Append(binStri,"0110");
	elif num = 7 then
		Append(binStri,"0111");
	elif num = 8 then
		Append(binStri,"1000");
	elif num = 9 then
		Append(binStri,"1001");
	elif num = 10 then
		Append(binStri,"1010");
	elif num = 11 then
		Append(binStri,"1011");
	elif num = 12 then
		Append(binStri,"1100");
	elif num = 13 then
		Append(binStri,"1101");
	elif num = 14 then
		Append(binStri,"1110");
	elif num = 15 then
		Append(binStri,"1111");
	fi;
	counter := counter +1;
od;
return binStri;
end);

#######################################################################
##
#M 
BindGlobal( "EnsureCompleteHexNum",
function( hexNum )
local hexNumLen, binStri, num, charStri, counter;
hexNumLen := Length(hexNum);
binStri := "0";
if not IsEvenInt(hexNumLen) then
	Append(binStri,hexNum);
	return binStri;
else
	return hexNum;
fi;
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
	WriteByte( writer![1], 1+128);
	intListLength := BigIntToListofInts(int);
	WriteIntasBytes(writer, intListLength);

elif intLength >= 0 and intLength <= 255 then
	WriteByte( writer![1], 2);	
	WriteByte(writer![1], intLength);
	WriteByte(writer![1], 43); #base 10 | sign +
	WriteAll(writer![1], intStri);
elif intLength > 255 then
	WriteByte( writer![1], 2+128);
	if int < 0 then
		WriteByte(writer![1], 45); #base 10 | sign -
	else
		WriteByte(writer![1], 43); #base 10 | sign +	
	fi;
	intListLength := BigIntToListofInts(intLength);
	WriteIntasBytes(writer, intListLength);
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
[ IsOpenMathBinaryWriter, IsFloat ],0,
function(writer, f)
	local intPart, decPart, sign, decHex;
	WriteByte( writer![1], 3);
	if f > 0 then
		sign := false;
	else
		sign := true;
	fi;
	intPart := Int(f);
	decPart := f - intPart;
	decHex := WriteDecasHex(decPart);
	decHex := EnsureCompleteHexNum(decHex);
	if AbsInt(intPart) = 0 then
		
	else
		
	fi;
	#TODO
end);

########################################################################
##
#M  OMPut( <OMWriter>, <variable> )
##
##
##
InstallMethod(OMPut, "for a variable to binary OpenMath", true,
[ IsOpenMathXMLWriter, IsObject ],0,
function(writer, var)
	local varLength, varStri, varLengthList;
	varStri := String(var);
	varLength := Length(varStri);
	if varLength >= 256 then
		WriteByte( writer![1], 5+128);
		varLengthList := BigIntToListofInts(varLength);
		WriteIntasBytes(writer, varLengthList);
	else
		WriteByte( writer![1], 5);
		WriteByte(varLength);
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
		WriteByte( writer![1], 8+128);
		cdListInt := BigIntToListofInts(cdLength);
		nameListInt := BigIntToListofInts(nameLength);
		#writing the cd length as 4 bytes
		WriteIntasBytes(writer, cdListInt);
		#writing the name length as 4 bytes
		WriteIntasBytes(writer, nameListInt);	
	else
		WriteByte(writer![1], 8);
		WriteByte(writer![1], cdLength);
		WriteByte(writer![1], nameLength);
	fi;
	WriteAll(writer![1], cd);
	WriteAll(writer![1], name);

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
		WriteByte(writer![1], 6+128);
		#writing the string length as 4 bytes
		WriteIntasBytes(writer, strListLength);
	else
		WriteByte(writer![1], 6);
		WriteByte(writer![1], strLength);
	fi;
	WriteAll(writer[1],string);
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
		WriteByte(writer![1], 12+128);
		encStrListLength := BigIntToListofInts(encStrLength);
		objStrListLength := BigIntToListofInts(objStrLength);
		WriteIntasBytes(writer, encStrListLength);
		WriteIntasBytes(writer, objStrListLength);
	else
		WriteByte(writer![1], 12);
		WriteByte(writer![1], encStrLength);
		WriteByte(writer![1], objStrLength);
	fi;
	WriteAll(writer[1], encString);
	WriteAll(writer[1], objString);
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
#M  OMPut( <OMWriter>, <error> )
##
##
##

########################################################################
##
#M  OMPut( <OMWriter>, <reference> )
##
##
##






















#############################################################################
#E
