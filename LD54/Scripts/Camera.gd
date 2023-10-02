extends Node3D
	
var transitioning: bool = false

var lowest_y_pos: float = position.y

var following_player: bool = false


func _ready() -> void:
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	set_physics_process(true)
	
	
func _physics_process(delta: float) -> void:
	lowest_y_pos += delta
	if following_player:
		position.y = lerp(position.y, %Player.position.y - 3, 0.1)
		if abs(position.y - %Player.position.y + 3) < 0.1:
			following_player = false
			return
	
	if position.y - %Player.position.y + 10 < 0:
		following_player = true
	position.y = max(lowest_y_pos, position.y)
	

func _on_player_edge_detected() -> void:
	$Whoosh.play(0.6)
	%Player.run_direction = %Player.run_direction.rotated(Vector3.UP, PI/2 * sign(%Player.speed))
	%Player.rotate_y(PI/2 * sign(%Player.speed))
	
	var tween = create_tween()
	tween.tween_property(self, "rotation", rotation + Vector3.UP * PI/2 * sign(%Player.speed), 0.3)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	get_tree().paused = true
	await tween.finished
	get_tree().paused = false
	
	rotation.y = %Player.rotation.y - PI / 2
	
	following_player = position.y < %Player.position.y - 3

	
