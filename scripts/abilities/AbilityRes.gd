class_name AbilityRes extends Resource
	
enum EInputMode { ONE_PRESS, HOLD_PRESS }

@export var name: String = ''
@export_multiline var description: String = ''
@export var icon: CompressedTexture2D

@export_category('Input')
@export var input_mode: EInputMode = EInputMode.ONE_PRESS

@export_group('Timings')
@export var cooldown_time: float = 0.1
@export var preparation_time: float = 0.3
@export var execution_time: float = 0.1
@export var recovery_time: float = 0.1
@export var cancel_time: float = 0.05
