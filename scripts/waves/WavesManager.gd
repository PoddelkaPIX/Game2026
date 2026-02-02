class_name WavesManager extends Node

@export var area: Area2D
@export var waves: Array[Wave] = []

var _is_active = false

func _ready() -> void:
	if area:
		area.body_entered.connect(_on_area_body_entered)
	
func _on_area_body_entered(body):
	if body.name == 'Player':
		activate()
		
func activate():
	_is_active = true
