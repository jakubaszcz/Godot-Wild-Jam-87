extends Control

signal click

@export var dropdown : OptionButton
@export var button : Button

@export var click_sound : AudioStream

@export var sound : AudioStreamPlayer2D

@export var timer : Timer

var difficulties = {}

var type : bool = false

func _ready() -> void:
	
	self.connect("click", Callable(self, "_on_click"))
	timer.timeout.connect(_on_delay_finished)
	Game._reset_game_start()
	
	difficulties = {
		"normal": DifficultyManager.Difficulty.Normal,
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
	type = true
	timer.start()

func _on_delay_finished() -> void:
	if type:
		_play()
	else:
		_htp()

func _htp() -> void:
	get_tree().change_scene_to_file("res://nodes/htp.tscn")

func _play() -> void:
	print("sdfdf")
	get_tree().change_scene_to_file("res://nodes/game.tscn")
	Game._set_game_start(true)

func _on_option_button_pressed() -> void:
	self.emit_signal("click")
	


func _on_button_pressed() -> void:
	self.emit_signal("click")


func _on_click() -> void:
	sound.stream = click_sound
	if sound.playing:
		sound.stop()
	sound.play()


func _on_htp_pressed() -> void:
	type = false
	self.emit_signal("click")
	timer.start()
	
