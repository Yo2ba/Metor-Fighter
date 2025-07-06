extends Node

func play_sound(stream: AudioStream, db: float = 1.0, pitch: float = 1.0):
	var instance = AudioStreamPlayer.new()
	instance.bus = "SFX"
	instance.stream = stream
	instance.volume_db = db
	instance.pitch_scale = pitch
	instance.finished.connect(sound_free.bind(instance))
	add_child(instance)
	instance.play()

func sound_free(instance: AudioStreamPlayer):
	instance.queue_free()
