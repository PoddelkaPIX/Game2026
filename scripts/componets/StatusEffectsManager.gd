class_name StatusEffectManager extends Node

@export var nodes: Array[Node]
var status_effects: Array[StatusEffect]

func _process(_delta: float) -> void:
	for node: Node in nodes:
		node.set_physics_process(true)
		node.set_process(true)
		if 'disabled' in node: node.disabled = false
		
		for status_effect in status_effects:
			status_effect.apply_to_node(node)

func _ready() -> void:
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)
	
func _on_child_entered_tree(node: Node):
	if node is StatusEffect:
		status_effects.append(node)
		
func _on_child_exiting_tree(node:Node):
	if node is StatusEffect:
		status_effects.erase(node)
