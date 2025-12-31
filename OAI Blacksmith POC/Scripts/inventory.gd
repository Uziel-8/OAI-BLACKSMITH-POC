#extends Node
#
##var coins := 0
#
#var items: Array[InventoryItem]
#
#const COAL : InventoryItem = preload("res://Resources/coal.tres") 
#const IRON_ORE : InventoryItem = preload("res://Resources/iron_ore.tres")
#func _ready() -> void:
	#pass
#
#func add_item(item: InventoryItem):
	#for existing_item in items:
		#if existing_item.item_name == item.item_name:
			#existing_item.stack_size += item.stack_size
			#print("stacked item:", item.item_name , "new count:", existing_item.stack_size)
			#return
	#
	###if no match found, add a duplicate to avoid shared stack_size
	#items.append(item.duplicate())
	#print("added new item:", item.item_name)
#
#func remove_item(item: InventoryItem):
	#for existing_item in items:
		#if existing_item.item_name == item.item_name:
			#var amount_to_remove = min(existing_item.stack_size, item.stack_size)
			#
			#existing_item.stack_size -= amount_to_remove
			#
			#print("removed ", amount_to_remove, "x ", item.item_name, ": new count:", existing_item.stack_size)
			#
			#if existing_item.stack_size <= 0:
				#items.erase(existing_item)
				#print("removed ", item.item_name, " from inventory")
			#return
	#
	#print("item not found: ", item.item_name)
