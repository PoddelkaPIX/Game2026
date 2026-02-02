extends Ability

@export_category("Components")
@export var _movement: Movement
@export var _dash_power = 500
@export var _look: Look

func _on_execution_entered():
	_movement.add_impulse(_look.get_direction(), _dash_power)
