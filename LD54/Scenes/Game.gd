extends Node

@onready var world = $World
var world_scene := preload("res://Scenes/World.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$Menus.visible = !$Menus.visible
		get_tree().paused = $Menus.visible
		
		
func restart() -> void:
	world.queue_free()
	world = world_scene.instantiate()
	add_child(world)
	$DeathSound.play()
	
