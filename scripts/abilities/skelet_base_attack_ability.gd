extends Node2D extends Ability

# TODO  ДОБАВИТЬ - 3-ю комбо атаку

@export var impulse_power: float = 200
@export_category("Components")
@export var look: Look
@export var focus_target: FocusTarget
@export var movement: Movement

@onready var hit_box: HitBox = $HitBox
@onready var color_rect: ColorRect = $ColorRect

# HACK ИЗМЕНИТЬ - Урон не меняется в зависимости от урона игрока
var damage = 1

var combo_attacks: Array[AbilityRes]

var _hited_hitboxes: Array[Area2D] = []

func _ready() -> void:
	self.visible = false

func use():
	if _current_state == State.RECOVERY:
		next_combo()
	super.use()

func next_combo():
	combo += 1
	if combo <= max_combo:
		set_state(State.PREPARATION)
	else: 
		reset_combo()
	
func reset_combo():
	combo = 1
	set_state(State.COOLDOWN)

func _exit_tree() -> void:
	super._exit_tree()

func _on_state_preparation_entered():
	movement.disabled = true
	movement.stop_movement()
	if combo == 1: _combo_1_preparation_entered()
	elif combo == 2: _combo_2_preparation_entered()
	elif combo == 3: _combo_3_preparation_entered()

func _on_execution_entered():
	movement.add_impulse(look.get_direction(), impulse_power)
	hit_box.start_temporary_monitoring(ability_res.execution_time)

func _on_execution_exited():
	_hited_hitboxes.clear()
	self.visible = false
	
func _on_state_cooldown_entered():
	reset_combo()
	movement.disabled = false

func _on_hit_box_area_entered(_area: Area2D) -> void:
	if _area is not HeartBox: return
	if _hited_hitboxes.find(_area) != -1: return
	if len(_hited_hitboxes) == 0:
		movement.add_impulse(look.get_direction() * -1, impulse_power / 2)
	_hited_hitboxes.append(_area)
	AddStatusEffectCommand.new().execute({
		'character': _area.owner,
		'status_effect': StunLockStatusEffect.new()
	})
	match combo:
		1:
			DealDamageCommand.new().execute({
				'attacker': owner,
				'attacked': _area.owner,
				'damage': damage
			})
		2:
			DealDamageCommand.new().execute({
				'attacker': owner,
				'attacked': _area.owner,
				'damage': damage
			})
		3:
			DealDamageCommand.new().execute({
				'attacker': owner,
				'attacked': _area.owner,
				'damage': damage * 2
			})
			var dir = global_position.direction_to(_area.owner.global_position)
			
			AddImpulseCommand.new().execute({
				'character': _area.owner,
				'direction': dir,
				'power': impulse_power * 1.5
			})

#region Combo 1
func _combo_1_preparation_entered():
	var target = focus_target.get_target()
	if target:
		look.set_target_direction(focus_target.get_direction())
		if global_position.distance_to(target.global_position) > 50:
			movement.add_impulse(focus_target.get_direction(), impulse_power)
		rotation = focus_target.get_direction().angle()
	else:
		rotation = look.get_direction().angle()
#endregion
