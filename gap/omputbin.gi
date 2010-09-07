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
BindGlobal( "WriteHexAsBin",
function( hexNum )
local hexNumLen, binStri, num, charStri, counter, binArray;
hexNumLen := Length(hexNum);
binStri := "";
counter:= 1;
binArray := ["0000", "0001" ,"0010", "0011",	"0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"];
while counter <= hexNumLen do
	charStri := hexNum{[counter]};
	num := IntHexString(charStri);
	Append(binStri, binArray[num+1]);
	counter := counter +1;
od;
return binStri;
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
	Print("int 2^31",int,"\n");
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
[ IsOpenMathBinaryWriter, IS_MACFLOAT ],0,
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
	#TODO not finished
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
		WriteByte( writer![1], 5+128);
		varLengthList := BigIntToListofInts(varLength);
		WriteIntasBytes(writer, varLengthList);
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
		Print("string len: ",strLength,"\n");
		WriteByte(writer![1], 6);
#	if strLength > 255 then
#		strListLength := BigIntToListofInts(strLength);	
#		WriteByte(writer![1], 6+128);
#		#writing the string length as 4 bytes
#		WriteIntasBytes(writer, strListLength);
#	else
#		
#		WriteByte(writer![1], strLength);
#	fi;
	WriteAll(writer[1],string);
	Print("end reached\n");
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
   	WriteByte (writer![1], 31+128);
   	lengthList := BigIntToListofInts(refLength);
	WriteIntasBytes(writer, lengthList);
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
