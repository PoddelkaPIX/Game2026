extends BTAction

var min_dist = 40
func _tick(_delta: float) -> Status:
	var movement: Movement = blackboard.get_var('movement')
	var nav_agent: NavigationAgent2D = blackboard.get_var('nav_agent')
	var look: Look = blackboard.get_var('look')
	var target: Node2D = blackboard.get_var('target')
		
	nav_agent.target_position = target.global_position
	var next_pos = nav_agent.get_next_path_position()
	var dir = agent.global_position.direction_to(next_pos)
	
	movement.set_movement_direction(dir)
	look.set_target_direction(dir)
	
	var dist = target.global_position.distance_to(nav_agent.get_parent().global_position)
	if nav_agent.is_navigation_finished() or dist < min_dist:
		movement.stop_movement()
		return SUCCESS
	return RUNNING
