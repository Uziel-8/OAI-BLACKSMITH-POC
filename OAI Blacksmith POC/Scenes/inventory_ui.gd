extends Control

var inventory = Globals.inventory
@onready var list = $Panel/ItemList

func _ready() -> void:
	EventBus.inventory_changed.connect(_on_inventory_changed)



func _on_inventory_changed(item):
	list.add_item(item)
	print("kachow")

func _process(delta: float) -> void:
	pass
