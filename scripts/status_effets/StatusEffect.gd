class_name StatusEffect extends Node

signal activated
signal deactivated
signal almost_over

enum Type {BUFF, DEBUFF}

@export var _duration = -1
var agent: Node2D
var _is_almost_over

func _init(duration: float = _duration) -> void:
	_duration = duration
	
func _ready() -> void:
	activated.emit()
	agent = get_parent().get_parent()

func _process(delta: float) -> void:
	if _duration == -1: return
	_duration -= delta

	if _duration <= 0:
		deactivated.emit()
		queue_free()

func check_almost_over():
	if _is_almost_over: return
	if _duration <= 1:
		_is_almost_over = true
		almost_over.emit()

func _disable_node(node):
	if 'disabled' in node: 
		node.disabled = true
	node.set_physics_process(false)
	node.set_process(false)

func apply_to_node(_node: Node):
	pass
