extends Node

var game_over : bool = false

func _ready() -> void:
	_reset()
	
func _reset() -> void:
	game_over = false

func _is_game_over() -> bool:
	return game_over
