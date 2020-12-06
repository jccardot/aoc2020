/*
--- Part Two ---

As you finish the last group's customs declaration, you notice that you misread one word in the instructions:

You don't need to identify the questions to which anyone answered "yes"; you need to identify the questions to which everyone answered "yes"!

Using the same example as above:

abc

a
b
c

ab
ac

a
a
a
a

b

This list represents answers from five groups:

    In the first group, everyone (all 1 person) answered "yes" to 3 questions: a, b, and c.
    In the second group, there is no question to which everyone answered "yes".
    In the third group, everyone answered yes to only 1 question, a. Since some people did not answer "yes" to b or c, they don't count.
    In the fourth group, everyone answered yes to only 1 question, a.
    In the fifth group, everyone (all 1 person) answered "yes" to 1 question, b.

In this example, the sum of these counts is 3 + 0 + 1 + 1 + 1 = 6.

For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?
*/

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.     
DEFINE VARIABLE iCount AS INTEGER     NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE cQuestion AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iLines AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttQuestion NO-UNDO LABEL ""
 FIELD cQuestion AS CHARACTER
 FIELD iCount AS INTEGER
 INDEX ic iCount.

ETIME(YES).

INPUT FROM C:\Work\aoc\aoc2020\day6.txt. /* added one blank line at the end */
REPEAT:
    IMPORT UNFORMATTED cLine NO-ERROR.
    IF cLine = "" THEN DO:
        FOR EACH ttQuestion WHERE ttQuestion.iCount = iLines:
            iCount = iCount + 1.
        END.
        iLines = 0.
        EMPTY TEMP-TABLE ttQuestion.
    END.
    ELSE DO:
        iLines = iLines + 1.
        DO i = LENGTH(cLine) TO 1 BY -1:
            cQuestion = SUBSTRING(cLine,i,1).
            FIND ttQuestion WHERE ttQuestion.cQuestion = cQuestion NO-ERROR.
            IF NOT AVAILABLE ttQuestion THEN DO:
                CREATE ttQuestion.
                ASSIGN ttQuestion.cQuestion = cQuestion.
            END.
            ttQuestion.iCount = ttQuestion.iCount + 1.
        END.
    END.
END.
INPUT CLOSE.

MESSAGE etime skip iCount
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
422 
3288
---------------------------
OK   Aide   
---------------------------
*/

