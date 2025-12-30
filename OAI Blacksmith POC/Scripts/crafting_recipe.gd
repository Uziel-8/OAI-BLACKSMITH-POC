extends Node

class_name Recipe
#
#const COIN = preload("res://Resources/coin.tres")
#const COAL = preload("res://Resources/coal.tres")
#const IRON_ORE = preload("res://Resources/iron_ore.tres")
#const IRON_BAR = preload("res://Resources/iron_bar.tres")
#const IRON_SHORTBLADE = preload("res://Resources/iron_shortblade.tres")

var recipes : Dictionary = {
	"iron bar" = {
		NAME = "Iron Bar",
		INGREDIENTS = {Globals.IRON_ORE : 1, Globals.COAL : 1},
		OUTPUT = {Globals.IRON_BAR : 1}
		},
	"iron shortblade" = {
		NAME = "Iron Shortblade",
		INGREDIENTS = {Globals.IRON_BAR : 2, Globals.COAL : 1},
		OUTPUT = {Globals.IRON_SHORTBLADE : 1}
	},
	"wooden hilt" = {
		NAME = "Wooden Hilt",
		INGREDIENTS = {Globals.WOOD : 3, Globals.IRON_BAR : 1},
		OUTPUT = {Globals.WOODEN_HILT : 1}
	},
	}

func _ready() -> void:
	EventBus.inventory_changed.connect(_on_inventory_changed)

func _on_inventory_changed():
	pass


func craft(key_name):
	var recipe: Dictionary = recipes[key_name]
	
	if recipe != null:
		var ingredients: Dictionary = recipe["INGREDIENTS"]
		var outputs: Dictionary = recipe["OUTPUT"]
		
		if Globals.inventory.has_all(ingredients.keys()):
			var obtained_ingredients: int = 0
			for item in ingredients:
				if Globals.inventory[item] >= ingredients[item]:
					obtained_ingredients += 1
			
			if obtained_ingredients == ingredients.size():
				for item in ingredients:
					Globals.update_item(item, -ingredients[item])
				for output in outputs:
					Globals.update_item(output, outputs[output])
		else:
			print("can't craft - missing ingredients")
