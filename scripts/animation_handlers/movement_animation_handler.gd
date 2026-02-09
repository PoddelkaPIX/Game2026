class_name MovementAnimHandler extends AnimationHandler

@export var movement: Movement

func _physics_process(_delta: float) -> void:
	if movement.disabled: return
	if combat_manager.is_ability_fulfilled(): return
	
	match movement.get_state():
		movement.State.IDLE:
			animated_sprite_2d.play('idle')
		movement.State.RUN:
			animated_sprite_2d.play('run')
