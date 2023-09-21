extends Node2D

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	#rotation = get_parent().global_position.direction_to(get_global_mouse_position()).angle() + PI/2
