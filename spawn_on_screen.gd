extends VisibleOnScreenNotifier2D

@export var to_spawn: PackedScene
@export var respawn: bool = false
@export_range(-1.0, 100.0, 1.0) var times: int = 1
@export var can_spawn: bool = true

func _on_screen_entered():
	if to_spawn and can_spawn:
		var scene = to_spawn.instantiate()
		scene.tree_exited.connect(_on_scene_free)
		add_sibling(scene)
		if scene is Node2D:
			scene.global_position = global_position
		can_spawn = false
		times -= 1
		
	if !respawn or (respawn and times == 0):
		queue_free()

func _on_scene_free():
	can_spawn = true
