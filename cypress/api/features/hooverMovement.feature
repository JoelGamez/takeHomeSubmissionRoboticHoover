Feature: Hoover navigation
#Happy Path Cases --------------------------------------------------
Scenario: Hoover can move north
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 2
  When the movement instructions are "N"
  Then the final hoover position should be 2, 3

Scenario: Hoover can move south
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 2
  When the movement instructions are "S"
  Then the final hoover position should be 2, 1


Scenario: Hoover can move west
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 2
  When the movement instructions are "W"
  Then the final hoover position should be 1, 2

Scenario: Hoover can move east
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 2
  When the movement instructions are "E"
  Then the final hoover position should be 3, 2

Scenario: Hoover can navigate through every coordinate
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  When the movement instructions are "EEEENWWWWNEEEENWWWWNEEEE" 
  Then the final hoover position should be 4, 4

#Edge Cases --------------------------------------------------
Scenario: Hoover moves in valid direction after hitting the wall
  Given the room has dimensions 5 by 5
  And the hoover starts at position 4, 4
  When the movement instructions are "NNWWW"
  Then the final hoover position should be 1, 4

Scenario: Hoover skids in place when moving into a wall
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  When the movement instructions are "SW"
  Then the final hoover position should be 0, 0

Scenario: Hoover rapidly skids against a boundary
  Given the room has dimensions 5 by 5
  And the hoover starts at position 4, 4
  When the movement instructions are "NNNNNNNNNN"
  Then the final hoover position should be 4, 4

Scenario: Hoover can start on a boundary and move in valid directions
  Given the room has dimensions 5 by 5
  And the hoover starts at position 4, 4
  When the movement instructions are "SSEW"
  Then the final hoover position should be 3, 2

Scenario: Hoover handles large sets of movement instructions
  Given the room has dimensions 5 by 5
  And the hoover starts at position 0, 0
  When the movement instructions are "NNNNNNEEEEEESSSSSSWWWWWW"
  Then the final hoover position should be 0, 0

Scenario: Hoover stays in place when no instructions are provided
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 2
  When the movement instructions are ""
  Then the final hoover position should be 2, 2

#Error Cases --------------------------------------------------
Scenario: Hoover raises an error with invalid instructions
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, 2
  When the movement instructions are "NNXW"
  Then an error should be raised

Scenario: Hoover raises an error with invalid room dimensions
  Given the room has dimensions C by 5
  And the hoover starts at position 2, 2
  When the movement instructions are "N"
  Then an error should be raised
  
Scenario: Hoover raises an error with invalid starting position
  Given the room has dimensions 5 by 5
  And the hoover starts at position 2, C
  When the movement instructions are "N"
  Then an error should be raised
