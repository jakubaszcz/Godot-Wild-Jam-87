extends Node

var time : float = 0.0
var rot : int = 0
var incubator : bool = false

func ready() -> void:
	_reset()

func _reset() -> void:
	time = 0.0
	rot = 0
	incubator = false
