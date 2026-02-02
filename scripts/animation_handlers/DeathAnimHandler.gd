class_name DeathAnimHandler extends AnimationHandler

func  _ready() -> void:
	if owner is Character:
		owner.died.connect(_on_character_died)

func _on_character_died():
	if animated_sprite_2d.sprite_frames.has_animation('death'):
		animated_sprite_2d.play('death')
