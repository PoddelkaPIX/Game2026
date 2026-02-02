class_name HitAnimHandler extends AnimationHandler

func _ready() -> void:
	owner.hited.connect(_on_character_hited)

func _on_character_hited():
	if owner.is_died(): return
	animated_sprite_2d.play('hit')
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play('idle')
