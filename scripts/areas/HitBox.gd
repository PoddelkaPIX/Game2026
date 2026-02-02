class_name HitBox extends Area2D

func _ready() -> void:
	monitorable = false

func toogle_monitoring():
	monitoring = !monitoring

func start_temporary_monitoring(time: float):
	monitoring = true
	await get_tree().create_timer(time).timeout
	monitoring = false
