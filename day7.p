/*
--- Day 7: Handy Haversacks ---

You land at the regional airport in time for your next flight. In fact, it looks like you'll even have time to grab some food: all flights are currently delayed due to issues in luggage processing.

Due to recent aviation regulations, many rules (your puzzle input) are being enforced about bags and their contents; bags must be color-coded and must contain specific quantities of other color-coded bags. Apparently, nobody responsible for these regulations considered how long they would take to enforce!

For example, consider the following rules:

light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.

These rules specify the required contents for 9 bag types. In this example, every faded blue bag is empty, every vibrant plum bag contains 11 bags (5 faded blue and 6 dotted black), and so on.

You have a shiny gold bag. If you wanted to carry it in at least one other bag, how many different bag colors would be valid for the outermost bag? (In other words: how many colors can, eventually, contain at least one shiny gold bag?)

In the above rules, the following options would be available to you:

    A bright white bag, which can hold your shiny gold bag directly.
    A muted yellow bag, which can hold your shiny gold bag directly, plus some other bags.
    A dark orange bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
    A light red bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.

So, in this example, the number of bag colors that can eventually contain at least one shiny gold bag is 4.

How many bag colors can eventually contain at least one shiny gold bag? (The list of rules is quite long; make sure you get all of it.)
*/

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE cEntry AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cContainer AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cContained AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iCount AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttBag NO-UNDO LABEL ""
 FIELD cColour AS CHARACTER
 FIELD iContained AS INTEGER
 INDEX ix cColour iContained.

DEFINE TEMP-TABLE ttContains NO-UNDO LABEL ""
 FIELD cContainer AS CHARACTER
 FIELD cContained AS CHARACTER
 FIELD iQuantity AS INTEGER
 INDEX ix cContainer cContained.

ETIME(YES).

FUNCTION Bag RETURNS LOGICAL ( cColour AS CHARACTER ):    
    IF CAN-FIND(ttBag WHERE ttBag.cColour = cColour) THEN RETURN FALSE.
    CREATE ttBag.
    ASSIGN ttBag.cColour = cColour.
    RETURN TRUE.
END FUNCTION.

FUNCTION howManyAreInside RETURNS INTEGER ( cBag AS CHARACTER, cColour AS CHARACTER ):
    DEFINE VARIABLE iContained AS INTEGER     NO-UNDO.
    DEFINE BUFFER ttContains FOR ttContains.
    FIND ttContains WHERE ttContains.cContainer = cBag AND ttContains.cContained = cColour NO-ERROR.
    IF AVAILABLE ttContains THEN
        iContained = ttContains.iQuantity.
    FOR EACH ttContains WHERE ttContains.cContainer = cBag:
        iContained = iContained + ttContains.iQuantity * howManyAreInside(ttContains.cContained, cColour).
    END.
    RETURN iContained.
END FUNCTION.

INPUT FROM C:\Work\aoc\aoc2020\day7.txt. /* added one blank line at the end */
REPEAT:
    IMPORT UNFORMATTED cLine.
    cContainer = ENTRY(1,cLine," ") + " " + ENTRY(2,cLine," ").
    Bag(cContainer).
    cLine = RIGHT-TRIM(SUBSTRING(cLine, INDEX(cLine, "contain") + 8), ".").
    IF cLine <> "no other bags" THEN DO i = NUM-ENTRIES(cLine) TO 1 BY -1:
        cEntry = TRIM(ENTRY(i, cLine)).
        cContained = ENTRY(2,cEntry," ") + " " + ENTRY(3,cEntry," ").
        Bag(cContained).
        CREATE ttContains.
        ASSIGN ttContains.cContainer = cContainer
               ttContains.cContained = cContained
               ttContains.iQuantity  = INTEGER(ENTRY(1,cEntry," ")).
    END.
END.
INPUT CLOSE.

FOR EACH ttBag:
    ttBag.iContained = howManyAreInside(ttBag.cColour, "shiny gold").
END.

FOR EACH ttBag WHERE ttBag.iContained > 0:
    iCount = iCount + 1.
END.

MESSAGE etime skip iCount
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
12481 
197
---------------------------
OK   Aide   
---------------------------
*/

