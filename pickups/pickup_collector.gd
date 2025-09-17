extends Node2D

signal xp_collected
signal ammo_collected
signal move_speed_augment_collected
signal fire_rate_augment_collected

func _on_magnet_area_area_entered(area):
	if area is not Pickup:
		return
		
	area.tie_to_node(self)



func _on_collection_area_area_entered(area):
	if area is not Pickup:
		return
	
	var pickup: Pickup = area as Pickup
	match pickup.pickup_type:
		Pickup.PickupTypes.NONE:
			pass
		Pickup.PickupTypes.XP:
			xp_collected.emit()
		Pickup.PickupTypes.AMMO:
			ammo_collected.emit()
		Pickup.PickupTypes.MOVE_SPEED_AUGMENT:
			move_speed_augment_collected.emit()
		Pickup.PickupTypes.FIRE_RATE_AUGMENT:
			fire_rate_augment_collected.emit()
	area.queue_free()
