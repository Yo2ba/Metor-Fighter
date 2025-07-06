extends Area2D

var factor: float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite.play('default')
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	factor = rng.randi_range(80,150)
	scale.x = scale.x / (factor / 100)
	scale.y = scale.y / (factor / 100)
	global_position.x = rng.randi_range(0, Global.screen_width)
	global_position.y = -500
	z_index = factor
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * (factor / 100) * 300 * Global.anim_factor
	if Global.anim_factor == 0:
		$Sprite.speed_scale = 0


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	
