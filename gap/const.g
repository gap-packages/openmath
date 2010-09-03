
#temporarily put here to test
#turns an int into a Blist for bitwise comparison operations
toBlist := function(token)
	#ensuring that the string to be converted has 2 hex digits, otherwise the conversion fails
	 local val;
	 val := token;
	 token := HexStringInt(token);
	 if val < 16 then
	 	token := Concatenation("0",token);		
	 fi;
	 return BlistStringDecode(token);
end;



#OMBinary constants


# Flags
BindGlobal("FLAG_STATUS",toBlist(32));
BindGlobal("FLAG_ID",toBlist(64));
BindGlobal("FLAG_LONG",toBlist(128));
# Bit-masks
BindGlobal("TYPE_MASK",toBlist( 31));
BindGlobal("MASK_SIGN_POS",toBlist( 43)); # 0x2b "+"
BindGlobal("MASK_SIGN_NEG",toBlist( 45)); # 0x2d "-"
BindGlobal("MASK_BASE_10",toBlist(0));
BindGlobal("MASK_BASE_16",toBlist( 64));
BindGlobal("MASK_BASE_256",toBlist( 128));
# Atomic objects
BindGlobal("TYPE_INT_SMALL",toBlist(  1));
BindGlobal("TYPE_INT_BIG",toBlist(  2));
BindGlobal("TYPE_OMFLOAT",toBlist(  3));
BindGlobal("TYPE_BYTES",toBlist(  4));
BindGlobal("TYPE_VARIABLE",toBlist(  5));
BindGlobal("TYPE_STRING_ISO",toBlist(  6));
BindGlobal("TYPE_STRING_UTF",toBlist(  7));
BindGlobal("TYPE_SYMBOL",toBlist(  8));
BindGlobal("TYPE_CDBASE",toBlist(  9));
BindGlobal("TYPE_FOREIGN",toBlist( 12));
# Compound objects
BindGlobal("TYPE_APPLICATION",toBlist( 16));
BindGlobal("TYPE_APPLICATION_END",toBlist( 17));
BindGlobal("TYPE_ATTRIBUTION",toBlist( 18));
BindGlobal("TYPE_ATTRIBUTION_END",toBlist( 19));
BindGlobal("TYPE_ATTRPAIRS",toBlist( 20));
BindGlobal("TYPE_ATTRPAIRS_END",toBlist( 21));
BindGlobal("TYPE_ERROR",toBlist( 22));
BindGlobal("TYPE_ERROR_END",toBlist( 23));
BindGlobal("TYPE_OBJECT",toBlist( 24));
BindGlobal("TYPE_OBJECT_END",toBlist( 25));
BindGlobal("TYPE_BINDING",toBlist( 26));
BindGlobal("TYPE_BINDING_END",toBlist( 27));
BindGlobal("TYPE_BVARS",toBlist( 28));
BindGlobal("TYPE_BVARS_END",toBlist( 29));
# References
BindGlobal("TYPE_REFERENCE_INT",toBlist( 30));
BindGlobal("TYPE_REFERENCE_EXT",toBlist( 31));
# other
BindGlobal("SHIFT_UNIT",8);
BindGlobal("MOST_SIG_MASK",toBlist(240));
BindGlobal("LESS_SIG_MASK",toBlist(15));
BindGlobal("EXP_BIAS", 1023);
BindGlobal("UTF_NOT_SUPP", toBlist(128));

# OM tags
BindGlobal("INT_TAG","OMI");
BindGlobal("STR_TAG","OMSTR");
BindGlobal("FLOAT_TAG", "OMF");
BindGlobal("VAR_TAG", "OMV");
BindGlobal("SYM_TAG", "OMS");
BindGlobal("APP_TAG", "OMA");
BindGlobal("ATP_TAG", "OMATP");
BindGlobal("ATT_TAG", "OMATTR");
BindGlobal("ERR_TAG", "OME");
BindGlobal("BVAR_TAG", "OMBVAR");
BindGlobal("BIND_TAG", "OMBIND");
BindGlobal("REF_TAG", "OMR");
BindGlobal("FOR_TAG", "OMFOREIGN");

DeclareGlobalFunction("GetNextTagObject");
DeclareGlobalFunction("GetNextObject");


