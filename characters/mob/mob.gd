class_name Mob
extends CharacterBody2D


var health = 3
@onready var player: Player = get_node("/root/Game/Player")
@export var size_mult: float = 1.0

const augment_drops: Array[PackedScene] = [
	preload("res://pickups/augments/move_speed/move_speed_augment_pickup.tscn"),
	preload("res://pickups/augments/fire_rate/fire_rate_augment_pickup.tscn"),
]

func _ready():
	%Slime.play_walk()
	%Slime.scale *= size_mult
	%CollisionShape2D.scale *= size_mult

func _physics_process(delta):
	if player == null:
		return
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		call_deferred("die") # not sure why i needed this, but errors were thrown elsewise

func die():
	queue_free()
	const SMOKE_EXPLOSION_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION_SCENE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
	
	const XP_SCENE = preload("res://pickups/xp/xp.tscn")
	var xp = XP_SCENE.instantiate()
	get_parent().add_child(xp)
	xp.global_position = global_position + 100.0 * Vector2(randf(), randf())
	
	if GlobalStats.spawn_augments and randf() < GlobalStats.augment_drop_chance:
		var augment: Node2D = augment_drops.pick_random().instantiate()
		get_parent().add_child(augment)
		augment.global_position = global_position + 100.0 * Vector2(randf(), randf())
	
	AudioManager.play_sound(AudioManager.Sounds.MOB_DEATH)
