extends Node

var time : float = 0.0
var rot : int = 0
var current_sprite : Texture2D

var power_cut_percent : int = 5

func ready() -> void:
	_reset()

func _reset() -> void:
	time = 0.0
	rot = 0

func _process(delta: float) -> void:
	time += delta
	
	_power()
	increase_power_percent()

func _power() -> void:
	if Game.power_cuted: return
	if DifficultyManager._get_value("power_cut"):
		
		var number = randi_range(0, 100)
		
		if number <= power_cut_percent:
			Signals.emit_signal("power")

func increase_power_percent() -> void:
	if Game.power_cuted: return
	if power_cut_percent >= 75: return
	if int(time) % 3 == 0:
		power_cut_percent += 1
		

func _get_rot() -> int:
	return rot

func _set_rot(value : int) -> void:
	rot = value

func _get_sprite() -> Texture2D:
	return current_sprite

func _set_sprite(sprite : Texture2D) -> void:
	current_sprite = sprite
