extends Node2D

@export var EnemyTemplateScene: PackedScene

var last_world_state_timestamp = 0
var world_state_buffer = []
const INTERPOLATION_OFFSET = 50

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
	if world_state['T'] < last_world_state_timestamp:
		return
	Pry.log("receiving world_state")
	last_world_state_timestamp = world_state['T']
	world_state_buffer.append(world_state)
	
func _physics_process(delta):
	var render_time = Time.get_unix_time_from_system() - INTERPOLATION_OFFSET
	if world_state_buffer.size() <= 1:
		return
	while world_state_buffer.size() > 2 and render_time > world_state_buffer[1].T:
		world_state_buffer.remove(0)
	#Pry.log(world_state_buffer)
	var time_elapsed_render = float(render_time - world_state_buffer[0]['T'])
	var time_elapsed_states = float(world_state_buffer[1]['T'] - world_state_buffer[0]['T'])
	var interpolation_factor = time_elapsed_render / time_elapsed_states
	for player_id in world_state_buffer[1].keys():
		if str(player_id) == 'T': # ignore timestamp key
			Pry.log("ignore timestamp key")
			continue
		elif player_id == multiplayer.get_unique_id(): # ignore yourselfs
			Pry.log("ignore yourselfs")
			continue
		elif not world_state_buffer[0].has(player_id): # ignore just logged players
			Pry.log("logged players")
			continue
		elif has_node(str(player_id)):
			Pry.log("MOVE PLAYER")
			var new_position = lerp(world_state_buffer[0][player_id]['P'], world_state_buffer[1][player_id]['P'], interpolation_factor)
			get_node(str(player_id)).move_player(new_position)
		else:
			Pry.log("SPAWN PLAYER")
			spawn(player_id, world_state_buffer[1][player_id]['P'])
	
	
	
	
	
	
