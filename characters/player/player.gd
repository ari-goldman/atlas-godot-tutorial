class_name Player
extends CharacterBody2D

signal health_depleted
signal level_up
signal augments_changed(number_speed: int, number_fire_rate)

@export var particle_colors: Dictionary[String, Color] = {
	"LEVEL_UP": Color.WHITE,
	"SPEED_UP": Color.WHITE,
	"FIRE_RATE_UP": Color.WHITE
}


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
		
		AudioManager.play_sound(AudioManager.Sounds.PLAYER_HURT, lerp(0.5, 1.0, health / %HealthBar.max_value))
		
	
		if health <= 0.0:
			health_depleted.emit()
			_clear_augments()
			



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
		AudioManager.play_sound(AudioManager.Sounds.PLAYER_LEVEL_UP)
		
		GlobalStats.augment_drop_chance = min(GlobalStats.augment_drop_chance + 0.1, 0.8)
		
		_play_particle(particle_colors["LEVEL_UP"])
	else:
		AudioManager.play_sound(AudioManager.Sounds.PICKUP_XP, 1.0, 0.05)


func _on_gun_ammo_changed(_ammo):
	gun_ammo_changed.emit(_ammo)


func _on_pickup_collector_ammo_collected():
	%Gun	.fill_ammo()
	AudioManager.play_sound(AudioManager.Sounds.PICKUP_AMMO, 1.0, 0.05)

func multiply_fire_rate(mult: float):
	%Gun.fire_rate /= mult

func multiply_move_speed(mult: float):
	speed *= mult

func _setup_augment(augment: Augment):
	%Augments.add_child(augment)
	augment.apply(self)
	_update_augment_count()
	augment.connect("done", _update_augment_count)
	
func _on_pickup_collector_fire_rate_augment_collected():
	var augment := FireRateAugment.new(GlobalStats.fire_rate_augment_mult, GlobalStats.augment_lifetime)
	_setup_augment(augment)
	_play_particle(particle_colors["FIRE_RATE_UP"])


func _on_pickup_collector_move_speed_augment_collected():
	var augment := MoveSpeedAugment.new(GlobalStats.move_speed_augment_mult, GlobalStats.augment_lifetime)
	_setup_augment(augment)
	_play_particle(particle_colors["SPEED_UP"])

func _clear_augments():
	for child: Augment in %Augments.get_children():
		child.unapply()
		child.queue_free()
	_update_augment_count()

func _update_augment_count():
	var speed_augments: int = 0
	var fire_rate_augments: int = 0
	
	for child in %Augments.get_children():
		if child is MoveSpeedAugment:
			speed_augments += 1
		if child is FireRateAugment:
			fire_rate_augments += 1
	
	augments_changed.emit(speed_augments, fire_rate_augments)
	
func _play_particle(color: Color):
	var direction: Vector3 = Vector3(velocity.x, velocity.y, 0.0).normalized()
	const PLAYER_PARTICLES = preload("res://characters/player/particles/player_particles.tscn")
	var particles: GPUParticles2D = PLAYER_PARTICLES.instantiate()
	particles.one_shot = true
	particles.emitting = true
	particles.modulate = color
	particles.process_material.direction = direction
	particles.connect("finished", particles.queue_free)
	%Particles.add_child(particles)
