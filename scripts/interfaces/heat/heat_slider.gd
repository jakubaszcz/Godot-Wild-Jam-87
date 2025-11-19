extends VSlider

func _ready() -> void:
	self.value = 0.0
	Signals.connect("heat", Callable(self, "_on_heat"))

func _on_heat(value) -> void:
	self.value = value


func _on_value_changed(value: float) -> void:
	Signals.emit_signal("heat", int(value))
