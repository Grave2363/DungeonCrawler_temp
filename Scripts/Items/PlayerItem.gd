extends Node

class_name PlayerItem

var ItemName : String = "what"
var ItemDis : String = "What is this?"
var healing : int
var uses : int

func initalize (thing :ItemBase):
	ItemName = thing.item_Name
	ItemDis = thing.ItemDis
	healing = thing.healing
	uses = thing.uses
