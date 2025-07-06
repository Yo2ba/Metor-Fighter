extends Control

var main_scene: String
var new_scene: PackedScene
var tip_index: int
@export var TipLabel: Label
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@export var tip: Array[String] = []

func _ready() -> void:
	tip_index = rng.randf_range(0,tip.size()-1)
	TipLabel.text = tip[tip_index]
	if TipLabel.text == tip[4]:
		TipLabel.add_theme_color_override('font_color',Color.RED)
	else:
		TipLabel.remove_theme_color_override('font_color')
	
	main_scene = 'res://scenes/main.tscn'
	ResourceLoader.load_threaded_request(main_scene)
	new_scene = ResourceLoader.load_threaded_get(main_scene)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed('fire'):
		if tip_index > tip.size()-2:
			tip_index = 0
		else:
			tip_index += 1
		TipLabel.text = tip[tip_index]
		if TipLabel.text == tip[4]:
			TipLabel.add_theme_color_override('font_color',Color.RED)
		else:
			TipLabel.remove_theme_color_override('font_color')

func _on_least_waiting_time_timeout() -> void:
	get_tree().change_scene_to_packed(new_scene)
