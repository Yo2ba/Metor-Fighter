extends Control

@onready var Line: LineEdit = $VBoxContainer/LineEdit
@onready var ConsoleText: RichTextLabel = $VBoxContainer/Panel/MarginContainer/VBoxContainer/Panel/MarginContainer/ConsoleText
var commands_i: int
var commands_pos: int = 0
var command: String: set = command_set
func command_set(value):
	command = value
	if value == 'secret.noclip':
		Global.noclip = !Global.noclip
	elif value == 'showfps':
		Global.fps = !Global.fps

func _ready() -> void:
	Commands.connect('new_text',console_text_update)

func console_text_update(text) -> void:
	var new_line = str('\n',text)
	ConsoleText.append_text(new_line)

var console_shown: bool = false: set = console_shown_set
func console_shown_set(value: bool):
	console_shown = value
	if console_shown == true:
		Line.call_deferred('grab_focus')
		show()
	else:
		Line.call_deferred('release_focus')
		hide()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed('console'):
		console_shown = !console_shown
	
	if event is InputEventKey and Input.is_action_just_pressed('return'):
		if Line.text != '':
			Commands.command = Line.text
			commands_i = Commands.command_history.size()-1
			Line.clear()
			commands_pos = 0
	if event is InputEventKey and Input.is_action_just_pressed('ArrowUp'):
		commands_pos += 1
		commands_pos = clamp(commands_pos,0,commands_i)
		if not Commands.command_history.has(Line.text):
			Commands.command_history[0] = str(Line.text)
		Line.text = Commands.command_history[commands_pos]
		await get_tree().create_timer(0.001).timeout
		Line.caret_column = Line.get_text().length()
	
	if event is InputEventKey and Input.is_action_just_pressed('ArrowDown'):
		commands_pos -= 1
		commands_pos = clamp(commands_pos,0,commands_i)
		Line.text = Commands.command_history[commands_pos]
		Line.caret_column = Line.get_text().length()

func _on_texture_button_pressed() -> void:
	console_shown = !console_shown
