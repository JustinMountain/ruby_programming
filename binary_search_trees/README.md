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