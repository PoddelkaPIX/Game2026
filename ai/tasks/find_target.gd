extends BTAction

func _tick(_delta: float) -> Status:
	var focus_target: FocusTarget = blackboard.get_var('focus_target')
	focus_target.find_target()
	var target = focus_target.target()
	blackboard.set_var('target', target)
	
	return SUCCESS
	
