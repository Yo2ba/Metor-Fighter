extends MarginContainer


func _process(_delta: float) -> void:
	$VBoxContainer/HBoxContainer/ObjCounter.text = str(Global.metetor_count)
	#$VBoxContainer/ProgressBar.value = lerp($VBoxContainer/ProgressBar.value, Global.metetor_count, 0.005)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property($VBoxContainer/ProgressBar,'value',Global.metetor_count,0.5).set_trans(Tween.TRANS_LINEAR)
	if Global.level == 2:
		pass
