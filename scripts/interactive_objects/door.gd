extends StaticBody2D

@export var exit_node: Node2D

func _on_interactive_trigger_area_interacted(character) -> void:
	if character and exit_node:
		var pos = exit_node.global_position + Vector2.DOWN * 15
		SetCharacterPositionCommand.new(character, pos).execute()

# HACK  ДОБАВИТЬ - затухание экрана при переходе
# HACK  ДОБАВИТЬ - забирать управление во время перехода
