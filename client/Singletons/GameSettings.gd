extends Node

var name_tag_visibility = true
var fullscreen = true :
	get:
		return fullscreen
	set(value):
		if value:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = value


func _ready():
	fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	
	var gameInterfaceScene = load("res://Scenes/GameInterface.tscn")
	var gameInterface = gameInterfaceScene.instantiate()
	get_parent().add_child.call_deferred(gameInterface)

func _process(delta):
	if Input.is_action_just_pressed("check_name"):
		name_tag_visibility = !name_tag_visibility


