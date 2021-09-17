# CS413-Project1

## Room Flow

* Skyler Hanson (swh65)
* Kyler Carling (kjc472)
* Robert Bednarek (rab587)

## Instructions

RoomFlow contains puzzles representing the floor plan of a house. Tiles can be moved around by clicking on an arrow on the
side of the house, which cause all the tiles in the corresponding row or column to move in that direction, with tiles wrapping back 
around after leaving the house. The goal of the game is to find a layout in which every room may be accessed by a route from the
front door, no doors lead to the outside except at the designated front door spot, and no wall has more than one door attached
to it in between rooms.

## Known Bugs or Issues

The movement animations of tiles are not always consistent, with some occasionally layering over one another. Additionally, rapid 
clicks by the player will cause the tiles to be derailed.

isSolved is known to occasionally produce a bug which gives the player an early victory, or sometimes fails to correctly detect a solved puzzle

## Credits

* Skyler Hanson: Created sprites for rooms and exterior, created music, created piece movement animations and logic
* Kyler Carling: Created sprites for GUI arrows, created function for checking if puzzle is solved
* Robert Bednarek: Created sprites for menu, tutorial, and win screens, created animations for menu screen, added code for navigating between screens
