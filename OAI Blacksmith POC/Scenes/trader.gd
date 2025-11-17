extends Control

var coal_buy := 2
var coal_sell := 1

var iron_ore_buy := 4
var iron_ore_sell := 2
# coal_buy is the player buying coal from the trader, coal_sell is the player selling coal

@onready var coal_buy_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer/CoalBuy
@onready var coal_sell_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer/CoalSell

@onready var iron_ore_buy_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer2/IronOreBuy
@onready var iron_ore_sell_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer2/IronOreSell

@onready var coal = preload("res://Resources/coal.tres")
@onready var iron_ore = preload("res://Resources/iron_ore.tres")

func _ready() -> void:
	EventBus.day_changed.connect(_on_day_changed)
	

func _process(_delta: float) -> void:
	if Globals.coins >= coal_buy:
		coal_buy_button.disabled = false
	if Globals.coins >= iron_ore_buy:
		iron_ore_buy_button.disabled = false

func _on_day_changed():
	if Globals.day > 2:
		self.visible = true

func _on_coal_buy_pressed() -> void:
	if Globals.coins >= coal_buy:
		Globals.coins -= coal_buy
		Inventory.add_item(coal)
	else:
		return

func _on_iron_ore_buy_pressed() -> void:
	if Globals.coins >= iron_ore_buy:
		Globals.coins -= iron_ore_buy
		Inventory.add_item(iron_ore)
	else:
		return

func _on_coal_sell_pressed() -> void:
	if Inventory.COAL.stack_size > 0:
		Globals.coins += coal_sell
		Inventory.remove_item(coal)
	else:
		return

func _on_iron_ore_sell_pressed():
	for IRON_ORE in Inventory.items:
		if iron_ore.stack_size > 0:
			Globals.coins += iron_ore_sell
			Inventory.remove_item(iron_ore)
		else:
			iron_ore_sell_button.disabled = true
