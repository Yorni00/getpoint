extends Node2D

@onready var Plr = $Session/Player

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func get_childs(_node):
	var deti = _node.get_child_count()
	var package = PackedScene.new()
	for i in deti:
		package.pack(_node.get_child(i))
	return package

func _process(delta):
	
	$Session/gmp.position = get_global_mouse_position()
	


func _on_save_pressed():
	var Package = PackedScene.new()
	if $Session:
		var result = Package.pack($Session)
		if result == OK:
			var er = ResourceSaver.save(Package, "user://scene.tscn")
			if er != OK:
				print("Error.")
		else:
			print("Package has not created.")
	else:
		print("Session does not exist.")
	
	


func _on_load_pressed():
	get_tree().change_scene_to_file("user://scene.tscn")


func _on_delete_pressed():
	pass # Replace with function body.
