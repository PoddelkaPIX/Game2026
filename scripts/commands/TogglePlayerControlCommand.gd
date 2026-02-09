class_name TogglePlayerControlCommand extends Command

var tree: SceneTree

func _init(_tree) -> void:
	tree = _tree
	
func execute() -> Result:
	var player = tree.get_first_node_in_group('Player')
	var controller: PlayerController = player.get_node_or_null("PlayerController")
	if controller:
		controller.disabled = !controller.disabled
		return Result.SUCCESS
	return Result.FAILUR
