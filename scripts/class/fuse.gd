extends VBoxContainer

class_name fuse

var correct_fuse : int
var correct_button_top : bool = false
var correct_button_bottom : bool = false

@export var button_top : Button
@export var button_bottom : Button

func _ready() -> void:
	_reset()
	
	correct_fuse = randi_range(0, 1)
	
	if !correct_fuse:
		correct_button_top = true
	else:
		correct_button_bottom = true


func _reset() -> void:
	correct_button_top = false
	correct_button_bottom = false
	correct_fuse = 0

func _on_button_top_pressed() -> void:
	if correct_button_top:
		button_top.modulate = Color(0.3, 1.0, 0.3, 1.0)
	else:
		button_top.modulate = Color(1.0, 0.3, 0.3, 1.0)


func _on_button_bottom_pressed() -> void:
	if correct_button_bottom:
		button_bottom.modulate = Color(0.3, 1.0, 0.3, 1.0)
	else:
		button_bottom.modulate = Color(1.0, 0.3, 0.3, 1.0)
