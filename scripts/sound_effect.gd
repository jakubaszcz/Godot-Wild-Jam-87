extends Control


@export var power_cut : AudioStream
@export var audio_player : AudioStreamPlayer2D

func _ready() -> void:
	Signals.connect("power", Callable(self, "_on_power_off"))

func _on_power_off() -> void:
	audio_player.stream = power_cut
	if audio_player.playing:
		audio_player.stop()
	audio_player.play()
