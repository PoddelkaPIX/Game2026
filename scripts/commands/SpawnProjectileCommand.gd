class_name SpawnProjectileCommand extends Command

var tree: SceneTree
var projectile: Projectile
var position: Vector2
var direction: Vector2

func _init(_tree: SceneTree, _projectile, _position, _direction) -> void:
	tree = _tree
	projectile = _projectile
	position = _position
	direction = _direction
	
func execute() -> Result:
	var projectile_manager = tree.get_first_node_in_group('ProjectileManager')
	
	projectile.flight_direction = direction
	projectile.global_position = position
	projectile_manager.add_child(projectile)

	return Result.SUCCESS
