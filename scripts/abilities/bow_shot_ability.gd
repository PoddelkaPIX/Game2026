extends Ability

@export_category('Components')
@export var focus_target: FocusTarget
@export var movement: Movement

func _on_state_entered(_state):
	if _state == State.EXECUTION:
		var projectile: Projectile = ProjectileList.ARROW_PROJECTILE.instantiate()
		projectile.agent = owner
		SpawnProjectileCommand.new(
			get_tree(), 
			projectile, 
			owner.global_position, 
			focus_target.direction()
		).execute()

func _on_state_exited(_state):
	if _state == State.EXECUTION:
		_reset()
