extends Node

@export var PORT = 1909
@export var MAX_PLAYERS = 100
var network = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	start_server()
	
func start_server():
	network.create_server(PORT, MAX_PLAYERS)
	multiplayer.multiplayer_peer = network
	print("Server Started")
	
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)


func _peer_connected(id):
	print("User " +str(id)+" Connected")
	
	
func _peer_disconnected(id):
	print("User " +str(id)+" Disconnected")
	
