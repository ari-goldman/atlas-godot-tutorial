class_name xp_object
extends Area2D

var tied_node: Node2D = null
var velocity: Vector2 = Vector2.ZERO
const ACCELERATION = 1200.0
const MAX_VELOCITY = 1000.0
const TURN_SPEED := 26.0

func tie_to_node(_tied_node: Node2D):
	tied_node = _tied_node
	
func _physics_process(delta):
	if tied_node == null:
		return
	
	var to_node: Vector2 = global_position.direction_to(tied_node.global_position)
	#if velocity.dot(to_node) < 0:
	
	var angle_to_node = velocity.angle_to(to_node)
	var max_turn = TURN_SPEED * delta
	angle_to_node = clamp(angle_to_node, -max_turn, max_turn)
	
	velocity = velocity.rotated(angle_to_node)
		
	velocity += ACCELERATION * delta * to_node
	
	if velocity.length() > MAX_VELOCITY:
		velocity = velocity.normalized() * MAX_VELOCITY

	global_position += velocity * delta
