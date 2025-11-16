extends Node2D

var timer : float = 0.0

func _ready() -> void:
	_reset_timer()
	Signals.connect("game_over", Callable(self, "_on_game_over"))
	Signals.connect("rot", Callable(self, "_on_rot"))

func _on_rot(value) -> void:
	PlayerStatistics.rot = value

func _on_game_over() -> void:
	Game.game_over = true

func _full_rot() -> bool:
	return PlayerStatistics.rot == 100

func _reset_timer() -> void:
	timer = 0.0

func _process(delta: float) -> void:
	if Game._is_game_over(): return
	timer += delta
	
	if timer >= Game._get_rot_timer():
		if _full_rot():
			Signals.emit_signal("game_over")
			return
		Signals.emit_signal("rot", PlayerStatistics.rot + 1)
		_reset_timer()
		print("Rot : " + str(PlayerStatistics.rot) + "%")
