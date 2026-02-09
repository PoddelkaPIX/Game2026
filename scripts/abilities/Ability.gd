class_name Ability extends Node2D

# Сигналы
signal active_changed(value)
signal state_entered(state)
signal state_exited(state)
signal cancelled

# Состояние
enum State {READY, PREPARATION, EXECUTION, RECOVERY, COOLDOWN}
@export var ability_res: AbilityRes = AbilityRes.new()

var _state_timer: float = 0.0
var _current_state: State = State.READY
var _is_active: bool = false:
	set(value):
		_is_active = value
		active_changed.emit(value)
		if value == false:
			_reset()

func _enter_tree() -> void:
	visible = false
	state_entered.connect(_on_state_entered)
	state_exited.connect(_on_state_exited)
	cancelled.connect(_on_cancelled)
	active_changed.connect(_on_active_changed)

func _exit_tree() -> void:
	state_entered.disconnect(_on_state_entered)
	state_exited.disconnect(_on_state_exited)
	cancelled.disconnect(_on_cancelled)
	active_changed.disconnect(_on_active_changed)

func _physics_process(delta: float) -> void:
	if _current_state == State.READY:
		return

	_state_timer += delta

	var duration: float
	match _current_state:
		State.PREPARATION: duration = ability_res.preparation_time
		State.EXECUTION: duration = ability_res.execution_time
		State.RECOVERY: duration = ability_res.recovery_time
		State.COOLDOWN: duration = ability_res.cooldown_time
		_: duration = 0.0

	if _state_timer >= duration:
		var next_state: State
		match _current_state:
			State.PREPARATION: next_state = State.EXECUTION
			State.EXECUTION: next_state = State.RECOVERY
			State.RECOVERY: next_state = State.COOLDOWN
			State.COOLDOWN: next_state = State.READY
			_: next_state = State.READY
		
		set_state(next_state)
	
func use() -> void:
	if _current_state == State.READY:
		set_state(State.PREPARATION)

func cancel() -> void:
	if _current_state == State.PREPARATION:
		_state_timer = ability_res.cancel_time
		set_state(State.COOLDOWN)
		cancelled.emit()

func set_state(new_state: State) -> void:
	if new_state == _current_state:
		return
	
	# Выход из текущего состояния
	if _current_state != State.READY:
		state_exited.emit(_current_state)
	
	_state_timer = 0
	_current_state = new_state
	
	# Вход в новое состояние
	state_entered.emit(_current_state)
	_is_active = _current_state not in [State.READY, State.COOLDOWN]

func get_state() -> State:
	return _current_state

func is_active() -> bool:
	return _is_active
	
func _reset():
	pass
	
func _on_state_entered(_state: State):
	pass
	
func _on_state_exited(_state: State):
	pass

func _on_active_changed(_active: bool): 
	pass

func _on_cancelled():
	pass
