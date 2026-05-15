extends CharacterBody2D


const SPEED = 175.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var double_jump : bool = false

func _physics_process(delta: float) -> void:
	if is_on_floor() and double_jump == true:
		double_jump = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			jump()
		elif double_jump == false:
			double_jump = true
			jump()

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("Move_Left", "Move_Right")
	
	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func jump():
	velocity.y = JUMP_VELOCITY
