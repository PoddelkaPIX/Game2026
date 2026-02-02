class_name AddImpulseCommand extends Command

var status_effects: Array[Node] = []

func execute(_data: Dictionary = {}) -> void:
	var character: CharacterBody2D = _data.get('character')
	var direction: Vector2 = _data.get('direction')
	var power: float = _data.get('power')
	var movement: Movement = character.get_node("./Movement")
	
	#status_effects = character.get_node("./StatusEffectsFactory").get_children()

	movement.add_impulse(direction, _mutate_power(power))

func _mutate_power(power):
	#for effect in status_effects:
		#if effect is InvulnerabilityStatusEffect:
			#power = 0
	return power
