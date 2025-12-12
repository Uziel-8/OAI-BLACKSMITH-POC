extends HBoxContainer

@onready var coal_label = $CoalQtyLabel
@onready var iron_ore_label = $IronOreQtyLabel
@onready var coin_label = $CoinQtyLabel

func _ready() -> void:
	EventBus.coin_changed.connect(_on_coin_changed)
	EventBus.inventory_changed.connect(_on_inventory_changed)


func _on_coin_changed():
	coin_label.text = str(Globals.coins)

func _on_inventory_changed():
	#for item in Globals.inventory:
	coal_label.text = str("Coal: ", Globals.inventory.get("coal"))
	iron_ore_label.text = str("Iron Ore: ", Globals.inventory.get("iron_ore"))
	print(Globals.inventory)
