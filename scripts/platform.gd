extends Node
@onready var platform: String = "Unknown"
var is_mobile: bool = false

func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		is_mobile = true
		if OS.has_feature("web_android"):
			platform = "Android"
		else:
			platform = "iOS"
	elif OS.has_feature("web_windows"):
		platform = "Windows"
	elif OS.has_feature("web_linuxbsd"):
		platform = "Linux"
	elif OS.has_feature("web_macos"):
		platform = "macOS"
