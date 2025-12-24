extends Control

var inventory = Globals.inventory
@onready var list = $Panel/ItemList



func _ready() -> void:
	EventBus.inventory_changed.connect(_on_inventory_changed)

var item_sprite: Dictionary = {}

func _on_inventory_changed():
	for item in inventory:
		
		var inv_item = item + " : " + str(inventory[item].amount)
		list.add_item(inv_item, inventory[item].texture)

func _process(_delta: float) -> void:
	pass

#set_item_icon
