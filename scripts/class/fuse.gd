extends VBoxContainer
class_name Fuse

signal fuse_signal(button_id: int, valid: bool)

@export var buttons: Array[Button]

var correct_button_top := false
var correct_button_bottom := false


func _ready():
	_generate_correct()
	_default_buttons()


func _generate_correct():
	var choice := randi_range(0, 1)
	correct_button_top = (choice == 0)
	correct_button_bottom = (choice == 1)


func reset_fuse():
	_default_buttons()


func _default_buttons():
	for b in buttons:
		b.modulate = Color(0.215, 0.215, 0.215, 1.0)


func _on_parent_fuse_signal(target_index: int, button_id: int, valid: bool, my_index: int):
	if target_index != my_index:
		return

	if valid:
		buttons[button_id].modulate = Color(0.3, 1.0, 0.3)
	else:
		buttons[button_id].modulate = Color(1.0, 0.3, 0.3)


func _on_button_top_pressed():
	emit_signal("fuse_signal", 0, correct_button_top)


func _on_button_bottom_pressed():
	emit_signal("fuse_signal", 1, correct_button_bottom)
