/*
--- Part Two ---

Ding! The "fasten seat belt" signs have turned on. Time to find your seat.

It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.

Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.

What is the ID of your seat?
*/

/* F:0, B:1 - R:1, L:0 */

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.     
DEFINE VARIABLE iCol AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRow AS INTEGER   NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMax AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttSeat NO-UNDO LABEL ""
 FIELD iRow AS INTEGER
 FIELD iCol AS INTEGER
 FIELD lUsed AS LOGICAL
 INDEX irc iRow iCol
 INDEX iu lUsed.

etime(yes).

DO iRow = 0 TO 127:
    DO iCol = 0 TO 7:
        CREATE ttSeat.
        ASSIGN ttSeat.iRow = iRow
               ttSeat.iCol = iCol.
    END.
END.

INPUT FROM C:\Work\aoc\aoc2020\day5.txt. /* added one blank line at the end */
REPEAT:
    IMPORT UNFORMATTED cLine NO-ERROR.
    ASSIGN
        iRow = 0
        iCol = 0.
    DO i = 0 TO 6:
        IF SUBSTRING(cLine, 7 - i, 1) = "B" THEN
            iRow = iRow +  EXP(2, i).
    END.
    DO i = 0 TO 2:
        IF SUBSTRING(cLine, 10 - i, 1) = "R" THEN
            iCol = iCol +  EXP(2, i).
    END.
    iMax = MAXIMUM(iMax, iRow * 8 + iCol).
    FIND ttSeat WHERE ttSeat.iRow = iRow AND ttSeat.iCol = iCol.
    ttSeat.lUsed = YES.
END.
INPUT CLOSE.

FIND ttSeat WHERE ttSeat.iRow > 8 AND ttSeat.iRow < 120 AND ttSeat.lUsed = NO.

MESSAGE etime skip ttSeat.iRow * 8 + ttSeat.iCol
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
42 
587
---------------------------
OK   Aide   
---------------------------
*/

