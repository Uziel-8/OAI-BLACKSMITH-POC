extends GridContainer

@onready var mine_coal = $MineCoal
@onready var coal_timer = $MineCoal/MineCoalTimer
@onready var coal_bar = $MineCoal/MineCoalBar
@onready var mine_iron = $MineIronOre
@onready var iron_ore_timer = $MineIronOre/MineIronOreTimer
@onready var iron_ore_bar = $MineIronOre/MineIronOreBar

func _process(_delta: float) -> void:
	if coal_timer.is_stopped():
		coal_bar.value = 0
	else:
		var remaining_time = coal_timer.time_left
		var total_time = coal_timer.wait_time
		coal_bar.value = remaining_time / total_time * coal_bar.max_value
		
	if iron_ore_timer.is_stopped():
		iron_ore_bar.value = 0
	else:
		var remaining_time = iron_ore_timer.time_left
		var total_time = iron_ore_timer.wait_time
		iron_ore_bar.value = remaining_time / total_time * iron_ore_bar.max_value

func _on_mine_coal_timer_timeout() -> void:
	mine_coal.disabled = false
	coal_timer.stop()


func _on_mine_coal_pressed() -> void:
	if Globals.energy > 0:
		mine_coal.disabled = true
		Globals.update_item("coal", 1)
		coal_timer.start()
		EventBus.mined.emit()
	else:
		print("Out of energy!")
		return


func _on_mine_iron_ore_pressed() -> void:
	if Globals.energy > 0:
		mine_iron.disabled = true
		#Inventory.add_item(iron_ore)
		Globals.update_item("iron_ore", 1)
		#i want to find a way to change this from emitting manually like this, to emitting automatically when the dict is updated - like coins
		iron_ore_timer.start()
		EventBus.mined.emit()
	else:
		print("Out of energy!")
		return


func _on_mine_iron_ore_timer_timeout() -> void:
	mine_iron.disabled = false
	iron_ore_timer.stop()
