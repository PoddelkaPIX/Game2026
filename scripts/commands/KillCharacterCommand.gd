class_name KillCommand extends Command

var node: Node2D

func _init(_node) -> void:
	node = _node
	
func execute() -> Result:
	var status_effect_manager = node.get_node_or_null("StatusEffectManager")
	if status_effect_manager == null: return Result.FAILUR
	
	if node is Character:
		node.visualization.visible = false

	status_effect_manager.add_child(DeathStatusEffect.new())
	Log.entry('"%s" умер' % [node.name])
	return Result.SUCCESS
	
