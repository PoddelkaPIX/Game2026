class_name ExitGameCommand extends Command

func execute(_data: Dictionary = {}) -> void:
	var tree: SceneTree = _data.get('tree')
	tree.quit()
