class_name RemoveProjectileCommand extends Command

var projectile: Projectile

func  _init(_projectile: Projectile) -> void:
	projectile = _projectile

func execute() -> Result:
	projectile.queue_free()
	return Result.SUCCESS
