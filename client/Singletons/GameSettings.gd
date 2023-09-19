extends Node

var name_tag_visibility = true

func _process(delta):
	if Input.is_action_just_pressed("check_name"):
		name_tag_visibility = !name_tag_visibility
