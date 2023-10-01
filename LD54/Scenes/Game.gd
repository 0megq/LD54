extends Node


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$Menus.visible = !$Menus.visible
		get_tree().paused = $Menus.visible
