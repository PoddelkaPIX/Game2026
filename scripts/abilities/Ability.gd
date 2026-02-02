class_name Ability extends Node2D

signal active_changed(value)

signal state_preparation_entered()
signal state_execution_entered()
signal state_recovery_entered()
signal state_cooldown_entered()

signal state_preparation_exited()
signal state_execution_exited()
signal state_recovery_exited()
signal state_cooldown_exited()

enum State {READY, PREPARATION, EXECUTION, RECOVERY, COOLDOWN}

@export var ability_res: AbilityRes = AbilityRes.new()

var _state_timer: float = 0.0

var _current_state = State.READY
var _is_active = false:
	set(value):
		_is_active = value
		active_changed.emit(_is_active)

func _enter_tree() -> void:
	state_execution_entered.connect(_on_execution_entered)
	state_execution_exited.connect(_on_execution_exited)
	state_preparation_entered.connect(_on_state_preparation_entered)
	state_preparation_exited.connect(_on_state_preparation_exited)
	state_cooldown_entered.connect(_on_state_cooldown_entered)

func _exit_tree() -> void:
	state_execution_entered.disconnect(_on_execution_entered)
	state_execution_exited.disconnect(_on_execution_exited)
	state_preparation_entered.disconnect(_on_state_preparation_entered)
	state_preparation_exited.disconnect(_on_state_preparation_exited)
	state_cooldown_entered.disconnect(_on_state_cooldown_entered)

func use():
	if not _current_state == State.READY: return
	set_state(State.PREPARATION)

func set_state(new_state):
	if new_state == _current_state: return
	_state_timer = 0
	match _current_state:
		State.PREPARATION:
			state_preparation_exited.emit()
		State.EXECUTION:
			state_execution_exited.emit()
		State.RECOVERY:
			state_recovery_exited.emit()
		State.COOLDOWN:
			state_cooldown_exited.emit()
			
	_current_state = new_state
	
	match _current_state:
		State.READY:
			_is_active = false
		State.PREPARATION:
			state_preparation_entered.emit()
			_is_active = true
		State.EXECUTION:
			state_execution_entered.emit()
			_is_active = true
		State.RECOVERY:
			state_recovery_entered.emit()
			_is_active = true
		State.COOLDOWN:
			state_cooldown_entered.emit()
			_is_active = false

func get_state() -> State:
	return _current_state

func cancel():
	if _current_state == State.PREPARATION:
		set_state(State.COOLDOWN)
		_state_timer = ability_res.cancel_time

func _physics_process(delta: float):
	if _current_state == State.READY: return
	
	match _current_state:
		State.PREPARATION:
			_state_timer += delta
			if _state_timer >= ability_res.preparation_time:
				set_state(State.EXECUTION)
				_state_timer = 0
		State.EXECUTION:
			_state_timer += delta
			if _state_timer >= ability_res.execution_time:
				set_state(State.RECOVERY)
				_state_timer = 0
		State.RECOVERY:
			_state_timer += delta
			if _state_timer >= ability_res.recovery_time:
				set_state(State.COOLDOWN)
				_state_timer = 0
		State.COOLDOWN:
			_state_timer += delta
			if _state_timer >= ability_res.cooldown_time:
				set_state(State.READY)
				_state_timer = 0

func is_active():
	return _is_active

func _on_state_preparation_entered():
	pass
	
func _on_state_preparation_exited():
	pass

func _on_execution_entered():
	pass

func _on_execution_exited():
	pass

func _on_state_cooldown_entered():
	pass
