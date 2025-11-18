extends Node

enum Difficulty { Easy, Medium, Hard }

var current_difficulty : Difficulty = Difficulty.Easy

var data := {
	Difficulty.Easy : {
		"sprite": preload("res://assets/textures/fruits/01.png"),
		"rot_timer": 3.0,
		"humidity_gap": 15,
		"heat_gap": 15,
		"humidity_timer": 3.0,
		"heat_timer": 2.0,
		"power_cut": true
	},
	Difficulty.Medium : {
		"sprite": preload("res://assets/textures/fruits/02.png"),
		"rot_timer": 2.0,
		"humidity_gap": 15,
		"heat_gap": 15,
		"humidity_timer": 3.0,
		"heat_timer": 2.0,
		"power_cut": true
	},
	Difficulty.Hard : {
		"sprite": preload("res://assets/textures/fruits/03.png"),
		"rot_timer": 1.5,
		"humidity_gap": 15,
		"heat_gap": 15,
		"humidity_timer": 3.0,
		"heat_timer": 2.0,
		"power_cut": true
	}
}

func _set_difficulty(difficulty : Difficulty):
	current_difficulty = difficulty

func _get_value(key : String):
	return data[current_difficulty].get(key)
