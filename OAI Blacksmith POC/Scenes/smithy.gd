extends Control

@onready var craft_button = preload("res://Scenes/craft_button.tscn")
const LEVEL_SCENE : PackedScene = preload("res://Scenes/level.tscn")
const TRADER_SCENE : PackedScene = preload("res://Scenes/trader.tscn")

@onready var smith_container = $Panel/SmithButtonContainer

@export var button_data : CraftData
@export var all_recipes: Array[CraftData] = [] ##these recipes need to be loaded in to the inspector

var recipe_buttons : Dictionary = {}
var can_craft : bool = false
func _ready() -> void:
	EventBus.inventory_changed.connect(_on_inventory_changed)

func _on_inventory_changed():
	for recipe in all_recipes:
		var ingredients: Dictionary = recipe.input
		if Globals.inventory.has_all(ingredients.keys()):
			var ingredients_requirements_met: int = 0
			for item in ingredients:
				print("top of for item in ingredients: ", recipe.name, " ", item.name, " ", ingredients[item])
				if Globals.inventory[item] >= ingredients[item]:
					print("fuck: " , item.name, " ", Globals.inventory[item], " ", recipe.name, " ", ingredients[item])
					ingredients_requirements_met += 1
			
			print("new print : ", ingredients_requirements_met, " ", ingredients.size())
			
			if ingredients_requirements_met == ingredients.size():
				print("yes", recipe.name)
				can_craft = true
			else:
				print("not enough ingredients to craft: ", recipe.name)
				can_craft = false
		else:
			print("no :", recipe.name)
			can_craft = false
		
	
	
		if can_craft and not recipe_buttons.has(recipe):
			print("can craft: ", recipe.name)
			if Globals.inventory.has(Globals.IRON_BAR):
				print("number of BARS: ", Globals.inventory[Globals.IRON_BAR])
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


func _on_level_transition_pressed() -> void:
	EventBus.scene_transition.emit(LEVEL_SCENE)


func _on_trader_transition_pressed() -> void:
	EventBus.scene_transition.emit(TRADER_SCENE)
