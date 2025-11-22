extends TextureButton

var is_pressed := false
var hold_cooldown := 0.2
var current_cooldown := 0.0

func _ready() -> void:
	connect("button_down", Callable(self, "_on_down"))
	connect("button_up", Callable(self, "_on_up"))

func _on_down():
	is_pressed = true

func _on_up():
	is_pressed = false
	current_cooldown = 0.0

func _process(delta: float) -> void:
	if is_pressed:
		current_cooldown -= delta
		if current_cooldown <= 0.0:
			current_cooldown = hold_cooldown
			_on_hold()

func _on_hold():
	Signals.emit_signal("humidty", Game._get_humidity() - 1)
