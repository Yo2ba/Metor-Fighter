extends Node2D

@export var explosion_sound: AudioStream

@onready var score: Label = $CanvasLayer/ScoreMargin/Score
@onready var player: CharacterBody2D = $PlayerAndPause/Player
@onready var mobile_gui: CanvasLayer = $MobileGUI


var laser_scene: PackedScene = load('res://scenes/laser.tscn')
var meteor_scene: PackedScene = load('res://scenes/meteor.tscn')
var PackedConsole: PackedScene = load('res://scenes/console.tscn')
var gamescore: int = 0: set = _gamescore_set
func _gamescore_set(value):
	gamescore = value
	score.text = str(gamescore)
	
var is_paused: bool = false
var multiplier: int = 1
var score_speed: float = 1
var console_shown: bool = false
var joystick_pressed: bool = true
@onready var screen_width = get_viewport().get_visible_rect().size[0]

func _ready() -> void:
	score_increment()
	_score_speed()
	if Platform.is_mobile:
		mobile_gui.show()

#func _input(event: InputEvent) -> void:
#	if event is InputEventScreenTouch:
#		if event.pressed and joystick_pressed and event.index == 0:
#			var pos = event.position
#			$MobileGUI/Hideable/Joystick.global_position = event.position

func _score_speed() -> void:
	await get_tree().create_timer(1,false).timeout
	score_speed *= 0.985
	_score_speed()

func score_increment() -> void:
	await get_tree().create_timer(score_speed * float(1)/multiplier,false).timeout
	if Global.gameover == false:
		gamescore += 1
		score_increment()

func _process(_delta: float) -> void:
	#score.text = str(gamescore)
	if !Global.gameover:
		$ExplosionAnim.position = player.global_position

func _physics_process(delta: float) -> void:
	if !Global.gameover:
		gamescore += 2 * delta
		Global.score = gamescore
	$MeteorSpawnTimer.wait_time *= 0.9998

func _on_player_fire(pos):
	var laser: Area2D = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos

func _on_laser_catcher_area_entered(area: Area2D) -> void:
	area.queue_free()


func _on_meteor_spawn_timer_timeout() -> void:
	var meteor: Area2D = meteor_scene.instantiate()
	$metors.add_child(meteor)


func _on_meteor_catcher_area_entered(area: Area2D) -> void:
	area.queue_free()


func _on_player_tree_exited() -> void:
	Global.gameover = true
	Global.anim_factor = 0
	$ExplosionAnim.play('default')
	Audio.play_sound(explosion_sound, -1.893)
	await $ExplosionAnim.animation_finished
	get_tree().change_scene_to_file('res://scenes/game_over.tscn')


func _on_controls_guide_timer_timeout() -> void:
	Global.controls_guide = false


func _on_joystick_pos_pressed() -> void:
	joystick_pressed = true
func _on_joystick_pos_released() -> void:
	joystick_pressed = false
