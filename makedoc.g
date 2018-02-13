###########################################################################
##
#W    buildman.g             OpenMath Package           Alexander Konovalov
##                                                      
###########################################################################


ExtractMyManualExamples:=function( pkgname, main, files )
local path, tst, i, s, name, output, ch, a;
path:="doc";
Print("Extracting manual examples for ", pkgname, " package ...\n" );
tst:=ExtractExamples( path, main, files, "Chapter" );
Print(Length(tst), " chapters detected\n");
for i in [ 1 .. Length(tst) ] do 
  Print( "Chapter ", i, " : \c" );
  if Length( tst[i] ) > 0 then
    s := String(i);
    if Length(s)=1 then 
      # works for <100 chapters
      s:=Concatenation("0",s); 
    fi;
    name := Filename( Directory( "tst" ), 
                Concatenation( LowercaseString(pkgname), s, ".tst" ) );
    output := OutputTextFile( name, false ); # to empty the file first
    SetPrintFormattingStatus( output, false ); # to avoid line breaks
    ch := tst[i];
    AppendTo(output, "# ", pkgname, ", chapter ",i,"\n");
    for a in ch do
      AppendTo(output, "\n# ",a[2], a[1]);
    od;
    Print("extracted ", Length(ch), " examples \n");
  else
    Print("no examples \n" );    
  fi;  
od;
end;

###########################################################################

OPENMATHMANUALFILES:=[ 
"../PackageInfo.g", 
"../gap/omget.gd",
"../gap/omput.gd",
"../gap/testing.gd" 
];

###########################################################################
##
##  OPENMATHBuildManual()
##
OPENMATHBuildManual:=function()
local mypath, path, main, files, f, bookname;
path:="doc";
main:="manual.xml";
bookname:="openmath";
MakeGAPDocDoc( path, main, OPENMATHMANUALFILES, bookname, "../../..", "MathJax" );  
CopyHTMLStyleFiles( path );
GAPDocManualLab( "openmath" );; 
ExtractMyManualExamples( "openmath", main, OPENMATHMANUALFILES);
end;


###########################################################################

OPENMATHBuildManual();

###########################################################################
##
#E
##
