extends Ability

@export var _dash_power = 500
@export_category("Components")
@export var _look: Look

func _on_state_entered(_state):
	if _state == State.EXECUTION:
		AddImpulseCommand.new(owner, _look.direction(), _dash_power).execute()

	
func _on_state_exited(_state):
	pass
