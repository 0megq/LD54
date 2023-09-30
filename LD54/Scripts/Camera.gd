extends Node3D
	
var transitioning: bool = false

func _on_camera_boundary_area_entered(area: Area3D) -> void:
	var tween = create_tween()
	tween.tween_property(self, "rotation", rotation + Vector3.UP * PI/2 * sign(%Player.velocity.x), 0.5)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)

	get_tree().paused = true
	await tween.finished
	get_tree().paused = false

	rotation.y = 0
	
	%testlevel2.rotate_y(-PI/2 * sign(%Player.velocity.x))
	%Player.position.x -= 9 * sign(%Player.velocity.x)
	

func _ready() -> void:
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	set_physics_process(true)
	
	
func _physics_process(delta: float) -> void:
	position.y += delta * 2 / 3
		
