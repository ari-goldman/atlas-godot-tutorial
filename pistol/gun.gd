class_name Gun
extends Area2D


func _physics_process(delta):
	var closest_enemy = get_closest_in_range_body()
	if closest_enemy != null:
		look_at(closest_enemy.global_position)

func shoot():
	const BULLET = preload("res://pistol/bullet/bullet.tscn")
	var new_bullet: Bullet = BULLET.instantiate()
	new_bullet.global_position = %"Shooting Point".global_position
	new_bullet.global_rotation = %"Shooting Point".global_rotation
	%"Shooting Point".add_child(new_bullet)
	%ShootSound.pitch_scale = randf_range(0.95, 1.05)
	%ShootSound.play()
	

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
	
	
func _on_timer_timeout():
	if !get_overlapping_bodies().is_empty():
		shoot()

func multiply_shoot_timer(mult: float):
	%Timer.wait_time *= mult
