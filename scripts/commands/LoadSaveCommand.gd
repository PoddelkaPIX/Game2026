class_name LoadSaveCommand extends Command

func execute(_data: Dictionary = {}) -> void:
	var tree = _data.get('tree', null)
	var save_path = _data.get('save_path', '')
	
	var scene_path = GameStateService.load_game_state(save_path)
	tree.change_scene_to_file(scene_path)
