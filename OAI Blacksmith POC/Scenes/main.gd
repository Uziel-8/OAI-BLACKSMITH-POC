extends Node

var current_scene : Node = null

@onready var fade_box: ColorRect = $Fade
@onready var game_start: Control = $GameStart



func _ready() -> void:
	current_scene = game_start
	EventBus.scene_transition.connect(_on_transition_scene)

func _on_transition_scene(scene):
	await fade(1.0, 1.5).finished
	current_scene.queue_free()
	var new_scene = scene.instantiate()
	add_child(new_scene)
	fade(0.0, 1.5)


func fade(target_alpha: float, duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(fade_box, "color:a", target_alpha, duration)
	return tween
