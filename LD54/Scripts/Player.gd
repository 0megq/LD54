extends CharacterBody3D
class_name Player

@export var run_speed: float = 20.0


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
	velocity.x = lerp(velocity.x, Input.get_axis("left", "right") * run_speed, 0.4)
	
	velocity.z = 0
	position.z = 4.6
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity
		
	var gravity = fall_gravity if velocity.y < 0 else jump_gravity
	velocity.y -= gravity * delta
	
	move_and_slide()
