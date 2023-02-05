class_name Player
extends Actor


# warning-ignore:unused_signal
signal collect_coin()
signal dialog_start()
signal dialog_end()

const FLOOR_DETECT_DISTANCE = 20.0

export(String) var action_suffix = ""

onready var platform_detector = $PlatformDetector
onready var animation_player = $AnimationPlayer
onready var shoot_timer = $ShootAnimation
onready var sprite = $Sprite
onready var sound_jump = $Jump

var trampoline_flag = 0
var base_jumps = 1
var jumps_remaining = 0
var interactable_list = []
var gliding = false
var running = false

func _ready():
	# Static types are necessary here to avoid warnings.
	var camera: Camera2D = $Camera
	camera.custom_viewport = $"../.."
	yield(get_tree(), "idle_frame")
	camera.make_current()

# Physics process is a built-in loop in Godot.
# If you define _physics_process on a node, Godot will call it every frame.

# We use separate functions to calculate the direction and velocity to make this one easier to read.
# At a glance, you can see that the physics process loop:
# 1. Calculates the move direction.
# 2. Calculates the move velocity.
# 3. Moves the character.
# 4. Updates the sprite direction.
# 5. Shoots bullets.
# 6. Updates the animation.

# Splitting the physics process logic into functions not only makes it
# easier to read, it help to change or improve the code later on:
# - If you need to change a calculation, you can use Go To -> Function
#   (Ctrl Alt F) to quickly jump to the corresponding function.
# - If you split the character into a state machine or more advanced pattern,
#   you can easily move individual functions.
func _physics_process(_delta):
	if is_on_floor():
		jumps_remaining = base_jumps
	
	var jump = false
	if Input.is_action_just_pressed("jump" + action_suffix):
		if is_on_floor() or jumps_remaining > 0:
			# Play jump sound
			sound_jump.play()
			jump = true
			jumps_remaining -= 1
	
	
	
	var direction = get_direction(jump)
	
	running = Input.is_action_pressed("run")
	
	var is_jump_interrupted = Input.is_action_just_released("jump" + action_suffix) and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	
	if running:
		_velocity.x *= 2.0

	var snap_vector = Vector2.ZERO
	if direction.y == 0.0:
		snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE
	var is_on_platform = platform_detector.is_colliding()
	
	
	if not is_on_floor():
		if Input.is_action_just_pressed("glide"):
			gliding = not gliding
	else:
		gliding = false
	
	#clamp the velocity to a fixed value
	if gliding:
		_velocity.y = 100.0
	
	_velocity = move_and_slide_with_snap(
		_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
	)

	# When the character’s direction changes, we want to to scale the Sprite accordingly to flip it.
	# This will make Robi face left or right depending on the direction you move.
	if direction.x != 0:
		if direction.x > 0:
			sprite.scale.x = abs(sprite.scale.x)
		else:
			sprite.scale.x = -abs(sprite.scale.x)
	
	
	
	# We use the sprite's scale to store Robi’s look direction which allows us to shoot
	# bullets forward.
	# There are many situations like these where you can reuse existing properties instead of
	# creating new variables.

	var animation = get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)

func _input(event):
	if event.is_action_pressed("interact") && interactable_list.size() > 0:
		interactable_list[-1].interact()

func get_direction(jump):
	return Vector2(
		Input.get_action_strength("move_right" + action_suffix) - Input.get_action_strength("move_left" + action_suffix),
		-1 if jump else 0
	)

# This function calculates a new velocity whenever you need it.
# It allows you to interrupt jumps.
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	elif trampoline_flag and linear_velocity.y > 0:
		# only activate the trampoline if the player is falling
		velocity.y = trampoline_flag * -1
		trampoline_flag = 0
		jumps_remaining = base_jumps - 1
	if is_jump_interrupted:
		# Decrease the Y velocity by multiplying it, but don't set it to 0
		# as to not be too abrupt.
		velocity.y *= 1.0
	return velocity


func get_new_animation(_is_shooting = false):
	var animation_new = ""
	if is_on_floor():
		if abs(_velocity.x) > 0.1:
			if running:
				animation_new = "fastrun"
			else:
				animation_new = "run"
		else:
			animation_new = "idle"
	else:
		if gliding:
			animation_new = "glide"
		elif _velocity.y > 0:
			animation_new = "falling"
		else:
			animation_new = "jumping"
	return animation_new

func _on_Trampoline(spring_power):
	trampoline_flag = spring_power

func _on_Interactable_enter(interactable_obj):
	interactable_obj.highlight()
	interactable_list.append(interactable_obj)
	print_debug(interactable_list)

func _on_Interactable_exit(interactable_obj):
	interactable_obj.unhighlight()
	interactable_list.erase(interactable_obj)
	print_debug(interactable_list)

func _on_dialog_start():
	$Camera.offset.x += 200
func _on_dialog_end():
	$Camera.offset.x -= 200
