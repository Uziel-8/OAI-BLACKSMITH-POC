extends Node

##ITEM LIST
const COIN = preload("res://Resources/coin.tres")
const COAL = preload("res://Resources/coal.tres")
const IRON_ORE = preload("res://Resources/iron_ore.tres")
const WOOD = preload("res://Resources/wood.tres")
const IRON_BAR = preload("res://Resources/iron_bar.tres")
const IRON_SHORTBLADE = preload("res://Resources/iron_shortblade.tres")
const WOODEN_HILT = preload("res://Resources/wooden_hilt.tres")
##

var energy = 10:
	set(value):
		energy = value
		EventBus.energy_changed.emit(value)


var max_energy := 10

var day = 1

var rent = -10

var xp = 0:
	set(value):
		xp = value
		EventBus.xp_changed.emit(value)


var level = 0

var xp_threshold = 100

var inventory: Dictionary = {}

func update_item(item, amount):
	if inventory.has(item):
		inventory[item] += amount #update amount of existing item
	else:
		inventory[item] = amount #add new item to inventory
	
	if inventory[item] <= 0:
		inventory.erase(item) #remove item when there is 0
	EventBus.inventory_changed.emit()
	_print_item()

func _print_item():
	for item: InventoryItem in inventory:
		print(item.name, inventory[item])
