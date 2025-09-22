extends CanvasLayer

@export var ammo_texture: Texture2D
var current_ammo: int = 6

func _ready():
	current_ammo = %AmmoContainer.get_child_count()
	%ActionLines.show()

func _set_ammo(ammo: int):
	if ammo == current_ammo:
		return
	
	if ammo < current_ammo:
		for i in range(current_ammo - ammo):
			var child := %AmmoContainer.get_child(0)
			if child:
				child.queue_free()
	
	if ammo > current_ammo:
		for i in range(ammo - current_ammo):
			var texture_rect = TextureRect.new()
			texture_rect.texture = ammo_texture
			texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
			texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			%AmmoContainer.add_child(texture_rect)
	
	current_ammo = ammo

func _on_player_gun_ammo_changed(_ammo):
	_set_ammo(_ammo)
	

var action_line_tween: Tween
func _on_player_augments_changed(number_speed, number_fire_rate):
	if action_line_tween and action_line_tween.is_running():
		action_line_tween.kill()
		
	var total: int = number_fire_rate + number_speed
	
	var color: Color = Color(
		1.0 - number_speed * 0.1,
		1.0 - total * 0.1,
		1.0 - number_fire_rate * 0.1,
		total * 0.175 + (0.5 if total > 0 else 0.0)
	)
	
	var radius: float = 2.0 - (total * 0.1) - (0.15 if total > 0 else 0.0)
	radius = clampf(radius, 1.6, 2.0)
	
	action_line_tween = get_tree().create_tween()
	action_line_tween.set_parallel(true)
	action_line_tween.tween_property(%ActionLines, "material:shader_parameter/LineColor", color, 0.3)
	action_line_tween.tween_property(%ActionLines, "material:shader_parameter/Radius", radius, 0.3)
