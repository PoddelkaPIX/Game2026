class_name SetCharacterPositionCommand extends Command

func execute(_data: Dictionary = {}) -> void:
	var character: CharacterBody2D = _data.get('character')
	var position: Vector2 = _data.get('position')
	character.global_position = position
	
