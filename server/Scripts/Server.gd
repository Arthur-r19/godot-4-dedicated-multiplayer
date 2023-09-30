extends Node

@export var ip = "127.0.0.1"
@export var PORT = 1909
@export var MAX_PLAYERS = 100
var network = ENetMultiplayerPeer.new()

var player_state_collection = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	start_server()
	

func start_server():
	network.set_bind_ip(ip)
	network.create_server(PORT, MAX_PLAYERS)
	multiplayer.multiplayer_peer = network
	print("Server Started")
	
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)


func _peer_connected(player_id):
	print("User " +str(player_id)+" Connected")
	%PlayerVerification.start(player_id)
	
	

func _peer_disconnected(player_id):
	print("User " +str(player_id)+" Disconnected")
	if has_node(str(player_id)):
		get_node(str(player_id)).queue_free()
		player_state_collection.erase(player_id)
		rpc("despawn_player", player_id)
	
	
@rpc
func spawn_player(player_id, spawn_position):
	var err = rpc("spawn_player", player_id, Vector2(1574, 931))
	print(err)
	
@rpc
func despawn_player(player_id): pass

@rpc("unreliable", "any_peer")
func receive_player_state(player_state):
	var player_id = multiplayer.get_remote_sender_id()
	if player_state_collection.has(player_id):
		if player_state_collection[player_id]['T'] < player_state['T']:
			player_state_collection[player_id] = player_state
	else:
		player_state_collection[player_id] = player_state

@rpc("unreliable", "any_peer")
func receive_player_attack():
	var player_id = multiplayer.get_remote_sender_id()
	rpc("set_player_attack", player_id)

@rpc("unreliable")
func set_player_attack(player_id): pass

@rpc("unreliable")
func receive_world_state(world_state): pass

func send_world_state(world_state):
	rpc("receive_world_state", world_state)
	
