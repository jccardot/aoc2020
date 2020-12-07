/*
--- Part Two ---

It's getting pretty expensive to fly these days - not because of ticket prices, but because of the ridiculous number of bags you need to buy!

Consider again your shiny gold bag and the rules from the above example:

    faded blue bags contain 0 other bags.
    dotted black bags contain 0 other bags.
    vibrant plum bags contain 11 other bags: 5 faded blue bags and 6 dotted black bags.
    dark olive bags contain 7 other bags: 3 faded blue bags and 4 dotted black bags.

So, a single shiny gold bag must contain 1 dark olive bag (and the 7 bags within it) plus 2 vibrant plum bags (and the 11 bags within each of those): 1 + 1*7 + 2 + 2*11 = 32 bags!

Of course, the actual rules have a small chance of going several levels deeper than this example; be sure to count all of the bags, even if the nesting becomes topologically impractical!

Here's another example:

shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.

In this example, a single shiny gold bag must contain 126 other bags.

How many individual bags are required inside your single shiny gold bag?
*/

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE cEntry AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cContainer AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cContained AS CHARACTER   NO-UNDO.

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

FUNCTION howManyBagsInside RETURNS INTEGER ( cColour AS CHARACTER ):
    DEFINE VARIABLE iContained AS INTEGER     NO-UNDO.
    DEFINE BUFFER ttContains FOR ttContains.
    FOR EACH ttContains WHERE ttContains.cContainer = cColour:
        iContained = iContained + ttContains.iQuantity + ttContains.iQuantity * howManyBagsInside(ttContains.cContained).
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

MESSAGE etime skip howManyBagsInside("shiny gold")
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
82 
85324
---------------------------
OK   Aide   
---------------------------
*/

