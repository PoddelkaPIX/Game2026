class_name SetCharacterPositionCommand extends Command

var character: Character
var position: Vector2

func _init(_character: Character, _position) -> void:
	character = _character
	position = _position
	
func execute() -> Result:
	character.global_position = position
	return Result.SUCCESS
	
