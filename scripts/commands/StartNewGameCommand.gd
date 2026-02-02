class_name StartNewGameCommand extends Command

func execute(_data: Dictionary = {}) -> void:
	GameStateService.new_game()
	var tree = _data.get('tree', null)
	tree.change_scene_to_file("res://scenes/maps/map_0.tscn")
