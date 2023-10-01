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


func _physics_process(delta: float) -> void:
	$PlayerModel/RayCast3D.enabled = true
	if $PlayerModel/RayCast3D.is_colliding():
		edge_detected.emit()
		$PlayerModel/RayCast3D.enabled = false
	
	var h_input = Input.get_axis("left", "right")
	
	$PlayerModel.scale.z = h_input / 2 if h_input != 0 else $PlayerModel.scale.z
	
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
	
	
	#Jumping and falling
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity
		
	if !is_on_floor():
		var gravity = fall_gravity if velocity.y < 0 else jump_gravity
		velocity.y -= gravity * delta
	
	
	move_and_slide()
