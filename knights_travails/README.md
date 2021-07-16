2021-07-16 Post Mortem
- This was a doosey of a problem. I really tried to solve this one completely on my own but after spending a day trying to make it work using a modified binary search tree algorithm, I decided to scrap that plan and do some research about the specific problem. After researching the problem to see a common solution to finding the distance in the shortest path, I once again tackled the problem on my own.
- The solution I ended up implementing was a modified level-order search algorithm. I first tackled the counter for the number of moves that it would take to reach the destination. This took some time to figure out but once I understood that I couldn't keep a running tally and instead needed to reset the counter based off the number of steps it had taken to reach the current node, I was able to relatively quickly put together the rest of this section of the problem. I could now accurately determine the number of steps between any two nodes in my chess board.
- Next up was to come up with a method for keeping track of the path that was being taken as we traversed to the destination. I quickly realized that I should mimic the same logic that was used for keeping track of the counter. Unfortunately, it took me a long time to realize that there is difference in storing arrays and integers. Arrays are objects, and by pointing a variable to the array I am pointing to its location in memory rather than storing a copy of it. I've come across this problem once before in another problem set, so once I made the realization it was aquick fix and a short journey to the end of the problem; I just wish I had made that realization a little quicker.
- This project will fold nicely into the Chess application at the end of the unit, and so I spent a little extra time here to make sure that I wouldn't have to repeat work in that project. I'm not convinced that it has saved me any time doing so, because I think that working under the constraints that I put myself under to work in this way might have made it a little more difficult to complete the problem but I'm still glad that I did it. 
- I wanted to accomplish a few things with this project: primarily writing clean code and better practice seting up and working with a library of files. I feel like I have done so, though I'm pretty sure there's still room for improvement in the cleanliness of what was written. Looking over my code I can see a few spots that look like there should be a more elegant solution (most notably in the setup of my chess board), but I can't see them yet. Like I've noticed in the past, I think this will be an excellent project to revisit once I've more experience to see where I could've done better. Overall I'm quite pleased with how I was able to solve this problem, including the use of recursion, without looking at code written by other people. I don't think that using peers is a bad thing, but the added challenge of doing this entirely on my own was very satisfying as a learning experience (even if I ended up throwing out an entire days' work). Bring on chess!

2021-07-16
- Knights Travails will now save the shortest path that it takes to find the finish location
- Knights Travails will now recursively find the number of steps it would take to reach any square on the board

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