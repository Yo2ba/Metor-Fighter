extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/VBoxContainer/StatMetors.text = str('Meteors destroyed: ',Global.destroyed_meteors)
	$VBoxContainer/VBoxContainer/StatScore.text = str('Score: ',Global.score)

func _process(_delta: float) -> void:
	Global.anim_factor = 1
	if Input.is_action_just_pressed('return'):
		get_tree().change_scene_to_file('res://scenes/main.tscn')
		Global.restart()
	if Input.is_action_just_pressed('esc'):
		get_tree().change_scene_to_file('res://scenes/menu_manager.tscn')
		Global.restart()


func _on_btn_restart_button_up() -> void:
	get_tree().change_scene_to_file('res://scenes/main.tscn')
	Global.restart()


func _on_btn_menu_button_up() -> void:
	get_tree().change_scene_to_file('res://scenes/menu_manager.tscn')
	Global.restart()
