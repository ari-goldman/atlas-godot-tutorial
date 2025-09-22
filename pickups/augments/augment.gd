class_name Augment
extends Node

signal done

@export var lifetime: float = 1.0
var player: Player = null

func _init(_lifetime: float):
	lifetime = _lifetime

func apply(_player: Player):
	player = _player
	
	if lifetime > 0:
		var t := Timer.new()
		t.wait_time = lifetime
		t.one_shot = true
		add_child(t)  # attach timer to augment itself
		t.start()
		t.timeout.connect(_on_lifetime_timeout)
	
func unapply():
	player = null

func _on_lifetime_timeout():
	unapply()
	done.emit()
	queue_free()
