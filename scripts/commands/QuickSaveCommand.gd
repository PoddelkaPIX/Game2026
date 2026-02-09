class_name QuickSaveCommand extends Command

var save_path: String = 'user://save_1.tres'

func execute() -> Result:	
	return SaveGameCommand.new(save_path).execute()
