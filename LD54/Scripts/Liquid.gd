extends Area3D

func _physics_process(delta: float) -> void:
	position.y += delta


func _on_body_entered(body: Node3D) -> void:
	get_parent().restart()
