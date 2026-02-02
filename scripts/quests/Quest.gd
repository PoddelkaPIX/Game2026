class_name Quest extends Node

signal activated
signal successfully
signal failed
 
var disabled = true

func _init() -> void:
	add_to_group('Quest')

func _ready() -> void:
	activated.connect(_on_activated)

func activate():
	disabled = false
	activated.emit()

func _on_activated():
	pass
