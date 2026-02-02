class_name HealthComponent extends Node

signal death_requested
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
	if _value == 0:
		death_requested.emit()

func get_value() -> float:
	return _value

func get_max_value() -> float:
	return _max_value
