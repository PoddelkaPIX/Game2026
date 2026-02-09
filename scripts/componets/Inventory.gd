class_name Inventory extends Node

@export var soul_pieces  = 0

func drop_soul_pieces():
	for i in soul_pieces:
		var spawn_pos = owner.global_position + Vector2(randf_range(-10, 10), randf_range(-10, 10))
		SpawnItemCommand.new(get_tree(), 'soul_piece', spawn_pos).execute()
