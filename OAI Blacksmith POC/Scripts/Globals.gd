extends Node

@export var test_image = preload("res://icon.svg")

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

func update_item(item):
	if inventory.has(item):
		inventory[item].amount += amount #update amount of existing item
	else:
		var inventory_item = InventoryItem.new()
		inventory_item.item_name = item
		inventory_item.amount = amount
		inventory_item.texture = test_image
		
		inventory[item] = inventory_item #add new item to inventory
	
	if inventory[item].amount <= 0:
		inventory.erase(item) #remove item when there is 0
	EventBus.inventory_changed.emit()
	print(inventory[item].item_name, " ",  inventory[item].amount)
	print("full dictionary ", inventory)
