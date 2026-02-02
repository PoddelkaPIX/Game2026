class_name StunLockStatusEffect extends StatusEffect

var character: Character

func _init() -> void:
	_duration = 1

func  _ready() -> void:
	super._ready()
	character = get_parent().get_parent()

func apply_to_node(node: Node):
	if character.name == 'Player': return
	if node is Movement \
	or node is CombatManager \
	or node is Look:
		node.set_physics_process(false)
		node.set_process(false)
