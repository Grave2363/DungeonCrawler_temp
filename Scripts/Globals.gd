extends Node

#dungeons unlocked
var availableDungeons = 0
#weather the player has found the hiden market
var hiddenMarket = 0
#cp unlocked
var cps_available = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getHM():
	return hiddenMarket
func setHM(int):
	hiddenMarket = int
func getAD():
	return availableDungeons
func setAD(int):
	availableDungeons = int
func getCPA():
	return cps_available
func setCPA(int):
	cps_available = int
