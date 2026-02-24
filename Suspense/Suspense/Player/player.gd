extends CharacterBody3D


@onready var pivot = $Pivot
@onready var camera_origin = $CameraOrigin
@onready var animation = $AnimationPlayer
@onready var ghost_node = $Pivot/Ghost
@onready var demon_node = $Pivot/Demon
@onready var beast_node = $Pivot/Beast
@onready var default_node = $Pivot/Body
@onready var shop_tip = $Label


@export var speed = 7
@export var type = "Blank"
@export var hidden = false
@export var shopping = false
@export var sensitivity = 0.5


var direction = Vector3.ZERO
var target_velocity = Vector3.ZERO
var movement = true
var appearance = []


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if not shopping:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * sensitivity))
			camera_origin.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
			camera_origin.rotation.x = clamp(camera_origin.rotation.x, deg_to_rad(-90), deg_to_rad(45))


func _physics_process(delta):
	if not shopping:
		shop_tip.show()
	else:
		shop_tip.hide()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if movement:
		var input_dur = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction_main = (transform.basis * Vector3(input_dur.x, 0, input_dur.y)).normalized()
		if direction_main:
			velocity.x = direction_main.x * speed
			velocity.z = direction_main.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	elif not movement or shopping:
		velocity = Vector3.ZERO
	if velocity != Vector3.ZERO:
		if not animation.is_playing():
			animation.play("walk")
	else:
		animation.play("RESET")
			
	## We create a local variable to store the input direction.
		#direction = Vector3.ZERO
		## We check for each move input and update the direction accordingly.
		#if Input.is_action_pressed("move_right"):
			#direction.x += 1
		#if Input.is_action_pressed("move_left"):
			#direction.x -= 1
		#if Input.is_action_pressed("move_back"):
			## Notice how we are working with the vector's x and z axes.
			## In 3D, the XZ plane is the ground plane.
			#direction.z += 1
		#if Input.is_action_pressed("move_forward"):
			#direction.z -= 1
	#else:
		#direction = Vector3.ZERO
	#if direction != Vector3.ZERO:
			#direction = direction.normalized()
			##direction.lerp()
			#pivot.look_at(position + direction, Vector3.UP)
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed
	#velocity = target_velocity
	#
	
	move_and_slide()
	if hidden:
		pivot.hide()
	else:
		pivot.show()
		


func _on_shop_interface_player_movement(boolean):
	movement = boolean


func _on_shop_interface_shopping(boolean):
	shopping = boolean
	velocity = Vector3.ZERO
	if shopping:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_shop_interface_player_appearance(appearance_new):
	if appearance.is_empty():
		if appearance_new == "Beast":
			beast_node.show()
			type = "Beast"
		elif appearance_new == "Demon":
			demon_node.show()
			type = "Demon"
		else:
			ghost_node.show()
			type = "Ghost"
	appearance.append(appearance_new)
	default_node.hide()


func play_jump():
	$JumpScareRange.play_jump()
