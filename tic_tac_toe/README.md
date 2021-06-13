2021-06-12 Post Mortem
- This was a fun project to put together. I was quite happy to start working on some programs of my own, and working through the logic of tic tac toe was a great way to tackle Ruby on my own. 
- I feel like I'm finally getting a better handle on Ruby's syntax. While working through this project, the most difficult thing I encountered was working with variables. I found that I still need a little practice deciding where to initialize variables as well as practice deciding which type of variables I need. I didn't enp up using any modules, either. The whole program was more or less constructed with 3 classes: GameSquare, GameBoard, and GamePlayLoop. I'm not sure if this was the most effectively way to solve the tic tac toe problem, but it's how I did it and it seems to work.
- After reviewing some of the top submissions, I have used a lot more explicit variable naming than maybe was necessary. The top posts also used a lot of different files linked together, which I hadn't thought of (or even now think is terribly necessary outside of practicing that skill). I suppose that I could've declared an array (of possibly variable length), then looped the GameSquares into the array positions, and then checked the array positions for equality to determine win conditions. This would've cut down on the code in a number of places and probably follows the don't repeat yourself mantra better than the solution I came up with. Rather than make any changes to my code, I will use this information moving forward and very specifically in the next assignment. I will try to do more programatic checking than explicit declarations in the Mastermind project. 

2021-06-12
- Minor tweaks and display fixes
- Win conditions setup
- Players now alternate
- Game pieces can be updated for player selection
- Game piece object established and linked to gameboard to populate
- Gameboard drawing object established
- First pass at psuedo code has been written
- Established README.md and tic_tac_toe.rb