@abstract
class_name Command
extends RefCounted

func execute(_data: Dictionary = {}) -> void:
	push_error("Default command executed - implement in subclass: ", _data)
