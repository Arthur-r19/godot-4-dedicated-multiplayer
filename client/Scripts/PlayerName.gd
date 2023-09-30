extends Label


func _ready():
	GameSettings.name_tag_visibility_changed.connect(_change_visibility)
	pass

func _change_visibility(new_value):
	visible = new_value
