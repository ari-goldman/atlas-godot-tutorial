class_name Gun
extends Area2D

signal ammo_changed(_ammo: int)

var fire_rate: float:
	set(value):
		fire_rate = value
		%Timer.wait_time = fire_rate

var ammo: int = 100_000: # 8:
	set(value):
		ammo = value
		ammo_changed.emit(ammo)
var max_ammo: int = 8

func _ready():
	ammo_changed.emit(ammo)
	fire_rate = %Timer.wait_time

func _physics_process(_delta):
	var closest_enemy = get_closest_in_range_body()
	if closest_enemy != null:
		look_at(closest_enemy.global_position)

func shoot():
	assert(ammo > 0)
	ammo -= 1
	
	const BULLET = preload("res://pistol/bullet/bullet.tscn")
	var new_bullet: Bullet = BULLET.instantiate()
	new_bullet.global_position = %"Shooting Point".global_position
	new_bullet.global_rotation = %"Shooting Point".global_rotation
	%"Shooting Point".add_child(new_bullet)
	AudioManager.play_sound(AudioManager.Sounds.WEAPON_FIRE, 1.0, 0.5)
	%AnimationPlayer.stop(true)
	%AnimationPlayer.play("shoot")
	
	var SPARK_SCENE := preload("res://pistol/sparks.tscn")
	var sparks = SPARK_SCENE.instantiate()
	sparks.emitting = true
	sparks.one_shot = true
	sparks.connect("finished", sparks.queue_free)
	%"Shooting Point".add_child(sparks)
	

func get_closest_in_range_body() -> Node2D:
	var enemies_in_range: Array[Node2D] = get_overlapping_bodies()
	var closest_enemy = null
	var closest_distance = INF
	for enemy in enemies_in_range:
		var enemy_distance = global_position.distance_to(enemy.global_position)
		if enemy_distance < closest_distance:
			closest_enemy = enemy
			closest_distance = enemy_distance
	return closest_enemy

func fill_ammo():
	ammo = max_ammo
	
	
func _on_timer_timeout():
	if ammo > 0 and !get_overlapping_bodies().is_empty():
		shoot()

func multiply_shoot_timer(mult: float):
	%Timer.wait_time *= mult
