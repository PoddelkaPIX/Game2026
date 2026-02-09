class_name DecreaseConcentrationCommand extends Command

var node: Node2D
var damage: float

func _init(_node, _damage) -> void:
	node = _node
	damage = _damage

func execute() -> Result:
	var conc = node.get_node_or_null("Concentration")
	if conc == null: return Result.FAILUR
	
	conc.set_value(conc.get_value() - damage)
	return Result.SUCCESS
