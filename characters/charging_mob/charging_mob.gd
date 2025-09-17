extends CharacterBody2D

enum State {
	MOVING,
	CHARGING,
	COOLDOWN
}

var times := {
	State.CHARGING: 1.0,
	State.COOLDOWN: 0.5
}

var health := 2
var current_state := State.MOVING
var move_speed = 300.0
var charge_speed = 750.0
var stateTime := 0.0
var charge_target: Vector2 = Vector2.INF
const CHARGE_DISTANCE = 500.0
@onready var player: Player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	
	match current_state:
		State.MOVING:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * move_speed
			move_and_slide()
			
			if global_position.distance_to(player.global_position) <= CHARGE_DISTANCE:
				current_state = State.CHARGING
				charge_target = Vector2.INF
				stateTime = 0.0
		State.CHARGING:
			if charge_target == Vector2.INF:
				var to_player := player.global_position - global_position
				charge_target = global_position + (to_player * 2.0)
				
			var direction = global_position.direction_to(charge_target)
			velocity = direction * charge_speed
			move_and_slide()
			
			stateTime += delta
			if stateTime >= times[State.CHARGING] or global_position.is_equal_approx(charge_target):
				current_state = State.COOLDOWN
				stateTime = 0.0
		State.COOLDOWN:
			velocity = Vector2.ZERO
			move_and_slide()
			
			stateTime += delta
			if stateTime >= times[State.COOLDOWN]:
				current_state = State.MOVING
				stateTime = 0.0
	

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
	for i in range(2):
		var xp = XP_SCENE.instantiate()
		get_parent().add_child(xp)
		xp.global_position = global_position + 20.0 * Vector2(randf(), randf())
	
	AudioManager.play_sound(AudioManager.Sounds.MOB_DEATH)
