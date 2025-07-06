extends ParallaxBackground
var speed: int
func _process(delta):
	scroll_offset.y += speed * delta
	if Global.anim_factor == 0:
		speed = 0




func _on_player_bg_speed(fastness: Variant) -> void:
	speed = fastness * 0.2
