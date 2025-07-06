extends Sprite2D

@onready var parent = $".."

var pressing = false
@export var maxLength = 128
var deadzone = 15

func _ready():
	deadzone = parent.deadzone
	maxLength *= parent.scale.x

func _process(delta):
	if pressing:
		var touch_pos = get_viewport().get_mouse_position()
		if touch_pos.distance_to(parent.global_position) <= maxLength:
			global_position = touch_pos
		else:
			var angle = parent.global_position.angle_to_point(touch_pos)
			global_position.x = parent.global_position.x + cos(angle)*maxLength
			global_position.y = parent.global_position.y + sin(angle)*maxLength
		calculateVector()
	else:
		global_position = lerp(global_position, parent.global_position, delta*10)
		parent.posVector = Vector2.ZERO

func calculateVector():
	if abs(global_position.x - parent.global_position.x) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x) / maxLength
	if abs(global_position.y - parent.global_position.y) >= deadzone:
		parent.posVector.y = (global_position.y - parent.global_position.y) / maxLength

func start_pressing():
	pressing = true

func stop_pressing():
	pressing = false
