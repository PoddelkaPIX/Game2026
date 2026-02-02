extends BTAction

var distance = 40

func _tick(_delta: float) -> Status:
	var nav_agent: NavigationAgent2D = blackboard.get_var('nav_agent')
	var pos = Vector2(randf_range(-distance, distance), randf_range(-distance, distance)) + agent.global_position
	nav_agent.target_position = pos
	return SUCCESS
