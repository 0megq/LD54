@tool
extends GridMap

@export var size: float = 32
@export var height: float = 48
@export var index: int = 0



@export var clear_grid: bool = false:
	set(value):
		if confirm_clear:
			confirm_clear = false
			clear_grid = false
			clear()
			
			
@export var confirm_clear: bool = false

@export var fill_box: bool = false:
	set(value):
		fill_box = false
		for x in size:
			for y in height:
				for z in size:
					set_cell_item(Vector3i(x - size / 2, y, z - size / 2), index)
		
					
