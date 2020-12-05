/*
--- Part Two ---

While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

Given the same example list from above:

    1-3 a: abcde is valid: position 1 contains a and position 3 does not.
    1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
    2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.

How many passwords are valid according to the new interpretation of the policies?
*/

DEFINE VARIABLE cLetter   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cLine     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cPassword AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i         AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCount    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMax      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMin      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iResult   AS INTEGER     NO-UNDO.

etime(yes).

INPUT FROM C:\User\JCCARDOT\Perso\Travail\aoc\aoc2020\day2.txt.
REPEAT:
    IMPORT UNFORMATTED cLine.
    iMin = INTEGER(ENTRY(1, cLine, "-")).
    iMax = INTEGER(ENTRY(2,ENTRY(1, cLine, " "), "-")).
    cLetter = SUBSTRING(ENTRY(2, cLine, " "), 1, 1).
    cPassword = ENTRY(3, cLine, " ").
    /* iCount = LENGTH(cPassword) - LENGTH(REPLACE(cPassword, cLetter, "")). */
    iResult = iResult + IF (SUBSTRING(cPassword,iMin,1) = cLetter OR SUBSTRING(cPassword,iMax,1) = cLetter) AND SUBSTRING(cPassword,iMin,1) <> SUBSTRING(cPassword,iMax,1) THEN 1 ELSE 0.
END.
INPUT CLOSE.

MESSAGE etime skip iResult
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Information (Press HELP to view stack trace)
---------------------------
50
588
---------------------------
Aceptar   Ayuda   
---------------------------
*/

