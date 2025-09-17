class_name FireRateAugment
extends Augment

@export var mult: float = 1.0

func _init(_mult: float, _lifetime: float):
	super(_lifetime)
	mult = _mult

func apply(_player: Player):
	super(_player)
	_player.multiply_fire_rate(mult)

func unapply():
	player.multiply_fire_rate(1.0 / mult)
	super()
	
