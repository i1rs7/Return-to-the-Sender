extends CharacterBody2D


@onready var SPEED = 125.0
const NORMAL_SPEED = 125.0
const JUMP_VELOCITY = -300.0

# for animations
@onready var anim_sprite = $AnimatedSprite2D

#for double jump
@onready var max_jumps = 2
@onready var jumps_left = max_jumps

#for dash
@export var max_dash = 2
@export var dash_left = max_dash
@export var dash_speed = 400.0 # Speed during the dash
@export var dash_duration = 0.2 # How long the dash lasts
@export var dash_cooldown = 1.0
@export var is_dashing = false
@export var can_dash = true

@onready var dash_timer = $Dash
@onready var dash_cooldown_timer = $DashCooldown

#for death
@onready var controls_enabled = true


	
func _ready():
	#double jump
	jumps_left = max_jumps
	
	#death
	controls_enabled = true
	
	#dash
	dash_left = max_dash
	dash_timer.wait_time = dash_duration
	dash_cooldown_timer.wait_time = dash_cooldown

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if controls_enabled == false:
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_left = max_jumps  # Reset jumps when on ground

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Handle dash.
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash(direction, anim_sprite.flip_h)
	
	#debug change scene
	if Input.is_action_just_pressed("change_scene"):
		if get_tree().current_scene.name == "Level 1":
			get_tree().change_scene_to_file("res://Scenes/Level 2.tscn")
		else: 
			get_tree().change_scene_to_file("res://Scenes/Level 1.tscn")
	
	move_and_slide()
	update_animation(direction)

#walk, jump, idle, dash animations
func update_animation(direction):
	if not is_on_floor():
		anim_sprite.play("jump")
	elif direction != 0:
		if is_dashing:
			anim_sprite.play("dash")
		else:
			anim_sprite.play("walk")
	else:
		anim_sprite.play("idle")

	# Flip sprite if moving left
	if direction < 0:
		anim_sprite.flip_h = true
	elif direction > 0:
		anim_sprite.flip_h = false
	
#dash functions
func start_dash(direction, is_anim_flipped):
	is_dashing = true
	dash_left -= 1
	SPEED = dash_speed
	dash_timer.start()
	if dash_left == 0:
		can_dash = false
	else:
		can_dash = true
	if direction == 0.0:
		if is_anim_flipped:
			velocity = Vector2(0,1) * dash_speed
		else:
			velocity = Vector2(1,0) * dash_speed
	else:
		velocity.x = direction * dash_speed
	
func _on_dash_timeout() -> void:
	SPEED = NORMAL_SPEED
	is_dashing = false
	velocity = Vector2.ZERO # Stop the dash immediately
	dash_cooldown_timer.start() # Start the cooldown
	dash_timer.wait_time = dash_duration
	
func _on_dash_cooldown_timeout() -> void:
	can_dash = true
	dash_left = max_dash
	dash_cooldown_timer.wait_time = dash_cooldown 
#DASH DONE

func _on_area_2d_body_entered(body: Node2D) -> void:
	anim_sprite.play("death")
	controls_enabled = false
	$Death.start()
		


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level 1.tscn")


func _on_cure_body_entered(body: Node2D) -> void:
	anim_sprite.play("happy")
	controls_enabled = false
	$"../UI".show()
	



func _on_delete_dash_pressed() -> void:
	max_dash = 1
	$"../UI/dash".hide()
	$"../UI/nodash".show()
	$"../UI/L1_Change_Scene".start()
	
func _on_delete_double_jump_pressed() -> void:
	max_jumps = 1
	$"../UI/doublejump".hide()
	$"../UI/nodoublejump".show()
	$"../UI/L1_Change_Scene".start()
	
func _on_l_1_change_scene_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level 2.tscn")


func _on_death_timeout() -> void:
	get_tree().reload_current_scene()
