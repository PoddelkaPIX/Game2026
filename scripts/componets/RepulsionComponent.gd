class_name Repulsion extends Node

@export var collision_mask = -1
@export var radius = 5

@export var is_active = true:
	set(value):
		is_active = value
		smart_area.monitoring = is_active
		smart_area.monitorable = is_active

var smart_area = SmartArea.new()
var collision_shape = CollisionShape2D.new()

func _ready() -> void:
	var shape = CircleShape2D.new()
	shape.radius = radius
	collision_shape.shape = shape
	smart_area.set_collision_layer_value(1, false)
	smart_area.set_collision_mask_value(1, false)
	smart_area.set_collision_layer_value(collision_mask, true)
	smart_area.set_collision_mask_value(collision_mask, true)

	smart_area.add_child(collision_shape)
	owner.add_child.call_deferred(smart_area)

func _physics_process(_delta: float) -> void:
	if is_active == false: return
	if len(smart_area.bodies) > 0:
		for body in smart_area.bodies:
			if body is CharacterBody2D and owner is CharacterBody2D and owner != body:
				var dir = owner.global_position.direction_to(body.global_position)
				var dist = owner.global_position.distance_to(body.global_position)
				body.velocity += dir * 200 / dist
