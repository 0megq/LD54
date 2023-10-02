extends CharacterBody3D
class_name Player
signal edge_detected


@export var max_speed: float = 5.0
@export var acceleration: float = 100.0
var run_direction: Vector3 = Vector3.RIGHT
var speed: float

# Jumping
@export var jump_height: float
@export var jump_duration: float
@export var fall_duration: float
@export var max_fall_speed: float

# Determine the gravity and velocity using physics equations 
# based on the height and duration of jump
@onready var fall_gravity: float = (2 * jump_height) / (fall_duration * fall_duration)
@onready var jump_gravity: float =  (2 * jump_height) / (jump_duration * jump_duration)
@onready var jump_velocity: float = (2 * jump_height) / jump_duration

# Quality of life jumping behavior
var can_jump: bool = true
var coyote_time_length: float = 0.1
var jump_was_pressed: bool = false
var remember_jump_length: float = 0.1

func _physics_process(delta: float) -> void:
	detect_edge()
	look()
	move(delta)
	
	if is_on_floor() and velocity.x != 0 and !$WalkSound.playing:
		$WalkSound.stream = load("res://Sound/Walking" + str(randi_range(1, 4)) +".wav")
		$WalkSound.play()
		
	
func look() -> void:
	if Input.get_axis("left", "right") == 0:
		return
	
	$PlayerModel.rotation.y = PI if Input.get_axis("left", "right") < 0 else 0
	
	
func detect_edge() -> void:
	$PlayerModel/RayCast3D.enabled = true
	if $PlayerModel/RayCast3D.is_colliding():
		edge_detected.emit()
		$PlayerModel/RayCast3D.enabled = false


func move(delta: float) -> void:
	var h_input = sign(Input.get_axis("left", "right"))
	
	#Deacceleration
	if h_input == 0 and speed != 0:
		if sign(speed - acceleration * delta * sign(speed)) != sign(speed):
			speed = 0
		speed -= acceleration * delta * sign(speed)
	
	#Acceleration
	speed += h_input * acceleration * delta
	
	#Max speed
	speed = clamp(speed, -max_speed, max_speed)
	
	#Rotating speed
	velocity.x = run_direction.x * speed
	velocity.z = run_direction.z * speed
	
	
	#Jumping	
	if is_on_floor():
		can_jump = true
		if jump_was_pressed:
			jump()

	if Input.is_action_just_pressed("jump"):
		jump_was_pressed = true
		remember_jump_time()
		if can_jump:
			jump()
	
	if !is_on_floor():
		coyote_time()
		
	apply_gravity(delta)
		
	move_and_slide()

func remember_jump_time():
	await get_tree().create_timer(remember_jump_length).timeout
	jump_was_pressed = false


func coyote_time() -> void:
	await get_tree().create_timer(coyote_time_length).timeout
	can_jump = false


func jump() -> void:
	$JumpSound.play()
	velocity.y = jump_velocity

	
func apply_gravity(delta: float) -> void:
	var gravity = fall_gravity if velocity.y < 0 else jump_gravity
	velocity.y -= gravity * delta
	velocity.y = max(velocity.y, -max_fall_speed)
