extends CharacterBody2D

@onready var T_Bullet = preload("res://Media/Scenes/template_bullet.tscn")
var T_Explosion = preload("res://Media/Scenes/explosion.tscn")

@onready var Base = $Base
@onready var Turret = $Turret
@onready var eotb = $Turret/Texture/Barrel/EndPoint #End_of_the_barrel
@onready var TurretTexture = $Turret/Texture
@onready var Cam = $Camera
@onready var Cursor = $GUI/Cursor
@onready var lcd = $GUI/Cursor/L_cd #Label cooldown
@onready var la = $GUI/Cursor/L_a #Label ammos

@export var cooldown = 0

var max_speed = 300
var current_speed = 0

var Rotation_Speed = 2
var Rotation_Direction = 0
var rot_dif = 0 #Rotation difference

var ammunition = 0

func SLA(object, delta):
	var direction = get_global_mouse_position()
	var angleTo = object.transform.x.angle_to(direction)
	object.rotate(sign(angleTo) * min(delta * Rotation_Speed, abs(angleTo)))

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
	ei.position = eotb.global_position
	ei.rotation = eotb.global_rotation
	get_parent().add_child(ei)

func _ready():
	ammunition = 8
	

func _process(delta):
	Cursor.global_position = get_global_mouse_position()
	lcd.text = str(cooldown/60)
	la.text = str(ammunition)
	if cooldown > 0:
		cooldown -= 1
	if true:
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
		if not Input.is_action_pressed("w") and current_speed >= -max_speed/4 and Input.is_action_pressed("s"):
			current_speed -= 2
		if Input.is_action_just_pressed("lbc") and cooldown == 0 and ammunition > 0:
			ammunition -= 1
			spawn_bullet()
			spawn_explosion()
			$Turret/Texture/Barrel.position = Vector2($Turret/Texture/Barrel.position.x - 50,0)
			cooldown = 300
		if $Turret/Texture/Barrel.position.x < 0:
			$Turret/Texture/Barrel.position.x += 0.5
	Cam.global_position = Vector2((global_position.x + Cursor.global_position.x)/2, (global_position.y + Cursor.global_position.y)/2)
	Cursor.global_rotation = 0
	
	$Aim.look_at(get_global_mouse_position())
	rot_dif = $Aim.rotation - Turret.rotation
	Turret.look_at(get_global_mouse_position())
	


func _physics_process(delta):
	movement()
	rotation += Rotation_Direction * Rotation_Speed * delta
	move_and_slide()
	



func _on_input_event(viewport, event, shape_idx):
	event.queue_free()


func _on_area_body_entered(body):
	body.queue_free()
