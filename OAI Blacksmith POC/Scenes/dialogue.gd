extends Control

signal dialogue_complete

@onready var label = $Panel/VBoxContainer/Label
@export var label_data : DialogueData


func _ready() -> void:
	label.text = str(label_data.dialogue_steps.front())

func _on_button_pressed() -> void:
	if label_data.step_index >= label_data.dialogue_steps.size():
		dialogue_complete.emit()
		print("dialogue complete")
		return
	else:
		label.text = label_data.dialogue_steps[label_data.step_index]
		label_data.step_index += 1
