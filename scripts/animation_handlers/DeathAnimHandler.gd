class_name DeathAnimHandler extends AnimationHandler

func  _ready() -> void:
	status_effect_manager.child_entered_tree.connect(_on_status_effect_entered)

func _on_status_effect_entered(node):
	if node is not DeathStatusEffect: return
	
	if animated_sprite_2d.sprite_frames.has_animation('death'):
		animated_sprite_2d.play.call_deferred('death')
