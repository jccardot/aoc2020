/*
--- Day 11: Seating System ---

Your plane lands with plenty of time to spare. The final leg of your journey is a ferry that goes directly to the tropical island where you can finally start your vacation. As you reach the waiting area to board the ferry, you realize you're so early, nobody else has even arrived yet!

By modeling the process people use to choose (or abandon) their seat in the waiting area, you're pretty sure you can predict the best place to sit. You make a quick map of the seat layout (your puzzle input).

The seat layout fits neatly on a grid. Each position is either floor (.), an empty seat (L), or an occupied seat (#). For example, the initial seat layout might look like this:

L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL

Now, you just need to model the people who will be arriving shortly. Fortunately, people are entirely predictable and always follow a simple set of rules. All decisions are based on the number of occupied seats adjacent to a given seat (one of the eight positions immediately up, down, left, right, or diagonal from the seat). The following rules are applied to every seat simultaneously:

    If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
    If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
    Otherwise, the seat's state does not change.

Floor (.) never changes; seats don't move, and nobody sits on the floor.

After one round of these rules, every seat in the example layout becomes occupied:

#.##.##.##
#######.##
#.#.#..#..
####.##.##
#.##.##.##
#.#####.##
..#.#.....
##########
#.######.#
#.#####.##

After a second round, the seats with four or more occupied adjacent seats become empty again:

#.LL.L#.##
#LLLLLL.L#
L.L.L..L..
#LLL.LL.L#
#.LL.LL.LL
#.LLLL#.##
..L.L.....
#LLLLLLLL#
#.LLLLLL.L
#.#LLLL.##

This process continues for three more rounds:

#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##

#.#L.L#.##
#LLL#LL.L#
L.L.L..#..
#LLL.##.L#
#.LL.LL.LL
#.LL#L#.##
..L.L.....
#L#LLLL#L#
#.LLLLLL.L
#.#L#L#.##

#.#L.L#.##
#LLL#LL.L#
L.#.L..#..
#L##.##.L#
#.#L.LL.LL
#.#L#L#.##
..L.L.....
#L#L##L#L#
#.LLLLLL.L
#.#L#L#.##

At this point, something interesting happens: the chaos stabilizes and further applications of these rules cause no seats to change state! Once people stop moving around, you count 37 occupied seats.

Simulate your seating area by applying the seating rules repeatedly until no seats change state. How many seats end up occupied?
*/

DEFINE VARIABLE cLine      AS CHARACTER   NO-UNDO.
/* DEFINE VARIABLE cSeat      AS CHARACTER   EXTENT 8190 NO-UNDO. /* won't work because of error 12371 :( */ */
/* DEFINE VARIABLE cSeatPrev  AS CHARACTER   EXTENT 8190 NO-UNDO. */
/* DEFINE VARIABLE cSeats     AS LONGCHAR    NO-UNDO. */
/* DEFINE VARIABLE cSeatsPrev AS LONGCHAR    NO-UNDO. */
DEFINE VARIABLE cSeat      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cSeats     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cSeatsPrev AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i          AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAdjacent  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCol       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRow       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iSeat      AS INTEGER     INITIAL 1 NO-UNDO.
DEFINE VARIABLE j          AS INTEGER     NO-UNDO.

&GLOBAL-DEFINE rows 90
&GLOBAL-DEFINE cols 91

/* &GLOBAL-DEFINE rows 10 */
/* &GLOBAL-DEFINE cols 10 */

/* ETIME(TRUE). */

INPUT FROM C:\Work\aoc\aoc2020\day11.txt.
/* INPUT FROM C:\Work\aoc\aoc2020\day11-test.txt. */
REPEAT:
    IMPORT UNFORMATTED cLine.
    cSeats = cSeats + cLine.
END.
INPUT CLOSE.

ETIME(YES).

DO WHILE cSeatsPrev <> cSeats:
    cSeatsPrev = cSeats.
    DO iRow = 1 TO {&rows}:
        DO iCol = 1 TO {&cols}:
            iSeat = (iRow - 1) * {&cols} + iCol.
            cSeat = SUBSTRING(cSeatsPrev, iSeat, 1).
            IF cSeat <> "." THEN DO:
                iAdjacent = 0.
                DO i = MAX(1, iRow - 1) TO MIN({&rows}, iRow + 1):
                    DO j = MAX(1, iCol - 1) TO MIN({&cols}, iCol + 1):
                        IF i = iRow AND j = iCol THEN NEXT.
                        IF SUBSTRING(cSeatsPrev, (i - 1) * {&cols} + j, 1) = "#" THEN
                            iAdjacent = iAdjacent + 1.
                    END.
                END.
                IF cSeat = "L" AND iAdjacent = 0 THEN SUBSTRING(cSeats, iSeat, 1) = "#".
                ELSE IF cSeat = "#" AND iAdjacent >= 4 THEN SUBSTRING(cSeats, iSeat, 1) = "L".
            END.
        END.
    END.
    /* MESSAGE STRING(cSeats) VIEW-AS ALERT-BOX INFO BUTTONS OK. */
END.

MESSAGE ETIME SKIP {&cols} * {&rows} - LENGTH(REPLACE(cSeats, "#", ""))
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
24585 
2113
---------------------------
OK   Aide   
---------------------------
*/
