class_name StunLockStatusEffect extends StatusEffect

func apply_to_node(node: Node):
	if node is Movement \
	or node is CombatManager \
	or node is Look:
		_disable_node(node)
