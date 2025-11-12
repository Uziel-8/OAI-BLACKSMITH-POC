extends Control

@onready var energy_label = $GameStateLabel/EnergyLabel
@onready var day_label = $GameStateLabel/DayLabel
@onready var rent_label = $GameStateLabel/RentLabel
@onready var coin_label = $LevelVBox/InventoryHbox/CoinQtyLabel
@onready var end_day_button = $EndDay
@onready var exp_bar = $ExpBar


func _process(_delta: float) -> void:
	exp_bar.max_value = Globals.exp_threshold
	exp_bar.value = Globals.exp
	#if Globals.day / 7 == int:
		#Globals.coins -= Globals.rent


func _ready() -> void:
	EventBus.mined.connect(_on_ore_mined)
	energy_label.text = str("Energy: ", Globals.energy)
	day_label.text = str("Day ", Globals.day)
	rent_label.text = str("Weekly Bill: ", Globals.rent)

func _on_ore_mined():
	#put a function here that makes different ores different energy to mine?
	#or make higher tier ores require equipment to mine
	#something to make it not always optimal to mine most valuable ore
	Globals.energy -= 1
	Globals.exp += 10
	energy_label.text = str("Energy: ", Globals.energy)

func _on_end_day_pressed() -> void:
	Globals.day += 1
	Globals.energy = Globals.max_energy
	energy_label.text = str("Energy: ", Globals.energy)
	day_label.text = str("Day ", Globals.day)
	EventBus.day_changed.emit()

func _on_coin_added():
	coin_label.text = str("Coins: ", Globals.coins)
	print("chaching")

func level_up():
	pass
	#make this


#TO DO
#need a more modular/portable way to create buttons and menus
#above notes
#create smithy node - left pane can be mine, middle trader, right smithy
#this could be broken in to bars and items
#trader could have multiple different traders - rename to marketplace or something?
#might need customers in there too
#create auto mine function
#make a more modular buy and sell function in trader - prbably events
