extends Node

var current_scene : Node = null


@onready var game_start: Control = $GameStart



func _ready() -> void:
	current_scene = game_start
	EventBus.scene_transition.connect(_on_transition_scene)

func _on_transition_scene(scene):
	print(scene)
	current_scene.queue_free()
#	fade function goes here
	var new_scene = scene.instantiate()
	add_child(new_scene)
