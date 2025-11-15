extends Node

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
