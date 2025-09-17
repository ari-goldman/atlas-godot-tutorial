extends RichTextLabel

signal timer_update(_seconds: int)

var seconds: int = 0:
	set(value):
		seconds = value
		_update_timer_text()

func _ready():
	_update_timer_text()

func _on_timer_timeout():
	seconds += 1
	timer_update.emit(seconds)

func _update_timer_text():
	#if seconds < 60:
		#text = "[i]%d[/i]" % seconds
	#else:
	text = "[i]%d:%02d[/i]" % [seconds / 60, seconds % 60]

func flash_red():
	$AnimationPlayer.play("flash_red")
