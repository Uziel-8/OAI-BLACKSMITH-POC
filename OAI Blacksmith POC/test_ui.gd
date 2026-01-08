extends Control
@onready var button: Button = $Panel/Button

var dict: Dictionary = {
	"coal": 15,
	"iron_ore": 7,
	"iron_bar": 3
}

func _on_button_pressed():
	print("fuck")
