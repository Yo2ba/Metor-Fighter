extends CharacterBody2D

@export var laser_sound: AudioStream

var SPEED: int =  500
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var laser_bar: ProgressBar = $LaserBar
@onready var joystick: Node2D = $'../../MobileGUI/Hideable/Joystick'
var dir_target: int = 0
signal fire(pos)
signal bg_speed(fastness)
var reloaded: bool = false
var dir: Vector2

var state: String = 'idle'
var fill_speed: float = 0.02
var noclip: bool = false
var is_fire_touchscreen: bool = false

var laser_cap: float = 3
var laser_amt: float = laser_cap

func _ready() -> void:
	sprite.frame = 9
	$AnimationUpdater.connect('timeout',update_animation)
	Global.leveled_up.connect(level_up)
	laser_bar.max_value = laser_cap
	laser_bar.value = laser_amt
	Commands.connect('noclip',_noclip)
	update_animation()

func update_animation():
	$AnimationUpdater.start()
	var newdir = round(dir.x * 10)
	if newdir < dir_target:
		dir_target -= 1
	elif newdir > dir_target:
		dir_target += 1
	dir_target = clamp(dir_target,-9,9)
	sprite.frame = dir_target+9

func on_fire_pressed() -> void:
	is_fire_touchscreen = true

func on_fire_unpressed() -> void:
	is_fire_touchscreen = false

func _physics_process(_delta: float) -> void:
	dir = Input.get_vector( 'left' , 'right' , 'forward' , 'backward' )
	if Platform.is_mobile:
		dir = joystick.posVector
	velocity = dir * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	move_and_slide()
	if dir[1] < 0:
		bg_speed.emit(350)
	else:
		bg_speed.emit(200)
	
	laser_amt += fill_speed
	laser_amt = clamp(laser_amt, 0,laser_cap)
	
	if (Input.is_action_pressed('fire') or is_fire_touchscreen) and reloaded == true and laser_amt >= 1:
		reloaded = false
		%ReloadLaser.start()
		fire.emit($LaserMarker.global_position)
		Audio.play_sound(laser_sound,-15.918,3.57)
		laser_amt -= 1
	laser_bar.value = laser_amt

func _on_reload_timeout() -> void:
	reloaded = true

func level_up():
	%ReloadLaser.wait_time = 0.2
	laser_cap = 5
	laser_bar.max_value = laser_cap
	fill_speed = 0.04
	SPEED = 650
	$AnimationPlayer.play('level_up')

func _noclip():
	if !noclip:
		noclip = true
		$Collision.disabled = true
		print('noclip ON')
		Commands.console_text_display = 'noclip ON'
	else:
		noclip = false
		$Collision.disabled = false
		print('noclip OFF')
		Commands.console_text_display = 'noclip OFF'
