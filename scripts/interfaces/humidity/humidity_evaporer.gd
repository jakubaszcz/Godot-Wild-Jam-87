extends Button

func _on_button_down() -> void:
	Signals.emit_signal("humidty", Game._get_humidity() - 1)
