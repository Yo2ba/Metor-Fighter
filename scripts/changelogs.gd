extends Control

@onready var menu_scene = preload('res://scenes/main_menu.tscn')

func _ready() -> void:
	$Text/TitleContents/LabelMargin/CloseMargin/CloseBtn.connect('pressed',close_cross)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed('esc'):
		var new_scene = menu_scene.instantiate()
		get_parent().add_child(new_scene)
		queue_free()

func close_cross() -> void:
	var new_scene = menu_scene.instantiate()
	get_parent().add_child(new_scene)
	queue_free()
