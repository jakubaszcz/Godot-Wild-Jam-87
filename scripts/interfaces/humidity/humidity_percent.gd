extends Label

func _ready() -> void:
	self.text = str(Game._get_humidity()) + "%"
	Signals.connect("humidty", Callable(self, "_on_humidity"))

func _on_humidity(_value) -> void:
	self.text = str(Game._get_humidity()) + "%"
