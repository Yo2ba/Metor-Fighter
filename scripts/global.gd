extends Node
@onready var screen_width = get_viewport().get_visible_rect().size[0]
@onready var screen_height = get_viewport().get_visible_rect().size[1]
signal leveled_up

var gameover: bool = false
var destroyed_meteors: int = 0
var score: int = 0
var anim_factor: float = 1.0
var controls_guide: bool = true
var metetor_count: int = 0
var level: int = 1
var music_volume: float = 1.0
var sfxx_volume: float = 1.0
@onready var coins: int = 0


func _process(_delta: float) -> void:
	if metetor_count >= 50 and level == 1:
		level = 2
		leveled_up.emit()

func restart():
	gameover = false
	destroyed_meteors = 0
	score = 0
	anim_factor = 1
	metetor_count = 0
	level = 1
	coins = 0
