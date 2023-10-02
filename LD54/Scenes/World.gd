extends Node3D


func restart() -> void:
	get_parent().restart()


func _on_win_detector_body_entered(body: Node3D) -> void:
	get_parent().win()
