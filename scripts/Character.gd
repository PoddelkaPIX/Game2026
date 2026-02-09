class_name Character extends CharacterBody2D

enum Fraction {NEUTRAL, TEAM_1, TEAM_2}

@export var fraction: Fraction = Fraction.NEUTRAL

@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visualization: Node2D = $Visualization
@onready var heart_box: HeartBox = $HeartBox
@onready var health: Health = $Health
@onready var look: Look = $Look
@onready var repulsion: Repulsion = $Repulsion
@onready var inventory: Inventory = $Inventory
@onready var focus_target: FocusTarget = $FocusTarget
@onready var movement: Movement = $Movement
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var status_effect_manager: StatusEffectManager = $StatusEffectManager
@onready var combat_manager: CombatManager = $CombatManager
@onready var concentration: Concentration = $Concentration

var _friction_power: float = 15

func _physics_process(delta: float) -> void:
	_friction(delta)
	move_and_slide()

func _friction(delta):
	velocity = velocity.lerp(Vector2.ZERO, _friction_power * delta)
