extends Control

@onready var menu_scene = preload('res://scenes/main_menu.tscn')
@onready var laser_sound = load('res://assets/sfx/348163__djfroyd__laser-one-shot-2.wav')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/MusicSlider.value = Global.music_volume
	$MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer2/SFXSlider.value = Global.sfxx_volume
	$MarginContainer/LabelMargin/CloseMargin/CloseBtn.connect('pressed',close_cross)
	
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		$MarginContainer/CenterContainer/VBoxContainer/HSeparator.hide()
		$MarginContainer/CenterContainer/VBoxContainer/HBoxContainer.hide()
	
	if Platform.is_mobile:
		$MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CheckBox.button_pressed = true
	$MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CheckBox.connect('toggled',mobile_controls_checkbox)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed('esc'):
		var new_scene = menu_scene.instantiate()
		get_parent().add_child(new_scene)
		queue_free()

func mobile_controls_checkbox(toggled_on):
	Platform.is_mobile = true if toggled_on else false

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('MUSIC'),linear_to_db(value))
	Global.music_volume = value

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('SFX'),linear_to_db(value))
	Global.sfxx_volume = value

func close_cross() -> void:
	var new_scene = menu_scene.instantiate()
	get_parent().add_child(new_scene)
	queue_free()


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	Audio.play_sound(laser_sound,-15.918,3.57)
