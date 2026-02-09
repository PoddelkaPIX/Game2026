class_name Projectile extends Node2D

@export var _flight_speed = 200
@export var _flight_distance = 200

var flight_direction: Vector2
var agent: Node2D

var _start_position: Vector2
var velocity: Vector2

func _ready() -> void:
	_start_position = global_position

func _physics_process(delta: float) -> void:
	rotation = flight_direction.angle()
	velocity = _flight_speed * delta * flight_direction
	global_position += velocity
	_check_flight_distance()

func _check_flight_distance():
	if _start_position.distance_to(global_position) >= _flight_distance:
		RemoveProjectileCommand.new(self).execute()

func _on_hit_box_area_entered(area: Area2D) -> void:
	var node: Node2D = area.get_parent()
	if agent is Character and node is Character:
		var agent_fraction = agent.fraction
		var body_fraction = node.fraction
		if area is HeartBox \
		and agent_fraction != body_fraction:
			DealDamageCommand.new(agent, node, 1).execute()
			RemoveProjectileCommand.new(self).execute()
			AddStatusEffectCommand.new(node, StunLockStatusEffect.new(0.1)).execute()
