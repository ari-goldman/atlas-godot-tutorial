extends Node2D

signal xp_collected

func _on_magnet_area_area_entered(area):
	if area is not xp_object:
		return
		
	area.tie_to_node(self)



func _on_collection_area_area_entered(area):
	xp_collected.emit()
	area.queue_free()
