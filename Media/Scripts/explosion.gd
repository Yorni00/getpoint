extends CPUParticles2D

func _ready():
	z_index = 4
	emitting = true
	await  get_tree().create_timer(5).timeout
	queue_free()
