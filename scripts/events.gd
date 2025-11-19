extends CanvasLayer

var power_interface_scene : PackedScene = preload("res://nodes/interfaces/power/power_fuse.tscn")
var power_instance: Node = null

@export var game_over_interface : Control

func _ready() -> void:
	Signals.connect("power", Callable(self, "_on_power"))
	Signals.connect("game_over", Callable(self, "_on_game_over"))
	

func _on_power() -> void:
	if Game._get_power_cut():
		_show_power_interface()
	else:
		_hide_power_interface()

func _on_game_over() -> void:
	game_over_interface.visible = true

func _show_power_interface():
	if power_instance != null and is_instance_valid(power_instance):
		return

	power_instance = power_interface_scene.instantiate()
	add_child(power_instance)


func _hide_power_interface():
	if power_instance != null and is_instance_valid(power_instance):
		power_instance.queue_free()
		power_instance = null
