extends Button

func _on_pressed() -> void:
	var value = not Game.incubator
	Signals.emit_signal("incubate", value)
