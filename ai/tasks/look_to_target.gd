extends BTAction

func _tick(_delta: float) -> Status:
	var look: Look = blackboard.get_var('look')
	var target: Node2D = blackboard.get_var('target')
	if target == null or look == null: return FAILURE
	var dir = agent.global_position.direction_to(target.global_position)
	look.set_target_direction(dir)
	
	return SUCCESS
