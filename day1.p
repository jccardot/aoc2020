/*
--- Day 1: Report Repair ---

After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.

The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.

To save your vacation, you need to get all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.

Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

For example, suppose your expense report contained the following:

1721
979
366
299
675
1456

In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

*/

DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAmount AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttExpense NO-UNDO
  FIELD iSeq AS INTEGER
  FIELD iAmount AS INTEGER
  INDEX ix iSeq.

INPUT FROM C:\User\JCCARDOT\Perso\Travail\aoc\aoc2020\day1.txt.
REPEAT:
    iSeq = iSeq + 1.
    IMPORT iAmount.
	create ttExpense.
	assign ttExpense.iSeq = iSeq
	       ttExpense.iAmount = iAmount.
END.
INPUT CLOSE.

etime(yes).

define buffer bttExpense for ttExpense.
blkSearch:
for each ttExpense:
    for each bttExpense where bttExpense.iSeq > ttExpense.iSeq:
	    if ttExpense.iAmount + bttExpense.iAmount = 2020 then
		    leave blkSearch.
	end.
end.

MESSAGE etime skip ttExpense.iAmount * bttExpense.iAmount
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Information (Press HELP to view stack trace)
---------------------------
13 
1005459
---------------------------
Aceptar   Ayuda   
---------------------------
*/

