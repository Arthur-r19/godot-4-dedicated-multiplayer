extends Node

var game_menu_scene: PackedScene = load("res://Scenes/GameMenu.tscn")
var open_world_scene: PackedScene = load("res://Scenes/World.tscn")


func set_open_world_scene():
	get_tree().change_scene_to_packed(open_world_scene)
	
func set_game_menu_scene():
	get_tree().change_scene_to_packed(game_menu_scene)
