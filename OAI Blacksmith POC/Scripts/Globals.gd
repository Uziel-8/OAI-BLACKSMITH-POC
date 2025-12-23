extends Node

var energy = 5:
	set(value):
		energy = value
		EventBus.energy_changed.emit(value)



var max_energy := 5

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
