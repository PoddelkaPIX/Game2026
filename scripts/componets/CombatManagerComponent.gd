class_name CombatManager extends Node2D

@export var disabled = false
@export_category('Abilities')
@export var _base_attack: Ability
@export var _ability_1: Ability
@export var _ability_2: Ability
@export var _ability_3: Ability
@export var _ability_4: Ability

@export_category("Stats")
#@export var _energy_value = 0
#@export var _energy_max_value = 0
#@export var _mana_value = 0
#@export var _mana_max_value = 0
#@export var _damage_value = 1

@export_category("Components")
@export var status_effects_manager: StatusEffectManager 

@onready var _abilities: Array[Ability] = [
	_base_attack,
	_ability_1,
	_ability_2,
	_ability_3,
	_ability_4
]
var _is_ability_fulfilled = false

func _ready() -> void:
	for ability in _abilities:
		if ability is Ability:
			ability.active_changed.connect(_on_active_changed)

func _process(_delta: float) -> void:
	for status_effect in status_effects_manager.status_effects:
		if status_effect is StunLockStatusEffect \
		or status_effect is DeathStatusEffect:
			_abilities.map(func(ability: Ability): if ability: ability.cancel())

func use_ability(ability_key):
	if disabled: return
	var ability: Ability = self[ability_key]
	if ability:
		ability.use()

func base_attack():
	return _base_attack
	
func ability_1():
	return _ability_1
	
func ability_2():
	return _ability_2
	
func ability_3():
	return _ability_3
	
func ability_4():
	return _ability_4
	
func is_ability_fulfilled() -> bool:
	return _is_ability_fulfilled
	
func _on_active_changed(_value):
	_update_is_ability_fulfilled()
	
func _update_is_ability_fulfilled():
	if disabled: return
	var array = _abilities.filter(
		func(ability: Ability):
			if ability == null: return
			if ability.is_active():
				return ability
			return null
	)
	_is_ability_fulfilled = len(array) > 0
