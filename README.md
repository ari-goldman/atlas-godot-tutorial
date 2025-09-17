# atlas-godot-tutorial

### Play the game at [atlas-godot-tutorial.ari-goldman.xyz](https://atlas-godot-tutorial.ari-goldman.xyz/)

## Info
- Soft gates
	- leveling: enemy spawn rate is no longer tied to enemy player level, so now the player level will only make their time easier, it is not required to progress the game 
	- augments: player can pickup augments dropped that increase their movement speed and fire rate for limited times
- Hard gate: time
	- augments unlock after 20 seconds
	- charging enemies now spawn at 40 seconds in
	- enemy difficulty is tied to time
- Faucets and Sinks:
	- Ammo: the player now spens ammo when they shoot (sink), and they must pickup more around the map (faucet)
	- Physical space: the player now gains more play area as they level up (faucet), but they lose it all when dying (sink?)
	
- Total time:
	- Week 2: ~9 hours
	- Week 3: ~13 hours

## Asset Sources
- Tutorial:
	- Video: https://www.youtube.com/watch?v=GwCiGixlqiU
	- Assets: https://www.gdquest.com/library/first_2d_game_godot4_vampire_survivor/#download-files
- Sounds generated from https://sfxr.me/
- Bubble pop sound by Universfield https://pixabay.com/sound-effects/bubble-pop-293342/
- Louis George Café font by Chen Yining https://www.dafont.com/louis-george-cafe.font?text=01234%3A5678
- Equip Sound by Homemade_SFX https://pixabay.com/sound-effects/equip-sound-272428/

## Logs

<details>
<summary>Week 2</summary>
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
</details>

<details open>
<summary>Week 3</summary>

### 9/15
- added background timer
- created border tool script
- 2 hours (had a lot of trouble with border script)

### 9/16
- made border expand on level
- fixed errors in border tool script
- added ammo meter
- made generic pickup object, now encompassing the XP pickup
- added ammo pickup
	- spawn rate increases with player level
	- has a pickup sound effect
- added text to player displaying current level
- tweaked difficulty curve, mob spawn rate is now depedent on time
	- timer flashes red when spawn rate increases
- death screen now displays time survived
- added augment system
	- augments drop from green slimes
	- can either increase player speed or fire rate
- 11 hours
</details>
