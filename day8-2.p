/*
--- Part Two ---

After some careful analysis, you believe that exactly one instruction is corrupted.

Somewhere in the program, either a jmp is supposed to be a nop, or a nop is supposed to be a jmp. (No acc instructions were harmed in the corruption of this boot code.)

The program is supposed to terminate by attempting to execute an instruction immediately after the last instruction in the file. By changing exactly one jmp or nop, you can repair the boot code and make it terminate correctly.

For example, consider the same program from above:

nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6

If you change the first instruction from nop +0 to jmp +0, it would create a single-instruction infinite loop, never leaving that instruction. If you change almost any of the jmp instructions, the program will still eventually find another jmp instruction and loop forever.

However, if you change the second-to-last instruction (from jmp -4 to nop -4), the program terminates! The instructions are visited in this order:

nop +0  | 1
acc +1  | 2
jmp +4  | 3
acc +3  |
jmp -3  |
acc -99 |
acc +1  | 4
nop -4  | 5
acc +6  | 6

After the last instruction (acc +6), the program terminates by attempting to run the instruction below the last instruction in the file. With this change, after the program terminates, the accumulator contains the value 8 (acc +1, acc +1, acc +6).

Fix the program so that it terminates normally by changing exactly one jmp (to nop) or nop (to jmp). What is the value of the accumulator after the program terminates?
*/

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iLine AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAccumulator AS INTEGER     NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE cPrevInstruction AS CHARACTER   NO-UNDO.

DEFINE TEMP-TABLE ttMemory NO-UNDO LABEL ""
 FIELD iAddress AS INTEGER
 FIELD cInstruction AS CHARACTER
 FIELD iArgument AS INTEGER
 FIELD lExecuted AS LOGICAL
 INDEX ix IS PRIMARY iAddress
 INDEX ie lExecuted.

DEFINE BUFFER bttMemory FOR ttMemory.

INPUT FROM C:\Work\aoc\aoc2020\day8.txt.
REPEAT:
    IMPORT UNFORMATTED cLine.
    iLine = iLine + 1.
    CREATE ttMemory.
    ASSIGN ttMemory.iAddress     = iLine
           ttMemory.cInstruction = ENTRY(1, cLine, " ")
           ttMemory.iArgument    = INTEGER(ENTRY(2, cLine, " ")).
END.
INPUT CLOSE.

FUNCTION runProg RETURNS LOGICAL ( ):
    DEFINE VARIABLE iLine AS INTEGER     NO-UNDO.
    DEFINE BUFFER ttMemory FOR ttMemory.
    ASSIGN
        iAccumulator = 0
        iLine = 1.
    DO WHILE TRUE:
        FIND ttMemory WHERE ttMemory.iAddress = iLine NO-ERROR.
        IF ERROR-STATUS:ERROR OR ttMemory.lExecuted THEN LEAVE.
        CASE ttMemory.cInstruction:
            WHEN "acc" THEN ASSIGN
                iAccumulator = iAccumulator + ttMemory.iArgument
                iLine = iLine + 1.
            WHEN "jmp" THEN
                iLine = iLine + ttMemory.iArgument.
            WHEN "nop" THEN
                iLine = iLine + 1.
        END CASE.
        ttMemory.lExecuted = YES.
    END.
    RETURN NOT AVAILABLE ttMemory. /* Yes if we reach the end */
END FUNCTION.

ETIME(TRUE).

DEFINE VARIABLE iRuns AS INTEGER     NO-UNDO.

FOR EACH ttMemory:
    cPrevInstruction = "".
    IF ttMemory.cInstruction = "nop" THEN ASSIGN
        cPrevInstruction = ttMemory.cInstruction
        ttMemory.cInstruction = "jmp".
    ELSE IF ttMemory.cInstruction = "jmp" THEN ASSIGN
        cPrevInstruction = ttMemory.cInstruction
        ttMemory.cInstruction = "nop".
    iRuns = iRuns + 1.
    IF runProg() THEN LEAVE.
    IF cPrevInstruction > "" THEN
        ttMemory.cInstruction = cPrevInstruction.
    REPEAT PRESELECT bttMemory WHERE bttMemory.lExecuted = YES.
        FIND NEXT bttMemory.
        bttMemory.lExecuted = NO.
    END.
END.

MESSAGE etime skip iAccumulator iRuns AVAILABLE ttMemory
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
2379 
1319 408 yes
---------------------------
OK   Aide   
---------------------------
*/
