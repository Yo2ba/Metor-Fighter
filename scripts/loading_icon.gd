extends Control


func _process(delta: float) -> void:
	$loading_inner.rotation -= delta*3
	$loading_outer.rotation += delta*4
