extends Node2D

var timer : float = 0.0
var is_game_over : bool = false

func _ready() -> void:
	_reset_timer()
	Signals.connect("game_over", Callable(self, "_on_game_over"))

func _on_game_over() -> void:
	print("Finish")
	is_game_over = true

func _is_game_over() -> bool:
	return is_game_over

func _full_rot() -> bool:
	return PlayerStatistics.rot == 100

func _reset_timer() -> void:
	timer = 0.0

func _process(delta: float) -> void:
	if _is_game_over(): return
	timer += delta
	
	if timer >= 0.1:
		if _full_rot():
			Signals.emit_signal("game_over")
			return
		PlayerStatistics.rot += 1
		print(str(PlayerStatistics.rot) + "%")
		_reset_timer()
