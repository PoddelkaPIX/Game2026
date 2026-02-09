class_name StartNewGameCommand extends Command

var tree: SceneTree

func _init(_tree: SceneTree) -> void:
	tree = _tree
	
func execute() -> Result:
	GameStateService.new_game()
	tree.change_scene_to_file("res://scenes/maps/map_0.tscn")
	
	return Result.SUCCESS
