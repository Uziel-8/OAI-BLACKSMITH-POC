class_name CraftButton

extends Button

@export var recipe : CraftData

func _ready() -> void:
	self.text = str(recipe.name)

func _on_pressed() -> void:
	CraftingRecipe.craft(recipe)
