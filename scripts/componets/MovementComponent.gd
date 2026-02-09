class_name Movement extends Node

# TODO  ДОБАВИТЬ - добавить возможность сбить с ног врага с отбрасыванием

enum State {
	IDLE,
	RUN,
}

@export var _move_speed = 2000

var _current_state: State = State.IDLE
var current_direction: Vector2 = Vector2.ZERO

var disabled: bool = false:
	set(value):
		disabled = value
		if disabled:
			current_direction = Vector2.ZERO

var _agent: CharacterBody2D

func _ready() -> void:
	if owner is CharacterBody2D:
		_agent = owner as CharacterBody2D
	else:
		set_physics_process(false)

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_update_movement_state()

func stop_movement():
	set_movement_direction(Vector2.ZERO)

func _handle_movement(delta: float) -> void:
	if disabled: return
	if current_direction == Vector2.ZERO: return
	
	_agent.velocity += current_direction * _move_speed * delta

func _update_movement_state() -> void:
	if disabled: return
	var new_state = _current_state
	
	# Проверяем, движемся ли мы
	if _agent.velocity.length_squared() > 10.0:
		if current_direction.length_squared() > 0.01:
			new_state = State.RUN
		else:
			new_state = State.IDLE
	else:
		new_state = State.IDLE
	
	if new_state != _current_state:
		_current_state = new_state

func set_movement_direction(direction: Vector2) -> void:
	if disabled: return
	
	if direction.length_squared() > 0.01:
		current_direction = direction
	else:
		current_direction = Vector2.ZERO

func get_state() -> State:
	return _current_state
