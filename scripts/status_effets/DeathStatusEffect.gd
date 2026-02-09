class_name DeathStatusEffect extends StatusEffect

func apply_to_node(node: Node):
	if node is Movement \
	or node is CombatManager \
	or node is Look \
	or node is Repulsion \
	or node is PlayerController \
	or node is FocusPoint \
	or node is FocusTarget:
		_disable_node(node)
	
	if node is HeartBox:
		node.monitorable = false
		node.monitoring = false
	
	if node is BTPlayer:
		node.active = false
