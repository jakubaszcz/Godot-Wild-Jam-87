extends Button


func _on_pressed() -> void:
	if Game._get_power_cut():
		Signals.emit_signal("power")
