extends Control

var dict: Dictionary = {
	"coal": 15,
	"iron_ore": 7,
	"iron_bar": 3
}



func _on_button_pressed() -> void:
	print(dict["coal"])
	
	#_update_dictionary(coal, 10)

#func _update_dictionary(resource_item, value):
	#dict[resource_item.name] = value

##WATCH A VIDEO ON RESOURCES IN DICTIONARIES
