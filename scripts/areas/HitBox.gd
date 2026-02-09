class_name HitBox extends Area2D

var _hited_hitboxes: Array[Area2D] = []

func _ready() -> void:
	monitorable = false

func reset():
	_hited_hitboxes.clear()

func hited_hitboxes():
	return _hited_hitboxes

func toogle_monitoring():
	monitoring = !monitoring

func start_temporary_monitoring(time: float):
	monitoring = true
	await get_tree().create_timer(time).timeout
	monitoring = false
