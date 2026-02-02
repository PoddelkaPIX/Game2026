extends Node2D

@export var status_effects_manager: StatusEffectManager
@export var animated_sprite_2d: AnimatedSprite2D

func _ready() -> void:
	status_effects_manager.child_entered_tree.connect(_on_status_effect_entered)
	status_effects_manager.child_exiting_tree.connect(_on_status_effect_exiting)
	
	for status_effect in status_effects_manager.get_children():
		_on_status_effect_entered(status_effect)
	
func _on_status_effect_entered(node):
	if node is InvulnerabilityStatusEffect:
		animated_sprite_2d.modulate = Color.YELLOW
	
func _on_status_effect_exiting(node):
	if node is InvulnerabilityStatusEffect:
		animated_sprite_2d.modulate = Color.WHITE
