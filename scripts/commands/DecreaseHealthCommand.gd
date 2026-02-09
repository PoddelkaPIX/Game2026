class_name DecreaseHealthCommand extends Command

var node: Node2D
var damage: float

func _init(_node, _damage) -> void:
	node = _node
	damage = _damage

func execute() -> Result:
	var health = node.get_node_or_null('Health')
	if health == null: return Result.FAILUR
	
	health.set_value(health.get_value() - damage)
	Log.entry('Здоровье "%s" уменьшено на "%s", осталось "%s"' % [node.name, str(damage), str(health.get_value())])
	if health.get_value() == 0:
		KillCommand.new(node).execute()
	return Result.SUCCESS
