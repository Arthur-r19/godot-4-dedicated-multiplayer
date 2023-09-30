extends CharacterBody2D

@export var SPEED = 450
@export var SPEED_WHILE_DEFENDING = 0.3

var is_attacking = false
var is_defending = false

var player_state
var player_name
func _process(_delta):
	pass

func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	velocity = direction * SPEED
	
	if !is_attacking and !is_defending:
		if velocity != Vector2.ZERO:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	
	if is_defending and !Input.is_action_pressed("defend"):
		end_defend()
		end_attack()
	#if is_attacking and !Input.is_action_pressed("attack"):
	#	end_attack()
	
	if !is_attacking and Input.is_action_pressed("attack"):
		is_attacking = true
		$AnimationPlayer.play("attack_2")
		Server.send_player_attack()
	
	elif !is_defending and Input.is_action_pressed("defend"):
		is_defending = true
		$AnimationPlayer.play("defend")
	
	if is_defending:
		velocity *= SPEED_WHILE_DEFENDING
	
	move_and_slide()
	
	set_player_state()

func end_attack():
	is_attacking = false
func hold_defend():
	$AnimationPlayer.play("defend_holding")
func end_defend():
	is_defending = false
	
func set_player_state():
	player_state = {"T": Time.get_unix_time_from_system(), "P": global_position, "A": $Axis.rotation}
	Server.send_player_state(player_state)
