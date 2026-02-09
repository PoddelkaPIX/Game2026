class_name Concentration extends Node

signal value_changed(new_value)

@export var _max_value: float = 1.0
@export var _value: float = 1.0

func set_value(_new_value):
	if _value == _new_value: return
	_new_value = clamp(_new_value, 0, _max_value)
	_value = _new_value
	value_changed.emit(_value)

func get_value() -> float:
	return _value

func get_max_value() -> float:
	return _max_value
