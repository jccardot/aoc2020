/*
--- Part Two ---

To completely determine whether you have enough adapters, you'll need to figure out how many different ways they can be arranged. Every arrangement needs to connect the charging outlet to your device. The previous rules about when adapters can successfully connect still apply.

The first example above (the one that starts with 16, 10, 15) supports the following arrangements:

(0), 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, (22)
(0), 1, 4, 5, 6, 7, 10, 12, 15, 16, 19, (22)
(0), 1, 4, 5, 7, 10, 11, 12, 15, 16, 19, (22)
(0), 1, 4, 5, 7, 10, 12, 15, 16, 19, (22)
(0), 1, 4, 6, 7, 10, 11, 12, 15, 16, 19, (22)
(0), 1, 4, 6, 7, 10, 12, 15, 16, 19, (22)
(0), 1, 4, 7, 10, 11, 12, 15, 16, 19, (22)
(0), 1, 4, 7, 10, 12, 15, 16, 19, (22)

(The charging outlet and your device's built-in adapter are shown in parentheses.) Given the adapters from the first example, the total number of arrangements that connect the charging outlet to your device is 8.

The second example above (the one that starts with 28, 33, 18) has many arrangements. Here are a few:

(0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49, (52)

(0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 49, (52)

(0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
32, 33, 34, 35, 38, 39, 42, 45, 46, 48, 49, (52)

(0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
32, 33, 34, 35, 38, 39, 42, 45, 46, 49, (52)

(0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
32, 33, 34, 35, 38, 39, 42, 45, 47, 48, 49, (52)

(0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
46, 48, 49, (52)

(0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
46, 49, (52)

(0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
47, 48, 49, (52)

(0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
47, 49, (52)

(0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
48, 49, (52)

In total, this set of adapters can connect the charging outlet to your device in 19208 distinct arrangements.

You glance back down at your bag and try to remember why you brought so many adapters; there must be more than a trillion valid ways to arrange them! Surely, there must be an efficient way to count the arrangements.

What is the total number of distinct ways you can arrange the adapters to connect the charging outlet to your device?
*/

DEFINE VARIABLE cLine         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iOnes AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPrevJolts AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPaths AS INT64     NO-UNDO.

DEFINE TEMP-TABLE ttAdapter NO-UNDO LABEL ""
 FIELD iJolts AS INTEGER
 FIELD iDelta AS INTEGER
 INDEX ix iJolts.

/* ETIME(TRUE). */

INPUT FROM C:\Work\aoc\aoc2020\day10.txt.
REPEAT:
    CREATE ttAdapter.
    IMPORT ttAdapter.iJolts.
END.
INPUT CLOSE.
DELETE ttAdapter.

ETIME(YES).

FIND LAST ttAdapter.
iPrevJolts = ttAdapter.iJolts.
CREATE ttAdapter.
ASSIGN ttAdapter.iJolts = iPrevJolts + 3.

iPrevJolts = 0.
FOR EACH ttAdapter:
    ttAdapter.iDelta = ttAdapter.iJolts - iPrevJolts.
    iPrevJolts = ttAdapter.iJolts.
END.

iPaths = 1.
FOR EACH ttAdapter:
    IF ttAdapter.iDelta = 1 THEN
        iOnes = iOnes + 1.
    ELSE IF iOnes > 0 THEN DO:
        CASE iOnes:
            WHEN 1 THEN .
            WHEN 2 THEN iPaths = iPaths * 2.
            WHEN 3 THEN iPaths = iPaths * 4.
            WHEN 4 THEN iPaths = iPaths * 7.
            WHEN 5 THEN iPaths = iPaths * 13.
            OTHERWISE MESSAGE "missing gap ratio"
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
        END CASE.
        iOnes = 0.
    END.
END.

MESSAGE ETIME SKIP iPaths
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
1 
6908379398144
---------------------------
OK   Aide   
---------------------------
*/
/*
0 1 2
0 2

0 1 2 3
0 1 3
0 2 3
0 3

0 1 2 3 4
0 1 2 4
0 1 3 4
0 1 4
0 2 3 4
0 2 4
0 3 4

0 1 2 3 4 5
0 1 2 3 5
0 1 2 4 5
0 1 2 5
0 1 3 4 5
0 1 3 5
0 1 4 5
0 2 3 4 5
0 2 3 5
0 2 4 5
0 2 5
0 3 4 5
0 3 5

1-1
2-1
3-1  4
6-3
9-3
10-1
11-1
12-1 4
15-3
16-1
17-1 2
20-3
23-3
26-3
27-1
28-1
29-1 4
30-1   7
33-3
34-1
35-1
36-1 4
39-3
40-1
41-1
42-1 4
43-1   7
46-3
47-1
48-1
49-1 4
52-3
53-1
54-1
55-1 4
58-3
61-3
62-1
63-1
64-1 4
67-3
68-1
71-3
72-1
73-1
74-1 4
77-3
78-1
79-1
80-1 4
81-1   7
84-3
85-1
86-1
87-1 4
88-1   7
91-3
92-1
93-1 2
96-3
97-1
98-1 2
101-3
102-1
103-1
104-1 4
107-3
108-1
109-1
110-1 4
111-1   7
114-3
115-1
116-1
117-1 4
120-3
123-3
126-3
129-3
132-3
133-1
134-1
135-1 4
136-1   7
139-3
142-3
145-3
146-1
147-1
148-1 4
151-3
154-3
155-1
156-1
157-1 4
158-1   7
161-3
*/
/*
MESSAGE 4 * 4 * 2 * 7 * 4 * 7 * 4 * 4 * 4 * 4 * 7 * 7 * 2 * 2 * 4 * 7 * 4 * 7 * 4 * 7
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
6908379398144
*/

