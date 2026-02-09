class_name HitAnimHandler extends AnimationHandler

func _ready() -> void:
	status_effect_manager.child_entered_tree.connect(_on_child_entered_tree)

func _on_child_entered_tree(child):
	if child is StunLockStatusEffect:
		_character_hited()

func _character_hited():
	animated_sprite_2d.play('hit')
