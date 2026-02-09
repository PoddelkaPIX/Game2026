class_name Item extends CharacterBody2D

@onready var texture_rect: TextureRect = $TextureRect
@onready var area_2d: Area2D = $Area2D

var _target: Character

var texture_name: String

# HACK Перенести это в отдельный список предметов
@onready var item_textures: Dictionary[String, CompressedTexture2D] = {
	'soul_piece': load('res://addons/anthonyec.camera_preview/Pin.svg')
}

func _ready() -> void:
	var size = Vector2(5, 5)
	
	texture_rect.size = size
	texture_rect.texture = item_textures[texture_name]
	
	area_2d.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if _target == null: return
	var dist = self.global_position.distance_to(_target.global_position)
	velocity = self.global_position.direction_to(_target.global_position) * delta * (12000 - dist * 100)
	move_and_slide()
	
	if dist < 5:
		GiveItemCommand.new(_target, texture_name).execute()
		queue_free()
	
func _on_body_entered(body):
	if body.name == 'Player':
		_target = body
