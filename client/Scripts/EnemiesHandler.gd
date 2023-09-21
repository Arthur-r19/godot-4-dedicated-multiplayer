extends Node2D

@export var EnemyTemplateScene: PackedScene

var last_world_state_timestamp = 0

func spawn(player_id, spawn_position):
	if multiplayer.get_unique_id() == player_id:
		Pry.log("cant spawn myself("+str(player_id)+")")
		return
	if has_node(str(player_id)):
		return
	var enemy_template = EnemyTemplateScene.instantiate()
	enemy_template.name = str(player_id)
	enemy_template.global_position = spawn_position
	Pry.log("enemy_template:" + str(enemy_template))
	add_child(enemy_template, true)

	
func despawn(player_id):
	if has_node(str(player_id)):
		get_node(str(player_id)).queue_free()

func update(world_state):
	# Buffer
	# Interpolation
	# Extrapolation
	# Rubber banding
	if world_state['T'] < last_world_state_timestamp:
		return
	last_world_state_timestamp = world_state['T']
	world_state.erase('T') # needed later for inter/extrapolation
	world_state.erase(multiplayer.get_unique_id()) # maybe needed later for anti...
	for player_id in world_state.keys():
		if has_node(str(player_id)):
			get_node(str(player_id)).move_player(world_state[player_id]['P'])
		else:
			spawn(player_id, world_state[player_id]['P'])
	
	
	
