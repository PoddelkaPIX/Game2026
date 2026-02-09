extends AnimationHandler

func _ready() -> void:
	var base_attack = combat_manager.base_attack()
	var ability_3 = combat_manager.ability_3()
	base_attack.state_entered.connect(_on_base_attack_state_entered)
	ability_3.state_entered.connect(_on_ability_3_state_entered)

func _on_base_attack_state_entered(state):
	if state == Ability.State.PREPARATION:
		animated_sprite_2d.play('attack_2' if animated_sprite_2d.animation == 'attack_1' else 'attack_1')

func _on_ability_3_state_entered(state):
	if state == Ability.State.PREPARATION:
		animated_sprite_2d.play('slide')
