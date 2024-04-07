extends CharacterBody2D

@export var Speed = 120

func _ready():
	await  get_tree().create_timer(5).timeout
	queue_free()

func _process(delta):
	move_local_x(Speed)

