extends Node

# Humidity between 0 & 100%
var humidity : int :
	set(value):
		humidity = clamp(value, 0, 100)
var humidity_timer : float = 0.0

# Heat between -20 & 100°
var heat : int :
	set(value):
		heat = clamp(value, -20, 100)
var heat_timer : float = 0.0

var rot_timer : float
var game_over : bool = false

func _ready() -> void:
	Signals.connect("humidty", Callable(self, "_on_humidity"))
	Signals.connect("heat", Callable(self, "_on_heat"))
	
	_reset()

func _on_humidity(value):
	humidity = value

func _on_heat(value):
	heat = value

func _reset() -> void:
	DifficultyManager._set_difficulty(DifficultyManager.Difficulty.Easy)
	rot_timer = DifficultyManager._get_value("rot_timer")
	_reset_humidity_timer()
	_reset_heat_timer()
	game_over = false

func _reset_humidity_timer() -> void:
	humidity_timer = 0.0

func _reset_heat_timer() -> void:
	heat_timer = 0.0

func _process(delta: float) -> void:
	if _is_game_over(): return
	
	_humidity_timer(delta)
	_heat_timer(delta)

func _humidity_timer(delta : float) -> void:
	humidity_timer += delta
	if humidity_timer >= DifficultyManager._get_value("humidity_timer"):
		Signals.emit_signal("humidty")
		_reset_humidity_timer()

func _heat_timer(delta : float) -> void:
	heat_timer += delta
	if heat_timer >= DifficultyManager._get_value("heat_timer"):
		Signals.emit_signal("heat")
		_reset_heat_timer()

func _is_game_over() -> bool:
	return game_over
	
func _get_rot_timer() -> float:
	return rot_timer
