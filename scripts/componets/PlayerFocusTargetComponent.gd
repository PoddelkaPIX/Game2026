class_name FocusTarget extends Node

# TODO  ДОБАВИТЬ - передключение цели

signal state_changed(state: State)

enum State {NO_TARGETING, TARGETING}

@export var _agent: CharacterBody2D
@export var _focus_distance = 250

var _target: CharacterBody2D
var _target_direction: Vector2

var _state = State.NO_TARGETING

var _target_pool: Array[CharacterBody2D] = []

func _physics_process(_delta: float) -> void:
	if _state == State.TARGETING and _target:
		var target_pos = _target.global_position
		var agent_pos = _agent.global_position
		if agent_pos.distance_to(target_pos) > _focus_distance:
			cancel_focus()
		_target_direction = agent_pos.direction_to(target_pos).normalized()

func find_target():
	if !is_inside_tree() or get_tree() == null: return
	var characters = get_tree().get_nodes_in_group('Character')
	
	var character = _find_closest_target(characters)
	_set_target(character)
	
func _find_closest_target(characters) -> CharacterBody2D:
	var closest_character: CharacterBody2D = null
	
	for character: CharacterBody2D in characters:
		var visible_on_screen: VisibleOnScreenNotifier2D = character.get_node('VisibleOnScreenNotifier2D')
		if character == _agent \
			or character.fraction == owner.fraction \
			or character.is_died() \
			or _target_pool.find(character) >= 0 \
			or visible_on_screen.is_on_screen() == false: 
				continue
		if closest_character == null: 
			closest_character = character 
			continue
		var a = closest_character.global_position.distance_to(_agent.global_position)
		var b = character.global_position.distance_to(_agent.global_position)
		
		if b < a:
			closest_character = character
	if closest_character:
		var dist = _agent.global_position.distance_to(closest_character.global_position) 
		return closest_character if dist < _focus_distance else null
	return null

func get_target() -> CharacterBody2D:
	return _target

func _set_target(new_target: CharacterBody2D):
	if _target != null and _target.tree_exited.is_connected(_on_target_tree_exited):
		_target.tree_exited.disconnect(_on_target_tree_exited)
		_target.died.disconnect(_on_target_died)

	_target = new_target
	
	if _target == null:
		_set_state(State.NO_TARGETING)
		_target_pool.clear()
	else:
		_target.tree_exited.connect(_on_target_tree_exited)
		_target.died.connect(_on_target_died)
		_set_state(State.TARGETING)
		_target_pool.append(new_target)

func _on_target_died():
	cancel_focus.call_deferred()
	find_target.call_deferred()
	
func _find_next_target(_characters) -> CharacterBody2D:
	return _target

func cancel_focus():
	_set_target(null)

func _set_state(new_state: State):
	_state = new_state
	state_changed.emit(_state)

func get_state():
	return _state

func get_direction() -> Vector2:
	return _target_direction

func _on_target_tree_exited():
	_on_target_died()
