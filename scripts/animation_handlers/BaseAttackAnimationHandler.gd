class_name BaseAttackAnimHandler extends AnimationHandler

func _ready() -> void:
	var base_attack = combat_manager.base_attack()
	base_attack.state_entered.connect(_on_base_attack_state_entered)

func _on_base_attack_state_entered(state):
	if state == Ability.State.PREPARATION:
		animated_sprite_2d.play('attack')
