extends CharacterBody2D
var speed = 200 
var accel = 7
@onready var na = get_parent().get_node("NavigationAgent2D")
func _physics_process(delta):
	var direction = Vector3()
	na.target_position = get_global_mouse_position()
	direction = na.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	move_and_slide()
