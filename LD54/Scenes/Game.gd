extends Node

@onready var world: Node = $World
var world_scene := preload("res://Scenes/World.tscn")

func _ready() -> void:
	$Win.hide()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$Menus.visible = !$Menus.visible
		get_tree().paused = $Menus.visible
		
		
func restart() -> void:
	if is_instance_valid(world):
		world.queue_free()
	world = world_scene.instantiate()
	add_child(world)
	$DeathSound.play()
	
	
func win() -> void:
	get_tree().paused = true
	$Win.show()
	await $Win/Button.pressed
	$Win.hide()
	get_tree().paused = false
	
	world.queue_free()
	world = world_scene.instantiate()
	add_child(world)
	
