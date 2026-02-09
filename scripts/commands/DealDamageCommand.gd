class_name DealDamageCommand extends Command

var attacker: Node2D
var attacked: Node2D
var damage: float

func _init(_attacker: Node2D, _attacked: Node2D, _damage: float) -> void:
	attacker = _attacker
	attacked = _attacked
	damage = _damage

func execute() -> Result:
	Log.entry('"%s" нанёс урон "%s" в размере "%s" ед.' % [attacker.name, attacked.name, str(damage)])
	DecreaseHealthCommand.new(attacked, damage).execute()
	DecreaseConcentrationCommand.new(attacked, damage / 2).execute()
	return Result.SUCCESS
