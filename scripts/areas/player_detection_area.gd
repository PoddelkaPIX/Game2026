class_name PlayerDetectionArea extends Area2D

signal player_detected(player: CharacterBody2D)
signal player_missed

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _exit_tree() -> void:
	body_entered.disconnect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		player_detected.emit(body)

func _on_body_exited(body):
	if body.name == "Player":
		player_missed.emit()
