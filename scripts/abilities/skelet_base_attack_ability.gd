extends Ability

# HACK ИЗМЕНИТЬ - Надо распутать это спагетти

@export var impulse_power: float = 200
@export_category("Components")
@export var look: Look
@export var focus_target: FocusTarget

@onready var hit_box: HitBox = $HitBox

var damage = 1

func _on_state_entered(_state):
	var look_dir = look.direction()
	if _state == State.PREPARATION:
		AddStatusEffectCommand.new(owner, RootStatusEffect.new(ability_res.preparation_time)).execute()
		visible = true
		var target = focus_target.target()
		if target:
			var focus_target_dir = focus_target.direction()
			look.set_target_direction(focus_target_dir)
			if global_position.distance_to(target.global_position) > 50:
				AddImpulseCommand.new(owner, focus_target_dir, impulse_power).execute()
			rotation = focus_target_dir.angle()
		else:
			rotation = look_dir.angle()
	elif _state == State.EXECUTION:
		AddImpulseCommand.new(owner, look_dir, impulse_power).execute()
		hit_box.start_temporary_monitoring(ability_res.execution_time)

func _on_state_exited(_state):
	if _state == State.EXECUTION:
		_reset()

func _reset():
	self.visible = false
	self.visible = false

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is HeartBox:
		var attacked = area.owner
		var attacker = owner
		if attacker is not Character or attacked is not Character: return
		if attacker.fraction == attacked.fraction: return
		
		DealDamageCommand.new(attacker,  attacked, damage).execute()
		AddImpulseCommand.new(attacked, focus_target.direction(), impulse_power).execute()
		AddStatusEffectCommand.new(attacked, StunLockStatusEffect.new(0.05)).execute()
