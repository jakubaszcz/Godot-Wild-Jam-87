extends Node

var time : float = 0.0
var rot : int = 0
var current_sprite : Texture2D


func ready() -> void:
	_reset()

func _reset() -> void:
	time = 0.0
	rot = 0


func _get_rot() -> int:
	return rot

func _set_rot(value : int) -> void:
	rot = value

func _get_sprite() -> Texture2D:
	return current_sprite

func _set_sprite(sprite : Texture2D) -> void:
	current_sprite = sprite
