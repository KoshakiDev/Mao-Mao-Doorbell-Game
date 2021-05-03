extends Label


func _ready():
	pass

func set_motion_blur():
	material.set_shader_param("strength", 0.05)

func remove_motion_blur():	
	material.set_shader_param("strength", 0)
