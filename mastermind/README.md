2021-06-18 Post Mortem
- I did it. I almost gave up, but I did it. This was as challenging as the calculator project, but for completely different reasons. After I started working on the computers solving algorithm, I came across a problem where it would solve the secret code about 50% of the time. Bugfixing this felt like walking into a brick wall. I stepped away, came back, asked for help, slept on it, tried something new, attacked the problem from a different angle, and eventually I was able to find a solution that worked. Fixing the bug cause another one (the I only really solved in a roundabout way), but I'm happy with the end results. 
- I think the largest lessons learned here were definitely Ruby specific. I got a lot of practice writing the syntax and looking into the documentation. I feel like I can find the logic of how to solve these problems relatively quickly, and I'm still playing catchup on finding the right way to implement that logic. This makes sense, I'm only 10 weeks or so into this journey of forever learning, but it can be very frustrating to work and work and feel like I've made no progress in 5 hours. I'm grateful for the support of my wife as I work through these problems. 
- The largest problem that I had with this project was my CheckCode class was creating a duplicate, then destructively checking the guess against the code to produce the clue string. I made it destructive because that was the most logical way I came up with to avoid duplicate results when the same number was present in the code more than once. This resulted in correct answers sometimes, incorrect answers others. I couldn't identify a pattern to predict complete/error, so I knew that I would have to refactor this portion of my code. I ended up creating another check that would work to find the solution every time, but would actually output the incorrect clue string. So, in the end I used both methods together: 1 to generate the clue code for the user, and the other to generate the solution in the algorithm. I'm well aware this can't be the most elegant solution, but it's my solution. Combined with my experience in previous projects, I'm beginning to see a trend. 
- The final thing I did was refactor my code so that my classes were smaller, there were fewer repeating sections of code, and the output was pleasing and easy to read. This was a suggestion made by someone who helped me talk through my bug, and I definitely think it has helped me become more comfortable with my code as well as Ruby syntax.
- Overall, I'm happy that I'm ready to move on to the next project. I learned a lot and I'm proud of what I accomplished, but I'm more than ready for the next challenge.

2021-06-18
- Setup game rules and explanation
- Made output more readable
- Everything seems to be working as expected for both maker and breaker
- Cleaning up code towards better practice
- Reworked CheckCode class to be non-destructive, still not likely the cleanest implementation but it works.

2021-06-17
- Implemented the checks for the computer's algorithm
- Gameloop as maker works sometimes
  - 4153, 6342, 5462, 6121 are examples of codes that break the algorithm
  - Possibly need to figure out a new CheckCode class

2021-06-16
- Implemented psuedo code, but missed interactivity.... need to refactor checks
- Array of Possibilities created
- Setup psuedo code for the computer algorithm
- Player as maker, computer as breaker gameplay loop has been finished!

2021-06-14
- Code checker has been established
- PlayerSelection class has been established
- Code creation has been established for both the player and computer

2021-06-13
- Established files for Mastermind