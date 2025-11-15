extends Node

enum Difficulty { Easy, Medium, Hard }

var current_difficulty : Difficulty = Difficulty.Easy

var data := {
	Difficulty.Easy : {
		"rot_timer": 3.0
	},
	Difficulty.Medium : {
		"rot_timer": 2.0
	},
	Difficulty.Hard : {
		"rot_timer": 1.5
	}
}

func _set_difficulty(difficulty : Difficulty):
	current_difficulty = difficulty

func _get_value(key : String):
	return data[current_difficulty].get(key)
