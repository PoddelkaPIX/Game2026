class_name SaveGameCommand extends Command

var save_path: String

func _init(_save_path) -> void:
	save_path = _save_path

func execute() -> Result:
	GameStateService.save_game_state(save_path)
	return Result.SUCCESS
