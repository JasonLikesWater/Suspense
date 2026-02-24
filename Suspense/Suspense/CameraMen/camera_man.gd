extends CharacterBody3D


signal changeEmotions(emotions, text)
signal targetRelocate(location : Vector3)
signal changeWage(money, wageIncrease)


@export var target : Node3D
@export var audience_control : Node


@onready var player = get_tree().get_first_node_in_group("Players")
@onready var lineOfSight = $RayCast3D
@onready var body = $Body
@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var investedRange = $InvestedRange
@onready var suspsenseRange = $SuspenseRange
@onready var frontRange = $FrontRange
@onready var runningTimer = $RunningTimer
@onready var changeStateTimer = $ChangeState


enum states{
	roaming,
	investigating,
	still,
	runningAway
} 


var playerNear = false
var speed = 7
var accel = 10
var current_state = states.roaming
var looking = true


func _process(delta):
	#if velocity == Vector3.ZERO:
		#$AnimationPlayer.stop()
	#else:
		#$AnimationPlayer.play("Walk")
	#if a player is near the manager
	if playerNear and looking:
		#get any overlapping bodies in the cone
		var overlaps = frontRange.get_overlapping_bodies()
		# if there are any overlapping bodies
		if overlaps.size() > 0:
			#for every vody
			for overlap in overlaps:
				#check if it is the player
				if overlap == player:
					if not player.hidden:
						#get the player's location
						var playerPosition = overlap.global_transform.origin
						#send a ray to the player
						lineOfSight.look_at(playerPosition, Vector3.UP)
						lineOfSight.force_raycast_update()
						#if the ray is colliding something
						if lineOfSight.is_colliding():
							#store collider in a variable and check if it is the player
							var collider = lineOfSight.get_collider()
							if collider == player and not current_state == states.runningAway:
								$AudioStreamPlayer.play()
								changeEmotions.emit(4)
								targetRelocate.emit(Vector3(player.global_position.x, 0, player.global_position.z))
								current_state = states.runningAway
									#mainCamera.current = true
									#this is for the when the player is caught	
		#if player not near manager roam
	match current_state:
		states.roaming:
			speed = 7
			roam(delta, 1)
		states.investigating:
			speed = 3
			roam(delta, 1)
		states.still:
			velocity = Vector3.ZERO
		states.runningAway:
			speed = 13
			roam(delta, -1)
	move_and_slide()


func roam(delta, modifier):
	#if manager is not waiting
	#move the manager towards the target
	var direction = Vector3.ZERO
	nav.target_position = target.global_position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	#make manager turn in direction he is moving
	#look_at(Vector3(nav.target_position.x , 1, nav.target_position.z))
	if (velocity + transform.origin).distance_to(global_position) > 1:
		look_at(transform.origin + velocity, Vector3.UP)
	else:
		rotation = Vector3.ZERO
	direction.y = 0
	velocity = velocity.lerp(direction * speed * modifier, accel * delta)


func _on_invested_range_body_entered(body):
	playerNear = true


func _on_invested_range_body_exited(body):
	playerNear = false
	if current_state == states.runningAway:
		runningTimer.start(randf_range(0, 3))


func _on_running_timer_timeout():
	current_state = states.roaming
	targetRelocate.emit(Vector3.ZERO)


func jumpscare(hellFire):
	match audience_control.current_emotion:
		emotionControl.emotions.BORED:
			changeWage.emit(10.00, 2.00)
			changeEmotions.emit(1)
		emotionControl.emotions.INTERESTED:
			changeWage.emit(20.00, 3.00)
			changeEmotions.emit(5)
		emotionControl.emotions.DISAPPOINTED:
			changeWage.emit(10.00, 1.00)
			changeEmotions.emit(1)
		emotionControl.emotions.SCARED:
			changeWage.emit(40.00, 8.00)
			changeEmotions.emit(3)
		emotionControl.emotions.SUSPENSFUL:
			changeWage.emit(50.00, 7.00)
			changeEmotions.emit(3)
		emotionControl.emotions.INVESTED:
			changeWage.emit(30.00, 4.00)
			changeEmotions.emit(3)
	if hellFire:
		changeWage.emit(10, 0)
		
	
	queue_free()


func _on_change_state_timeout():
	changeStateTimer.start(randi_range(2, 8))
	var rand = randi_range(0, 2)
	if rand == 0:
		current_state = states.roaming
	elif  rand == 1:
		current_state = states.investigating
	else:
		current_state = states.still


func stun():
	looking = false
	current_state = states.still


func _on_stun_timer_timeout():
	looking = true
	current_state = states.investigating
