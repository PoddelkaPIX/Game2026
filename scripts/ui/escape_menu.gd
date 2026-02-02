extends Control
@onready var continue_btn: Button = $VBoxContainer/ContinueBtn

func _on_continue_btn_pressed() -> void:
	continue_btn.grab_focus()
	toogle_vision()

func _on_exit_btn_pressed() -> void:
	ExitGameCommand.new().execute({
		'tree': get_tree()
	})

func toogle_vision():
	visible = !visible
	if visible:
		continue_btn.grab_focus()
