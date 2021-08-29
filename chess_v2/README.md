TODO:
x Create GameController
  x Requires a way to track which player has the active turn
  x Requires a method that takes in a string from the player and interprets it into a move
  x Needs to initiate a board and pieces on the board
  x Needs to initiate moves and update locations accordingly
    x Should check for move validity before moving
    x board.p1/p2_pieces && piece.location
  x Needs to check for win conditions
- Needs to prevent King from moving itself in danger
- Pawn promotes to queen if reaches the end

* GameBoard Object:
  - p1_pieces and p2_pieces may need to be updated to attr_accessor for remove_piece and update_piece_location to function properly

2021-08-29
- Updated location variable on piece to attr_accessor so it can be changed by Controller
- Controller.input_move
  - Will check for move validity
  - Will update piece.location, board.reset_location_marker, board.update_board, board.update_piece_location if move is valid
- Checks for game over condition (the king is dead)

2021-08-28
- Controller.input_move
  - will take in only valid long form notation
  - will convert letter-number from string to location coordinates
  - will initialize all pieces on to the game board
  - will check for a piece at the specified starting location

2021-08-27
- Controller will initialize all 16 game pieces
- Added player piece hash for p1 and p2 to GameBoard
- Added active_player tracker to controller 
- Initiated controller and controller_spec
* Break was due to moving to Canada

2021-08-18
- Updated TODO for GameController object and moved to the top
- Minor optimization done to King movement
  - Does not need break condition since it can only move one in any direction
- Pawn-specific movement added with tests

2021-08-17
- King-specific movement added with tests
- Queen-specific movement added with tests
- Bishop-specific movement added with tests
- Updated tests for new rook methods
  - After talking with the discord server, I got a better understanding of when tests are needed
- Refactored Rook-specific restrictions

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
x Create each different game piece which inherit from Piece
  x Each piece should hold an array of its possible moves
    x Rook
    x Bishop
    x Queen
    x King
    x Knight
    x Pawn
  x Each piece should remove from the array its piece-specific restricted positions
    x Rook should remove squares if boxed in by either player
    x Bishop should remove squares if boxed in by either player
    x Queen should remove squares if boxed in by either player
    x Knight has no meaningful restrictions
    x Pawn can move twice from start position, can only capture diagonally
