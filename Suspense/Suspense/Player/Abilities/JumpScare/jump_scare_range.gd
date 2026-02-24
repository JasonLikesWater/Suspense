extends Area3D


@export var camera_man : CharacterBody3D = null


@onready var player = get_tree().get_first_node_in_group("Players")
@onready var timer = $Timer
@onready var animation = $AnimationPlayer
@onready var label = $Label


func _process(delta):
	if camera_man != null:
		if not player.hidden and not player.shopping:
			if Input.is_action_pressed("jump_scare"):
				if timer.is_stopped():
					timer.start()
					animation.play("jumpScare")
			if not timer.is_stopped():
				if not Input.is_action_pressed("jump_scare"):
					animation.play("RESET")
			
			


func _on_body_entered(body):
	camera_man = body
	label.show()


func _on_body_exited(body):
	if body == camera_man:
		camera_man = null
		label.hide()
		animation.play("RESET")


func _on_timer_timeout():
	if Input.is_action_pressed("jump_scare") and camera_man != null:
		camera_man.jumpscare(false)
		timer.stop()
		animation.play("RESET")
		if player.type == "Demon":
			$Node2D2/Bodies/Demon.show()
		elif player.type == "Ghost":
			$Node2D2/Bodies/Ghost.show()
		elif player.type == "Beast":
			$Node2D2/Bodies/Beast.show()
		else:
			$Node2D2/Bodies/Blank.show()
		$AnimationPlayer2.play("jump")
		$AudioStreamPlayer.play()
		


func play_jump():
	if player.type == "Demon":
		$Node2D2/Bodies/Demon.show()
	elif player.type == "Ghost":
		$Node2D2/Bodies/Ghost.show()
	elif player.type == "Beast":
		$Node2D2/Bodies/Beast.show()
	else:
		$Node2D2/Bodies/Blank.show()
	$AnimationPlayer2.play("jump")
	$AudioStreamPlayer.play()
