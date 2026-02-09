class_name Health extends Node

signal value_changed(new_value)

@export var _max_value: float = 1.0
@export var _value: float = 1.0

func _init() -> void:
	_value = 1

func set_value(_new_value):
	_new_value = clamp(_new_value, 0, _max_value)
	if _value == _new_value: return
	_value = _new_value
	value_changed.emit(_value)

func get_value() -> float:
	return _value

func get_max_value() -> float:
	return _max_value
