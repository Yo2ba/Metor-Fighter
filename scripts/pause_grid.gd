extends Control

var GRID_SIZE: Vector2 = Vector2(1152,648)
var CELL_SIZE: Vector2 = Vector2(32,32)
var CELL_SIZE_2: Vector2 = Vector2(64,64)
var CELLS_AMOUNT: Vector2 = Vector2(GRID_SIZE.x/CELL_SIZE.x, GRID_SIZE.y/CELL_SIZE.y)
@export var GRID_COLOR : Color


func _draw() -> void:

	# draw vertical lines
	for i in CELLS_AMOUNT.x:
		var from: Vector2 = Vector2(i * CELL_SIZE.x, 0)
		var to: Vector2 = Vector2(from.x, GRID_SIZE.y)
		draw_line(from, to, GRID_COLOR,1)
	
	# draw horizontal lines
	for i in CELLS_AMOUNT.y:
		var from: Vector2 = Vector2(0, CELL_SIZE.y * i)
		var to: Vector2 = Vector2(GRID_SIZE.x, from.y)
		draw_line(from, to, GRID_COLOR,1)
