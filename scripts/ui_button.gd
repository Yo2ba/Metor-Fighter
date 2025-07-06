extends Button

@onready var CLICK = load('res://assets/sfx/click.wav')

func _ready() -> void:
	connect('pressed',pressed)

func pressed() -> void:
	Audio.play_sound(CLICK,-12.0)
