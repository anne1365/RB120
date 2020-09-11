=begin
  The flow -> same as before - user chooses, comp chooses, winner displayed
  Now coding it in classes and objects

  APPROACH TO OOP
  1. Write a textual description of the problem or exercise.
  2. Extract the major nouns and verbs from description
  3. Organize & associate the verbs with the nouns
  4. Nouns are the classes, and verbs are the behaviors or methods

  --> At this step we want to modularize the problem as much as possible
      the logic and game flow will come later.

  TEXTUAL DESCRIPTION
  Rock, Paper, Scissors is a two-player game where each player chooses one of
  three possible moves: rock, paper, or scissors. The chosen moves are
  compared to see who wins, according to the following rules:
  - rock beats scissors
  - scissors beats paper
  - paper beats rock
  - tie if choices are the same

  NOUNS: player, move, rule
  VERBS: choose, compare

  Associating the nouns & verbs
   - a player can choose
   - move and rule don't have any verbs
   - no clue where to put compare

  We need an 'engine' of some sort to orchestrate the objects - this is where the 
  procedural program flow goes. 
=end