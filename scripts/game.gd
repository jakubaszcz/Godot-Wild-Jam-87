extends Node

# Humidity between 0 & 100%
var humidity : int :
	set(value):
		humidity = clamp(value, 0, 100)

# Heat between -20 & 100°
var heat : int :
	set(value):
		heat = clamp(value, -20, 100)

var rot_timer : float
var game_over : bool = false

func _ready() -> void:
	_reset()
	
func _reset() -> void:
	DifficultyManager._set_difficulty(DifficultyManager.Difficulty.Easy)
	rot_timer = DifficultyManager._get_value("rot_timer")
	game_over = false

func _is_game_over() -> bool:
	return game_over
	
func _get_rot_timer() -> float:
	return rot_timer
