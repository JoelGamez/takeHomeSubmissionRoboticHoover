Feature: Hoover cleaning

#Happy Path Cases --------------------------------------------------
Scenario: Hoover removes a single patch of dirt
  Given the room has dimensions 5 by 5
  And the hoover starts at position 1, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 1  | 0  |
  When the movement instructions are "E"
  Then the final hoover position should be 2, 0
  And the number of cleaned patches should be 1

#failing scenario - returning 5 instead of 4 | Seems to be returning the number of navigation movements
Scenario: Hoover removes multiple patches of dirt in a horizontal pattern
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 1  | 1  |
    | 2  | 1  |
    | 3  | 1  |
    | 4  | 1  |
  When the movement instructions are "NEEEE"
  Then the final hoover position should be 4, 1
  And the number of cleaned patches should be 4

#failing scenario - returning 4 instead of 3
Scenario: Hoover removes multiple patches of dirt in a diagonal pattern
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 1  | 1  |
    | 2  | 2  |
    | 3  | 3  |
  When the movement instructions are "NENENE"
  Then the final hoover position should be 3, 3
  And the number of cleaned patches should be 3

#Edge Cases --------------------------------------------------
#failing scenario - returning 3 instead of 2
Scenario: Hoover removes multiple patches of dirt with gaps in between
  Given the room has dimensions 5 by 5
  And the hoover starts at position 1, 1
  And there are dirt patches at positions:
    | x  | y  |
    | 2  | 1  |
    | 4  | 1  |
  When the movement instructions are "EEEE"
  Then the final hoover position should be 4, 1
  And the number of cleaned patches should be 2

# I have a hunch this scenario is falsely passing
Scenario: Hoover starts on a dirt patch 
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 2  | 0  |
  When the movement instructions are "N"
  Then the final hoover position should be 2, 1
  And the number of cleaned patches should be 1

#failing scenario - returning 2 instead of 1
Scenario: Hoover handles duplicate dirt patches on a single position
  Given the room has dimensions 5 by 5
  And the hoover starts at position 1, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 2  | 2  |
    | 2  | 2  |
  When the movement instructions are "NE"
  Then the final hoover position should be 2, 1
  And the number of cleaned patches should be 1

#failing scenario - returning 1 instead of 0
Scenario: Hoover moves without any dirt patches present
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  And there are dirt patches at positions:
    | x  | y  |
    |     |   |
  When the movement instructions are "NNNNEEEE"
  Then the final hoover position should be 4, 4
  And the number of cleaned patches should be 0

#failing scenario - returning 24 instead of 25 | perhaps missing the initial patch?
Scenario: Hoover cleans a patch on every position in the room
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 0  | 0  |
    | 1  | 0  |
    | 2  | 0  |
    | 3  | 0  |
    | 4  | 0  |
    | 0  | 1  |
    | 1  | 1  |
    | 2  | 1  |
    | 3  | 1  |
    | 4  | 1  |
    | 0  | 2  |
    | 1  | 2  |
    | 2  | 2  |
    | 3  | 2  |
    | 4  | 2  |
    | 0  | 3  |
    | 1  | 3  |
    | 2  | 3  |
    | 3  | 3  |
    | 4  | 3  |
    | 0  | 4  |
    | 1  | 4  |
    | 2  | 4  |
    | 3  | 4  |
    | 4  | 4  |
  When the movement instructions are "EEEENWWWWNEEEENWWWWNEEEE" 
  Then the final hoover position should be 4, 4
  And the number of cleaned patches should be 24

#failing scenario - returning 24 instead of 1 | The patch counter is the number of navigation movements
Scenario: Hoover can clean a patch at the end of room
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  And there are dirt patches at positions:
    | x  | y  |
    | 4  | 4  |
  When the movement instructions are "EEEENWWWWNEEEENWWWWNEEEE" 
  Then the final hoover position should be 4, 4
  And the number of cleaned patches should be 1


#Error Cases --------------------------------------------------
Scenario: Hoover raises an error with invalid patch coordinates
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, C
  And there are dirt patches at positions:
    | x  | y  |
    | B  | 4  |
  When the movement instructions are "N"
  Then an error should be raised