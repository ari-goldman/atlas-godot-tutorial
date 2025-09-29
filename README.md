# atlas-godot-tutorial

### Play the game at [atlas-godot-tutorial.ari-goldman.xyz](https://atlas-godot-tutorial.ari-goldman.xyz/)

## Info
- Juice added:
	- border expands smoothly
	- a lot of particles
		- level up particles
		- gun fire particles
		- augment pickup particles
	- gun "recoil" (squish)
	- audio manager
	- music
	- action lines indicating a player's current augments
		- fades in with more augments collected
		- changes color based on how many of which augment the player has
			- more blue -\> more speed augments
			- more red -\> more fire rate augments
	

- Total time:
	- Week 2: ~9 hours
	- Week 3: ~13 hours
	- Week 4: ~9 hours

## Asset Sources
- Tutorial:
	- Video: https://www.youtube.com/watch?v=GwCiGixlqiU
	- Assets: https://www.gdquest.com/library/first_2d_game_godot4_vampire_survivor/#download-files
- Sounds generated from https://sfxr.me/
- Bubble pop sound by Universfield https://pixabay.com/sound-effects/bubble-pop-293342/
- Louis George Café font by Chen Yining https://www.dafont.com/louis-george-cafe.font?text=01234%3A5678
- Equip Sound by Homemade_SFX https://pixabay.com/sound-effects/equip-sound-272428/
- Actionlines Comic Anime Shader by EriNixie https://godotshaders.com/shader/actionlines-comic-anime/
- Dramatic Serious Intense Music by Hitslab https://pixabay.com/music/main-title-dramatic-serious-intense-music-406394/
- Pixel Plains Tileset by SnowHex https://snowhex.itch.io/pixel-plains

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

<details>
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

<details>
<summary>Week 4</summary>

### 9/17
- implemented (basic) audio manager
- 1 hour

### 9/19
- made border expand with tween
- 2 hours

### 9/22
- added action lines that change based on player augments
- added spark particles when the player's gun shoots
- 2 hours

### 9/23
- added music
	- music fades out on death
- adjusted audio levels
- added player particles
	- emitted on augment collection and player level up
	- each event has its own color of particle
- adjusted spark particles
- action lines now change to better colors depending on what augments you have
	- will mix between blue and red when you have both augment types depending amount each of augment had
- 4 hours (spent a lot of time tinkering with the particles)

</details>


<details open>
<summary>Week 5</summary>

### 9/25
- found and added tileset
- defined layers
- fumbled around with autotiling settings
- 1 hour

### 9/29
- figured out and finished autotiling settings (lots of trial and error)
- added bush layer
- 2 hours

<details>
