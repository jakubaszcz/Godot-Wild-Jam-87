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

var incubator : bool = false
var is_incubate : bool = true
var incubator_rot : float = 1.35

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
	incubator = true
	is_incubate = false

func _reset_humidity_timer() -> void:
	humidity_timer = 0.0

func _reset_heat_timer() -> void:
	heat_timer = 0.0

func _toggle_incubator():
	incubator = not incubator

func _process(delta: float) -> void:
	if _is_game_over(): return
	
	if _get_incubator() and not is_incubate:
		_set_rot_timer(_get_rot_timer() * incubator_rot)
		is_incubate = true
	elif not _get_incubator() and not is_incubate:
		_set_rot_timer(_get_rot_timer() / incubator_rot)
		is_incubate = true
	
	_humidity_timer(delta)
	_heat_timer(delta)

func _humidity_timer(delta : float) -> void:
	humidity_timer += delta
	if humidity_timer >= DifficultyManager._get_value("humidity_timer"):
		Signals.emit_signal("humidty", humidity + 1)
		_reset_humidity_timer()
		print("Humidity : " + str(humidity) + "%")
		

func _heat_timer(delta : float) -> void:
	heat_timer += delta
	if heat_timer >= DifficultyManager._get_value("heat_timer"):
		Signals.emit_signal("heat", heat + 1)
		_reset_heat_timer()
		print("Heat : " + str(heat) + "°")


func _is_game_over() -> bool:
	return game_over

func _get_incubator() -> bool:
	return incubator

func _set_incubator(value : bool) -> void:
	incubator = value

func _get_rot_timer() -> float:
	return rot_timer
	
func _set_rot_timer(value : float) -> void:
	rot_timer = value
