extends Node

@export var port = 1909
@export var ip = "127.0.0.1"
#@export var MAX_PLAYERS = 100
var network = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#start_server()
	pass
	
func start_server():
	var err = network.create_client(ip, port)
	if err != OK:
		return err
	multiplayer.multiplayer_peer = network
	
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	
	return OK


func _on_connected_to_server():
	print("Connected to server")
	SceneHandler.set_open_world_scene()
	
func _on_connection_failed():
	print("Failed to connect")
	SceneHandler.set_game_menu_scene()
	
