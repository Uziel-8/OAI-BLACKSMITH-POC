extends Control

@onready var dialogue = $Dialogue
@onready var level_scene = preload("res://Scenes/level.tscn")

func _on_dialogue_dialogue_complete() -> void:
	EventBus.scene_transition.emit(level_scene)
