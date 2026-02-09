class_name SpawnItemCommand extends Command

const ITEM = preload("uid://b1epvltx0bbft")

var tree: SceneTree
var item: Item = ITEM.instantiate()
var item_name: String

func _init(_tree, _texture_name, _position) -> void:
	tree = _tree
	item.texture_name = _texture_name
	item.global_position = _position
	
func execute() -> Result:
	var item_manager = tree.get_first_node_in_group('ItemManager')
	
	item_manager.add_child.call_deferred(item)
	return Result.SUCCESS
