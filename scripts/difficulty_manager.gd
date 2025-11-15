extends Node

enum Difficulty { Easy, Medium, Hard }

var difficulty : Difficulty = Difficulty.Easy

var data := {
	Difficulty.Easy : {
		"rot_timer": 3
	},
	Difficulty.Medium : {
		"rot_timer": 2
	},
	Difficulty.Hard : {
		"rot_timer": 1.5
	}
}

func _get_value(key : String):
	return data[difficulty].get(key)
