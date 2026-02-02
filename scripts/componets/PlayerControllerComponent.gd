class_name PlayerController extends Node

@export var player_input: PlayerInput
@export var player_interact: PlayerInteract
@export var _focus_target: FocusTarget 

@export var movement: Movement
@export var look: Look
@export var combat_manager: CombatManager

func _ready() -> void:
	_connect_all_signals()

func _connect_all_signals() -> void:
	if player_input:
		player_input.movement_requested.connect(_on_movement_requested)
		player_input.interact_requested.connect(_on_interact_requested)
		player_input.focus_target_requested.connect(_on_focus_target_requested)
		player_input.focus_target_cancel_requested.connect(_on_focus_target_cancel_requested)
		player_input.ability_requested.connect(_on_ability_requested)

func _on_focus_target_cancel_requested():
	_focus_target.cancel_focus()

func _on_focus_target_requested():
	_focus_target.find_target()

func _on_movement_requested(direction: Vector2) -> void:
	if movement.disabled: return
	movement.set_movement_direction(direction)
	
	if movement.current_direction != Vector2.ZERO:
		look.set_target_direction(direction)
	elif _focus_target.get_target():
		look.set_target_direction(_focus_target.get_direction())

func _on_interact_requested():
	if player_interact.interactive_area:
		player_interact.interactive_area.interact(owner)

func _on_ability_requested(ability_slot):
	combat_manager.use_ability(ability_slot)
