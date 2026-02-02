extends BTAction

func _tick(_delta: float) -> Status:
	var combat_manager: CombatManager = blackboard.get_var('combat_manager')
	combat_manager.use_ability('_base_attack')
	return SUCCESS
