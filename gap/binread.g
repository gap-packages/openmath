##################	TO DO LOG	###########################

#TODO: cdbase

############### Already Tested:
#Small int
#big int b10:OK b256:OK b16:ok isLong flag :OK all
#applications 
#iso strings
# attributions
# symbols
#variables
#binding
#TODO error , they work but gap does not recognise them, although they seem to agree with OM standards
#checking id: ints: 

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


#this function returns the length of the object, reads 4 bytes if long flag is set or 1 if flag is off		
getObjLength := function(isLong, stream)
	local length, i, temp;
	if isLong then 
		i := 4;
		length := ""; 
		temp := "";
		while i > 0 do
			temp := HexStringInt(ReadByte(stream));
			temp := EnsureCompleteHexNum(temp);
			Append(length, temp);
			i:= i -1;
					Print("l:",length, "\n");
			od;
		length := IntHexString(length);

		return length;	
	else 
		return ReadByte(stream);
	fi;
end;
	
#reads all tokens of a given object for the given length and returns a string
readAllTokens := function (length, stream, isUTF16)
	local curByte, stri, out;
	stri := "";
	out := OutputTextString(stri,true);
	while length > 0 do
		curByte := ReadByte(stream);
		WriteByte(out, curByte);
		length := length -1;
		if isUTF16 then
			curByte := toBlist(curByte);
			if UTF_NOT_SUPP = IntersectionBlist(curByte ,UTF_NOT_SUPP) then
				Error("Characted in string not supported\n");	
			fi;
			ReadByte(stream);
		fi;
	od; 
	CloseStream(out);
	return stri;
end;

#read 8 bytes and returns a corresponding blist
readFloatToBlist := function(stream)
	local curByte, temp, bitList, length;
	temp := [];
	bitList :=[];
	length := 8;
	while length > 0 do
		curByte := ReadByte(stream);
		temp := toBlist(curByte); 
		Append(bitList,temp);
		length :=  length -1;
	od; 
	return bitList;
end;
#returns a record that represents a float number in gap
CreateRecordFloat := function(fnumber, idStri)
	fnumber := String(fnumber);
	if idStri <> false then
		return rec( attributes := rec( id:= idStri, dec := fnumber ), name := FLOAT_TAG, content := 0); 
	else
		return rec( attributes := rec( dec := fnumber ), name := FLOAT_TAG, content := 0); 
	fi;
	
end;

#returns a record representing a string 
CreateRecordString := function(stri, idStri)
	if idStri <> false then
		return rec( attributes := rec( id := idStri )  , name := STR_TAG , content := [ rec( content := stri ) ]); 
	else
		return rec( attributes := rec(  )  , name := STR_TAG , content := [ rec( content := stri ) ]); 
	fi;
end;

#returns a record that represents an integer in gap
CreateRecordInt := function(intNumber, sign, idStri)
	local signedNumber;
	signedNumber := "-";
	intNumber := String(intNumber);
	if sign then #if it's negative
		Append(signedNumber,intNumber);
		intNumber := signedNumber;
	fi;
	if idStri <> false then
		return rec( attributes := rec( id := idStri ), name := INT_TAG, content := [ rec( name := "PCDATA", content := intNumber ) ]); 
	else 
		return rec( attributes := rec(  ), name := INT_TAG, content := [ rec( name := "PCDATA", content := intNumber ) ]);
	fi;
end;

#returns a record that represents a variable
CreateRecordVar := function(stri, idStri)
	if idStri <> false then
		return rec( attributes := rec(name := stri,  id := idStri ), name := VAR_TAG, content := 0); 
	else 
		return rec( attributes := rec(name := stri), name := VAR_TAG, content := 0); 
	fi;

end;

#returns a record that represents a symbol
CreateRecordSym := function(stri, cdStri, idStri)
	if idStri <> false then
	  	return rec( attributes := rec( cd := cdStri, name := stri, id := idStri ), name := SYM_TAG, content := 0);
	else
	  	return rec( attributes := rec( cd := cdStri, name := stri ), name := SYM_TAG, content := 0);
	fi;
end;

#return a record that represents an application
CreateRecordApp := function(idStri, objectList)
	if idStri <> false then
		return rec( attributes := rec( id := idStri ), name := APP_TAG, content := objectList); 
	else
		return rec( attributes := rec( ), name := APP_TAG, content := objectList); 
	fi;
end;

CreateRecordAtribution := function(objectList, idStri)
	if idStri <> false then
		return rec( attributes := rec( id := idStri ), name := ATT_TAG, content := objectList); 
	else
		return rec( attributes := rec( ), name := ATT_TAG, content := objectList);
	fi;
end;

CreateRecordAttributePairs := function(objectList, idStri)
	if idStri <> false then
		return rec( attributes := rec( id := idStri ), name := ATP_TAG, content := objectList);
	else
		return rec( attributes := rec( ), name := ATP_TAG, content := objectList);
	fi;
end;

CreateRecordError := function (objectList, idStri)
	if idStri <> false then
		return rec( attributes := rec( id:= idStri ), name := ERR_TAG, content := objectList);
	else 
		return rec( attributes := rec( ), name := ERR_TAG, content := objectList);
	fi;

end;

CreateRecordOMBVar := function(objectList, idStri)
	if idStri <> false then
		return rec( attributes := rec( id:= idStri ), name := BVAR_TAG, content := objectList);
	else 
		return rec( attributes := rec( ), name := BVAR_TAG, content := objectList);
	fi;
end;

CreateRecordBinding := function(objectList, idStri)
	if idStri <> false then
		return rec( attributes := rec( id:= idStri ), name := BIND_TAG, content := objectList);
	else 
		return rec( attributes := rec( ), name := BIND_TAG, content := objectList);
	fi;
end;

CreateRecordReference := function(objectRef, isInternal)
	if isInternal then
		return rec( attributes := rec( id := "inner", href := objectRef ), name := REF_TAG, content := 0); 
	else
		return rec( attributes := rec( id := "outer", href := objectRef ), name := REF_TAG, content := 0); 
	fi;
end;

CreateRecordForeign := function(forStri, encStri, idStri)
	if idStri <> false then
		return rec( attributes := rec( id := idStri, encoding:= encStri )  , name := FOR_TAG , content := [ rec( content := forStri ) ]); 
	else
		return rec( attributes := rec( encoding:= encStri )  , name := FOR_TAG , content := [ rec( content := forStri ) ]); 
	fi;

end;

#CreateRecordCDBase := function(cdStri)
#	return rec( attributes := rec( ), name := ERR_TAG, content := objectList);
#end;

InstallGlobalFunction( GetNextTagObject,
function(stream, isRecursiveCall)
	local omObject, omSymbol, omObject2, token, objLength, sign, isLong, num, i, tempList, 
	      basensign, base, curByte, objectStri, exponent, fraction, hasId, idLength, idStri, idStriAttrPairs, idBVars, cdStri, cdLength, encLength, encStri, objectList, treeObject;
		token := ReadByte(stream);

		token := toBlist(token);
		isLong := false;
		hasId := false;
		# checking if the long and id flag is on
		if FLAG_LONG = IntersectionBlist(token ,FLAG_LONG) then 
			isLong := true;
		fi;
		if FLAG_ID = IntersectionBlist(token ,FLAG_ID) then
			hasId := true;
		fi;
		#checking for streaming flag
		if FLAG_STATUS = IntersectionBlist(token ,FLAG_STATUS) then
			Error("Streaming flag not supported");
		fi;
		#removing bits that could interfere with type distinction
		token := IntersectionBlist(token ,TYPE_MASK);
#################################start standard check for types####################################
		
		if (token = TYPE_INT_SMALL) then
		    Print("Detected TYPE_INT_SMALL \n");
			num := 0;
			idStri := false;
			sign := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				idStri := readAllTokens(idLength, stream, false);	
			fi;
			if isLong then #read 4 bytes
						Print("in long small int\n");
				num:= getObjLength(isLong, stream);
				i := 0;
				if num > 2^31-1 then
					num := 2^32 - num;
					sign := true;
				fi;
			else 
				Print("in small short int\n");
				num := ReadByte(stream);
				if num > 127 then
					num := 256 - num;
					sign := true;
				fi;	
			fi;
			treeObject:= CreateRecordInt(num, sign, idStri);

		
		elif (token = TYPE_INT_BIG) then
			Print("in big int\n");
			num := 0;
			#get length
			objLength := getObjLength(isLong, stream);
			#check for id
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
			fi;

			# get base and sign
			basensign := ReadByte(stream); 
			basensign := toBlist(basensign);
			
			#set the sign
			if (MASK_SIGN_POS = IntersectionBlist(basensign, MASK_SIGN_POS)) then
				sign := false; #negative
			else 
				sign := true; #positive
			fi;
			#get the base
			base := IntersectionBlist(basensign ,(UnionBlist(MASK_BASE_256, MASK_BASE_16)));
			if base = MASK_BASE_256 then
				objectStri := "";
				i := objLength;
				# for all the bytes that compose the number
				while i >0 do
					#read the byte
					curByte := ReadByte(stream);
					#converting the values into hex
					curByte := HexStringInt(curByte);
					#adding the hex digits to the string
					Append(objectStri,curByte);
					i := i -1;
				od;
				num := IntHexString(objectStri);		
			else
				objectStri := readAllTokens(objLength, stream, false);
				#needs to be converted to a b10 before assigning it	
				if base = MASK_BASE_16 then
					num := IntHexString(objectStri);
				else 
				#just assign the integer
					num := objectStri;
					num := EvalString(num);
				fi;
			fi;
			if hasId then
				idStri := readAllTokens(idLength, stream, false);	
			fi;
			treeObject := CreateRecordInt(num, sign, idStri);
		
					
		elif (token = TYPE_OMFLOAT) then
			idStri := false;
			#check for id
			if hasId then
				idStri := "";
				idLength := getObjLength(isLong, stream);
				idStri := readAllTokens(idLength, stream, false);
			fi;
			
			#obtain a blist representation of the float
			tempList := readFloatToBlist(stream);
			#get the sign from the most significant bit
			sign := tempList[1];
			#appending the implicit 1 + 3 false to complete the bytes, this is necessary for HexStringBlist to work correctly
			fraction := [false, false, false, true];
			Append(fraction,tempList{[13..64]});
			#appending 5 false to complete the bytes, this is necessary for HexStringBlist to work correctly
			exponent := [false, false, false, false, false];
			Append(exponent, tempList{[2..12]});

			exponent := HexStringBlist(exponent);
			exponent := IntHexString(exponent);
			fraction := HexStringBlist(fraction);
			fraction := IntHexString(fraction);
			if(sign) then 
				sign := -1; 
			else 
				sign := 1;
			fi;
			num := 	Float(sign*2^(exponent - EXP_BIAS) * fraction*2^-52);
			#call record creator and assign		
			treeObject := CreateRecordFloat(num, idStri);

		elif (token = TYPE_VARIABLE) then
			objectStri := "";
			objLength := getObjLength(isLong, stream);
			idStri := false;			
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				objectStri := readAllTokens(objLength, stream, false);
				idStri := readAllTokens(idLength, stream, false);	
			else
				objectStri := readAllTokens(objLength, stream, false);
			fi;
			treeObject := CreateRecordVar(objectStri, idStri);
		
		
		elif (token = TYPE_SYMBOL) then
			objectStri := "";
			cdStri := "";
			cdLength := getObjLength(isLong, stream);
			objLength := getObjLength(isLong, stream);
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				cdStri := readAllTokens(cdLength, stream, false);
				objectStri := readAllTokens(objLength, stream, false);
				idStri := readAllTokens(idLength, stream, false);	
			else
				cdStri := readAllTokens(cdLength, stream, false);
				objectStri := readAllTokens(objLength, stream, false);
			fi;
			treeObject := CreateRecordSym(objectStri, cdStri, idStri);
		

		elif (token = TYPE_STRING_UTF) then
			#must be twice the length as it is UTF-16 (each char takes 2 bytes, second byte being ignored)
			objLength := getObjLength(isLong, stream);
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				objectStri := readAllTokens(objLength, stream, true);
				idStri := readAllTokens(idLength, stream, false);	
			else
				objectStri := readAllTokens(objLength, stream, true);
			fi;
			treeObject := CreateRecordString(objectStri, idStri);
		
		
		elif (token = TYPE_STRING_ISO) then
			objLength := getObjLength(isLong, stream);
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				objectStri := readAllTokens(objLength, stream, false);
				idStri := readAllTokens(idLength, stream, false);	
			else
				objectStri := readAllTokens(objLength, stream, false);
			fi;	
			treeObject := CreateRecordString(objectStri, idStri);
		

		elif (token = TYPE_BYTES) then
			Error("Gap does not support byte arrays, sorry...");
		

		### FIXME gap does not parse a tree with a foreign tag in....
		if (TYPE_FOREIGN = IntersectionBlist(token, TYPE_FOREIGN)) then
			encLength := getObjLength(isLong, stream);
			objLength := getObjLength(isLong, stream);
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				encStri := readAllTokens(encLength, stream, false);
				objectStri := readAllTokens(objLength, stream, false);
				idStri := readAllTokens(idLength, stream, false);
			else
				encStri := readAllTokens(encLength, stream, false);
				objectStri := readAllTokens(objLength, stream, false);	
			fi;
			treeObject := CreateRecordForeign(objectStri, encStri, idStri);
		fi;

		elif (token = TYPE_APPLICATION) then
			idStri := false;
			objectList := [];
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				idStri := readAllTokens(idLength, stream, false);
			fi;
			i := 0;
			while (true) do
				omObject := GetNextTagObject(stream, true); 
				if omObject = fail then
					break;
				fi;
				Add(objectList, omObject);
				i := i+1;
			od;
			treeObject := CreateRecordApp(idStri, objectList);
		

		elif (token = TYPE_ATTRIBUTION) then
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				idStri := readAllTokens(idLength, stream, false);
			fi;
			token := ReadByte(stream);
			token := toBlist(token);
			isLong := false;
			hasId := false;
			# checking if the long and id flag is on
			if FLAG_LONG = IntersectionBlist(token ,FLAG_LONG) then 
				isLong := true;
			fi;
			if FLAG_ID = IntersectionBlist(token ,FLAG_ID) then
				hasId := true;
			fi;
			#checking for streaming flag
			if FLAG_STATUS = IntersectionBlist(token ,FLAG_STATUS) then
				Error("Streaming flag not supported");
			fi;
			#removing bits that could interfere with type distinction
			token := IntersectionBlist(token ,TYPE_MASK);
			if (token <> TYPE_ATTRPAIRS) then
				Error("Attribution pairs expected");					
			fi;
			#checking if attpairs have id and if isLong 
			idStriAttrPairs := false;
			if(hasId) then 
				idStriAttrPairs := "";
				idLength := getObjLength(isLong, stream);
				idStriAttrPairs := readAllTokens(idLength, stream, false);
			fi;	
				objectList := [];
			#getting pairs till an end token is found
			while (true) do
				omSymbol := GetNextTagObject(stream,true);
				if omSymbol = fail then
					break;
				fi;
				omObject := GetNextTagObject(stream, true);
				Add(objectList, omSymbol);
				Add(objectList, omObject);
			od;
			#creating the attribution pair record
			treeObject := CreateRecordAttributePairs(objectList, idStriAttrPairs);
			#getting the object that is at the end
			omObject2 := GetNextTagObject(stream, true);
			#clearing the list
			objectList := [];
			#adding the pairs and the objects to the list that is to be added to the attribution
			Add(objectList, treeObject);
			Add(objectList, omObject2);
			#creating the final tree
			treeObject := CreateRecordAtribution(objectList, idStri);			
		
			
		elif (token = TYPE_ERROR) then		
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				idStri := readAllTokens(objLength, stream, false);
			fi;
			objectList := [];
			omSymbol := GetNextTagObject(stream, true);
			omObject := GetNextTagObject(stream, true);
			Add(objectList, omSymbol);
			Add(objectList, omObject);
			#creating the final tree
			treeObject := CreateRecordError(objectList, idStri);
		
		
		elif (token = TYPE_BINDING) then
			idStri := false;
			if(hasId) then 
				idStri := "";
				idLength := getObjLength(isLong, stream);
				idStri := readAllTokens(idLength, stream, false);
			fi;
			omSymbol := GetNextTagObject(stream, true);
			token := ReadByte(stream);
			token := toBlist(token);
			isLong := false;
			hasId := false;
			# checking if the long and id flag is on
			if FLAG_LONG = IntersectionBlist(token ,FLAG_LONG) then 
				isLong := true;
			fi;
			if FLAG_ID = IntersectionBlist(token ,FLAG_ID) then
				hasId := true;
			fi;
			#checking for streaming flag
			if FLAG_STATUS = IntersectionBlist(token ,FLAG_STATUS) then
				Error("Streaming flag not supported");
			fi;
			#removing bits that could interfere with type distinction
			token := IntersectionBlist(token ,TYPE_MASK);
			if (token <> TYPE_BVARS) then
				Error("Bvars start byte expected");
			fi;
			#checking if bvars have id and if isLong 
			idBVars := false;
			if(hasId) then 
				idBVars := "";
				idLength := getObjLength(isLong, stream);
				idBVars := readAllTokens(idLength, stream, false);
			fi;
			objectList := [];
			#getting pairs till an end token is found
			while (true) do
				omObject := GetNextTagObject(stream, true);
				if omObject = fail then
					break;
				fi;
				Add(objectList, omObject);
			od;
			treeObject := CreateRecordOMBVar(objectList, idBVars);
			omObject2 := GetNextTagObject(stream, true);
			objectList := [];
			Add(objectList, omSymbol);
			Add(objectList, treeObject);
			Add(objectList, omObject2);
			treeObject := CreateRecordBinding(objectList, idStri);
		
		elif (token = TYPE_REFERENCE_INT) then
			objLength := getObjLength(isLong, stream);
			treeObject := CreateRecordReference(objLength, true);
				
		elif (token = TYPE_REFERENCE_EXT) then
			objLength := getObjLength(isLong, stream);
			objectStri := readAllTokens(objLength, stream, false);
			treeObject := CreateRecordReference(objectStri, false);
		
		elif (token = TYPE_BVARS) then
			Error("Bvars token shouldn't be here'");
		
		elif (token = TYPE_ATTRPAIRS) then
			Error("Attribution pairs token shouldn't be here'");
			#TODO must test this
		elif (token = TYPE_CDBASE) then
			objLength := getObjLength(isLong, stream);
			objectStri := readAllTokens(objLength, stream, false);
			treeObject := GetNextTagObject(stream);
			treeObject.content[1].attributes.cdbase := objectStri;
		
		#END LINE CASES
		elif (token = TYPE_APPLICATION_END) then		
			return fail;
		
		
		elif (token = TYPE_BINDING_END) then		
			return fail;
		
		
		elif (token = TYPE_ATTRIBUTION) then		
			return fail;
		
		
		elif (token = TYPE_ERROR_END) then		
			return fail;
		
		
		elif (token = TYPE_ATTRPAIRS_END) then		
			return fail;	
		
		
		elif (token = TYPE_BVARS_END) then		
			return fail;
		fi;

		#added to allow not removing the end token when called recursively
		if (not isRecursiveCall) then	
			token := ReadByte(stream);
			token := toBlist(token);

		fi;


	return treeObject;	
end);


#gets a whole object, this function calls GetNextTagObject to read all the sub-objects
InstallGlobalFunction( GetNextObject,
function( stream, firstbyte )
	local btoken;
	# firstbyte contains the start token
	btoken := toBlist(firstbyte);
	if (btoken <> TYPE_OBJECT) then 
		Error("Object tag expected");
	fi;
	return GetNextTagObject(stream, false);
end);
		

