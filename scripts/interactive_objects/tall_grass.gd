extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	animated_sprite_2d.flip_h = true if randi_range(1, 2) == 2 else false

func _on_health_value_changed(_new_value: Variant) -> void:
	gpu_particles_2d.emitting = true
	animated_sprite_2d.play('2')
