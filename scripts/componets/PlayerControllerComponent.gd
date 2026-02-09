class_name PlayerController extends Node

# Экспортируемые зависимости
@export var movement: Movement
@export var look: Look
@export var combat_manager: CombatManager
@export var _focus_target: FocusTarget

# Внутренние компоненты для взаимодействия
var _marker: Marker2D
var _smart_area: SmartArea
var _collision_shape: CollisionShape2D
var _interactive_area: InteractiveTriggerArea

# Настройки взаимодействия
@export var collision_mask: int = 6
@export var _radius: float = 25

# Состояние управления
var disabled: bool = false
var _is_focus_target_pressed: bool = false
var _focus_target_input_timer: float = 0.0
var _time_to_cancel_focus: float = 0.5

func _ready() -> void:
	_setup_interaction_area()

func _setup_interaction_area() -> void:
	_marker = Marker2D.new()
	_smart_area = SmartArea.new()
	_collision_shape = CollisionShape2D.new()

	var shape = CircleShape2D.new()
	shape.radius = _radius
	_collision_shape.shape = shape

	_smart_area.set_collision_layer_value(1, false)
	_smart_area.set_collision_mask_value(1, false)
	_smart_area.set_collision_layer_value(collision_mask, true)
	_smart_area.set_collision_mask_value(collision_mask, true)

	_smart_area.add_child(_collision_shape)
	_smart_area.position.x = 15
	_smart_area.area_entered.connect(_on_area_entered)
	_smart_area.area_exited.connect(_on_area_exited)

	_marker.add_child(_smart_area)
	owner.add_child.call_deferred(_marker)

func _process(delta: float) -> void:
	if disabled: return

	_process_movement_input()
	_process_interaction_input()
	_process_focus_target_input(delta)
	_process_combat_input()

	_update_interaction_marker()

func _update_interaction_marker() -> void:
	_marker.rotation = look.direction().angle()

func _process_movement_input() -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	_on_movement_requested(input_vector)

func _process_interaction_input() -> void:
	if Input.is_action_just_pressed("interact"):
		_on_interact_requested()

func _process_focus_target_input(delta: float) -> void:
	if _is_focus_target_pressed:
		_focus_target_input_timer += delta

	if Input.is_action_just_pressed('focus_target'):
		_is_focus_target_pressed = true

	var is_cancel_time = _focus_target_input_timer >= _time_to_cancel_focus
	if is_cancel_time:
		_on_focus_target_cancel_requested()

	if Input.is_action_just_released('focus_target'):
		if not is_cancel_time:
			_on_focus_target_requested()
		_focus_target_input_timer = 0.0
		_is_focus_target_pressed = false

func _process_combat_input() -> void:
	if Input.is_action_pressed('attack'):
		_on_ability_requested('_base_attack')
	elif Input.is_action_pressed('ability_3'):
		_on_ability_requested('_ability_3')

func _on_movement_requested(direction: Vector2) -> void:
	movement.set_movement_direction(direction)

	if movement.current_direction != Vector2.ZERO:
		look.set_target_direction(movement.current_direction)
	elif _focus_target.target():
		look.set_target_direction(_focus_target.direction())

func _on_interact_requested() -> void:
	if _interactive_area:
		_interactive_area.interact(owner)

func _on_focus_target_requested() -> void:
	_focus_target.find_target()

func _on_focus_target_cancel_requested() -> void:
	_focus_target.cancel_focus()

func _on_ability_requested(ability_slot: String) -> void:
	combat_manager.use_ability(ability_slot)

func _on_area_entered(_area: Area2D) -> void:
	_interactive_area = find_interactive_area()

func _on_area_exited(_area: Area2D) -> void:
	_interactive_area = find_interactive_area()

func find_interactive_area() -> InteractiveTriggerArea:
	if _interactive_area:
		_interactive_area.toogle_visible_button()
	if _smart_area.areas.size() == 0:
		return null

	var closest_area: InteractiveTriggerArea = null
	for area in _smart_area.areas:
		if not closest_area:
			closest_area = area
			continue

		var distance_to_new = _smart_area.global_position.distance_to(area.global_position)
		var distance_to_current = _smart_area.global_position.distance_to(closest_area.global_position)

		if distance_to_new < distance_to_current:
			closest_area = area
	closest_area.toogle_visible_button()
	return closest_area
