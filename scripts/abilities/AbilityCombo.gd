class_name AbilityCombo extends RefCounted

var current_combo = 1
var max_combo = 3

func next_combo():
	current_combo += 1
	if current_combo > max_combo:
		reset()
	
func reset():
	current_combo = 1
