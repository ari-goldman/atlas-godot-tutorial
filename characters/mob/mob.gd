extends CharacterBody2D

var health = 3
@onready var player: Player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
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
	
	const XP_SCENE = preload("res://xp/xp.tscn")
	var xp = XP_SCENE.instantiate()
	get_parent().add_child(xp)
	xp.global_position = global_position
	
	var death_sound_player = AudioStreamPlayer.new()
	death_sound_player.stream = preload("res://sounds/bubble_pop.wav")
	get_tree().current_scene.add_child(death_sound_player)
	death_sound_player.play()
	death_sound_player.finished.connect(func(): death_sound_player.queue_free())
