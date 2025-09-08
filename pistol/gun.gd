class_name Gun
extends Area2D


func _physics_process(delta):
	var enemies_in_range: Array[Node2D] = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy: Node2D = enemies_in_range[0]
		look_at(target_enemy.global_position)

func shoot():
	const BULLET = preload("res://pistol/bullet/bullet.tscn")
	var new_bullet: Bullet = BULLET.instantiate()
	new_bullet.global_position = %"Shooting Point".global_position
	new_bullet.global_rotation = %"Shooting Point".global_rotation
	%"Shooting Point".add_child(new_bullet)
	


func _on_timer_timeout():
	if !get_overlapping_bodies().is_empty():
		shoot()

func multiply_shoot_timer(mult: float):
	%Timer.wait_time *= mult
