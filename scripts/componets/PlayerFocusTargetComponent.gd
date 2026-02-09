class_name FocusTarget extends Node

signal state_changed(state: State)

enum State {NO_TARGETING, TARGETING}

@export var _focus_distance = 250

var _target: FocusPoint
var _target_direction: Vector2

var _closest_focus_point: FocusPoint

var _state = State.NO_TARGETING
var _target_pool: Array[FocusPoint] = []

func _physics_process(_delta: float) -> void:
	if _state == State.TARGETING and _target:
		var target_pos = _target.global_position
		var agent_pos = owner.global_position
		if agent_pos.distance_to(target_pos) > _focus_distance:
			cancel_focus()
		if _target and _target.disabled:
			find_target()
		_target_direction = agent_pos.direction_to(target_pos).normalized()

	_closest_focus_point  = _find_closest_focus_point()

func find_target():
	if !is_inside_tree() or get_tree() == null: return
	
	_set_target(_closest_focus_point)
	
func _find_closest_focus_point() -> FocusPoint:
	var focus_points = get_tree().get_nodes_in_group('FocusPoint')
	var cl_focus_point: FocusPoint = null
	
	for focus_point: FocusPoint in focus_points:
		if focus_point.owner.fraction == owner.fraction \
		or _target_pool.find(focus_point) >= 0\
		or focus_point.disabled: 
				continue
		if cl_focus_point == null: 
			cl_focus_point = focus_point 
			continue
		var a = cl_focus_point.global_position.distance_to(owner.global_position)
		var b = focus_point.global_position.distance_to(owner.global_position)
		
		if b < a:
			cl_focus_point = focus_point
	if cl_focus_point:
		var dist = owner.global_position.distance_to(cl_focus_point.global_position) 
		return cl_focus_point if dist < _focus_distance else null
	return null

func target() -> FocusPoint:
	return _target
	
func state():
	return _state

func direction() -> Vector2:
	return _target_direction

func closest_focus_point():
	return _closest_focus_point

func _set_target(new_target: FocusPoint):
	_target = new_target
	
	if _target == null:
		_set_state(State.NO_TARGETING)
		_target_pool.clear()
	else:
		_set_state(State.TARGETING)
		_target_pool.append(new_target)

func cancel_focus():
	_set_target(null)

func _set_state(new_state: State):
	_state = new_state
	state_changed.emit(_state)
