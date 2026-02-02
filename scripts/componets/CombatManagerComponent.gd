class_name CombatManager extends Node2D

# TODO  ДОБАВИТЬ - Автонаводку на врагов по направлению взгляда для атак
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

func use_ability(ability_key):
	if disabled: return
	var ability = self[ability_key]
	if ability:
		ability.use()

func get_base_attack():
	return _base_attack

func get_ability_3():
	return _ability_3
	
func _on_active_changed(_value):
	_update_is_ability_fulfilled()
	
func _update_is_ability_fulfilled():
	var array = _abilities.filter(
		func(ability: Ability):
			if ability == null: return
			if ability.is_active():
				return ability
			return null
	)
	_is_ability_fulfilled = len(array) > 0

func is_ability_fulfilled() -> bool:
	return _is_ability_fulfilled
