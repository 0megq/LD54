extends CanvasLayer



func _ready() -> void:
	get_tree().paused = true
	$CreditsPanel.hide()


func _on_play_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_controls_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	$CreditsPanel.show()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	$CreditsPanel.hide()
