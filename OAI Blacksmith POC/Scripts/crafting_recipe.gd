extends Node

class_name Recipe

var recipes : Dictionary = {
	"iron bar" = {
		NAME = "Iron Bar",
		INGREDIENTS = {"iron_ore" = 1, "coal" = 1},
		OUTPUT = {"iron_bar" = 1}
		},
	"iron shortblade" = {
		NAME = "Iron Shortblade",
		INGREDIENTS = {"iron_bar" = 2, "coal" = 1},
		OUTPUT = {"iron_shortblade" = 1}
	},
	}

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
	
	
