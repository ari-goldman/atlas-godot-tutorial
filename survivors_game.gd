extends Node2D


func spawn_mob():
	var mob = preload("res://characters/mob/mob.tscn")
	var charging_mob = preload("res://characters/charging_mob/charging_mob.tscn")
	%PathFollow2D.progress_ratio = randf()
	
	var rand = randf()
	var to_spawn
	if rand <= 0.75:
		to_spawn = mob.instantiate()
	else:
		to_spawn = charging_mob.instantiate()
	
	to_spawn.global_position = %PathFollow2D.global_position
	add_child(to_spawn)
	


func _on_mob_spawn_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true


func _on_player_level_up():
	%MobSpawnTimer.wait_time *= 0.9
