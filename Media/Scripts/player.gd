extends CharacterBody2D

@onready var Base = $Base
@onready var Turret = $Turret

var Directed_Speed = 200
var Rotation_Speed = 5
var Rotation_Direction = 0

func movement():
	Rotation_Direction = Input.get_axis("a", "d")
	velocity = transform.x * Input.get_axis("s","w") * Directed_Speed
	

func _ready():
	pass
	

func _process(delta):
	Turret.look_at(get_global_mouse_position())
	

func _physics_process(delta):
	movement()
	rotation += Rotation_Direction * Rotation_Speed * delta
	move_and_slide()
	

