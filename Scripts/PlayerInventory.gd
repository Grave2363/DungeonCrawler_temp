extends Node

var exp = 0
var currency = 0
var consumables = []
var materials = []
var weps = []
var gear = []
var accessories = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getExp():
	return exp
func setExp(int):
	var temp = exp
	exp = temp + int
func getCurrency():
	return currency
func deductCurrency(int):
	var temp = currency
	currency = temp - int
func addCurrency(int):
	var temp = currency
	currency = temp + int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
