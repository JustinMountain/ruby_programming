2021-07-12 Post Mortem
- This has been another fantastic learning explerience. I feel much more comfortable with implementing recursion and identifying the situations where it is useful to do so. I was abl;e to write my own recursive methods for all of the methods except for 'height.' I had to seek out the assistance of my peers for this particular problem and while I can read and understand what the code is accomplishing, I'm not sure I can see how it came to be. I expect that it's simply a matter of needing more experience with recursion. I understood what was necessary, but my attempts centered around passing a counter through the recursion and adding that to an array, which would return the max value in the base case. I couldn't get it to work properly, which is when I sought out my peers for assistance. 
- Otherwise, I can see that my scripts are becoming quite long and cumbersome to navigate so I will attempt to break up the script into multiple files for the next project. I think this will also result in some excellent practice, because even though I know it is an easy thing to accomplish, it's not something that I've had any real practice with. I expect this to also be a necessary step towards adding complexity to my programs.
- When I first looked at the problem spec I had a hard time understanding what this was supposed to accomplish outside of practice, and while I still can't really see where using these data structures would be useful I'm confident that 1) I wouldn't be asked to do it for no reason and 2) I'm pleased with the practice that it has allowed me to do. I'm very excited to continue forward towards the Chess application, since that is something with tangible applicability, but I'm growing more fond of the practice for practice sakes projects as the programming complexity continues to escalate.

2021-07-12
- Rebalance has been implemented
  - I made sure to .sort!.uniq on the level order array to ensure that the rebalanced tree would be populated correctly
- Balanced? has been implemented
- Height and Depth methods implemented
- Preorder, Inorder, and Postorder recursive traversal methods have been implemented

2021-07-10
- Implemented level_order method that returns an array of values in level order
  - Added case for clearing array if the method is envoked more than once
- Implemented the find method

2021-07-09
- Recursive delete implemented by translating code from C# (iterative approach can be found in history)
  - https://www.geeksforgeeks.org/binary-search-tree-set-2-delete/?ref=lbp
- Found an iterative solution to delete but it doesn't seem right; will investigate recursive solution
- Insert completed
- build_tree will recursively build the BST with an array
- Node and Tree classes established
- Directory and files established