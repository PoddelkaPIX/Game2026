extends Node

@onready var deal_damage_quest: Quest = $DealDamageQuest
@onready var move_awsd_quest: Quest = $MoveAWSDQuest
@onready var move_to_position_quest: Quest = $MoveToPositionQuest

func start_education():
	deal_damage_quest.activate()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		start_education()
