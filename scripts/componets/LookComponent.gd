class_name Look extends Node

var _target_direction = Vector2.RIGHT
var _direction = _target_direction

@export var animated_sprite_2d: AnimatedSprite2D

@export var smooth_turn_enabled = true
@export var turn_speed_deg: float = 600.0

@onready var _init_sprite_scale: Vector2 = animated_sprite_2d.scale

func _physics_process(delta: float) -> void:
	if _direction.x > 0:
		animated_sprite_2d.scale.x = _init_sprite_scale.x
	elif _direction.x < 0:
		animated_sprite_2d.scale.x = -_init_sprite_scale.x
	if smooth_turn_enabled:
		_update_linear_direction(delta)
	else:
		_direction = _target_direction

func _update_linear_direction(delta: float) -> void:
	# Если направление уже совпадает с целевым, ничего не делаем
	if _direction.dot(_target_direction) > 0.999:
		_direction = _target_direction
		return
	
	# Конвертируем скорость из градусов в радианы
	var turn_speed_rad = deg_to_rad(turn_speed_deg) * delta
	
	# Находим текущий и целевой углы
	var current_angle = _direction.angle()
	var target_angle = _target_direction.angle()
	
	# Находим кратчайший путь (учитываем переход через 0)
	var angle_diff = wrapf(target_angle - current_angle, -PI, PI)
	
	# Вычисляем новый угол с линейной скоростью
	var angle_change = 0.0
	if abs(angle_diff) > turn_speed_rad:
		angle_change = sign(angle_diff) * turn_speed_rad
	else:
		angle_change = angle_diff
	
	# Обновляем направление
	var new_angle = current_angle + angle_change
	_direction = Vector2(cos(new_angle), sin(new_angle))

func direction() -> Vector2:
	return _direction

func target_direction() -> Vector2:
	return _target_direction

func set_target_direction(dir: Vector2) -> void:
	if dir.length_squared() > 0:
		_target_direction = dir.normalized()
