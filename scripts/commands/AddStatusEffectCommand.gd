class_name AddStatusEffectCommand extends Command

var node: Node2D
var status_effect: StatusEffect

func _init(_node, _status_effect) -> void:
	node = _node
	status_effect = _status_effect

func execute() -> Result:
	var status_effects_manager = node.get_node_or_null('StatusEffectManager')
	if status_effects_manager == null: return Result.FAILUR
	
	status_effects_manager.add_child(status_effect)
	return Result.SUCCESS
