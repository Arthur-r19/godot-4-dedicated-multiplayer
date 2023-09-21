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
	Pry.log("Connected to server")
	SceneHandler.set_open_world_scene()
	
func _on_connection_failed():
	print("Failed to connect")
	SceneHandler.set_game_menu_scene()
	

@rpc
func spawn_player(player_id, spawn_position):
	Pry.log('trying to spawn player '+str(player_id)+' at '+str(spawn_position))
	get_tree().root.get_node("World/Enemies").spawn(player_id, spawn_position)

@rpc
func despawn_player(player_id):
	Pry.log('despawning player '+str(player_id))
	get_tree().root.get_node("World/Enemies").despawn(player_id)

@rpc("unreliable", "any_peer")
func receive_player_state(player_state): pass

#@rpc("unreliable")
#func send_world_state(world_state): pass

func send_player_state(player_state):
	Pry.log("sending my state"+str(player_state))
	rpc_id(1, "receive_player_state", player_state)

@rpc("unreliable")
func receive_world_state(world_state):
	get_tree().root.get_node("World/Enemies").update(world_state)
