extends CharacterBody2D

@export var on_bulb_texture : Texture2D
@export var off_bulb_texture : Texture2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

var toggle : bool = true
var percent : int= 75
var time : float = 0.0
var timer : float = 0.0
var changed : bool = true

var bonus : float = 0.75

func _ready() -> void:
	Signals.connect("power", Callable(self, "_on_power"))
	
	percent = DifficultyManager._get_value("bulb_percent")
	timer = DifficultyManager._get_value("bulb_timer")
	changed = true
	
	_update_bulb()

func _on_power() -> void:
	if not Game._get_power_cut(): return
	toggle = false
	changed = false
	_update_bulb()

func _process(delta: float) -> void:
	if toggle and not changed:
		Signals.emit_signal("rot_timer", Game._get_rot_timer() + bonus)
		changed = true
	if not toggle and not changed:
		Signals.emit_signal("rot_timer", Game._get_rot_timer() - bonus)
		changed = true
	if not toggle: return
	time += delta
	if time >= timer:
		toggle = false
		changed = false
		time = 0.0
		_update_bulb()

func _update_bulb() -> void:
	sprite.texture = on_bulb_texture if toggle else off_bulb_texture

func _on_area_2d_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed:
		toggle = not toggle
		changed = false
		_update_bulb()
