extends Node

class_name Recipe

#var can_craft : bool = false

#func can_craft(recipe: CraftData, inventory: Dictionary) -> bool:
	#if recipe != null:
		#for item in recipe.input:
			#if Globals.inventory.value <= recipe.input[item]:
				#return false
			#if Globals.inventory.value >= recipe.input[item]:
					#return true
	#return true

func craft(recipe):
	if recipe != null:
		var ingredients: Dictionary = recipe.input
		var outputs: Dictionary = recipe.output
		print(recipe.name, recipe.input, recipe.output)
		if Globals.inventory.has_all(ingredients.keys()):
			var obtained_ingredients: int = 0
			for item in ingredients:
				if Globals.inventory[item] >= ingredients[item]:
					obtained_ingredients += 1
			
			if obtained_ingredients == ingredients.size():
				for item in ingredients:
					Globals.update_item(item, -ingredients[item])
				for item in outputs:
					Globals.update_item(item, outputs[item])
		else:
			print("can't craft - missing ingredients")

func can_craft(recipe):
	if recipe != null:
		var ingredients: Dictionary = recipe.input
		var outputs: Dictionary = recipe.output
		print(recipe.name, recipe.input, recipe.output)
		if Globals.inventory.has_all(ingredients.keys()):
			var obtained_ingredients: int = 0
			for item in ingredients:
				if Globals.inventory[item] >= ingredients[item]:
					obtained_ingredients += 1
			
			if obtained_ingredients == ingredients.size():
				print("yes")
				return true
		else:
			print("no")
			return false
			print("can't craft - missing ingredients")



#func craft(key_name):
	#var recipe: Dictionary = recipes[key_name]
	#
	#if recipe != null:
		#var ingredients: Dictionary = recipe["INGREDIENTS"]
		#var outputs: Dictionary = recipe["OUTPUT"]
		#
		#if Globals.inventory.has_all(ingredients.keys()):
			#var obtained_ingredients: int = 0
			#for item in ingredients:
				#if Globals.inventory[item] >= ingredients[item]:
					#obtained_ingredients += 1
			#
			#if obtained_ingredients == ingredients.size():
				#for item in ingredients:
					#Globals.update_item(item, -ingredients[item])
				#for output in outputs:
					#Globals.update_item(output, outputs[output])
		#else:
			#print("can't craft - missing ingredients")
