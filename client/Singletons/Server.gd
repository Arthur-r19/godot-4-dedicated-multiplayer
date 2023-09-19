extends Node

@export var port = 1909
@export var ip = "127.0.0.1"
#@export var MAX_PLAYERS = 100
var network = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	start_server()
	
func start_server():
	network.create_client(ip, port)
	multiplayer.multiplayer_peer = network
	
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)


func _on_connected_to_server():
	print("Connected to server")
	
func _on_connection_failed():
	print("Failed to connect")
	
