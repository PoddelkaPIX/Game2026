class_name RootStatusEffect extends StatusEffect

func apply_to_node(node: Node):
	if node is Movement:
		_disable_node(node)
