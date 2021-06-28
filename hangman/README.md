2021-06-28 Post Mortem
- Hangman has been completed!
- With every project I can really feel myself getting more comfortable with the concepts and ideas that we're tackling in the bootcamp. I would hoep that's the case, but actually feeling it is something else. The only snag here is that I feel like I'm lagging a little behind. Now that I've completed the Serialization portion, I feel like I've got a handle on Objects and writing methods from the previous section and only just starting to understand serialization.
- Writing the game code this time around was relatively straight-forward. I was able to write the game loop without much issue, but when it came to serialization I hit a bit of a wall. I ended up reading about serializing game objects and looking at some other code before coming up with my solution, serializing the variables and refactoring my code to take those variables as arguments. This allowed me to serialize the game state for saving and loading, but it didn't feel like an elegant solution (I'm starting to feel like I say that at the end of every project). The solution worked, and I could've added multiple save instances via this method, but I feel like I serialized my variables rather than the object itself. I tried to find a more elegant solution, but after a bunch of research I feel like the '1 step forward 2 steps back' way of continuing will help develop my skills faster than getting stuck on trying to perfect my understanding here. 
- Overall I feel like this was another great project and that I learned a lot. I'm looking forward to building out more projects that can help me master the concepts of serialization and objects. 

2021-06-28
- Converted Hangman into a class for serialization
- Save and load methods added

2021-06-25
- Implemented end if word has been guessed
- Implemented loop on game over
- Put restrictions on grab_guess to ensure 1 letter value
- Basic Game Loop established
- Game_loop psuedo code written
- Funcitons for drawing the hidden word, asking for a guess, and hiding the secret word have been established
- Hangman drawing and guess remaining counter established
- Word selection method created

2021-06-24
- Established directories, README, and hangman.rb
- Started the Hangman project