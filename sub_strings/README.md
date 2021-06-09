2021-06-09 Post Mortem
- I tried to do this with the reduce method, but continually encountered errors until I changed tactics towards looping over the dictionary with .each. I'm not convinced I understand the reduce method and need to take a deeper look into how it functions. I was able to complete the task and the hardest part after changed methodology to .each was making it search for multiple instances of the same word. I ended up chaining the .scan and .count methods onto my existing to do it. This was another good practice project, though I think moreso in that it made me think about the difference between each and reduce and will make me research more into the reduce method after I wrap up.

2021-06-09
- Included interactive prompt that will default to the string given in the assignment
- Completed the code to count the number of times a word in the dictionary is present in an input phrase
- Established README and sub_strings.rb