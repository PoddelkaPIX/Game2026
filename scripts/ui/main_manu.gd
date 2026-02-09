extends Control

@onready var new_game_btn: Button = %NewGameBtn

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	new_game_btn.grab_focus()

func _on_play_game_pressed() -> void:
	StartNewGameCommand.new(get_tree()).execute()

func _on_continue_btn_pressed() -> void:
	pass

func _on_exit_btn_pressed() -> void:
	ExitGameCommand.new(get_tree()).execute()
