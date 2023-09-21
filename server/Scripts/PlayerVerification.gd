extends Node

@onready var player_container_scene = preload("res://Scenes/PlayerContainer.tscn")

# Called when the node enters the scene tree for the first time.
func start(player_id):
	"""
	if the token verification is unsuccessfull we send a message and kick the player from the server
	if the token verification is successfull we continue with the
	
	"""
	print("player "+str(player_id)+" verified")
	create_player_container(player_id)
	
func create_player_container(player_id):
	var new_player_container = player_container_scene.instantiate()
	new_player_container.name = str(player_id)
	get_parent().add_child(new_player_container, true)
	# var player_container = get_parent().get_node(str(player_id))
	get_parent().spawn_player(player_id, Vector2(1574, 931))
	
