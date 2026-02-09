class_name PlayerInteract extends Node

@export var look: Look

@export var collision_mask = 6
@export var _radius = 25

var marker = Marker2D.new()
var smart_area = SmartArea.new()
var collision_shape = CollisionShape2D.new()

var interactive_area: InteractiveTriggerArea:
	set(new_area):
		if new_area == null:
			interactive_area.toogle_visible_button()
			interactive_area = new_area
		elif interactive_area == null: 
			interactive_area = new_area
			interactive_area.toogle_visible_button()
		else:
			interactive_area.toogle_visible_button()
			interactive_area = new_area
			interactive_area.toogle_visible_button()
		
		

func _ready() -> void:
	var shape = CircleShape2D.new()
	shape.radius = _radius
	collision_shape.shape = shape
	smart_area.set_collision_layer_value(1, false)
	smart_area.set_collision_mask_value(1, false)
	smart_area.set_collision_layer_value(collision_mask, true)
	smart_area.set_collision_mask_value(collision_mask, true)

	smart_area.add_child(collision_shape)
	smart_area.position.x = 15
	smart_area.area_entered.connect(_on_area_entered)
	smart_area.area_exited.connect(_on_area_exited)
	marker.add_child(smart_area)
	owner.add_child.call_deferred(marker)
	
func _physics_process(_delta: float) -> void:
	marker.rotation = look.direction().angle()

func _on_area_entered(_area):
	interactive_area = find_interactive_area()
	
func _on_area_exited(_area):
	interactive_area = find_interactive_area()

func find_interactive_area() -> InteractiveTriggerArea:
	if len(smart_area.areas) == 0: return
	var _interactive_area: Node = null
	for area: Area2D in smart_area.areas:
		if _interactive_area == null:
			_interactive_area = area
			continue
		var a = smart_area.global_position.distance_to(area.global_position)
		var b = _interactive_area.global_position.distance_to(area.global_position)
		if a < b:
			_interactive_area = area
	return _interactive_area
		
