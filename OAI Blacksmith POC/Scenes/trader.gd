extends Control

const LEVEL_SCENE : PackedScene = preload("res://Scenes/level.tscn")
const SMITHY_SCENE : PackedScene = preload("res://Scenes/smithy.tscn")

var coal_buy := 2
var coal_sell := 1

var iron_ore_buy := 4
var iron_ore_sell := 2
# coal_buy is the player buying coal from the trader, coal_sell is the player selling coal
@onready var coal_buy_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer/CoalBuy
@onready var coal_sell_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer/CoalSell

@onready var iron_ore_buy_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer2/IronOreBuy
@onready var iron_ore_sell_button = $Panel/VSplitContainer/VBoxContainer/HSplitContainer2/IronOreSell

func _ready() -> void:
	iron_ore_buy_button.text = str("Buy Iron Ore: $", iron_ore_buy)
	iron_ore_sell_button.text = str("Sell Iron Ore: $", iron_ore_sell)
	EventBus.day_changed.connect(_on_day_changed)
	EventBus.inventory_changed.connect(_on_inventory_changed)


func _on_day_changed():
	pass

func _on_inventory_changed():
	if Globals.inventory.has(Globals.COIN):
		if Globals.inventory[Globals.COIN] >= int(coal_buy):
			coal_buy_button.disabled = false
		if Globals.inventory[Globals.COIN] >= int(iron_ore_buy):
			iron_ore_buy_button.disabled = false

func _on_coal_buy_pressed() -> void:
	if Globals.inventory.has(Globals.COIN) and Globals.inventory[Globals.COIN] >= coal_buy:
		Globals.update_item(Globals.COIN, -(coal_buy))
		Globals.update_item(Globals.COAL, 1)
	else:
		return
	pass

func _on_iron_ore_buy_pressed() -> void:
	if Globals.inventory.has(Globals.COIN) and Globals.inventory[Globals.COIN] >= iron_ore_buy:
		Globals.update_item(Globals.COIN, -(iron_ore_buy))
		Globals.update_item(Globals.IRON_ORE, 1)
	else:
		return

func _on_coal_sell_pressed() -> void:
	if Globals.inventory.has(Globals.COAL):
		Globals.update_item(Globals.COIN, (coal_sell))
		Globals.update_item(Globals.COAL, -1)


func _on_iron_ore_sell_pressed():
	if Globals.inventory.has(Globals.IRON_ORE):
		Globals.update_item(Globals.COIN, (iron_ore_sell))
		Globals.update_item(Globals.IRON_ORE, -1)


func _on_level_transition_pressed() -> void:
	#if scene == null:
		#push_error("Scene transition called with null PackedScene")
		#return
	#
	EventBus.scene_transition.emit(LEVEL_SCENE)


func _on_smithy_transition_pressed() -> void:
	EventBus.scene_transition.emit(SMITHY_SCENE)
