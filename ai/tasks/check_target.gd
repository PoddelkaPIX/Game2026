extends BTAction

func _tick(_delta: float) -> Status:
	var focus_target: FocusTarget = blackboard.get_var('focus_target')
	blackboard.set_var('target', focus_target.target())
	
	return SUCCESS
	
