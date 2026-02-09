extends BTAction

var p: Vector2
var stuck_timer = 0
var max_stack_timer = 0.2

func _tick(_delta: float) -> Status:
	var movement: Movement = blackboard.get_var('movement')
	var nav_agent: NavigationAgent2D = blackboard.get_var('nav_agent')
	var look: Look = blackboard.get_var('look')
	
	var next_pos = nav_agent.get_next_path_position()
	var dir = agent.global_position.direction_to(next_pos)
	
	if p.distance_to(movement.owner.global_position) <= 1:
		stuck_timer += _delta
	else:
		stuck_timer = 0
	if stuck_timer >= max_stack_timer:
		stuck_timer = 0
		return FAILURE
		
	p = movement.owner.global_position
	movement.set_movement_direction(dir)
	look.set_target_direction(dir)
	
	if nav_agent.is_target_reachable() == false:
		return FAILURE
		
	if nav_agent.is_navigation_finished():
		movement.stop_movement()
		return SUCCESS
	return RUNNING
