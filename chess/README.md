TODO
- Create Pawn
- Create Rook
- Create Bishop
- Create Queen
- Create King

note: will need to convert movement to consider array drawing (invert and consider 0)

2021-08-07
- Added player correction method to remove nodes which have player's own pieces at the target location

2021-08-06
- Work done on Pawn object, working on check_validity
  - Need to add control for player/direction to valid_moves(?)
- Added init_pawns to ChessBoard
  - Tests written
- Added Pawn method to ChessNode
  - Tests written
- Refactored Knight class to move a knight piece on the chess board
  - Tests established for these methods
- Refactored Knight class methods to find valid move locations
  - Tests established for these methods
- Created tests for ChessNode object
- Separated ChessNode from chessboard.rb
- Created tests for ChessBoard object

2021-08-04
- Refactored chessboard.rb to create an array of arrays filled with ChessNodes
  - Solved an issue where 1 ChessNode was being duplicated across the whole array
- Created TODO overview for project

2021-08-03
- Copied chessboard.rb and knight.rb from knights_travails project
- Initialized directory for Chess