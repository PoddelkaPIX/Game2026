class_name LoadSaveCommand extends Command

var tree: SceneTree
var save_path: String

func _init(_tree: SceneTree, _save_path) -> void:
	tree = _tree
	save_path = _save_path
	
func execute() -> Result:
	var scene_path = GameStateService.load_game_state(save_path)
	tree.change_scene_to_file(scene_path)
	return Result.SUCCESS
