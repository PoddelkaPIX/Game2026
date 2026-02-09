class_name AddImpulseCommand extends Command

var status_effects: Array[Node] = []
var node: Node2D
var direction: Vector2
var power: float

func _init(_node, _direction, _power) -> void:
	node = _node
	direction = _direction
	power = _power
	
func execute() -> Result:
	if node is not CharacterBody2D: return Result.FAILUR
	
	node.velocity += direction * power
	return Result.SUCCESS
	
