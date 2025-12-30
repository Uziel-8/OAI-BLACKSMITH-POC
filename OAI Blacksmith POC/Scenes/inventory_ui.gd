extends Control

var inventory = Globals.inventory
@onready var list = $Panel/ItemList

func _ready() -> void:
	EventBus.inventory_changed.connect(_on_inventory_changed)


var item_sprite: Dictionary = {}

func _on_inventory_changed():
	for item: InventoryItem in inventory.keys():
		list.add_item(str(item.name), item.texture, true)
