extends StaticBody2D

@export var exit_node: Node2D

func _on_interactive_trigger_area_interacted(character) -> void:
	if character and exit_node:
		SetCharacterPositionCommand.new().execute({
			'character': character,
			'position': exit_node.global_position + Vector2.DOWN * 15
		})

# TODO  ДОБАВИТЬ - затухание экрана при переходе
# TODO  ДОБАВИТЬ - забирать управление во время перехода
