extends CharacterBody2D

@onready var T_Bullet = preload("res://Media/Scenes/template_bullet.tscn")
var T_Explosion = preload("res://Media/Scenes/explosion.tscn")

@onready var Base = $Base
@onready var Turret = $Turret
@onready var eotb = $Turret/Barrel/EndPoint #End_of_the_barrel

var max_speed = 300
var current_speed = 0
var Rotation_Speed = 2
var Rotation_Direction = 0

func movement():
	Rotation_Direction = Input.get_axis("a", "d")
	velocity = transform.x * current_speed

func spawn_bullet():
	var bullet_instance = T_Bullet.instantiate()
	bullet_instance.position = eotb.global_position
	bullet_instance.rotation = eotb.global_rotation
	get_parent().add_child(bullet_instance)

func spawn_explosion():
	var ei = T_Explosion.instantiate()
	ei.position = eotb.position
	get_parent().add_child(ei)

func _ready():
	pass
	

func _process(delta):
	if Input.is_action_pressed("w") and Input.is_action_pressed("s"):
		if current_speed > 0:
			current_speed -= 2
		elif current_speed < 0:
			current_speed += 2
	elif not Input.is_action_pressed("w") and not Input.is_action_pressed("s"):
		if current_speed > 0:
			current_speed -= 2
		elif current_speed < 0:
			current_speed += 2
	
	if Input.is_action_pressed("w") and current_speed <= max_speed and not Input.is_action_pressed("s"):
		current_speed += 2
	if not Input.is_action_pressed("w") and current_speed >= -max_speed and Input.is_action_pressed("s"):
		current_speed -= 2
	Turret.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("lbc"):
		spawn_bullet()

func _physics_process(delta):
	movement()
	rotation += Rotation_Direction * Rotation_Speed * delta
	move_and_slide()
	

