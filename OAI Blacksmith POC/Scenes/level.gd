extends Control

@onready var energy_label = $GameStateLabel/EnergyLabel
@onready var day_label = $GameStateLabel/DayLabel
@onready var rent_label = $GameStateLabel/RentLabel
@onready var end_day_button = $EndDay
@onready var xp_bar = $ExpBar

@onready var inventory_label = $InventoryPanel/InventoryLabel


func _ready() -> void:
	EventBus.mined.connect(_on_ore_mined)
	EventBus.xp_changed.connect(_on_xp_changed)
	EventBus.inventory_changed.connect(_on_inventory_changed)
	energy_label.text = str("Energy: ", Globals.energy)
	day_label.text = str("Day ", Globals.day)
	rent_label.text = str("Weekly Bill: ", Globals.rent)

func _on_ore_mined():
	#put a function here that makes different ores different energy to mine?
	#or make higher tier ores require equipment to mine
	#something to make it not always optimal to mine most valuable ore
	Globals.energy -= 1
	Globals.xp += 50
	energy_label.text = str("Energy: ", Globals.energy)

func _on_end_day_pressed() -> void:
	Globals.day += 1
	Globals.energy = Globals.max_energy
	energy_label.text = str("Energy: ", Globals.energy)
	day_label.text = str("Day ", Globals.day)
	EventBus.day_changed.emit()
	if Globals.day % 7 == 0:
		_pay_rent()

func _pay_rent():
	Globals.update_item("coin", int(Globals.rent))
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

func _on_inventory_changed():
	inventory_label.text = str(Globals.inventory)


#TO DO
#currently energy reduction is inherently tied to mining, let's pull that out - will probably need a "energy changed" event
#replace InventoryHbox with the new inventory - partially done, just need to dynamically handle coins - probs just add to inventory TBH
#make sprites for inv. items - less text everywhere.


#trader could have multiple different traders - rename to marketplace or something?
#might need customers in there too
#create auto mine function
#make a more modular buy and sell function in trader - prbably events
#figure out if i need inventory to be resources? would streamline a lot if not. It could probably just be a dictionary
