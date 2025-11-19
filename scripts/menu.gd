extends Control

@export var dropdown : OptionButton
@export var button : Button

var difficulties = {}

func _ready() -> void:
	
	Game._reset_game_start()
	
	difficulties = {
		"easy": DifficultyManager.Difficulty.Easy,
		"medium": DifficultyManager.Difficulty.Medium,
		"hard": DifficultyManager.Difficulty.Hard,
	}

	for difficulty_name in difficulties:
		dropdown.add_item(difficulty_name)

	
	dropdown.connect("item_selected", Callable(self, "_on_item_selected"))
	button.connect("pressed", Callable(self, "_on_pressed"))

func _on_item_selected(index) -> void:
	var key := dropdown.get_item_text(index)
	DifficultyManager._set_difficulty(difficulties[key])

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/game.tscn")
	Game._set_game_start(true)
