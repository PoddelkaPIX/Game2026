extends Quest

@export var _required_damage = 1

var _counter = 0

func _process(_delta: float) -> void:
	if disabled: return
	
	if _counter >= _required_damage:
		successfully.emit()
	
func _on_player_deal_damage(_data):
	if disabled: return
	var attacker: Node2D = _data.get('attacker')
	var damage: float = _data.get('damage')
	if attacker.name == 'Player':
		_counter += damage
