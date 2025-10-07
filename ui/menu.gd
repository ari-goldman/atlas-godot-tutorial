extends Control

@onready var main_menu = $CanvasLayer/MainMenu
@onready var settings = $CanvasLayer/Settings

var difficulty_names: Array[String] = [
	"Easy",
	"Normal",
	"Hard",
	"Impossible"
]



func _ready():
	assert(difficulty_names.size() == GlobalStats.difficulties.size())
	_update_difficulty(GlobalStats.selected_difficulty)
	
	main_menu.show()
	settings.hide()
	
	$CanvasLayer/Settings/VBoxContainer/MasterVolume/HSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))
	$CanvasLayer/Settings/VBoxContainer/MusicVolume/HSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))
	$CanvasLayer/Settings/VBoxContainer/EffectVolume/HSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Effects"))



func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_effects_value_changed(value):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Important Effects"), db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), db)


func _on_play_button_button_up():
	var main_game = preload("res://survivors_game.tscn")
	var s: SurvivorsGame = main_game.instantiate()
	add_sibling(s)
	queue_free()



func _on_settings_button_button_up():
	settings.show()
	main_menu.hide()

func _on_back_button_button_up():
	main_menu.show()
	settings.hide()


func _on_quit_button_button_up():
	get_tree().quit()
	

	
func _update_difficulty(value):
	var less: Button = $CanvasLayer/Settings/VBoxContainer/Difficulty/HBoxContainer/Less
	var more: Button = $CanvasLayer/Settings/VBoxContainer/Difficulty/HBoxContainer/More
	var difficulty_label: Button = $CanvasLayer/Settings/VBoxContainer/Difficulty/HBoxContainer/Difficulty
	
	if value <= 0:
		less.disabled = true
	else:
		less.disabled = false
	
	if value >= GlobalStats.difficulties.size() - 1:
		more.disabled = true
	else:
		more.disabled = false
		
	difficulty_label.text = difficulty_names[value]
	GlobalStats.selected_difficulty = value


func _on_less_button_up():
	_update_difficulty(GlobalStats.selected_difficulty - 1)


func _on_more_button_up():
	_update_difficulty(GlobalStats.selected_difficulty + 1)
