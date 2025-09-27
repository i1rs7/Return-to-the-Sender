extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_sprite = $AnimatedSprite2D
@onready var max_jumps = 2
@onready var jumps_left = max_jumps


	
func _ready():
	jumps_left = max_jumps

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_left = max_jumps  # Reset jumps when on ground

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and jumps_left >0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1
		
	if Input.is_action_just_pressed("change scene"):
		get_tree().change_scene_to_file("res://Level 2.tscn")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	update_animation(direction)

func update_animation(direction):
	if not is_on_floor():
		anim_sprite.play("jump")
	elif direction != 0:
		anim_sprite.play("walk")
	else:
		anim_sprite.play("idle")

	# Flip sprite if moving left
	if direction < 0:
		anim_sprite.flip_h = true
	elif direction > 0:
		anim_sprite.flip_h = false
	
	
