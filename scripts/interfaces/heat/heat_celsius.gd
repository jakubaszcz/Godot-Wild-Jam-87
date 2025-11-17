extends Label

func _ready() -> void:
	self.text = str(Game._get_heat()) + "°C"
	Signals.connect("heat", Callable(self, "_on_heat"))

func _on_heat(_value):
	self.text = str(Game._get_heat()) + "°C"
	
