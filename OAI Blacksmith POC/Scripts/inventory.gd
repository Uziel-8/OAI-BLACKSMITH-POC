extends Node

#var coins := 0

var items: Array[Item]

const COAL : Item = preload("res://Resources/coal.tres") 
const IRON_ORE : Item = preload("res://Resources/iron_ore.tres")
func _ready() -> void:
	pass

func add_item(item: Item):
	for existing_item in items:
		if existing_item.item_name == item.item_name:
			existing_item.stack_size += item.stack_size
			print("stacked item:", item.item_name , "new count:", existing_item.stack_size)
			return
	
	##if no match found, add a duplicate to avoid shared stack_size
	items.append(item.duplicate())
	print("added new item:", item.item_name)

func remove_item(item: Item):
	for existing_item in items:
		if existing_item.item_name == item.item_name:
			existing_item.stack_size -= item.stack_size
			print("stacked item:", item.item_name , "new count:", existing_item.stack_size)
			return
	
	items.erase(item.duplicate())
	print("removed item:", item.item_name)
	#for this function, it seems to basically be identical to the add function.
	#use erase instead of append
