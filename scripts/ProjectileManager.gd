class_name ProjectileManager extends Node2D

var projectile_pool: Array[Projectile] = []

func _on_remove_projectile(_data: Dictionary):
	var projectile: Node2D = _data.get('projectile')
	projectile_pool.append(projectile)
