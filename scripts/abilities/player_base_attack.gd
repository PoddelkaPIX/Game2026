extends Ability

# HACK ИЗМЕНИТЬ - Надо распутать это спагетти

@export var impulse_power: float = 200
@export_category("Components")
@export var look: Look
@export var focus_target: FocusTarget

@onready var hit_box: HitBox = $HitBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var damage = 1
var ability_combo = AbilityCombo.new()

func use():
	if _current_state == State.RECOVERY:
		ability_combo.next_combo()
		if ability_combo.current_combo <= ability_combo.max_combo:
			set_state(State.PREPARATION)
		else: 
			_reset()
			set_state(State.COOLDOWN)
	super.use()

func _on_state_entered(_state):
	if _state == State.EXECUTION:
		hit_box.start_temporary_monitoring(ability_res.execution_time)
		rotation = look.direction().angle()
	elif _state == State.COOLDOWN:
		ability_combo.reset()
		_reset()
	elif _state == State.PREPARATION:
		self.visible = true
		AddStatusEffectCommand.new(owner, RootStatusEffect.new(ability_res.preparation_time)).execute()
		var target = focus_target.target()
		if target:
			look.set_target_direction(focus_target.direction())
			if global_position.distance_to(target.global_position) > 5:
				AddImpulseCommand.new(owner, look.direction(), impulse_power).execute()
		
func _on_state_exited(_state):
	if _state == State.EXECUTION:
		_reset()

func _reset():
	hit_box.reset()
	self.visible = false
	
func _on_hit_box_area_entered(_area: Area2D) -> void:
	var _hited_hitboxes = hit_box.hited_hitboxes()
	var _node = _area.owner
	var _damage = damage
	var _impulse_power = impulse_power
	
	if _area is not HeartBox: return
	if _hited_hitboxes.find(_area) != -1: return
	if owner == _node: return
	_hited_hitboxes.append(_area)
	
	if ability_combo.current_combo == 3:
		_damage *= 2
		_impulse_power *= 1.5
	
	AddStatusEffectCommand.new(_node, StunLockStatusEffect.new(0.3)).execute()
	AddImpulseCommand.new(_node, look.direction(), _impulse_power).execute()
	DealDamageCommand.new(owner, _node, _damage).execute()
	if len(_hited_hitboxes) == 0:
		AddImpulseCommand.new(owner, look.direction() * -1, impulse_power).execute()
