class_name BaseAttackAnimHandler extends AnimationHandler

func _ready() -> void:
	var base_attack = combat_manager.get_base_attack()
	base_attack.state_preparation_entered.connect(_on_attack_preparation_entered)

func _on_attack_preparation_entered():
	animated_sprite_2d.play('attack')
