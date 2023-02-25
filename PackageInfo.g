###########################################################################
##
#W    PackageInfo.g            OpenMath Package            Marco Costantini
##                                                       Olexandr Konovalov
##                                                              Max Nicosia
##                                                           Andrew Solomon
##
#Y    Copyright (C) 1999, 2000, 2001, 2006, 2007-2011
#Y    School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y    Copyright (C) 2004, 2005, 2006 Marco Costantini
##
##    PackageInfo.g file
##
SetPackageInfo( rec(
PackageName := "OpenMath",
Subtitle := "OpenMath functionality in GAP",

Version := "11.5.3",
Date := "25/02/2023", # dd/mm/yyyy format
License := "GPL-2.0-or-later",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "11.5.3">
##  <!ENTITY RELEASEDATE "25 February 2023">
##  <!ENTITY RELEASEYEAR "2023">
##  <#/GAPDoc>

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", LowercaseString(~.PackageName) ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://gap-packages.github.io/", LowercaseString(~.PackageName) ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),
ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Costantini",
    FirstNames    := "Marco",
    IsAuthor      := true,
    IsMaintainer  := false
  ),
 
  rec(
    LastName      := "Konovalov",
    FirstNames    := "Olexandr",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "obk1@st-andrews.ac.uk",
    WWWHome       := "https://olexandr-konovalov.github.io/",
    PostalAddress := Concatenation( [
                     "School of Computer Science\n",
                     "University of St Andrews\n",
                     "Jack Cole Building, North Haugh,\n",
                     "St Andrews, Fife, KY16 9SX, Scotland" ] ),
    Place         := "St Andrews",
    Institution   := "University of St Andrews"
  ),  
  
  rec(
    LastName      := "Nicosia",
    FirstNames    := "Max",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "lmn27@cam.ac.uk",
    WWWHome       := "http://www-edc.eng.cam.ac.uk/~lmn27/",
    PostalAddress := Concatenation( [
                     "University of Cambridge\n",
                     "Department of Engineering\n",
                     "Engineering Design Centre\n",
                     "Intelligent Interactive Systems Group\n",
                     "Trumpington Street, Cambridge, CB2 1PZ, UK" ] ),
    Place         := "St Andrews",
    Institution   := "University of St Andrews"
  ),   
  
  rec(
    LastName      := "Solomon",
    FirstNames    := "Andrew",
    IsAuthor      := true,
    IsMaintainer  := false,
    PostalAddress := Concatenation( [
    "Faculty of IT\n",
    "University of Technology, Sydney\n",
    "Broadway, NSW 2007\n",
    "Australia" ] ),
    Institution   := "Faculty of Information Technology, University of Technology, Sydney."
  ),
],

Status := "accepted",
CommunicatedBy := "David Joyner (Annapolis)",
AcceptDate := "08/2010",

AbstractHTML := 

"This package provides an <a href=\"http://www.openmath.org/\">OpenMath</a> \
phrasebook for <span class=\"pkgname\">GAP</span>. \
This package allows <span class=\"pkgname\">GAP</span> users to import \
and export mathematical objects encoded in OpenMath, for the purpose of \
exchanging them with other applications that are OpenMath enabled.",

PackageDoc := rec(
  BookName  := "OpenMath",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "OpenMath functionality in GAP",
  Autoload  := true
),

Dependencies := rec(
  GAP := " >= 4.9.0",
  # Needed packages:
  # GapDoc provides the function ParseTreeXMLString
  # IO is needed to generate random string from really random source 
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.6.0" ],
                           [ "IO", ">= 4.5.1" ] ],  
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

Autoload := false,

TestFile := "tst/testall.g",

Keywords := [ "OpenMath", "Phrasebook" ]

));


#############################################################################
#E
