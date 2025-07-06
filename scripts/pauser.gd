extends Node
@onready var pause_menu: Control = $'.'
@onready var hideable: Control = $'../../MobileGUI/Hideable'


var is_paused: bool = false

func _ready() -> void:
	$'../../MobileGUI/PauseBtn'.connect('pressed',PauseBtn_pressed)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed('esc') and not Global.gameover:
		match is_paused:
			true:
				unpause()
			false:
				pause()

func PauseBtn_pressed() -> void:
	print('pressed')
	match is_paused:
		true:
			unpause()
		false:
			pause()

func pause():
	get_tree().paused = true
	is_paused = true
	pause_menu.show()
	$MarginContainer/CenterContainer/HBoxContainer/Control/Coins.text = str(Global.coins)
	if Platform.is_mobile:
		hideable.hide()
func unpause():
	get_tree().paused = false
	is_paused = false
	pause_menu.hide()
	if Platform.is_mobile:
		hideable.show()
