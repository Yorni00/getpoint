extends Node2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Media/Scenes/firstscene.tscn")
