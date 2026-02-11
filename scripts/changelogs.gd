extends Control

@onready var menu_scene = preload('res://scenes/main_menu.tscn')
@export var http_request: HTTPRequest
@onready var error_code: Label = %ErrorCode
@onready var loading_icon: Control = %LoadingIcon
@export var text_holder: VBoxContainer
@onready var version_font = preload("res://assets/Font/Kenney Future.ttf")

func _ready() -> void:
	$Text/TitleContents/LabelMargin/CloseMargin/CloseBtn.connect('pressed',close_cross)
	http_request.request_completed.connect(_on_request_completed)
	await get_tree().create_timer(0.5).timeout
	http_request.request("https://yo2ba.github.io/Metor-Fighter/changelog.json")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed('esc'):
		var new_scene = menu_scene.instantiate()
		get_parent().add_child(new_scene)
		queue_free()

func close_cross() -> void:
	var new_scene = menu_scene.instantiate()
	get_parent().add_child(new_scene)
	queue_free()

func _on_request_completed(_result, response_code, _headers, body):
	loading_icon.hide()
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		display(json)
	if response_code == 0:
		error_code.text = "No connection"
		error_code.show()
		print("No connection")
	if response_code == 404:
		error_code.text = "No data found"
		error_code.show()
		print("No data")

func display(data):
	
	var versions = data["versions"]
	
	for i in range(versions.size()):
		var update = versions[i]
		
		var version_group = VBoxContainer.new()
		version_group.add_theme_constant_override("separation", 8)
		text_holder.add_child(version_group)
		
		var version_date_sep = HBoxContainer.new()
		version_date_sep.size_flags_vertical = Control.SIZE_EXPAND | Control.SIZE_FILL
		version_date_sep.add_theme_constant_override("separation", 24)
		version_group.add_child(version_date_sep)
		
		var version_label = Label.new()
		version_label.add_theme_font_override("font", version_font)
		version_label.add_theme_font_size_override("font_size", 24)
		version_label.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		version_label.text = "V" + update["version"]
		version_date_sep.add_child(version_label)
		
		var version_date = Label.new()
		version_date.add_theme_color_override("font_color", "969696")
		version_date.size_flags_horizontal = Control.SIZE_SHRINK_END
		version_date.text = update["date"]
		version_date_sep.add_child(version_date)
		
		var version_text_content = RichTextLabel.new()
		version_text_content.mouse_filter = Control.MOUSE_FILTER_IGNORE
		version_text_content.fit_content = true
		var text_concatenate = ""
		for line in update["changes"]:
			text_concatenate += "– " + line + "\n\n"
		text_concatenate = text_concatenate.substr(0, text_concatenate.length() - 1)
		version_text_content.text = text_concatenate
		version_group.add_child(version_text_content)
		
		if i != versions.size() - 1:
			var separator = HSeparator.new()
			text_holder.add_child(separator)
