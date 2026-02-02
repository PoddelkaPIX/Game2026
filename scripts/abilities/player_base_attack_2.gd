extends Ability

@onready var hit_box: HitBox = $HitBox

func _on_state_preparation_entered():
	owner.movement.set_movement_enabled(false)
	owner.movement.stop_movement()
	owner.movement.add_impulse(owner.look.get_direction(), owner.impulse_power / 2)

func _on_execution_entered():
	hit_box.start_temporary_monitoring(ability_res.execution_time)

func _on_execution_exited():
	owner.visible = false
	
func _on_state_cooldown_entered():
	owner.movement.set_movement_enabled(true)
	
func _on_hit_box_area_entered(_area: Area2D) -> void:
	owner.movement.add_impulse(owner.look.get_direction() * -1, owner.impulse_power / 2)
	
	if _area is HeartBox:
		DealDamageCommand.new().execute({
			'attacker': owner,
			'attacked': _area.agent,
			'damage': owner.damage * 2
		})
		AddImpulseCommand.new().execute({
			'character': _area.owner,
			'power': owner.impulse_power / 2,
			'direction': owner.look.get_direction()
		})
