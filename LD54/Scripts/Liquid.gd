extends Area3D
#
#func _physics_process(delta: float) -> void:
#	position.y += delta * 2 / 3


func _on_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()
