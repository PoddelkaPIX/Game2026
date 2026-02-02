extends AnimationHandler

func _ready() -> void:
	var base_attack = combat_manager.get_base_attack()
	var ability_3 = combat_manager.get_ability_3()
	base_attack.state_preparation_entered.connect(_on_attack_preparation_entered)
	ability_3.state_preparation_entered.connect(_on_ability_3_preparation_entered)

func _on_attack_preparation_entered():
	if owner.is_died(): return
	if animated_sprite_2d.animation == 'attack_1':
		animated_sprite_2d.play('attack_2')
	else:
		animated_sprite_2d.play('attack_1')

func _on_ability_3_preparation_entered():
	animated_sprite_2d.play('slide')
