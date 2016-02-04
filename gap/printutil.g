#############################################################################
##  
#W  printutil.g                   GAP4 utility                   Frank Lübeck
##  
#H  @(#)$Id$
##  
#Y  Copyright (C)  2000,  Lehrstuhl D für Mathematik,  RWTH Aachen,  Germany
##  
##  This file contains small utilities  for printing large amounts of data
##  to a file and for viewing large screen output with a pager.
##  
##  Examples of usage:
##  
##  # a fast possibility to write the numbers from 1 to 1000000 into a file:
##  # (of course there are still unwanted line breaks)
##  f := function() local i; for i in [1..1000000] do Print(i); od; end;;
##  PrintTo1("blabla", f); time;                                         
##  
##  # and there is a similar `AppendTo1'.
##  
##  # what `Print' and `View' print, but as a string:
##  PrintString(2^100);
##  ViewString(Group((1,2), (1,2,3)));
##  
##  # for paging through large output  (only with help.g newer than 10/2000)
##  Page(List([1..1000], i-> i^5));
##  PageDisplay(CharacterTable("Symmetric", 12));
##  

Revision.("openmath/gap/printutil.g") :=
    "@(#)$Id$";


#############################################################################
##  
#F  PrintTo1( <stream>, <fun> ) 
#F  AppendTo1( <stream>, <fun> ) . . . . . . . redirect printing into stream
##  
##  <fun> must be a function without argument which does some printing and 
##  returns nothing. With PrintTo1 and AppendTo1 the print output of <fun> 
##  is redirected to stream <stream>. 
##  
##  This function seems to be quite efficient for writing large amounts of
##  small text pieces to a file.
##  
if not IsBound(IsObjToBePrinted) then
  DeclareFilter("IsObjToBePrinted");
  DUMMYTBPTYPE := NewType(NewFamily(""), IsObjToBePrinted); 
  InstallMethod(PrintObj, "", true, [IsObjToBePrinted], 0, 
          function(obj) obj!.f(); end); 
  PrintTo1 := function(file, fun)
    local   obj;
    obj := rec(f := fun);
    Objectify(DUMMYTBPTYPE, obj);
    PrintTo(file, obj);
  end;
  AppendTo1 := function(file, fun)
    local   obj;
    obj := rec(f := fun);
    Objectify(DUMMYTBPTYPE, obj);
    AppendTo(file, obj);
  end;
fi;

#############################################################################
##  
#F  PrintString( <obj> ) . . . . . . . . . the result of Print(obj) as string
#F  ViewString( <obj> ) . . . . . . . . . . the result of View(obj) as string
##  
##  Of course, in general  I would find it better  to have these functions
##  first, such that `Print' and `View' generically just need to print the
##  string.
##  
PrintString := function(obj)
  local   str,  out;
  str := "";
  out := OutputTextString(str, false);
  PrintTo1(out, function() Print(obj); end);
  CloseStream(out);
  return str;
end;


if not IsBound( ViewString )  then
    DeclareOperation( "ViewString", [ IsObject ] );
fi;

InstallMethod( ViewString, "for an object", true, [ IsObject ], 0, function(obj)
  local   str,  out;
  str := "";
  out := OutputTextString(str, false);
  PrintTo1(out, function() View(obj); end);
  CloseStream(out);
  return str;
end  );


#############################################################################
#E

