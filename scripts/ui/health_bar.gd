extends Node2D

@onready var over_progress: TextureProgressBar = $Over
@onready var under_progress: TextureProgressBar = $Under

@export var health: HealthComponent

func _ready():
	set_hp(health.get_value(), health.get_max_value())
	health.value_changed.connect.call_deferred(_on_health_value_changed)

func _on_health_value_changed(new_value):
	set_hp(new_value, health.get_max_value())

func set_hp(new_hp, max_hp):
	var tween = create_tween()
	over_progress.max_value = max_hp
	under_progress.max_value = max_hp

	tween.tween_property(over_progress, 'value', new_hp, 0.1)
	tween.tween_property(under_progress, 'value', new_hp, 0.5)
