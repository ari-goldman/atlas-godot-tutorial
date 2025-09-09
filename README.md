# atlas-godot-tutorial

### Play the game at [atlas-godot-tutorial.ari-goldman.xyz](https://atlas-godot-tutorial.ari-goldman.xyz/)

## Info
- Total time: ~9 hours
- Features added:
	- XP and leveling system
		- all enemies drop XP
  		- when close enough, the XP will magnetize to the player
    	- when picked up, the XP will slowly fill the blue bar above the player
     	- when the bar is full, the player levels up and their rate of fire increases, but so does the enemies' spawn rate
	- charging enemy variant
 		- walks towards the player until it's close enough, when it charges the player
   		- the player can dodge out of the way by moving to either side of it's charge
    	- after charging, goes on a brief cooldown until it can move again
     	- implemented using a state machine (which I've never done until now)
	- sound effects
		- effects on shoot, XP pickup, slime death, player damage, and player death
 	- GitHub action for web deployment
  		- see link at the top!

## Asset Sources
- Tutorial:
	- Video: https://www.youtube.com/watch?v=GwCiGixlqiU
	- Assets: https://www.gdquest.com/library/first_2d_game_godot4_vampire_survivor/#download-files
- Sounds generated from https://sfxr.me/
- Bubble pop sound by Universfield https://pixabay.com/sound-effects/bubble-pop-293342/

## Logs
### 9/3
- initialized repository with project files
- started tutorial
- 0.5 hours

### 9/7
- finished tutorial project
- 1.5 hours

### 9/8
- reorganize files
- add XP system
	- mobs drop XP
	- XP attractes to player when in range
	- player levels up at certain XP values
	- player shoots faster on level
- 3 hours (I lost a lot of work to the git gods)

### 9/9
- added charging enemy
- made gun now shoot the closest enemy
- adjusted enemy spawning path to be outside camera
- made enemies spawn faster as player levels up
- added sound effects
- add github workflow to push to github pages
- 4 hours
