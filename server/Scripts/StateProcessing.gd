extends Node

var world_state = {}

func _physics_process(delta):
	if get_parent().player_state_collection.is_empty():
		return
	
	world_state = get_parent().player_state_collection.duplicate(true)
	for player_id in world_state.keys():
		world_state[player_id].erase('T')
	world_state['T'] = Time.get_unix_time_from_system()
	# Verifications
	# Anti-Cheat
	# Cuts (chuncking / maps)
	# Physics checks
	# Anything else you have to do
	get_parent().send_world_state(world_state)
