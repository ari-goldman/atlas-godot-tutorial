class_name Player
extends CharacterBody2D

signal health_depleted
signal level_up

var health := 100.0

const SPEED := 600.0


func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	if velocity.length() > 0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	const DAMAGE_RATE := 10.0
	var overlapping_mobs: Array[Node2D] = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
	
		if health <= 0.0:
			health_depleted.emit()



func _on_xp_collector_xp_collected():
	%XPBar.value += 1
	if %XPBar.value >= %XPBar.max_value:
		## level up
		level_up.emit()
		%XPBar.value -= %XPBar.max_value
		%XPBar.max_value *= 1.2
		%Gun.multiply_shoot_timer(0.9)
		
