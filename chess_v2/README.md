2021-08-16
- TDD Done for Rook
- All named pieces initialize with proper marker
- Piece: Finished tests for valid_move? boolean method

2021-08-15 
- Piece: Added boolean move to test for move validity
- Piece: Added method to adjust for piece specific restrictions (none for default piece object)
- Piece: Added method to remove any square containing ally pieces
- Piece: Added method to remove invalid board positions from possible move array
- Piece: Added method to add start location to the piece's possible moves
- Piece: Added method to return board state to GameBoard

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
x Create each different game piece which inherit from Piece
  - Each piece should hold an array of its possible moves
    x Rook
    - Bishop
    - Queen
    - King
    x Knight
    - Pawn
  - Each piece should remove from the array its piece-specific restricted positions
    - Rook should remove squares if boxed in by either player
    - Bishop should remove squares if boxed in by either player
    - Queen should remove squares if boxed in by either player
    - King cannot put itself in danger
    x Knight has no meaningful restrictions
    - Pawn can move twice from start position, can only capture diagonally
- Create a method that takes in a string from the player and interprets it into a move

* GameBoard Object:
  - p1_pieces and p2_pieces may need to be updated to attr_accessor for remove_piece and update_piece_location to function properly
* If Boolean for move validity returns true: (in game logic, not in object)
  - Call Update board methods for start and finish locations


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
x Create Piece object
  x Initialize with player, location
  x Boolean method to check validity of a move(start, end)
  x Method to add the start location to array of all possible moves
  x Method to remove any square with player's own pieces in it
  x Method to remove any coordinates that aren't on the board (position greater than 8 or less than 1)
  x Method to be replaced with piece-specific restrictions
  x Method to move(start, end)
