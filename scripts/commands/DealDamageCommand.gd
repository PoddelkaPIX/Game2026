class_name DealDamageCommand extends Command

func execute(_data: Dictionary = {}) -> void:
	var attacker: Node2D = _data.get('attacker')
	var attacked: Node2D = _data.get('attacked')
	var damage: float = _data.get('damage')
	
	if attacked is Character and attacker is Character:
		if attacker.fraction == attacked.fraction:
			return
		
		if attacked:
			attacked.hit(damage)
			EventBus.emit('damage_done', _data)
