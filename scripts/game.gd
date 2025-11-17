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
var heat_time : float

var incubator : bool = false
var is_incubate : bool = true
var incubator_rot : float = 1.35

var rot_timer : float
var game_over : bool = false

func _ready() -> void:
	Signals.connect("humidty", Callable(self, "_on_humidity"))
	Signals.connect("heat", Callable(self, "_on_heat"))
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	Signals.connect("rot_timer", Callable(self, "_on_rot_timer"))
	
	_reset()

func _on_humidity(value) -> void:
	humidity = value

func _on_heat(value) -> void:
	heat = value
	
	var equation : float = heat_time / 99
	
	if heat >= DifficultyManager._get_value("heat_gap"):
		Signals.emit_signal("rot_timer", _get_rot_timer() - (equation * (heat - DifficultyManager._get_value("heat_gap") + 1)))


func _on_incubate(value) -> void:
	_set_incubator(value)
	is_incubate = false

func _on_rot_timer(value) -> void:
	_set_rot_timer(value)
	is_incubate = true
	
func _reset() -> void:
	DifficultyManager._set_difficulty(DifficultyManager.Difficulty.Easy)
	rot_timer = DifficultyManager._get_value("rot_timer")
	_reset_humidity_timer()
	_reset_heat_timer()
	
	heat_time = DifficultyManager._get_value("heat_timer")
	
	game_over = false
	incubator = false
	is_incubate = true

func _reset_humidity_timer() -> void:
	humidity_timer = 0.0

func _reset_heat_timer() -> void:
	heat_timer = 0.0

func _toggle_incubator():
	incubator = not incubator

func _process(delta: float) -> void:
	if _is_game_over(): return
	
	# print("Rot time : " + str(_get_rot_timer()))
	
	if _get_incubator() and not is_incubate:
		Signals.emit_signal("rot_timer", _get_rot_timer() * incubator_rot)
	elif not _get_incubator() and not is_incubate:
		Signals.emit_signal("rot_timer", _get_rot_timer() / incubator_rot)
	
	_humidity_timer(delta)
	_heat_timer(delta)

func _humidity_timer(delta : float) -> void:
	humidity_timer += delta
	if humidity_timer >= DifficultyManager._get_value("humidity_timer"):
		Signals.emit_signal("humidty", humidity + 1)
		_reset_humidity_timer()
		

func _heat_timer(delta : float) -> void:
	heat_timer += delta
	if heat_timer >= DifficultyManager._get_value("heat_timer"):
		Signals.emit_signal("heat", heat + 1)
		_reset_heat_timer()


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
	
func _get_heat() -> int:
	return heat
