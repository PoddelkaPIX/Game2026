extends Marker2D

@export var look: Look

func _physics_process(_delta: float) -> void:
	self.rotation = look.get_direction().angle()
