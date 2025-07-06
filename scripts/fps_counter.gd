extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Commands.connect('showfps',fps_toggle)
	hide()

func fps_toggle(OnOff) -> void:
	if OnOff == '1':
		show()
		text = 'FPS: '+ str(int(Engine.get_frames_per_second()))
	elif OnOff == '0':
		hide()
