extends AnimationPlayer

func _on_health_component_value_changed(_new_value: Variant) -> void:
	var anims = ['hit_1', 'hit_2']
	play(anims.pick_random())
	
	if _new_value == 0:
		owner.queue_free()
