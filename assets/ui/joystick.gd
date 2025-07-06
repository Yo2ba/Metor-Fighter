extends Node2D

@export var deadzone := 30.0
@export var joystick_area_width := 400.0
@export var joystick_area_top_margin := 120.0

@onready var knob = $Knob

var posVector: Vector2 = Vector2.ZERO
var active_touch_id: int = -1

func _ready():
	# Optional: scale knob max distance if needed
	knob.deadzone = deadzone

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var touch_area = Rect2(
				Vector2(0, joystick_area_top_margin),
				Vector2(joystick_area_width, get_viewport_rect().size.y - joystick_area_top_margin)
			)
			
			if touch_area.has_point(event.position) and active_touch_id == -1:
				position = event.position
				active_touch_id = event.index
				knob.start_pressing()
		else:
			if event.index == active_touch_id:
				active_touch_id = -1
				knob.stop_pressing()
