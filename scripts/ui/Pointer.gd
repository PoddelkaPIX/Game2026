extends Node
class_name Pointer

@export var target: Node2D
@export var pointer_sprite: Texture2D
@export var margin: float = 10

var camera: Camera2D
var viewport: Viewport
var sprite = Sprite2D.new()

func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	viewport = get_viewport()
	
	sprite.texture = pointer_sprite
	add_child(sprite)
	sprite.hide()

func _physics_process(_delta: float) -> void:
	if not target or not camera:
		return
	
	var screen_size = viewport.get_visible_rect().size
	
	var camera_center = camera.get_screen_center_position()
	var target_pos = target.global_position
	
	var offset_from_camera = target_pos - camera_center
	var screen_offset = offset_from_camera * camera.zoom
	
	var screen_center = screen_size / 2
	var target_screen_pos = screen_center + screen_offset
	
	var is_visible_on_screen = (
		target_screen_pos.x >= 0 and 
		target_screen_pos.x <= screen_size.x and
		target_screen_pos.y >= 0 and 
		target_screen_pos.y <= screen_size.y
	)
	
	if is_visible_on_screen:
		sprite.hide()
		return
	
	sprite.show()
	
	var direction = (target_screen_pos - screen_center).normalized()
	sprite.rotation = direction.angle()
	
	var edge_point = _get_edge_point(screen_center, direction, screen_size)
	var world_edge_point = camera.global_position + (edge_point - screen_center) / camera.zoom
	
	sprite.global_position = world_edge_point

func _get_edge_point(screen_center: Vector2, direction: Vector2, screen_size: Vector2) -> Vector2:
	var min_x = margin
	var max_x = screen_size.x - margin
	var min_y = margin
	var max_y = screen_size.y - margin
	
	var t_values = []
	
	if direction.x < 0:
		var t = (min_x - screen_center.x) / direction.x
		var y = screen_center.y + direction.y * t
		if y >= min_y and y <= max_y:
			t_values.append(t)
	
	if direction.x > 0:
		var t = (max_x - screen_center.x) / direction.x
		var y = screen_center.y + direction.y * t
		if y >= min_y and y <= max_y:
			t_values.append(t)
	
	if direction.y < 0:
		var t = (min_y - screen_center.y) / direction.y
		var x = screen_center.x + direction.x * t
		if x >= min_x and x <= max_x:
			t_values.append(t)
	
	if direction.y > 0:
		var t = (max_y - screen_center.y) / direction.y
		var x = screen_center.x + direction.x * t
		if x >= min_x and x <= max_x:
			t_values.append(t)
	
	if t_values.size() > 0:
		t_values.sort()
		for t in t_values:
			if t > 0:
				return screen_center + direction * t
	
	return screen_center + direction * 100
