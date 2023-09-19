extends Label


func _process(delta):
	if Input.is_action_just_pressed("check_name"):
		visible = GameSettings.name_tag_visibility
