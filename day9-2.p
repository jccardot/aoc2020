/*
--- Part Two ---

The final step in breaking the XMAS encryption relies on the invalid number you just found: you must find a contiguous set of at least two numbers in your list which sum to the invalid number from step 1.

Again consider the above example:

35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576

In this list, adding up all of the numbers from 15 through 40 produces the invalid number from step 1, 127. (Of course, the contiguous set of numbers in your actual list might be much longer.)

To find the encryption weakness, add together the smallest and largest number in this contiguous range; in this example, these are 15 and 47, producing 62.

What is the encryption weakness in your XMAS-encrypted list of numbers?
*/

DEFINE VARIABLE cLine         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i             AS INTEGER     NO-UNDO.
DEFINE VARIABLE j             AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCurrent      AS INT64       NO-UNDO.
DEFINE VARIABLE iMax          AS INT64       NO-UNDO.
DEFINE VARIABLE iMin          AS INT64       NO-UNDO.
DEFINE VARIABLE iNumber       AS INT64       EXTENT 1000 NO-UNDO.
DEFINE VARIABLE iPos          AS INTEGER     INITIAL 1 NO-UNDO.
DEFINE VARIABLE iSum          AS INT64       NO-UNDO.
DEFINE VARIABLE lFound        AS LOGICAL     NO-UNDO.
DEFINE VARIABLE lInitializing AS LOGICAL     INITIAL TRUE NO-UNDO.

/* ETIME(TRUE). */

INPUT FROM C:\Work\aoc\aoc2020\day9.txt.
REPEAT:
    IMPORT UNFORMATTED cLine.
    iNumber[iPos] = INT64(cLine).
    iPos = iPos + 1.
END.
INPUT CLOSE.

DO iPos = 26 TO 1000:
    lFound = NO.
    blkSearch:
    DO i = 1 TO 25:
        DO j = i TO 25:
            IF iNumber[iPos - i] + iNumber[iPos - j] = iNumber[iPos] THEN DO:
                lFound = YES.
                LEAVE blkSearch.
            END.
        END.
    END.
    IF NOT lFound THEN DO:
        iCurrent = iNumber[iPos].
        LEAVE.
    END.
END.

ETIME(TRUE).

lFound = NO.
DO iPos = 1 TO 1000:
    i = iPos.
    iSum = iNumber[i].
    iMin = iNumber[i].
    iMax = iNumber[i].
    DO WHILE iSum < iCurrent AND i < 1000:
        i = i + 1.
        iSum = iSum + iNumber[i].
        iMin = MINIMUM(iMin, iNumber[i]).
        iMax = MAXIMUM(iMax, iNumber[i]).
    END.
    /* MESSAGE iPos i SKIP iCurrent "=?" iSum VIEW-AS ALERT-BOX INFO BUTTONS OK. */
    IF iSum = iCurrent THEN DO:
        lFound = YES.
        LEAVE.
    END.
END.

MESSAGE etime skip iCurrent SKIP lFound SKIP iMin + iMax
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
295 
14144619 
yes 
1766397
---------------------------
OK   Aide   
---------------------------
*/
