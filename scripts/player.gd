extends CharacterBody2D

@export var sprite2D : Sprite2D

var timer : float = 0.0

func _ready() -> void:
	_update_color()
	_set_sprite()
	_reset_timer()
	PlayerStatistics._set_rot(0)
	Signals.connect("game_over", Callable(self, "_on_game_over"))
	Signals.connect("rot", Callable(self, "_on_rot"))

func _update_color() -> void:
	var rot_percent = PlayerStatistics._get_rot() / 100.0
	var start_color = Color(1, 1, 1)
	var target_color = Color(0.0, 0.750, 0.0, 1.0)
	sprite2D.modulate = start_color.lerp(target_color, rot_percent)

func _set_sprite() -> void:
	sprite2D.texture = DifficultyManager._get_value("sprite")

func _on_rot(value) -> void:
	PlayerStatistics._set_rot(value)

func _on_game_over() -> void:
	Game.game_over = true

func _full_rot() -> bool:
	return PlayerStatistics.rot == 100

func _reset_timer() -> void:
	timer = 0.0

func _process(delta: float) -> void:
	if Game._is_game_over(): return
	
	_update_color()
	
	timer += delta
	PlayerStatistics.time += delta
	
	if timer >= Game._get_rot_timer():
		if _full_rot():
			Signals.emit_signal("game_over")
			return
		Signals.emit_signal("rot", PlayerStatistics.rot + 1)
		_reset_timer()
