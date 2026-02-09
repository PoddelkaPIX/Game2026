class_name MapInput extends Node

@export var _debuging = false
@export var escape_menu: Control

var _is_enabled = true

func _enter_tree() -> void:
	#EventBus.subscribe('toggle_player_control', _on_toggle_player_control)
	escape_menu.visibility_changed.connect(_on_escape_menu_visibility_changed)

func _process(_delta: float) -> void:
	_process_menus()
	if Input.is_action_just_pressed('quick_save'):
		QuickSaveCommand.new().execute()
	elif Input.is_action_just_pressed('quick_load'):
		QuickLoadCommand.new(get_tree()).execute()
	if _debuging:
		if Input.is_action_just_pressed('debug_1'):
			pass
	
func _process_menus():
	if Input.is_action_just_pressed('escape'):
		escape_menu.toogle_vision()

func _on_toggle_player_control():
	_is_enabled = !_is_enabled

func _on_escape_menu_visibility_changed():
	TogglePlayerControlCommand.new(get_tree()).execute()
