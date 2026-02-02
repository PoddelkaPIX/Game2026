class_name StatusEffect extends Node

signal activated
signal deactivated
signal almost_over

enum Type {BUFF, DEBUFF}

@export var _duration = 1

var _is_almost_over

func _ready() -> void:
	activated.emit()

func _process(delta: float) -> void:
	_duration -= delta

	if _duration <= 0:
		deactivated.emit()
		queue_free()

func check_almost_over():
	if _is_almost_over: return
	if _duration <= 1:
		_is_almost_over = true
		almost_over.emit()

func apply_to_node(_node: Node):
	pass
