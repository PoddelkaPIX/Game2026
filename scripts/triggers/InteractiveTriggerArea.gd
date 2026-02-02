@tool
class_name InteractiveTriggerArea extends Area2D

signal interacted(character)

const F = preload("uid://ilxgae41d8ye")
const Y = preload("uid://b077dmbi1ew6x")

@export var radius = 7

var collision_shape = CollisionShape2D.new()

var sprite_button = Sprite2D.new()

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		sprite_button.texture = Y
	else:
		sprite_button.texture = F

func _ready() -> void:
	var shape = CircleShape2D.new()
	shape.radius = radius
	collision_shape.shape = shape
	
	self.set_collision_layer_value(1, false)
	self.set_collision_mask_value(1, false)
	self.set_collision_layer_value(6, true)
	self.set_collision_mask_value(6, true)

	self.add_child(collision_shape)
	sprite_button.z_index = 1
	sprite_button.modulate.a = 0.9
	add_child(sprite_button)
	toogle_visible_button()

func _get_configuration_warnings() -> PackedStringArray:
	return []
	
func _get_accessibility_configuration_warnings() -> PackedStringArray:
	return []

func toogle_visible_button():
	sprite_button.visible = !sprite_button.visible

func interact(character: CharacterBody2D):
	interacted.emit(character)
