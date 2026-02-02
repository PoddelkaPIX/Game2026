extends BTAction

func _tick(_delta: float) -> Status:
	var target: Node2D = blackboard.get_var('target')
	var nav_agent: NavigationAgent2D = blackboard.get_var('nav_agent')
	
	nav_agent.target_position = target.global_position
	
	return SUCCESS
