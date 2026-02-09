class_name GiveItemCommand extends Command

var character: Character
var item_name: String

func _init(_character, _item_name) -> void:
	character = _character
	item_name = _item_name

func execute() -> Result:
	character.inventory.soul_pieces += 1
	Log.entry('"%s" выдан "s%"' % [item_name, character.name])
	return Result.SUCCESS
