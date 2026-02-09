class_name PlayerInput extends Node

# HACK Изменить - Объеденить PlayerInput, PlayerController и PlayerInteract

signal movement_requested(direction: Vector2)
signal interact_requested()
signal focus_target_requested()
signal focus_target_cancel_requested()
signal ability_requested(ability_slot)

var _is_enabled = true

var _is_focus_target_pressed = false
var _focus_target_input_timer: float = 0
var _time_to_cancel_focus: float = 0.5

func _process(delta: float) -> void:
	if _is_enabled == false: return
	_process_movement_input()
	_process_interaction_input()
	_process_focus_target_input(delta)
	_process_combat_input()
		
func _process_movement_input() -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	movement_requested.emit(input_vector)

func _process_interaction_input() -> void:
	if Input.is_action_just_pressed("interact"):
		interact_requested.emit()

func _process_focus_target_input(delta):
	if _is_focus_target_pressed: _focus_target_input_timer += delta
		
	if Input.is_action_just_pressed('focus_target'):
		_is_focus_target_pressed = true
		
	var _is_cancel_time = _focus_target_input_timer >= _time_to_cancel_focus
	if _is_cancel_time:
		focus_target_cancel_requested.emit()

	if Input.is_action_just_released('focus_target'):
		if not _is_cancel_time:
			focus_target_requested.emit()
		_focus_target_input_timer = 0
		_is_focus_target_pressed = false
		
func _process_combat_input():
	if Input.is_action_pressed('attack'):
		ability_requested.emit('_base_attack')
	elif Input.is_action_pressed('ability_3'):
		ability_requested.emit('_ability_3')

func _on_toggle_player_control(_data):
	_is_enabled = !_is_enabled
