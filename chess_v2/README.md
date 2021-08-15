2021-08-15 
- Added method to return board state to GameBoard

2021-08-14
- Piece and piece_spec established
- GameBoard has a method to update the location of a piece in the player hash
- GameBoard has a method to update the display contents depending on piece
- GameBoard has a method to reset the display contents for drawing
- GameBoard has a method to remove a piece from a player's hash
- GameBoard has methods to draw each row and to draw the game
- GameBoard will initialize with board array and 2 hashes
- Thought through game loop and necessary functionality
- Established directory for chess_v2

TODO:
- Create Piece object
  x Initialize with player, location
  - Boolean method to check validity of a move(start, end)
    - Start with an array of all possible moves
    - Add the start location to this array
    - Remove any square with player's own pieces in it
    - Remove any coordinates that aren't on the board (position greater than 8 or less than 1)
    - Remove any piece-specific restricted positions
      - Bishop/Rook/Queen should remove squares if boxed in by either player
      - King cannot put itself in danger
      - Pawn can move twice from start position, can only capture diagonally
  x Method to move(start, end)
    *-* If Boolean above returns true: (in game logic, not in object)
      - Call Update board methods for start and finish locations
- Create each different game piece which inherit from Piece
  - Each piece type should hold an array of its possible moves and this_piece_restrictions
    - Knight
    - Rook
    - Bishop
    - Queen
    - King
    - Pawn
- Create a method that takes in a string from the player and interprets it into a move
* GameBoard Object:
  - p1_pieces and p2_pieces may need to be updated to attr_accessor for remove_piece and update_piece_location to function properly

Chess Game Loop:
1) Choose a piece to move
   - Is there a piece at this location?
   - Does that piece belong to the current player?
2) Choose a location to move to
   - Is the chosen piece allowed to move here?
   - Is there a piece at the location already?
     - Which player owns that piece?
3) Place the piece at the new location
   - Update the board to include the piece at the location
4) Remove piece from the old position
   - Update the board so the starting position is now empty
5) Change player
6) Repeat 1-5 until winner is declared

COMPLETE
x Create game board
  x Array of 8 Arrays with 8 positions each
  x Hash to store the remaining pieces for each player (key: piece name, value: location)
  x Method to draw the board
  x Method to remove piece from the hash
  x Method to update the game board
  x Method to update the hash for a piece's new location
