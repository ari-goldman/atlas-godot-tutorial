@tool
extends Node2D

@export var color_modulate: Color = Color.WHITE:
	set(value):
		color_modulate = value
		_update_sprite_colors(value)

func play_walk():
	%AnimationPlayer.play("walk")


func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")

func _update_sprite_colors(color: Color) -> void:
	$Anchor/SlimeBody.modulate = color
	#$Anchor/SlimeBody/SlimeBodyHurt.modulate = color
	$Anchor/Face/SlimeFace.modulate = color
