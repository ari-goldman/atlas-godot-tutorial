class_name MoveSpeedAugment
extends Augment

@export var mult: float = 1.0

func _init(_mult: float, _lifetime: float):
	super(_lifetime)
	mult = _mult

func apply(_player: Player):
	super(_player)
	_player.multiply_move_speed(mult)

func unapply():
	player.multiply_move_speed(1.0 / mult)
	super()
	
