class_name Character extends CharacterBody2D

signal died
signal hited

enum Fraction {NEUTRAL, TEAM_1, TEAM_2}

@export var fraction: Fraction = Fraction.NEUTRAL

@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visualization: Node2D = $Visualization
@onready var heart_box: HeartBox = $HeartBox
@onready var health: HealthComponent = $HealthComponent
@onready var look: Look = $Look
@onready var repulsion: Repulsion = $Repulsion
@onready var inventory: Inventory = $Inventory
@onready var focus_target: FocusTarget = $FocusTarget
@onready var movement: Movement = $Movement
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var status_effects_manager: StatusEffectManager = $StatusEffectsManager
@onready var combat_manager: CombatManager = $CombatManager

var _is_died = false
var _friction_power: float = 15

func _ready() -> void:
	health.death_requested.connect(_on_death_requested)

func _physics_process(delta: float) -> void:
	_friction(delta)
	move_and_slide()

func _on_death_requested():
	died.emit()
	_is_died = true
	self.set_physics_process(false)
	self.set_process(false)
	disable_components.call_deferred()
	
func disable_components():
	heart_box.monitorable = false
	heart_box.monitoring = false
	visualization.visible = false
	movement.disabled = true
	repulsion.is_active = false
	collision_shape_2d.disabled = true
	focus_target.cancel_focus()
	combat_manager.disabled = true

func is_died():
	return _is_died

func hit(damage):
	var hp = health.get_value()
	health.set_value(hp - damage)
	hited.emit()

func _friction(delta):
	velocity = velocity.lerp(Vector2.ZERO, _friction_power * delta)
