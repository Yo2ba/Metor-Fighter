extends Control

@onready var play_scene = preload('res://scenes/loading_screen.tscn')
@onready var settings_scene = load('res://scenes/settings.tscn')
@onready var changelogs_scene = load('res://scenes/changelogs.tscn')
@onready var ver_label: Label = $VersionLabel/Label

@export var play: Button
@export var settings: Button
@export var changes: Button
@export var changes2: Button
@onready var buttons: Array[Button] = [play,settings,changes,changes2]

func _ready() -> void:
	for button in buttons:
		var short_name: String = str(button.name.replace('Btn','').to_lower())
		button.connect('pressed',Callable(self, "button_pressed").bind(short_name))


func button_pressed(btn):
	var scene
	match btn:
		'play':
			scene = play_scene
		'settings':
			scene = settings_scene
		'changes':
			scene = changelogs_scene
		'changes2':
			scene = changelogs_scene
	var new_scene = scene.instantiate()
	get_parent().add_child(new_scene)
	queue_free()
