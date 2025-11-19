extends Node

# ───────────────────────────────────────────────────────
# 				Variables
# ───────────────────────────────────────────────────────

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
var power_cut_percent : int = 0 :
	set(value): 
		power_cut_percent = clamp(value, 0, 75)
var power_cut_timer : float = 0.0
var power_cut_percent_timer : float = 0.0

var rot_timer : float :
	set(value):
		rot_timer = clamp(value, 0, INF)
var game_over : bool = false
var game_start : bool = false

# ───────────────────────────────────────────────────────
# 				Ready Function
# ───────────────────────────────────────────────────────


func _ready() -> void:
	
	_reset()
	
	Signals.connect("humidty", Callable(self, "_on_humidity"))
	Signals.connect("heat", Callable(self, "_on_heat"))
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	Signals.connect("rot_timer", Callable(self, "_on_rot_timer"))
	Signals.connect("power", Callable(self, "_on_power"))


func _reset() -> void:
	rot_timer = DifficultyManager._get_value("rot_timer")
	_reset_humidity_timer()
	_reset_heat_timer()
	_reset_power_cut_timer()
	_reset_power_cut_percent()
	
	heat_time = DifficultyManager._get_value("heat_timer")
	humidity_time = DifficultyManager._get_value("humidity_timer")
	
	game_over = false
	incubator = false
	is_incubate = true
	power_cuted = false


# ───────────────────────────────────────────────────────
# 				Signals Function
# ───────────────────────────────────────────────────────


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
		print(str(power_cuted))
		if power_cuted:
			heat_time *= 1.15
			humidity_time *= 1.10
		else:
			heat_time /= 1.15
			humidity_time /= 1.10


# ───────────────────────────────────────────────────────
# 				Process
# ───────────────────────────────────────────────────────


func _process(delta: float) -> void:
	if _is_game_over(): return
	if not _get_game_start(): return
	
	# print("Rot time : " + str(_get_rot_timer()))
	if not power_cuted:
		if _get_incubator() and not is_incubate:
			Signals.emit_signal("rot_timer", _get_rot_timer() * incubator_rot)
		elif not _get_incubator() and not is_incubate:
			Signals.emit_signal("rot_timer", _get_rot_timer() / incubator_rot)
	
	_humidity_timer(delta)
	_heat_timer(delta)
	_power(delta)
	_increase_power_percent(delta)


func _power(delta : float) -> void:
	if Game.power_cuted: return
	if DifficultyManager._get_value("power_cut"):
		
		power_cut_timer += delta
		
		if power_cut_timer >= 3.0:
			var number = randi_range(1, 100)
		
			if number <= power_cut_percent:
				Signals.emit_signal("power")
		
			_reset_power_cut_timer()


func _increase_power_percent(delta : float) -> void:
	power_cut_percent_timer += delta
	if Game.power_cuted: return
	if power_cut_percent >= 75: return
	if power_cut_percent_timer >= 3:
		power_cut_percent += 1
		power_cut_percent_timer = 0.0


# ───────────────────────────────────────────────────────
# 				Reset Function
# ───────────────────────────────────────────────────────


func _reset_humidity_timer() -> void:
	humidity_timer = 0.0


func _reset_heat_timer() -> void:
	heat_timer = 0.0


func _reset_power_cut_timer() -> void:
	power_cut_timer = 0.0


func _reset_power_percent_timer() -> void:
	power_cut_percent_timer = 0.0

func _reset_power_cut_percent() -> void:
	power_cut_percent = DifficultyManager._get_value("power_cut_percent")

func _reset_game_start() -> void:
	_set_game_start(false)

# ───────────────────────────────────────────────────────
# 				Toggler
# ───────────────────────────────────────────────────────


func _toggle_incubator():
	incubator = not incubator


# ───────────────────────────────────────────────────────
# 				Timer
# ───────────────────────────────────────────────────────


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


# ───────────────────────────────────────────────────────
# 				Boolean
# ───────────────────────────────────────────────────────


func _is_game_over() -> bool:
	return game_over


# ───────────────────────────────────────────────────────
# 				Getter-Setter
# ───────────────────────────────────────────────────────


func _get_incubator() -> bool:
	return incubator


func _set_incubator(value : bool) -> void:
	incubator = value


func _get_rot_timer() -> float:
	return rot_timer


func _get_game_start() -> bool:
	return game_start


func _set_game_start(value : bool) -> void:
	game_start = value


func _set_rot_timer(value : float) -> void:
	rot_timer = value


func _get_heat() -> int:
	return heat


func _get_humidity() -> int:
	return humidity


func _set_humidity(value : int) -> void:
	humidity = value

func _get_power_cut() -> bool:
	return power_cuted


func _set_power_cut(value : bool) -> void:
	power_cuted = value
