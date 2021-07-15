2021-07-15
- Many attempts at creating a modified tree and node like in BST
  - I created what I thought was a logical recursion psuedo code but after much tribulation, I couldn't get it to implement correctly. Instead of continuing to attempt my own code, I will restart tomorrow focusing on creating a graph of all possible moves and utilize A* search or Dijkstra's algorithm

2021-07-14
- Psuedo code written for knights travails pathfinding algorithm
- Minor optimizations to ChessNode to control via ChessNode.method
- Knight class now contains move method which will move the piece around the board
- Knight class now contains moves? method which returns an array of all valid knight moves
- Modified ChessBoard to spawn 8 unique ChessNodes rather than 1 in all 8 positions
- Knight class will now initialize at a specified location, replacing the "piece" and "marker" in the ChessNode at the specified location
- Established separate files for chessboard, knight, and main

2021-07-13
- Chess board can be instantiated and drawn with axis markers and ChessNode placeholders
- Chess Node class created
- Directory and files established for Knights Travails