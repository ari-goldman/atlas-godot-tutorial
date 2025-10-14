extends Node2D

func _play_anim():
	$HappyBoo/AnimationPlayer2.play("new_animation")

var step = 0

func _ready():
	$HappyBoo/AnimationPlayer.play("idle")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		#if step == 0:
			#print("ok")
			#_play_anim()
			#step += 1
		#elif step == 1:
			#print("hmm")
			#$HappyBoo/Gun.show()
			
		
		$Player.process_mode = Node.PROCESS_MODE_ALWAYS
		for child in get_children():
			if child is Pickup:
				child.tie_to_node($HappyBoo)
			if child is Mob:
				child.queue_free()
