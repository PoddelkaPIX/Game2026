class_name ExitGameCommand extends Command

var tree: SceneTree

func _init(_tree: SceneTree) -> void:
	tree = _tree

func execute() -> Result:
	tree.quit()
	return Result.SUCCESS
