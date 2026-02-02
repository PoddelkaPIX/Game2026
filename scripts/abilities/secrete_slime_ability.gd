extends Ability

var hitboxes: Array[HitBox] = []

const SHADOW = preload("uid://diykdflp4gsgg")

var timer: Timer = Timer.new()

func _on_execution_entered():
	var hitbox = HitBox.new()
	var collider = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	var sprite = Sprite2D.new()
	sprite.texture = SHADOW
	sprite.scale = Vector2(0.05, 0.05)
	collider.shape = shape
	
	hitbox.global_position = global_position
	hitbox.z_index = -1
	hitbox.add_child(collider)
	hitbox.add_child(sprite)
	hitboxes.append(hitbox)
	get_tree().root.add_child(hitbox)
	await get_tree().create_timer(1).timeout
	hitboxes.erase(hitbox)
	hitbox.queue_free()
