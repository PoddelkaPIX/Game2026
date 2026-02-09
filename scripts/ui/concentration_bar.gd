extends Node2D

@onready var over_progress: TextureProgressBar = $Over
@onready var under_progress: TextureProgressBar = $Under

@export var concentration: Concentration

func _ready():
	set_concentration(concentration.get_value(), concentration.get_max_value())
	concentration.value_changed.connect.call_deferred(_on_health_value_changed)

func _on_health_value_changed(new_value):
	set_concentration(new_value, concentration.get_max_value())

func set_concentration(new_hp, max_hp):
	var tween = create_tween()
	over_progress.max_value = max_hp
	under_progress.max_value = max_hp

	tween.tween_property(over_progress, 'value', new_hp, 0.1)
	tween.tween_property(under_progress, 'value', new_hp, 0.5)
