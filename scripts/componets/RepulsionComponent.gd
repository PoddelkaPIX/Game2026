class_name Repulsion extends Node

@export var collision_mask = -1
@export var radius: float = 4
@export var power: float = 50

@export var disabled = false:
	set(value):
		disabled = value
		area.monitoring = !value
		area.monitorable = !value

var area = Area2D.new()
var area_name = 'RepulsionArea'
var collision_shape = CollisionShape2D.new()

var nodes: Array[Node2D]

func _ready() -> void:
	var shape = CircleShape2D.new()
	shape.radius = radius
	collision_shape.shape = shape
	area.set_collision_layer_value(1, false)
	area.set_collision_mask_value(1, false)
	area.set_collision_layer_value(collision_mask, true)
	area.set_collision_mask_value(collision_mask, true)
	area.name = area_name
	area.add_child(collision_shape)
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)

	owner.add_child.call_deferred(area)

func _on_area_entered(_area):
	if _area.name != area_name: return
	nodes.append(_area.get_parent())
	
func _on_area_exited(_area):
	if _area.name != area_name: return
	nodes.erase(_area.get_parent())

func _physics_process(_delta: float) -> void:
	if disabled: return
	for node in nodes:
		if owner == node: return
		
		var char_pos = node.global_position
		var owner_pos = owner.global_position
		
		var dir = owner_pos.direction_to(char_pos)
		var dist = owner_pos.distance_to(char_pos)
		
		AddImpulseCommand.new(node, dir, (power / 2) - dist).execute()
