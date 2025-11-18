extends Button

func _on_button_down() -> void:
	if Game._get_power_cut(): return
	Signals.emit_signal("humidty", Game._get_humidity() - 1)
