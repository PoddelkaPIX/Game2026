class_name IdleAnimHandler extends AnimationHandler

@export var movement: Movement

func _physics_process(_delta: float) -> void:
	if movement.get_state() != movement.State.IDLE \
	or owner.is_died() \
	or combat_manager.is_ability_fulfilled() \
	or ['hit', 'death'].find(animated_sprite_2d.animation) != -1 :
		return
	
	animated_sprite_2d.play('idle')
