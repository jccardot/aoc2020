/*
--- Part Two ---

As soon as people start to arrive, you realize your mistake. People don't just care about adjacent seats - they care about the first seat they can see in each of those eight directions!

Now, instead of considering just the eight immediately adjacent seats, consider the first seat in each of those eight directions. For example, the empty seat below would see eight occupied seats:

.......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#.....

The leftmost empty seat below would only see one empty seat, but cannot see any of the occupied ones:

.............
.L.L.#.#.#.#.
.............

The empty seat below would see no occupied seats:

.##.##.
#.#.#.#
##...##
...L...
##...##
#.#.#.#
.##.##.

Also, people seem to be more tolerant than you expected: it now takes five or more visible occupied seats for an occupied seat to become empty (rather than four or more from the previous rules). The other rules still apply: empty seats that see no occupied seats become occupied, seats matching no rule don't change, and floor never changes.

Given the same starting layout as above, these new rules cause the seating area to shift around as follows:

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

#.LL.LL.L#
#LLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLL#
#.LLLLLL.L
#.LLLLL.L#

#.L#.##.L#
#L#####.LL
L.#.#..#..
##L#.##.##
#.##.#L.##
#.#####.#L
..#.#.....
LLL####LL#
#.L#####.L
#.L####.L#

#.L#.L#.L#
#LLLLLL.LL
L.L.L..#..
##LL.LL.L#
L.LL.LL.L#
#.LLLLL.LL
..L.L.....
LLLLLLLLL#
#.LLLLL#.L
#.L#LL#.L#

#.L#.L#.L#
#LLLLLL.LL
L.L.L..#..
##L#.#L.L#
L.L#.#L.L#
#.L####.LL
..#.#.....
LLL###LLL#
#.LLLLL#.L
#.L#LL#.L#

#.L#.L#.L#
#LLLLLL.LL
L.L.L..#..
##L#.#L.L#
L.L#.LL.L#
#.LLLL#.LL
..#.L.....
LLL###LLL#
#.LLLLL#.L
#.L#LL#.L#

Again, at this point, people stop shifting around and the seating area reaches equilibrium. Once this occurs, you count 26 occupied seats.

Given the new visibility method and the rule change for occupied seats becoming empty, once equilibrium is reached, how many seats end up occupied?
*/

DEFINE VARIABLE cLine      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cSeat      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cSeats     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cSeatsPrev AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iAdjacent  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCol       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRow       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iSeat      AS INTEGER     INITIAL 1 NO-UNDO.

/* &GLOBAL-DEFINE rows 10 */
/* &GLOBAL-DEFINE cols 10 */
/* INPUT FROM C:\Work\aoc\aoc2020\day11-test.txt. */
&GLOBAL-DEFINE rows 90
&GLOBAL-DEFINE cols 91
INPUT FROM C:\Work\aoc\aoc2020\day11.txt.
REPEAT:
    IMPORT UNFORMATTED cLine.
    cSeats = cSeats + cLine.
END.
INPUT CLOSE.

FUNCTION look RETURNS INTEGER ( idx AS INTEGER, idy AS INTEGER ):    
    DEFINE VARIABLE cSeat AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i     AS INTEGER     NO-UNDO.
    DEFINE VARIABLE j     AS INTEGER     NO-UNDO.
    ASSIGN
     i = iRow + idy
     j = iCol + idx.
    DO WHILE j <= {&cols} AND i <= {&rows} AND j >= 1 AND i >= 1:
        cSeat = SUBSTRING(cSeatsPrev, (i - 1) * {&cols} + j, 1).
        IF cSeat = "#" THEN RETURN 1.
        ELSE IF cSeat = "L" THEN RETURN 0.
        ASSIGN
         i = i + idy
         j = j + idx.
    END.
    RETURN 0.
END FUNCTION.

FUNCTION pretty RETURNS CHARACTER ( cmap AS CHARACTER ):    
    DEFINE VARIABLE cpretty AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i       AS INTEGER     INITIAL 1 NO-UNDO.
    DO WHILE i < LENGTH(cmap):
        cpretty = cpretty + "~n" + SUBSTRING(cmap, i, {&cols}).
        i = i + {&cols}.
    END.
    RETURN SUBSTRING(cpretty,2).
END FUNCTION.

ETIME(YES).

/* MESSAGE pretty(cSeats) VIEW-AS ALERT-BOX INFO BUTTONS OK. */

DO WHILE cSeatsPrev <> cSeats:
    cSeatsPrev = cSeats.
    DO iRow = 1 TO {&rows}:
        DO iCol = 1 TO {&cols}:
            iSeat = (iRow - 1) * {&cols} + iCol.
            cSeat = SUBSTRING(cSeatsPrev, iSeat, 1).
            IF cSeat <> "." THEN DO:
                iAdjacent = look(+1,  0)
                          + look(+1, +1)
                          + look( 0, +1)
                          + look(-1, +1)
                          + look(-1, 0)
                          + look(-1, -1)
                          + look( 0, -1)
                          + look(+1, -1).
                IF cSeat = "L" AND iAdjacent = 0 THEN SUBSTRING(cSeats, iSeat, 1) = "#".
                ELSE IF cSeat = "#" AND iAdjacent >= 5 THEN SUBSTRING(cSeats, iSeat, 1) = "L".
            END.
        END.
    END.
    /* MESSAGE pretty(cSeats) VIEW-AS ALERT-BOX INFO BUTTONS OK. */
END.

MESSAGE ETIME SKIP {&cols} * {&rows} - LENGTH(REPLACE(cSeats, "#", ""))
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
36849 
1865 
---------------------------
OK   Aide   
---------------------------
*/
