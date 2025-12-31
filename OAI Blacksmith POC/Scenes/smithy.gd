extends Control

@onready var craft_button = preload("res://Scenes/craft_button.tscn")

@onready var smith_container = $Panel/SmithButtonContainer

@export var button_data : CraftData
@export var all_recipes: Array[CraftData] = []

var recipe_buttons : Dictionary = {}

func _ready() -> void:
	EventBus.inventory_changed.connect(_on_inventory_changed)


func _on_inventory_changed():
	for recipe in all_recipes:
		var can_craft = CraftingRecipe.can_craft
		if can_craft and not recipe_buttons.has(recipe):
			print("can craft: ", recipe.name)
			add_button(recipe)
		elif not can_craft and recipe_buttons.has(recipe):
			remove_button(recipe)

func add_button(recipe):
	var button = craft_button.instantiate()
	button.recipe = recipe
	smith_container.add_child(button)
	recipe_buttons[recipe] = button

func remove_button(recipe):
	recipe_buttons[recipe].queue_free()
	recipe_buttons.erase(recipe)
#
#func _on_craft_iron_bar_button_pressed() -> void:
	#CraftingRecipe.craft("iron bar")
#
#
#func _on_craft_iron_shortblade_button_pressed() -> void:
	#CraftingRecipe.craft("iron shortblade")
#
#
#func _on_button_pressed() -> void:
	##Globals.update_item("coin", 5)
	#print(Globals.inventory)
