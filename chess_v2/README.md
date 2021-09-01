2021-09-01 Post Mortem
- Chess turned out to be much more difficult that I had originally anticipated for a couple of reasons. The first major reason why this was the case is that I tried to reuse code from the Knights Travails project, despite having learned a lot between the end of that project and the start of Chess. I tried to shoehorn a lot from that project into chess in an effort to DRY, but I ended up throwing the original project away to start fresh. I learned a lot from the process of throwing away and starting again, especially when I came across points that I knew should work a different way - a different way that I ultimately ended up implementing.
- When I started v2, I spent some extra time outlining what needs to be done for a chess game to work. The main points being a chess board to play on, a piece object that would determing movement, individual pieces that implement specific piece movement rules which inherit from Piece, and a controller to maintain game state as well as control player input for movement. I set out to implement all of this and it went relatively smoothly until I needed to take a 10 day break to move from Brazil to Canada. After this break, coming back to my code was confusing. I had lost all of my familiarity with the codebase and though I could sit and read everything to understand it (and debug it) I had lost a lot of the enthusiasm through momentum that I had accumulated by creating the game from scratch. I would find more places that I wish I had done differently, where changing the implementation was breaking the TDD I had done up until that point (things like adding an argument to the method aren't so easily worked around). 
- I learned a lot about planning and implementation and finally got a great grasp on TDD through the first half of my work on this project, but the loss of momentum has been quite disheartening. I have completed the project: there is a game loop which functions as you would expect it to except for a lack of castle, pawn promotion, and check. The game plays and while I know that I could implement these last few things as well as clean up the game loop and controller portions of the code, I need to step away from chess and (like many projects before it) come back to it at a later date with more knowledge and understanding. I know that this was a incredible learning experience, but after reaching 80-90% complete I'm sure that moving forward and coming back later will be much more fruitful than continuing to implement the finer aspects of this implementation of chess.

2021-08-31
- Fixed bug where pieces weren't being removed from player hash when removed from game
- Main game loop completed
- Fixed bug where Player 2 couldn't move pieces in the back row
- Added explanation to the introduction about the current limitations of the game.

2021-08-30
- Started writing game loop
- Initiated main.rb
- input_move now only accepts moves if the desired piece is at the start location
- Used Marshall to make a deep copy of @moves_array to prevent it from mutating

2021-08-29
- BUG: piece movement arrays are returning incorrectly
  - new end location not being updated correctly?
  - Seems like @moves_array is mutating somewhere...
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
x Create GameController
  x Requires a way to track which player has the active turn
  x Requires a method that takes in a string from the player and interprets it into a move
  x Needs to initiate a board and pieces on the board
  x Needs to initiate moves and update locations accordingly
    - Needs to restrict string based on piece type
    x Should check for move validity before moving
    x board.p1/p2_pieces && piece.location
  x Needs to check for win conditions
x Create game loop in main.rb
x Create game description and how to play instructions

TODO:
- Create save/load function
- Needs to prevent King from moving itself in danger
- Pawn promotes to queen if reaches the end
