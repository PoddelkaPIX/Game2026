extends Control
@onready var continue_btn: Button = $VBoxContainer/ContinueBtn

func _on_continue_btn_pressed() -> void:
	continue_btn.grab_focus()
	toogle_vision()

func _on_exit_btn_pressed() -> void:
	ExitGameCommand.new(get_tree()).execute()

func toogle_vision():
	visible = !visible
	if visible:
		continue_btn.grab_focus()

func _on_save_game_btn_pressed() -> void:
	QuickSaveCommand.new().execute()

func _on_load_save_btn_pressed() -> void:
	QuickLoadCommand.new(get_tree()).execute()
