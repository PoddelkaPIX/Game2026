class_name SmartArea extends Area2D

var bodies = []
var areas = []

func _init() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	areas.append(area)
	
func _on_area_exited(area):
	areas.erase(area)
	
func _on_body_entered(body):
	bodies.append(body)
	
func _on_body_exited(body):
	bodies.erase(body)
