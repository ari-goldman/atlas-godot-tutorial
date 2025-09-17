class_name Player
extends CharacterBody2D

signal health_depleted
signal level_up

signal gun_ammo_changed(_ammo: int)

var health := 50
var level: int = 0

var speed: float = 600.0

func _ready():
	for augment in %Augments.get_children():
		if augment is Augment:
			augment.apply(self)

func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	const DAMAGE_RATE := 10.0
	var overlapping_mobs: Array[Node2D] = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if !%HitSound.playing:
			%HitSound.pitch_scale = lerp(0.5, 1.0, health / %HealthBar.max_value)
			%HitSound.play()
	
		if health <= 0.0:
			health_depleted.emit()
			



func _on_xp_collector_xp_collected():
	%XPBar.value += 1
	if %XPBar.value >= %XPBar.max_value:
		## level up
		level_up.emit()
		level += 1
		
		%LevelLabel.text = "Level %d" % level
		
		%XPBar.value -= %XPBar.max_value
		%XPBar.max_value *= 1.2
		%Gun.multiply_shoot_timer(0.9)
		%LevelUpSound.play()
		
		GlobalStats.augment_drop_chances = min(GlobalStats.augment_drop_chance + 0.1, 0.8)
	else:
		%PickupXPSound.pitch_scale = randf_range(0.95, 1.05)
		%PickupXPSound.play()


func _on_gun_ammo_changed(_ammo):
	gun_ammo_changed.emit(_ammo)


func _on_pickup_collector_ammo_collected():
	%Gun	.fill_ammo()
	%PickupAmmoSound.pitch_scale = randf_range(0.95, 1.05)
	%PickupAmmoSound.play()

func multiply_fire_rate(mult: float):
	%Gun.fire_rate /= mult

func multiply_move_speed(mult: float):
	speed *= mult


func _on_pickup_collector_fire_rate_augment_collected():
	var augment := FireRateAugment.new(GlobalStats.fire_rate_augment_mult, GlobalStats.augment_lifetime)
	%Augments.add_child(augment)
	augment.apply(self)
	pass


func _on_pickup_collector_move_speed_augment_collected():
	var augment := MoveSpeedAugment.new(GlobalStats.move_speed_augment_mult, GlobalStats.augment_lifetime)
	%Augments.add_child(augment)
	augment.apply(self)
