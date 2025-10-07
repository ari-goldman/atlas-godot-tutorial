#@tool
class_name Border
extends Path2D

@export var border_size := Vector2(1920.0, 1080.0):
	set(value):
		border_size = value
		if Engine.is_editor_hint():
			call_deferred("_set_border_points")
			call_deferred("_create_elements")
		else:
			call_deferred("_set_border_points")
			call_deferred("_create_elements")
@onready var base_border_size: Vector2 = border_size

@export var border_object: PackedScene: # better have a Node2D base node...
	set(value):
		border_object = value
		if border_object and Engine.is_editor_hint():
			call_deferred("_create_elements")
		else:
			_create_elements()
@export var border_elements: int = 10:
	set(value):
		border_elements = value
		if border_object and Engine.is_editor_hint():
			call_deferred("_create_elements")
		else:
			call_deferred("_create_elements")

@export_range(0.0, 50.0) var jitter: float = 0.0:
	set(value):
		jitter = value
		if border_object and Engine.is_editor_hint():
			call_deferred("_create_elements")
		else:
			_create_elements()

@export var random_seed: String = "seed":
	set(value):
		random_seed = value
		if border_object and Engine.is_editor_hint():
			call_deferred("_create_elements")
		else:
			_create_elements()

func _ready():
	border_size = base_border_size
	if border_object:
		call_deferred("_create_elements")
	else:
		push_error("No border object set in border!")

func _create_elements():
	if not is_inside_tree():
		call_deferred("_create_elements")
		return
	
	if curve == null:
		_set_border_points()
	
	for child in %Objects.get_children():
		child.queue_free()
		
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(random_seed)
	
	for i in range(border_elements):
		%PathFollow2D.progress_ratio = float(i) / border_elements
		var new_object: Node2D = border_object.instantiate()
		new_object.global_position = %PathFollow2D.global_position
		new_object.global_position.x += rng.randf_range(-jitter, jitter)
		new_object.global_position.y += rng.randf_range(-jitter, jitter)
		%Objects.add_child(new_object)
		
		if new_object is CollisionObject2D:
			new_object.collision_layer = 0
			new_object.set_collision_layer_value(4, true)

func _set_border_points():
	if curve == null:
		curve = Curve2D.new()
	
	var x = border_size.x
	var y = border_size.y
	curve.clear_points()
	curve.add_point(Vector2(0, 0))
	curve.add_point(Vector2(0, y))
	curve.add_point(Vector2(x, y))
	curve.add_point(Vector2(x, 0))
	curve.add_point(Vector2(0, 0))

func expand_border(added_size: Vector2, add_objects: int = 1, tween: Tween = null, tween_time: float = 0.0):
	var final_position: Vector2 = global_position - added_size / 4.0
	var final_size: Vector2 = border_size + added_size
	border_elements += add_objects
	if is_instance_valid(tween) and tween.is_valid(): 
		tween.set_parallel(true)
		tween.tween_property(self, "global_position", final_position, tween_time)
		tween.tween_property(self, "border_size", final_size, tween_time)
		tween.set_parallel(false)
	else:
		global_position = final_position
		border_size = final_size
