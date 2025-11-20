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

# Heat between 0 & 100°
var heat : int :
	set(value):
		heat = clamp(value, 0, 100)
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


func _reset() -> void:
	_set_rot_timer(DifficultyManager._get_value("rot_timer"))
	_reset_humidity_timer()
	_reset_heat_timer()
	_reset_power_cut_timer()
	_reset_power_cut_percent()
	
	PlayerStatistics._reset()
	
	_set_heat_time(DifficultyManager._get_value("heat_timer"))
	_set_humidity_time(DifficultyManager._get_value("humidity_timer"))
	
	_set_humidity(0)
	_set_heat(0)
	
	game_over = false
	_set_incubator(false)
	is_incubate = true
	power_cuted = false


func _reset_humidity_timer() -> void:
	humidity_timer = 0.0


func _reset_heat_timer() -> void:
	Game.heat_timer = 0.0


func _reset_power_cut_timer() -> void:
	power_cut_timer = 0.0


func _reset_power_percent_timer() -> void:
	power_cut_percent_timer = 0.0

func _reset_power_cut_percent() -> void:
	power_cut_percent = DifficultyManager._get_value("power_cut_percent")

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


func _set_heat_time(value : float) -> void:
	heat_time = value

func _set_humidity_time(value : float) -> void:
	humidity_time = value

func _set_heat(value : int) -> void:
	heat = value


func _get_humidity() -> int:
	return humidity


func _set_humidity(value : int) -> void:
	humidity = value
	

func _get_power_cut() -> bool:
	return power_cuted


func _set_power_cut(value : bool) -> void:
	power_cuted = value
