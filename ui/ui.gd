extends CanvasLayer

@export var ammo_texture: Texture2D
var current_ammo: int = 6

func _ready():
	current_ammo = %AmmoContainer.get_child_count()

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
