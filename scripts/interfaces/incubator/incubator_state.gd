extends HBoxContainer

var timer : float = 0.5
var time : float = 0.0
var start : bool = false

var is_pressed := false
var hold_cooldown := 0.2
var current_cooldown := 0.0

@export var progress_bar : ProgressBar
@export var button : Button

func _ready() -> void:
	Signals.connect("incubate_bar", Callable(self, "_on_incubate_bar"))
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	
	button.connect("button_down", Callable(self, "_on_down"))
	button.connect("button_up", Callable(self, "_on_up"))
	
	_reset_time()
	progress_bar.value = 100

func _on_down():
	is_pressed = true

func _on_up():
	is_pressed = false
	current_cooldown = 0.0

func _reset_time() -> void:
	time = 0.0

func _on_incubate_bar(value) -> void:
	progress_bar.value = value
	if _get_percent() <= 0:
		Game._set_incubator_state(true)

func _on_incubate(value) -> void:
	start = value

func _process(delta: float) -> void:
	if Game._get_power_cut(): return

	if is_pressed:
		current_cooldown -= delta
		if current_cooldown <= 0.0:
			current_cooldown = hold_cooldown
			_on_hold()
	else:
		if start:
			time += delta
			if time >= timer:
				Signals.emit_signal("incubate_bar", _get_percent() - 1)
				if _get_percent() >= 25 and Game._get_incubator_state():
					Game._set_incubator_state(false)
				_reset_time()

func _on_hold():
	Signals.emit_signal("incubate_bar", _get_percent() + 1)

func _set_percent(value : int) -> void:
	progress_bar.value = value

func _get_percent() -> int:
	return progress_bar.value

func _on_button_pressed() -> void:
	if _get_percent() >= 100: return
	Signals.emit_signal("incubate_bar", _get_percent() + 1)
