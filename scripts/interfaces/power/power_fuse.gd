extends Control

signal feedback_to_fuse(fuse_index: int, button_id: int, valid: bool)

var fuse_scene: PackedScene = preload("res://nodes/interfaces/power/fuse.tscn")
var fuses: Array[Fuse] = []

@onready var location = $CenterContainer/PanelContainer/MarginContainer/HBoxContainer

var fuse_count := 5
var current_index := 0


func _ready():
	_create_fuses()

func _create_fuses():
	for i in fuse_count:
		var f: Fuse = fuse_scene.instantiate()
		location.add_child(f)
		fuses.append(f)

		f.connect("fuse_signal", Callable(self, "_on_fuse_pressed").bind(i))

		connect("feedback_to_fuse", Callable(f, "_on_parent_fuse_signal").bind(i))


func _on_fuse_pressed(button_id: int, valid: bool, fuse_index: int):
	emit_signal("feedback_to_fuse", fuse_index, button_id, valid)

	if !valid:
		_reset_all()
		return

	current_index += 1

	if current_index >= fuse_count:
		_on_success()

func _reset_all():
	current_index = 0
	for f in fuses:
		f.reset_fuse()

func _on_success():
	Signals.emit_signal("power")
