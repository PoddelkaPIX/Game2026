class_name CharacterManager extends Node2D

#func _ready() -> void:
	#EventBus.subscribe('spawn_character', _on_spawn_character)
	
func _on_spawn_character(_data: Dictionary):
	print(_data)
