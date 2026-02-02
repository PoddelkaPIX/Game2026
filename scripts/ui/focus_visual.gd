extends Marker2D

@export var focus_target: FocusTarget

@onready var target_sprite: CompressedTexture2D = load("res://scripts/componets/component_icon.png")
@onready var sprite = Sprite2D.new()

func _ready() -> void:
	visible = false
	focus_target.state_changed.connect(_on_state_changed)
	_create_target_sprite()

func _exit_tree() -> void:
	focus_target.state_changed.disconnect(_on_state_changed)
	
func _physics_process(_delta: float) -> void:
	self.rotation = focus_target.get_direction().angle()
	var target = focus_target.get_target()
	if target:
		sprite.global_position = target.global_position
		
func _on_state_changed(state):
	if state == focus_target.State.NO_TARGETING:
		visible = false
		sprite.visible = false
	elif state == focus_target.State.TARGETING:
		await get_tree().create_timer(0.1).timeout
		visible = true
		sprite.visible = true

func _create_target_sprite():
	var node = Node.new()
	sprite.texture = target_sprite
	sprite.scale = Vector2(0.25, 0.25)
	sprite.visible = false
	node.add_child(sprite)
	self.add_child(node)
	
