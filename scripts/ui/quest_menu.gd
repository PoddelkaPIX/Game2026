extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer

var quests: Array[Node]
var quest_items = []
func _ready() -> void:
	quests = get_tree().get_nodes_in_group('Quest')
	_update_quest_list()
	
func _update_quest_list():
	for quest: Quest in quests:
		var label = Label.new()
		label.text = quest.name
		label.visible = !quest.disabled
		label.name = 'Label'+quest.name
		v_box_container.add_child(label)
		quest.activated.connect(func(): _on_quest_activated(label))
		
func _on_quest_activated(label):
	label.visible = true
