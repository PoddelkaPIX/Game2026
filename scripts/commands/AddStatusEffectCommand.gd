class_name AddStatusEffectCommand extends Command

func execute(_data: Dictionary = {}) -> void:
	var character: Character = _data.get('character')
	var status_effect: StatusEffect = _data.get('status_effect')
	character.status_effects_manager.add_child(status_effect)
