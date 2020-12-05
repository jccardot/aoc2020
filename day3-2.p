/*
--- Part Two ---

Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal stop, after all.

Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:

    Right 1, down 1.
    Right 3, down 1. (This is the slope you already checked.)
    Right 5, down 1.
    Right 7, down 1.
    Right 1, down 2.

In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively; multiplied together, these produce the answer 336.

What do you get if you multiply together the number of trees encountered on each of the listed slopes?
*/

DEFINE TEMP-TABLE ttTerrain NO-UNDO LABEL ""
 FIELD iLine AS INTEGER
 FIELD cPattern AS CHARACTER
 INDEX ix iLine.

DEFINE VARIABLE iCol   AS INTEGER   INITIAL 1 NO-UNDO.
DEFINE VARIABLE iLine  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTrees1 AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTrees2 AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTrees3 AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTrees4 AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTrees5 AS INTEGER   NO-UNDO.

etime(yes).

INPUT FROM C:\User\JCCARDOT\Perso\Travail\aoc\aoc2020\day3.txt.
REPEAT:
    iLine = iLine + 1.
    CREATE ttTerrain.
    ttTerrain.iLine = iLine.
    IMPORT UNFORMATTED ttTerrain.cPattern.
END.
INPUT CLOSE.

iCol = 1.
FOR EACH ttTerrain:
    IF SUBSTRING(ttTerrain.cPattern,iCol,1) = "#" THEN
        iTrees1 = iTrees1 + 1.
    iCol = iCol + 1.
    IF iCol > 31 THEN
        iCol = iCol - 31 /* length(ttTerrain.cPattern) */.
END.

iCol = 1.
FOR EACH ttTerrain:
    IF SUBSTRING(ttTerrain.cPattern,iCol,1) = "#" THEN
        iTrees2 = iTrees2 + 1.
    iCol = iCol + 3.
    IF iCol > 31 THEN
        iCol = iCol - 31 /* length(ttTerrain.cPattern) */.
END.

iCol = 1.
FOR EACH ttTerrain:
    IF SUBSTRING(ttTerrain.cPattern,iCol,1) = "#" THEN
        iTrees3 = iTrees3 + 1.
    iCol = iCol + 5.
    IF iCol > 31 THEN
        iCol = iCol - 31 /* length(ttTerrain.cPattern) */.
END.

iCol = 1.
FOR EACH ttTerrain:
    IF SUBSTRING(ttTerrain.cPattern,iCol,1) = "#" THEN
        iTrees4 = iTrees4 + 1.
    iCol = iCol + 7.
    IF iCol > 31 THEN
        iCol = iCol - 31 /* length(ttTerrain.cPattern) */.
END.

DEFINE VARIABLE lEven AS LOGICAL   INITIAL YES  NO-UNDO.
iCol = 1.
FOR EACH ttTerrain:
    lEven = NOT lEven.
    IF lEven THEN NEXT.
    IF SUBSTRING(ttTerrain.cPattern,iCol,1) = "#" THEN
        iTrees5 = iTrees5 + 1.
    iCol = iCol + 1.
    IF iCol > 31 THEN
        iCol = iCol - 31 /* length(ttTerrain.cPattern) */.
END.

MESSAGE etime skip iTrees1 iTrees2 iTrees3 iTrees4 iTrees5 SKIP iTrees1 * iTrees2 * iTrees3 * iTrees4 * iTrees5
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Information (Press HELP to view stack trace)
---------------------------
28 
61 265 82 70 34 
3154761400
---------------------------
Aceptar   Ayuda   
---------------------------
*/

