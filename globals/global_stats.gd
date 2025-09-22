extends Node

## Mobs
var red_slime_time: int = 40 # minimum time for red slimes to spawn (seconds)

## Augments
var augment_time: int = 0 # 20 # minimum time for augments to drop (seconds)
var spawn_augments = false # whether or not augments are spawning
var augment_drop_chance: float = 1.0 # 0.2  # chance to drop any augment
var augment_lifetime: float = 7.5 # how long an augment will last on the player (seconds)
var move_speed_augment_mult: float = 1.2 # player movemenet speed augment multiplier 
var fire_rate_augment_mult: float = 1.5 # player fire rate augment multiplier

## Border
var border_expansion_size: Vector2 = Vector2(75, 75) # how much to expand the border on levelup
var border_expansion_time: float = 0.5 # how long border expansions take
