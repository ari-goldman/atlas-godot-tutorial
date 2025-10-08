# atlas-godot-tutorial

### Play the game at [atlas-godot-tutorial.ari-goldman.xyz](https://atlas-godot-tutorial.ari-goldman.xyz/)

## Info
- Added main menu
- Added settings menu
	- 3 volume sliders: master, music, and effects
	- Difficulty selector
- Can now return to main menu and restart the game on death
- Mouse controls (click to move to mouse)

<img src=UI_wireframe.jpg width=500px> \
(apologies for the lack of design skills)

---

- Total time:
	- Week 2: ~9 hours
	- Week 3: ~13 hours
	- Week 4: ~9 hours
	- Week 5: ~6 hours (see level branch)
	- Week 6: ~8 hours

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


<details>
<summary>Week 5</summary>
See level branch
</details>

<details open>
<summary>Week 6</summary>

### 10/5
- made wireframe
- started implementing main menu
- 1 hour

### 10/6
- finished main menu layout
- worked on settings menu
- 1 hour

### 10/7
- finalized theming
- finished settings menu
	- volume sliders work
	- difficulty slector works
- added mouse controls
- fixed audio bugs on scene change
- fixed scene changes crashing the game
- 6 hours

</details>