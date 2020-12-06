/*
--- Day 6: Custom Customs ---

As your flight approaches the regional airport where you'll switch to a much larger plane, customs declaration forms are distributed to the passengers.

The form asks a series of 26 yes-or-no questions marked a through z. All you need to do is identify the questions for which anyone in your group answers "yes". Since your group is just you, this doesn't take very long.

However, the person sitting next to you seems to be experiencing a language barrier and asks if you can help. For each of the people in their group, you write down the questions for which they answer "yes", one per line. For example:

abcx
abcy
abcz

In this group, there are 6 questions to which anyone answered "yes": a, b, c, x, y, and z. (Duplicate answers to the same question don't count extra; each question counts at most once.)

Another group asks for your help, then another, and eventually you've collected answers from every group on the plane (your puzzle input). Each group's answers are separated by a blank line, and within each group, each person's answers are on a single line. For example:

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

    The first group contains one person who answered "yes" to 3 questions: a, b, and c.
    The second group contains three people; combined, they answered "yes" to 3 questions: a, b, and c.
    The third group contains two people; combined, they answered "yes" to 3 questions: a, b, and c.
    The fourth group contains four people; combined, they answered "yes" to only 1 question, a.
    The last group contains one person who answered "yes" to only 1 question, b.

In this example, the sum of these counts is 3 + 3 + 3 + 1 + 1 = 11.

For each group, count the number of questions to which anyone answered "yes". What is the sum of those counts?
*/

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.     
DEFINE VARIABLE iCount AS INTEGER     NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE lFirst AS LOGICAL     NO-UNDO.
DEFINE VARIABLE cYes AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cQuestion AS CHARACTER   NO-UNDO.

ETIME(YES).

INPUT FROM C:\Work\aoc\aoc2020\day6.txt. /* added one blank line at the end */
REPEAT:
    IMPORT UNFORMATTED cLine NO-ERROR.
    IF cLine = "" THEN DO:
        iCount = iCount + LENGTH(cYes).
        ASSIGN
            lFirst = YES
            cYes = ""
            .
    END.
    ELSE DO:
        IF lFirst THEN DO:
            lFirst = NO.
            cYes = cLine.
        END.
        ELSE DO:
            DO i = LENGTH(cLine) TO 1 BY -1:
                cQuestion = SUBSTRING(cLine,i,1).
                IF INDEX(cYes, cQuestion) = 0 THEN
                    cYes = cYes + cQuestion.
            END.
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
33 
6590
---------------------------
OK   Aide   
---------------------------
*/

