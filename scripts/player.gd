extends CharacterBody2D

# MOVEMENT CONSTANTS
const SPEED := 130.0
const JUMP_VELOCITY := -300.0

# DASH CONSTANTS
const DASH_SPEED := 300.0           # Horizontal speed during dash
const DASH_DURATION := 0.15         # Seconds the dash lasts
const DASH_COOLDOWN := 0.50         # Seconds before the next dash

# DASH STATE
var dash_time_left := 0.0           # Time remaining for the current dash
var dash_cooldown_time := 1.0       # Time remaining for cooldown
var facing := 1                     # 1 = right, -1 = left

# DOUBLE JUMP STATE
var jumps_count: int = 0
const max_jumps: int = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
# Sounds effects
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var dash: AudioStreamPlayer2D = $dash

# Proyectile



func _physics_process(delta: float) -> void:
	# Update dash timers 
	if dash_time_left > 0.0:
		dash_time_left -= delta
	if dash_cooldown_time > 0.0:
		dash_cooldown_time -= delta

	# Apply gravity only when not dashing
	if dash_time_left <= 0.0 and not is_on_floor():
		velocity += get_gravity() * delta

	# Reset jump count on floor 
	if is_on_floor():
		jumps_count = 0

	# Jump / double jump (disabled during dash)
	if Input.is_action_just_pressed("jump") and jumps_count < max_jumps and dash_time_left <= 0.0:
		velocity.y = JUMP_VELOCITY
		jumps_count += 1
		jump.play()

	# Read horizontal input: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")

	# Update facing (used by dash and sprite flip)
	if direction != 0:
		facing = 1 if direction > 0 else -1

	# Flip sprite based on facing
	animated_sprite.flip_h = (facing < 0)

	# Start dash if pressed, not already dashing, and no cooldown
	if Input.is_action_just_pressed("dash") and dash_time_left <= 0.0 and dash_cooldown_time <= 0.0:
		dash_time_left = DASH_DURATION
		dash_cooldown_time = DASH_COOLDOWN
		velocity.y = 0.0  
		dash.play()

	# Horizontal movement
	if dash_time_left > 0.0:
		# Force strong horizontal velocity while dashing
		velocity.x = facing * DASH_SPEED
	else:
		# Normal ground/air control
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Move character
	move_and_slide()
