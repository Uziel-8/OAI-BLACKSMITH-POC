extends Control



@onready var energy_label = $GameStateLabel/EnergyLabel
@onready var day_label = $GameStateLabel/DayLabel
@onready var rent_label = $GameStateLabel/RentLabel
@onready var end_day_button = $EndDay
@onready var xp_bar = $ExpBar
@onready var inv_ui = $InventoryUI

@onready var inventory_label = $InventoryPanel/InventoryLabel

func _ready() -> void:
	EventBus.mined.connect(_on_ore_mined)
	EventBus.xp_changed.connect(_on_xp_changed)
	EventBus.inventory_changed.connect(_on_inventory_changed)
	EventBus.energy_changed.connect(_on_energy_changed)
	energy_label.text = str("Energy: ", Globals.energy)
	day_label.text = str("Day ", Globals.day)
	rent_label.text = str("Weekly Bill: ", Globals.rent)

func _on_ore_mined():
	#put a function here that makes different ores different energy to mine?
	#or make higher tier ores require equipment to mine
	#something to make it not always optimal to mine most valuable ore
	Globals.energy -= 1
	Globals.xp += 50


func _on_end_day_pressed() -> void:
	Globals.day += 1
	Globals.energy = Globals.max_energy
	day_label.text = str("Day ", Globals.day)
	EventBus.day_changed.emit()
	if Globals.day % 7 == 0:
		_pay_rent()

func _pay_rent():
	#Globals.update_item("coin", int(Globals.rent))
	print(Globals.inventory) 

func _on_xp_changed(total: int):
	xp_bar.value = Globals.xp
	if Globals.xp >= Globals.xp_threshold:
		var remainder_xp: int = total - Globals.xp_threshold
		EventBus.level_up.emit()
		Globals.xp_threshold = Globals.xp_threshold * 1.1
		xp_bar.max_value = Globals.xp_threshold
		Globals.level = Globals.level + 1
		Globals.xp = remainder_xp

func _on_energy_changed(_value):
	energy_label.text = str("Energy: ", Globals.energy)


func _on_inventory_changed():
	var statement: String
	var inventory = Globals.inventory
	
	for item in inventory:
		statement = statement + item.name + " : " + str(inventory[item]) + "\n"
	inventory_label.text = statement

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Tab"):
		_toggle_inventory()

func _toggle_inventory():
	if Input.is_action_just_pressed("Tab"):
		if inv_ui.is_visible():
			inv_ui.set_visible(false)
		else:
			inv_ui.set_visible(true)


#TO DO
#make sprites for inv. items - less text everywhere.
##LEVELVBOX may be unneccessary here?

#trader could have multiple different traders - rename to marketplace or something?
#might need customers in there too
#create auto mine function
