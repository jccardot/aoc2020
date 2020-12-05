/*
--- Part Two ---

The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

In your expense report, what is the product of the three entries that sum to 2020?

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
define buffer bbttExpense for ttExpense.
blkSearch:
for each ttExpense:
    for each bttExpense where bttExpense.iSeq > ttExpense.iSeq:
        for each bbttExpense where bbttExpense.iSeq > ttExpense.iSeq:
    	    if ttExpense.iAmount + bttExpense.iAmount + bbttExpense.iAmount = 2020 then
    		    leave blkSearch.
        end.
	end.
end.

MESSAGE etime skip ttExpense.iAmount * bttExpense.iAmount * bbttExpense.iAmount
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Information (Press HELP to view stack trace)
---------------------------
5803 
92643264
---------------------------
Aceptar   Ayuda   
---------------------------
*/

