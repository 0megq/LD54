extends CanvasLayer



func _ready() -> void:
	get_tree().paused = true
	$CreditsPanel.hide()
	$ControlsPanel.hide()


func _on_play_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_controls_pressed() -> void:
	$ControlsPanel.show()


func _on_credits_pressed() -> void:
	$CreditsPanel.show()


func _on_quit_pressed() -> void:
	get_tree().quit()
	

func _on_close_credits_pressed() -> void:
	$CreditsPanel.hide()


func _on_close_controls_pressed() -> void:
	$ControlsPanel.hide()


func _on_check_button_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(0, button_pressed)
