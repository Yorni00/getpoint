# Independent Main Stage
extends Node



func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	
