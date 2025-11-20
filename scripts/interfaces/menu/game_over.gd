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
	
	Signals.connect("game_over", Callable(self, "_on_game_over"))
	

func _on_restart_pressed() -> void:
	var current_scene := get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_game_over() -> void:
	time.text = "Time : " + format_time_full(PlayerStatistics.time)
	difficulty.text = "Difficulty : " + DifficultyManager._get_difficulty_format(DifficultyManager.current_difficulty)


func format_time_full(seconds: int) -> String:
	var hours = seconds / 3600
	var minutes = (seconds % 3600) / 60
	var secs = seconds % 60

	return str(hours).pad_zeros(2) + ":" \
		+ str(minutes).pad_zeros(2) + ":" \
		+ str(secs).pad_zeros(2)
