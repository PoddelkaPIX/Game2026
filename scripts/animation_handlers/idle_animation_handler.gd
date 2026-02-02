class_name IdleAnimHandler extends AnimationHandler

@export var movement: Movement

# HACK Изменить - Объеденить Idle и Run (Movement)

func _physics_process(_delta: float) -> void:
	if movement.get_state() != movement.State.IDLE \
	or owner.is_died() \
	or combat_manager.is_ability_fulfilled() \
	or ['death'].find(animated_sprite_2d.animation) != -1 :
		return
	
	animated_sprite_2d.play('idle')
