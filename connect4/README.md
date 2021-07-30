2021-07-30 Post Mortem
- RSpec is hard. I ghave spent the last two weeks trying to wrap my head around testing and TDD. I get the concept in theory, I guess... but I'm really struggling on seeing it as more than a burdensome addition to the create process. I see that it can help me clean up some of my code. I see the merit of thinking about simplifying things into small and bite sized, easily changable and testable code: I really do. What I struggle with is the incredible amounts of redundancy and seeming complexity required to do simple tasks. After what was likely about 10 days of reading, videos, and all around research, I decided to just tackle the connect 4 project for fear of never really understanding RSpec. I was met with just as much hostility as I expect to. I still can't figure out how to test the (in my mind) very straight forward :gets method. I think I tried to do this for an entire day. What I ended up doing was oversimplifying all of my code. The result of this, was that after I had all of the constituent methods written, writing the game loop itself was relatively straight forward but NONE of that is being tested. It's preactically all puts, gets and calls to the aforementioned tested methods, but it FEELS like I'm doing something wrong. 
- The Connect 4 project itself was relatively straight forward; the spec even said as much. I'd wager I spent 75-80% of my time on this project working on RSpec and testing. I'm going to continue forward and continue to make an effort to improve my udnerstanding of RSpec, TDD, and testing in general, but this unit has left a sour taste in my mouth. I'm very happy that I perservered and I'm pleased that I was able to complete the project. I hope that with more practice and mastery that I'm able to appreciate RSpec.

2021-07-30
- Created the game loop class and completed the project
- Implemented both diagonal win conditions and the tests for them
- Implemented method and tests for vertical victory conditions
- Implemented method and tests for horiztontal victory condition
- Implemented game over boolean method
- Implemented a method that determines if the game is at a stalemate
- Created condition to require the two markers to be different

2021-07-28
- Added a method to track the active player to the Player class
- Implemented the Play method and tests

2021-07-26
- Completed Players object and RSpec tests
- Completed GameBoard object and RSpec tests
- GameBoard file and spec created
- Directory established
