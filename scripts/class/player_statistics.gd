extends Node

var time : float = 0.0
var rot : int = 0

func ready() -> void:
	_reset()

func _reset() -> void:
	time = 0.0
	rot = 0
