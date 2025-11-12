extends HBoxContainer

@onready var coal = preload("res://Resources/coal.tres")
@onready var iron_ore = preload("res://Resources/iron_ore.tres")

@onready var coal_label = $CoalQtyLabel
@onready var iron_ore_label = $IronOreQtyLabel
@onready var coin_label = $CoinQtyLabel

func _ready() -> void:
	EventBus.coin_changed.connect(_on_coin_changed)

func _process(_delta: float) -> void:
	for item in Inventory.items:
		if item.item_name == "coal":
			coal_label.text = str("Coal: ", item.stack_size)
		elif item.item_name == "iron_ore":
			iron_ore_label.text = str("Iron Ore: ", item.stack_size)

func _on_coin_changed():
	coin_label.text = str(Globals.coins)
