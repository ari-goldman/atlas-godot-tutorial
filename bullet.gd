class_name Bullet
extends Area2D

var distance_travelled = 0.0

func _physics_process(delta):
	const SPEED = 1000.0
	const RANGE = 1200.0
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	if distance_travelled > RANGE:
		queue_free()


func _on_body_entered(body: Node2D):
	queue_free()
	
	if body.has_method("take_damage"):
		body.take_damage()
