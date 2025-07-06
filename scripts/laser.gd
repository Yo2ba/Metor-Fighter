extends Area2D
var speed: int = 700

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * speed


func _on_area_entered(area: Area2D) -> void:
	queue_free()
	area.queue_free()
	Global.destroyed_meteors += 1
	Global.metetor_count += 1
	Global.coins += 1
