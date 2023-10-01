extends Node3D
	
var transitioning: bool = false


func _ready() -> void:
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	set_physics_process(true)
	
	
func _physics_process(delta: float) -> void:
	position.y += delta * 2 / 3
	

func _on_player_edge_detected() -> void:
	

	%Player.run_direction = %Player.run_direction.rotated(Vector3.UP, PI/2 * sign(%Player.speed))
	%Player.rotate_y(PI/2 * sign(%Player.speed))
	
	var tween = create_tween()
	tween.tween_property(self, "rotation", rotation + Vector3.UP * PI/2 * sign(%Player.speed), 0.2)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	get_tree().paused = true
	await tween.finished
	get_tree().paused = false
	
	rotation = %Player.rotation

	
