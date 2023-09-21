extends CharacterBody2D

var is_attacking = false
var is_defending = false

func move_player(new_position):
	if !is_attacking and !is_defending:
		if new_position == position:
			$AnimationPlayer.play("idle")
		else:
			$AnimationPlayer.play("walk")
	
	if new_position != position:
		global_position = new_position

func rotate_player(new_rotation):
	$Axis.rotation = new_rotation
	
func attack():
	is_attacking = true
	$AnimationPlayer.play("attack_2")
	
func end_attack():
	is_attacking = false
	
