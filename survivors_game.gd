extends Node2D

#@export var horde_time: int = 15
#@export var horde_spawn_time: float = 0.1
@export var difficulty_increase_time: int = 20



func _spawn_mob():
	var mob = preload("res://characters/mob/mob.tscn")
	var charging_mob = preload("res://characters/charging_mob/charging_mob.tscn")
	%PathFollow2D.progress_ratio = randf()
	
	var rand = randf()
	var to_spawn
	if %Timer.seconds < GlobalStats.red_slime_time or rand <= 0.75:
		to_spawn = mob.instantiate()
		if %Timer.seconds < GlobalStats.red_slime_time:
			to_spawn.health = to_spawn.health - 1
		else:
			to_spawn.size_mult = 1.3
	else:
		to_spawn = charging_mob.instantiate()
	
	to_spawn.global_position = %PathFollow2D.global_position
	add_child(to_spawn)
	



func _on_mob_spawn_timer_timeout():
	_spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	%SurvivedText.text = %SurvivedText.text % %Timer.seconds
	get_tree().paused = true
	%DeathSound.play()


func _on_player_level_up():
	var border_expanion := Vector2(25, 25)
	%AmmoSpawnTimer.wait_time = max(%AmmoSpawnTimer.wait_time - 0.2, 0.1)
	%Border.expand_border(border_expanion, 3)
	%Camera.limit_left -= border_expanion.x / 2.0
	%Camera.limit_right += border_expanion.x / 2.0
	%Camera.limit_top -= border_expanion.y / 2.0
	%Camera.limit_bottom += border_expanion.y / 2.0


func _on_timer_update(_seconds):
	if _seconds > 0 and _seconds % difficulty_increase_time == 0:
		%MobSpawnTimer.wait_time *= 0.8
		%Timer.flash_red()
	
	if not GlobalStats.spawn_augments and _seconds >= GlobalStats.augment_time:
		GlobalStats.spawn_augments = true
		
	#if _seconds > horde_time and %MobSpawnTimer.wait_time > horde_spawn_time:
		#%MobSpawnTimer.wait_time = horde_spawn_time
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		_on_player_level_up()


func _on_ammo_spawn_timer_timeout():
	var spawnable_min = %Border.position + Vector2(100, 100)
	var spawnable_max = %Border.position + %Border.border_size - Vector2(50, 50)
	
	var spawn_position: = Vector2(
		randi_range(spawnable_min.x, spawnable_max.x),
		randi_range(spawnable_min.y, spawnable_max.y)
	)
	
	const AMMO = preload("res://pickups/ammo/ammo.tscn")
	var ammo = AMMO.instantiate()
	ammo.position = spawn_position
	add_child(ammo)
	
