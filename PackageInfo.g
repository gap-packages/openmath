#############################################################################
##
#W    PackageInfo.g       OpenMath Package             Marco Costantini
##
#H    @(#)$Id$
##
#Y    Copyright (C) 1999, 2000, 2001, 2006
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##    PackageInfo.g file
##

Revision.("openmath/PackageInfo.g") :=
    "@(#)$Id$";


SetPackageInfo( rec(
PackageName := "openmath",
Subtitle := "OpenMath functionality in GAP",


Version := "06.03.02",
Date := "02/03/2006",


ArchiveURL := Concatenation([
 "http://www-math.science.unitn.it/~costanti/gap_code/openmath/openmath-",
  ~.Version]),
ArchiveFormats := ".tar.gz",


Persons := [
  rec(
  LastName := "Solomon",
  FirstNames := "Andrew",
  IsAuthor := true,
  IsMaintainer := false,
  Email := "andrew@illywhacker.net",
  WWWHome := "http://www.illywhacker.net/",
  PostalAddress := Concatenation( [
    "Faculty of IT\n",
    "University of Technology, Sydney\n",
    "Broadway, NSW 2007\n",
    "Australia" ] ),
  Institution := "Faculty of Information Technology, University of Technology, Sydney."
 
  ),

  rec(
  LastName := "Costantini",
  FirstNames := "Marco",
  IsAuthor := true,
  IsMaintainer := true,
  Email := "costanti@science.unitn.it",
  WWWHome := "http://www-math.science.unitn.it/~costanti/",
  Place := "Trento",
  Institution := "Department of Mathematics, University of Trento"
  ),

],

Status := "deposited",
#CommunicatedBy := "",
#AcceptDate := "",


README_URL := "http://www-math.science.unitn.it/~costanti/gap_code/openmath/README",
PackageInfoURL :=
 "http://www-math.science.unitn.it/~costanti/gap_code/openmath/PackageInfo.g",


AbstractHTML := 

"This package provides an <a href=\"http://www.openmath.org/\">OpenMath</a> \
phrasebook for <span class=\"pkgname\">GAP</span>. \
This package allows <span class=\"pkgname\">GAP</span> users to import \
and export mathematical objects encoded in OpenMath, for the purpose of \
exchanging them with other applications that are OpenMath enabled.",


PackageWWWHome := "http://www-math.science.unitn.it/~costanti/#openmath",


PackageDoc := rec(
  BookName  := "OpenMath",
  ArchiveURLSubset := ["doc","htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "OpenMath functionality in GAP",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4",
  NeededOtherPackages := [  ],
  SuggestedOtherPackages := [ [ "GapDoc", ">= 0.99" ] ],
  # GapDoc provides the function ParseTreeXMLString
  ExternalConditions := [ "This package can be useful only with other \
applications that support OpenMath" ]
),

AvailabilityTest := ReturnTrue,

Autoload := false,

# the banner
BannerString := 
"OpenMath package, by Andrew Solomon and Marco Costantini\n",


TestFile := "tst/test_new",


Keywords := [ "OpenMath", "OpenMath Phrasebook", "Phrasebook" ]

));


#############################################################################
#E
