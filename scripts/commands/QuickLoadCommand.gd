class_name QuickLoadCommand extends Command

var tree: SceneTree
var save_path: String = 'user://save_1.tres'

func _init(_tree: SceneTree) -> void:
	tree = _tree

func execute() -> Result:
	return LoadSaveCommand.new(tree, save_path).execute()
	
