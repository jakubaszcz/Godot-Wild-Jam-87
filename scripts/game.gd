extends Node

# Humidity between 0 & 100%
var humidity : int :
	set(value):
		humidity = clamp(value, 0, 100)
var humidity_timer : float = 0.0
var humidity_time : float = 0.0

# Heat between -20 & 100°
var heat : int :
	set(value):
		heat = clamp(value, -20, 100)
var heat_timer : float = 0.0
var heat_time : float

var incubator : bool = false
var is_incubate : bool = true
var incubator_rot : float = 1.35

var power_cuted : bool = false
var power_cut_percent : int = 1892

var rot_timer : float
var game_over : bool = false

func _secure_value() -> void:
	power_cut_percent = clamp(power_cut_percent, 0, 75)

func _ready() -> void:
	_secure_value()
	
	Signals.connect("humidty", Callable(self, "_on_humidity"))
	Signals.connect("heat", Callable(self, "_on_heat"))
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	Signals.connect("rot_timer", Callable(self, "_on_rot_timer"))
	Signals.connect("power", Callable(self, "_on_power"))
	
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

func _on_power() -> void:
	
	if DifficultyManager._get_value("power_cut"):
		power_cuted = not power_cuted
		print("Power cut ? " + str(power_cuted))
		if power_cuted:
			heat_time *= 1.15
			humidity_time *= 1.10
		else:
			heat_time /= 1.15
			humidity_time /= 1.10

func _power() -> void:
	print(str(heat_time))
	
	if Game.power_cuted: return
	if DifficultyManager._get_value("power_cut"):
		
		var number = randi_range(0, 100)
		
		print("Random : " + str(number))
		
		if number <= power_cut_percent:
			Signals.emit_signal("power")

func _increase_power_percent() -> void:
	if Game.power_cuted: return
	if power_cut_percent >= 75: return
	if int(PlayerStatistics.time) % 3 == 0:
		power_cut_percent += 1

func _reset() -> void:
	DifficultyManager._set_difficulty(DifficultyManager.Difficulty.Hard)
	rot_timer = DifficultyManager._get_value("rot_timer")
	_reset_humidity_timer()
	_reset_heat_timer()
	
	heat_time = DifficultyManager._get_value("heat_timer")
	humidity_time = DifficultyManager._get_value("humidity_timer")
	
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
	if power_cuted:
		if _get_incubator() and not is_incubate:
			Signals.emit_signal("rot_timer", _get_rot_timer() * incubator_rot)
		elif not _get_incubator() and not is_incubate:
			Signals.emit_signal("rot_timer", _get_rot_timer() / incubator_rot)
	
	_humidity_timer(delta)
	_heat_timer(delta)
	_power()
	_increase_power_percent()

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

func _get_humidity() -> int:
	return humidity
