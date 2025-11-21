extends Node

var energy := 5
var max_energy := 5

var day = 1

var coins = 0:
	set(value):
		if coins != value:
			coins = value
			EventBus.coin_changed.emit()

var rent = 0

var xp = 0:
	set(value):
		xp = value
		EventBus.xp_changed.emit(value)


var level = 0

var xp_threshold = 100
