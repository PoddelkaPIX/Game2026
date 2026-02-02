class_name Look extends Node

var _target_direction = Vector2.RIGHT
var _direction = _target_direction

@export var animated_sprite_2d: AnimatedSprite2D

@export var smooth_turn_enabled = true
@export var turn_speed_deg: float = 600.0  # Скорость в градусах в секунду

@onready var _init_sprite_scale: Vector2 = animated_sprite_2d.scale

func _physics_process(delta: float) -> void:
	if get_direction().x > 0:
		animated_sprite_2d.scale.x = _init_sprite_scale.x
	elif get_direction().x < 0:
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

func get_direction() -> Vector2:
	return _direction

func get_target_direction() -> Vector2:
	return _target_direction

func set_target_direction(dir: Vector2) -> void:
	if dir.length_squared() > 0:
		_target_direction = dir.normalized()

func set_immediate_direction(dir: Vector2) -> void:
	"""Установить направление мгновенно (без плавности)"""
	if dir.length_squared() > 0:
		_target_direction = dir.normalized()
		_direction = _target_direction

func get_angle() -> float:
	"""Получить текущий угол направления в радианах"""
	return _direction.angle()

func get_target_angle() -> float:
	"""Получить целевой угол направления в радианах"""
	return _target_direction.angle()

func get_angle_to_target() -> float:
	"""Получить разницу между текущим и целевым направлением в радианах"""
	return wrapf(_target_direction.angle() - _direction.angle(), -PI, PI)

func get_angle_to_target_deg() -> float:
	"""Получить разницу между текущим и целевым направлением в градусах"""
	return rad_to_deg(get_angle_to_target())

func is_facing_target(tolerance_deg: float = 1.0) -> bool:
	"""Проверяет, смотрит ли объект в целевом направлении"""
	var tolerance_rad = deg_to_rad(tolerance_deg)
	return abs(get_angle_to_target()) < tolerance_rad

func set_turn_speed_deg(speed: float) -> void:
	"""Установить скорость поворота в градусах в секунду"""
	turn_speed_deg = max(speed, 0.0)

func set_turn_speed_rad(speed: float) -> void:
	"""Установить скорость поворота в радианах в секунду"""
	turn_speed_deg = rad_to_deg(max(speed, 0.0))
