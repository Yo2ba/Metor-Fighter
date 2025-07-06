extends Area2D

var SPEED: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y += SPEED * delta


func _on_body_entered(_body: Node2D) -> void:
	Global.coins += 1
	$CoinIcon.hide()
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	queue_free()
