extends Node

enum Sounds {
	PLAYER_DEATH,
	PLAYER_HURT,
	PLAYER_LEVEL_UP,
	PICKUP_XP,
	PICKUP_AMMO,
	WEAPON_FIRE,
	MOB_DEATH,
}

@onready var sound_to_node: Dictionary[Sounds, AudioStreamPlayer] = {
	Sounds.PLAYER_DEATH: $Player/Death,
	Sounds.PLAYER_HURT: $Player/Hurt,
	Sounds.PLAYER_LEVEL_UP: $Player/LevelUp,
	Sounds.PICKUP_XP: $Pickups/XP,
	Sounds.PICKUP_AMMO: $Pickups/Ammo,
	Sounds.WEAPON_FIRE: $Weapon/ShootSound,
	Sounds.MOB_DEATH: $Mob/Death,
}

func play_sound(sound: Sounds, pitch_scale = 1.0, random_pitch_range = 0.0):
	var player: AudioStreamPlayer = sound_to_node[sound]
	var previous_pitch_scale = player.pitch_scale
	player.pitch_scale = pitch_scale + randf_range(-random_pitch_range, random_pitch_range)
	player.play()
	player.pitch_scale = previous_pitch_scale
