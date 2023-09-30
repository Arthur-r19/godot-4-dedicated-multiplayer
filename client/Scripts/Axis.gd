extends Node2D

func _physics_process(_delta):
	if DisplayServer.window_is_focused():
		look_at(get_global_mouse_position())
		rotation_degrees += 90
