extends Control

@export var time : Label
@export var difficulty : Label


@export var restart_button : Button
@export var menu_button : Button
@export var quit_button : Button

func _ready() -> void:
	restart_button.connect("pressed", Callable(self, "_on_restart_pressed"))
	menu_button.connect("pressed", Callable(self, "_on_menu_pressed"))
	quit_button.connect("pressed", Callable(self, "_on_quit_pressed"))
	

func _on_restart_pressed() -> void:
	var current_scene := get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
